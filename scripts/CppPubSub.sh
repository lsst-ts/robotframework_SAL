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
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
	arg=$1

	# Get the XML definition file. This requires the CSC be capitalized properly. This in done in the _common.sh.getEntity() function.
	subsystem=$(getEntity $arg)
	file=($HOME/trunk/ts_xml/sal_interfaces/$subsystem/*_Telemetry.xml)

	# Delete all test associated test suites first, to catch any removed topics.
	clearTestSuites $arg "CPP" "Telemetry" || exit 1

	# Now generate the test suites.
	createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
	subSystem=$(getEntity $1)
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
	local subSystem=$1
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    cpp    $skipped" >> $testSuite
    echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "...    AND    Create Session    Publisher    AND    Create Session    Subscriber" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
	local subSystem=$(getEntity $1)
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
    echo "    \${output}=    Read Until    [Subscriber] Ready ..." >> $testSuite
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
		elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
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
    messageType="telemetry"
	file=$2
	topicIndex=1

	# Get the topics for the CSC.
	getTopics $subSystem $file

	# Generate the test suite for each topic.
	echo Generating:
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
		
		#  Get EFDB EFDB_Topic telemetry parameters
		getTopicParameters $file $topicIndex

		#  Check if test suite should be skipped.
		skipped=$(checkIfSkipped $subSystem $topic $messageType)

		#  Create test suite.
		echo $testSuite
		createSettings $subSystem
		createVariables $subSystem
		echo "*** Test Cases ***" >> $testSuite
        verifyCompPubSub
		startSubscriber
		startPublisher
		readSubscriber $file $topicIndex
    	(( topicIndex++ ))
	done
	echo ""
}

#### Call the main() function ####
main $1
