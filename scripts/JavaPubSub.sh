#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/Java/Telemetry
arg=${1-all}
#arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
declare -a subSystemArray=(camera dm dome hexapod m1m3 m2ms MTMount rotator scheduler tcs)    #dm, mtmount - TSS-771, TSS-773
declare -a topicsArray=($EMPTY)
declare -a itemsArray=($EMPTY)

#  FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$1/$1_Telemetry.xml |sed "s/$1_//" )
	topicsArray=($output)
}

function getTopicItems {
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$2]/item/EFDB_Name" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$1/$1_Telemetry.xml )
	itemsArray=($output)
}

function clearTestSuite {
    if [ -f $testSuite ]; then
        echo $testSuite exists.  Deleting it before creating a new one.
        rm -rf $testSuite
    fi
}

function createSettings {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    ${subSystemUp}_${topic} communications tests." >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "#\${subOut}    \${subSystem}_\${component}_sub.out" >> $testSuite
    echo "#\${pubOut}    \${subSystem}_\${component}_pub.out" >> $testSuite
    echo "" >> $testSuite
}

function createPubSession {
    echo "Create Publisher Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Publisher    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}_\${component}" >> $testSuite
    echo "" >> $testSuite
}

function createSubSession {
    echo "Create Subscriber Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Subscriber    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}_\${component}" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_pub.jar" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_sub.jar" >> $testSuite
    echo "" >> $testSuite
}

function startSubscriber {
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/java/standalone" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    echo "    \${input}=    Write    java -cp \$SAL_HOME/lib/saj_\${subSystem}_types.jar:./classes:\$OSPL_HOME/jar/dcpssaj.jar:saj_\${subSystem}_\${component}_sub.jar \${subSystem}_\${component}DataSubscriber" >> $testSuite
    echo "    \${output}=    Read Until    [\${component} Subscriber] Ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    [\${component} Subscriber] Ready" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Publisher" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/java/standalone" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
    echo "    \${input}=    Write    java -cp \$SAL_HOME/lib/saj_\${subSystem}_types.jar:./classes:\$OSPL_HOME/jar/dcpssaj.jar:saj_\${subSystem}_\${component}_pub.jar \${subSystem}_\${component}DataPublisher" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [putSample \${component}] writing a message containing :    5" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ : LSST TEST REVCODE    5" >> $testSuite
    echo "" >> $testSuite
}

function readSubscriber {
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    \${output}=    Read    delay=1s" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [getSample \${component} ] message received :    7" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ : LSST TEST REVCODE    6" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ :    7" >> $testSuite
    #for item in "${itemsArray[@]}"; do
        #echo "    Should Contain X Times    \${output}    $item :    5" >>$testSuite
    #done
}

function createTestSuite {
	subSystem=$1
	index=1
    if [ "$subSystem" == "m1m3" ]; then
        subSystemUp="M1M3"
    elif [ "$subSystem" == "m2ms" ]; then
        subSystemUp="M2MS"
    elif [ "$subSystem" == "tcs" ]; then
        subSystemUp="TCS"
    elif [ "$subSystem" == "mtmount" ]; then
        subSystemUp="MTMount"
    elif [ "$subSystem" == "dm" ]; then
        subSystemUp="DM"
    else
        subSystemUp="$(tr '[:lower:]' '[:upper:]' <<< ${subSystem:0:1})${subSystem:1}"
    fi
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${topic}.robot
		
		#  Test to see if the TestSuite exists then, if it does, delete it.
		clearTestSuite
		
		#  Get EFDB EFDB_Topic telemetry items
		getTopicItems $subSystem $index

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables
		echo "*** Test Cases ***" >> $testSuite
		createPubSession
		createSubSession
		verifyCompPubSub
		startSubscriber
		startPublisher
		readSubscriber
		echo Done with test suite.
    	(( index++ ))
	done
}


#  MAIN
if [ "$arg" == "all" ]; then
	for i in "${subSystemArray[@]}"; do
		getTopics $i
		createTestSuite $i
	done
	echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $arg ]]; then
	getTopics $arg
	createTestSuite $arg
	echo COMPLETED all test suites for the $arg.
else
	echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

