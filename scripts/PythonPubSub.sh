#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/PYTHON/Telemetry
arg=${1-all}
#arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
declare -a subSystemArray=(camera dm dome hexapod m1m3 m2ms MTMount rotator scheduler tcs)
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a parameterTypeArray=($EMPTY)
declare -a unique_types=($EMPTY)

#  FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$1/$1_Telemetry.xml |sed "s/$1_//" )
	topicsArray=($output)
}

function getTopicParameters() {
    subSystem=$1
    index=$2
    unset parametersArray
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/EFDB_Name" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml )
    parametersArray=($output)
}

function getParameterIndex() {
    value=$1
    for i in "${!parametersArray[@]}"; do
        if [[ "${parametersArray[$i]}" = "${value}" ]]; then
            parameterIndex="${i}";
        fi
    done
    echo $parameterIndex
}

function getParameterType() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterType=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item[$itemIndex]/IDL_Type" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml )
    echo $parameterType
}

function getParameterCount() {
    subSystem=$1
    topicIndex=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$topicIndex]/item[$itemIndex]/Count" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml )
    echo $parameterCount
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
    echo "Library    String" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_\${component}_Subscriber.py" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_\${component}_Publisher.py" >> $testSuite
    echo "" >> $testSuite
}

function startSubscriber {
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_\${component}_Subscriber.py" >> $testSuite
    echo "    \${output}=    Read Until    subscriber ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Be Equal    \${output}    \${subSystem}_\${component} subscriber ready" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Publisher" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_\${component}_Publisher.py" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [putSample] \${subSystem}::\${component} writing a message containing :   10" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ : LSST TEST REVCODE    10" >> $testSuite
    echo "" >> $testSuite
}

function find_Format_TestValue {
	parameterType=$1
    if [[ ( "$parameterType" == "float" ) || ( "$parameterType" == "double" ) ]]; then
        format="01"
        value="1.0"
    elif [[ ( "$parameterType" == *"long"* ) || ( "$parameterType" == *"int"* ) || ( "$parameterType" == *"short"* ) ]]; then
        format=""
        value="1"
    elif [ "$parameterType" == "boolean" ]; then
        format=""
        value="1"
    elif [ "$parameterType" == "string" ]; then
        format=""
        value="LSST"
    else
        format=""
		value="0"
    fi
}

function determine_return_count {
    subSystem=$1
    topicIndex=$2
	count="10"
	IFS=" " read -ra array <<< $( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/Count" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |tr "\n" " ")
	for item in "${array[@]}"; do
		if [[ ( "$item" -gt 2000 ) ]]; then
			count="1"
		fi
	done
}

function readSubscriber {
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    \${output}=    Read    delay=1s" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    @{list}=    Split To Lines    \${output}    start=1" >> $testSuite
    determine_return_count $subSystem $topicIndex
    for parameter in "${parametersArray[@]}"; do
        parameterIndex=$(getParameterIndex $parameter)
        parameterType="$(getParameterType $subSystem $topicIndex $parameterIndex)"
        parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
		find_Format_TestValue "$parameterType"
		if [[ ( "$parameterCount" == "1" ) || ( "$parameterType" == "string" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter = $value    $count" >>$testSuite
		elif [[ ( $parameterCount -gt 2000 ) && ( "$parameterType" != "char" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [$(seq -f %1.${format}f -s ', ' 0 $(($parameterCount - 1)) |sed 's/..$//')]    $count" >>$testSuite
		elif [[ (( "$parameterCount" > "1" )) && ( "$parameterType" == "char" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [\'L\', \'S\', \'S\', \'T\']    $count" >>$testSuite
		else
        	echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [$(seq -f %1.${format}f -s ', ' 0 $(($parameterCount - 1)) |sed 's/..$//')]    $count" >>$testSuite
		fi
    done
}

function createTestSuite {
	subSystem=$1
	topicIndex=1
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
		getTopicParameters $subSystem $topicIndex

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables
		echo "*** Test Cases ***" >> $testSuite
		createSession "Publisher"
        createSession "Subscriber"
        verifyCompPubSub
		startSubscriber
		startPublisher
		readSubscriber

		#  Done with topic test suite.
		echo Done with test suite.
    	(( topicIndex++ ))
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

