#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/CPP/Telemetry
arg=${1-all}
declare -a subSystemArray=($(subsystemArray))
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)

#  FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	subSystem=$1
	file=$2
	output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n ${file} |sed "s/${subSystem}_//g" )
	topicsArray=($output)
}

function getTopicParameters() {
    file=$1
    index=$2
    unset parametersArray
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/EFDB_Name" -v . -n ${file} )
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
    parameterType=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item[$itemIndex]/IDL_Type" -v . -n $file )
    echo $parameterType
}

function getParameterCount() {
    subSystem=$1
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
	if [ "$subSystem" == "mtmount" ]; then subSystem="MTMount"; fi
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
    echo "" >> $testSuite
}

function startSubscriber {
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_sub" >> $testSuite
    echo "    \${output}=    Read Until    [Subscriber] Ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    [Subscriber] Ready" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Publisher" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_pub" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [putSample] \${subSystem}::\${component} writing a message containing :    9" >> $testSuite
    echo "    Should Contain X Times    \${output}    revCode \ : LSST TEST REVCODE    9" >> $testSuite
    echo "" >> $testSuite
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
		if [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
        	echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    9" >>$testSuite
		elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" )]]; then
			echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : LSST    9" >>$testSuite
		else
			for num in `seq 1 9`; do
				echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : $num    1" >>$testSuite
			done
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
		
		#  Get EFDB EFDB_Topic telemetry parameters
		getTopicParameters $file $topicIndex

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
		readSubscriber $file $topicIndex
		echo Done with test suite.
    	(( topicIndex++ ))
	done
}


#  MAIN
if [ "$arg" == "all" ]; then
	for subsystem in "${subSystemArray[@]}"; do
		declare -a filesArray=($HOME/trunk/ts_xml/sal_interfaces/${subsystem}/*_Telemetry.xml)
		# Get the Subsystem in the correct capitalization.
    	subSystemUp=$(capitializeSubsystem $subsystem)
		#  Delete all the test suites.  This is will expose deprecated topics.
		clearTestSuites $subSystemUp "CPP" "Telemetry"
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
	clearTestSuites $subSystemUp "CPP" "Telemetry"

	for file in "${filesArray[@]}"; do
		getTopics $arg $file
		
		createTestSuite $arg $file
	done
	echo COMPLETED all test suites for the $arg.
else
	echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

