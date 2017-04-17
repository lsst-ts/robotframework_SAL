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
declare -a subSystemArray=($(subsystemArray))
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a parameterTypeArray=($EMPTY)
declare -a unique_types=($EMPTY)

#  FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	subSystem=$(getEntity $1)
	file=$2
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $file |sed "s/${subSystem}_//g" )
	topicsArray=($output)
}

function getTopicParameters() {
    file=$1
    index=$2
    unset parametersArray
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/EFDB_Name" -v . -n $file )
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
    file=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterType=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item[$itemIndex]/IDL_Type" -v . -n $file )
    echo $parameterType
}

function getParameterCount() {
    file=$1
    topicIndex=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$topicIndex]/item[$itemIndex]/Count" -v . -n $file )
    echo $parameterCount
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

function readSubscriber {
	file=$1
	topicIndex=$2
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    \${output}=    Read    delay=1s" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    @{list}=    Split To Lines    \${output}    start=1" >> $testSuite
    for parameter in "${parametersArray[@]}"; do
        parameterIndex=$(getParameterIndex $parameter)
        parameterType="$(getParameterType $file $topicIndex $parameterIndex)"
        parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
		find_Format_TestValue "$parameterType"
		if [[ ( "$parameterCount" == "1" ) || ( "$parameterType" == "string" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter = $value    10" >>$testSuite
		elif [[ ( $parameterCount -gt 2000 ) && ( "$parameterType" != "char" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [$(seq -f %1.${format}f -s ', ' 0 $(($parameterCount - 1)) |sed 's/..$//')]    10" >>$testSuite
		elif [[ (( "$parameterCount" > "1" )) && ( "$parameterType" == "char" ) ]]; then
			echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [\'L\', \'S\', \'S\', \'T\']    10" >>$testSuite
		else
        	echo "    Should Contain X Times    \${list}    $parameter($parameterCount) = [$(seq -f %1.${format}f -s ', ' 0 $(($parameterCount - 1)) |sed 's/..$//')]    10" >>$testSuite
		fi
    done
}

function createTestSuite {
	subSystem=$1
	file=$2
	topicIndex=1
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${topic}.robot
		
		#  Get EFDB EFDB_Topic telemetry items
		getTopicParameters $file $topicIndex

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
		readSubscriber $file $topicIndex

		#  Done with topic test suite.
		echo Done with test suite.
    	(( topicIndex++ ))
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
        clearTestSuites $subSystemUp "PYTHON" "Telemetry"
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
    clearTestSuites $subSystemUp "PYTHON" "Telemetry"

    for file in "${filesArray[@]}"; do
        getTopics $arg $file

        createTestSuite $arg $file
    done
    echo COMPLETED all test suites for the $arg.
else
    echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi
