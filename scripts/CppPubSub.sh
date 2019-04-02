#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/Separate/CPP/Telemetry
workDirCombined=$HOME/trunk/robotframework_SAL/Combined/CPP
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
	local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
	local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem) ${topic} communications tests." >> $testSuite
    echo "Force Tags    cpp    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${timeout}    \${subSystem}    \${component}" >> $testSuite
	echo "Suite Teardown    Terminate All Processes" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
	local subSystem=$1
	local testSuite=$2
	local topic=$3
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
	local testSuite=$1
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
	if [ $topic ]; then
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
	else
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_publisher" >> $testSuite
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_subscriber" >> $testSuite
	fi
    echo "" >> $testSuite
}

function startSubscriber {
	local testSuite=$1
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    if [ $topic ]; then
    	echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_sub    alias=Subscriber" >> $testSuite
	else
		echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_subscriber    alias=Subscriber" >> $testSuite
	fi
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \"\${output}\"   \"1\"" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
	local testSuite=$1
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
	if [ $topic ]; then
    	echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
	else
		echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_publisher" >> $testSuite
    fi
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
	if [ $topic ]; then
    	echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::\${component} writing a message containing :    10" >> $testSuite
    	echo "    Should Contain X Times    \${output.stdout}    revCode \ : LSST TEST REVCODE    10" >> $testSuite
	else
		for item in "${topicsArray[@]}"; do
			echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
			echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_${item}" >> $testSuite
			echo "    @{words}=    Split String    \${line}" >> $testSuite
			echo "    \${revcode}=    Set Variable    @{words}[2]" >> $testSuite
			echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::${item}_\${revcode} writing a message containing :    10" >> $testSuite
			echo "    Should Contain X Times    \${output.stdout}    revCode \ : \${revcode}    10" >> $testSuite
		done
	fi
    echo "" >> $testSuite
}

function readSubscriber {
	file=$1
	topicIndex=$2
	local testSuite=$3
	echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Process    Subscriber" >> $testSuite
    echo "    \${output}=    Wait For Process    Subscriber    timeout=10    on_timeout=terminate" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
	echo "    Should Contain    \${output.stdout}    \${subSystem} subscriber Ready" >> $testSuite
	echo "    @{list}=    Split To Lines    \${output.stdout}    start=1" >> $testSuite
	if [ $topic ]; then
		readSubscriber_params $file $topicIndex $testSuite
	else
		itemIndex=1
		for item in "${topicsArray[@]}"; do
			getTopicParameters $file $itemIndex
			readSubscriber_params $file $itemIndex $testSuite
			(( itemIndex++ ))
		done
    fi
}

function readSubscriber_params {
	file=$1
    topicIndex=$2
    local testSuite=$3
    for parameter in "${parametersArray[@]}"; do
        parameterIndex=$(getParameterIndex $parameter)
        parameterType="$(getParameterType $file $topicIndex $parameterIndex)"
        parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
		if [[ ( "$parameterType" == "byte" ) ]]; then
			#echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter :    10" >>$testSuite
		elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
			#echo "$parameter $parameterType Count 1"
        	echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    10" >>$testSuite
		elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
			#echo "$parameter $parameterType String or Char"
			echo "    Should Contain X Times    \${list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : LSST    10" >>$testSuite
		else
			#echo "$parameter $parameterType Else"
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

	# Generate the test suite for each message type.
	echo ============== Generating Combined messaging test suite ==============
	testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
	echo $testSuiteCombined
	createSettings $subSystem $messageType $testSuiteCombined
	createVariables $subSystem $testSuiteCombined "all"
	echo "*** Test Cases ***" >> $testSuiteCombined
	verifyCompPubSub $testSuiteCombined
    startSubscriber $testSuiteCombined
    startPublisher $testSuiteCombined
    readSubscriber $file $topicIndex $testSuiteCombined
	echo Generation complete
	echo ""
	# Generate the test suite for each topic.
	echo ============== Generating Separate messaging test suites ==============
	topicIndex=1
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
		
		#  Get EFDB_Topic Telemetry parameters
		getTopicParameters $file $topicIndex

		#  Check if test suite should be skipped.
		skipped=$(checkIfSkipped $subSystem $topic $messageType)

		#  Create test suite.
		echo $testSuite
		createSettings $subSystem $topic $testSuite
		createVariables $subSystem $testSuite
		echo "*** Test Cases ***" >> $testSuite
        verifyCompPubSub $testSuite
		startSubscriber $testSuite
		startPublisher $testSuite
		readSubscriber $file $topicIndex $testSuite
    	(( topicIndex++ ))
	done
	echo Generation complete
	echo ""
}

#### Call the main() function ####
main $1
