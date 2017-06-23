#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/Java/Telemetry
arg=${1-all}
#arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
declare -a subSystemArray=($(subsystemArray))
declare -a topicsArray=($EMPTY)
declare -a itemsArray=($EMPTY)

#  FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	subSystem=$(getEntity $1)
    file=$2
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $file |sed "s/${subSystem}_//g" )
	topicsArray=($output)
}

function getTopicItems {
	file=$1
	index=$2
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/EFDB_Name" -v . -n $file )
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
	echo "Force Tags    java" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
	subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
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
	echo "    Should Contain    \${output}    [createTopic] : topicName \${subSystem}_\${component} type = \${subSystem}::\${component}">> $testSuite
	echo "    Should Contain    \${output}    [createreader idx] : topic org.opensplice.dds.dcps.TopicImpl@ ">> $testSuite
    echo "    Should Contain    \${output}    reader = \${subSystem}.\${component}DataReaderImpl@">> $testSuite
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
    echo "    Should Contain    \${output}    [createTopic] : topicName \${subSystem}_\${component} type = \${subSystem}::\${component}">> $testSuite
    echo "    Should Contain    \${output}    [createwriter idx] : topic org.opensplice.dds.dcps.TopicImpl@ ">> $testSuite
    echo "    Should Contain    \${output}    writer = \${subSystem}.\${component}DataWriterImpl@">> $testSuite
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
    echo "    Should Contain X Times    \${output}    [getSample \${component} ] message received :    6" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ : LSST TEST REVCODE    5" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ :    6" >> $testSuite
}

function createTestSuite {
	subSystem=$1
	file=$2
	index=1
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${topic}.robot
		
		#  Test to see if the TestSuite exists then, if it does, delete it.
		clearTestSuite
		
		#  Get EFDB EFDB_Topic telemetry items
		getTopicItems $file $index

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables $subSystem
		echo "*** Test Cases ***" >> $testSuite
		createSession "Publisher"
        createSession "Subscriber"
        verifyCompPubSub
		startSubscriber
		startPublisher
		readSubscriber
		echo Done with test suite.
    	(( index++ ))
	done
    echo ""
}


#  MAIN
if [ "$arg" == "all" ]; then
    for subsystem in "${subSystemArray[@]}"; do
        declare -a filesArray=($HOME/trunk/ts_xml/sal_interfaces/${subsystem}/*_Telemetry.xml)
        # Get the Subsystem in the correct capitalization.
        subSystemUp=$(capitializeSubsystem $subsystem)
        #  Delete all the test suites.  This is will expose deprecated topics.
        clearTestSuites $subSystemUp "JAVA" "Telemetry"
        for file in "${filesArray[@]}"; do
            getTopics $subsystem $file
            createTestSuite $subsystem $file
        done
    done
    echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $arg ]]; then
    declare -a filesArray=($HOME/trunk/ts_xml/sal_interfaces/$arg/*_Telemetry.xml)
    subSystemUp=$(capitializeSubsystem $arg)
    #  Delete all the test suites.  This is will expose deprecated topics.
    clearTestSuites $subSystemUp "JAVA" "Telemetry"
    for file in "${filesArray[@]}"; do
        getTopics $arg $file
        createTestSuite $arg $file
    done
    echo COMPLETED all test suites for the $arg.
else
    echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi
