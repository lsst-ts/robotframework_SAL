#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/Separate/CPP/Events
workDirCombined=$HOME/trunk/robotframework_SAL/Combined/CPP/Events
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a argumentsArray=($EMPTY)

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
    arg=$1

    # Get the XML definition file. This requires the CSC be capitalized properly. This in done in the _common.sh.getEntity() function.
    subsystem=$(getEntity $arg)
    file=($HOME/trunk/ts_xml/sal_interfaces/$subsystem/*_Events.xml)

    # Delete all test associated test suites first, to catch any removed topics.
    clearTestSuites $arg "CPP" "Events" || exit 1

    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

# Get EFDB_Topics from Events XML.
function getTopics() {
	subSystem=$(getEntity $1)
	file=$2
	output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $file |cut -d"_" -f 3 )
	topicsArray=($output)
}

function getTopicParameters() {
	file=$1
	index=$2
	unset parametersArray
	output=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item/EFDB_Name" -v . -n $file )
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
	parameterType=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Type" -v . -n $file )
	echo $parameterType
}

function getParameterIDLSize() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterIDLSize=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Size" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
    echo $parameterIDLSize
}

function getParameterCount() {
    file=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/Count" -v . -n $file )
    echo $parameterCount
}

function createSettings() {
    local subSystem=$1
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    cpp    $skipped" >> $testSuite
	echo "Suite Setup    Log Many    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Terminate All Processes" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Collections" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
	local subSystem=$1
    local testSuite=$2
    local topic=$3
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompSenderLogger() {
    local testSuite=$1
    echo "Verify Component Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
	if [ $topic ]; then
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_send" >> $testSuite
    	echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_log" >> $testSuite
	else
		echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_sender" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_logger" >> $testSuite
    fi
    echo "" >> $testSuite
}

function startLogger() {
    local testSuite=$1
    echo "Start Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Logger." >> $testSuite
	if [ $topic ]; then
		echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone//sacpp_\${subSystem}_\${component}_log" >> $testSuite
	else
		echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_logger    alias=Logger     stdout=\${EXECDIR}\${/}stdout.txt    stderr=\${EXECDIR}\${/}stderr.txt" >> $testSuite
	fi
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \"\${output}\"    \"1\"" >> $testSuite
	echo "    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    \${EXECDIR}\${/}stdout.txt" >> $testSuite
    echo "    \${output}=    Get File    \${EXECDIR}\${/}stdout.txt" >> $testSuite
	echo "    Should Contain    \${output}    ===== \${subSystem} all loggers ready =====" >> $testSuite
	echo "    Sleep    6s" >> $testSuite
    echo "" >> $testSuite
}

function startSender() {
	i=0
	#local device=$1
	#local property=$2
    local testSuite=$1
    echo "Start Sender" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
	if [ $topic ]; then
		echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_\${component}_send ${argumentsArray[*]}" >> $testSuite
	else
		 echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_sender" >> $testSuite
    fi
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
	if [ $topic ]; then
		echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
        echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_logevent_${topic}" >> $testSuite
        echo "    @{words}=    Split String    \${line}" >> $testSuite
        echo "    \${revcode}=    Set Variable    @{words}[2]" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::logevent_\${component}_\${revcode} writing a message containing :    10" >> $testSuite
    	echo "    Should Contain X Times    \${output.stdout}    revCode  : \${revcode}    10" >> $testSuite
	else
		for item in "${topicsArray[@]}"; do
			echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
            echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_logevent_${item}" >> $testSuite
            echo "    @{words}=    Split String    \${line}" >> $testSuite
            echo "    \${revcode}=    Set Variable    @{words}[2]" >> $testSuite
    		echo "    Should Contain X Times    \${output}    === [putSample] \${subSystem}::logevent_${item}_\${revcode} writing a message containing :    1" >> $testSuite
    		echo "    Should Contain    \${output}    revCode \ : \${revcode}    10" >>$testSuite
			echo "    Should Contain    \${output}    === \${subSystem}_${item} end of topic ===" >> $testSuite
		done
	fi
	#for parameter in "${parametersArray[@]}"; do
        #echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$i]}    1" >>$testSuite
		#(( i++ ))
    #done
    echo "" >> $testSuite
}

function readLogger() {
	i=0
	#device=$1
	#property=$2
	local file=$1
    local topicIndex=$2
    local testSuite=$3
    echo "Read Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Process    Logger" >> $testSuite
    echo "    \${output}=    Wait For Process    handle=Logger    timeout=\${timeout}    on_timeout=terminate" >> $testSuite
	echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
	echo "    Should Contain    \${output.stdout}    ===== \${subSystem} all loggers ready =====" >> $testSuite
	echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=1" >> $testSuite
	if [ $topic ]; then
		readLogger_params $file $topic $topicIndex $testSuite
		echo "    Should Contain    \${output.stdout}    priority : ${argumentsArray[${#argumentsArray[@]}-1]}" >> $testSuite
	else
		itemIndex=1
		for item in "${topicsArray[@]}"; do
            echo "    \${${item}_start}=    Get Index From List    \${full_list}    === \${subSystem}_${item} start of topic ===" >> $testSuite
            echo "    \${${item}_end}=    Get Index From List    \${full_list}    === \${subSystem}_${item} end of topic ===" >> $testSuite
            echo "    \${${item}_list}=    Get Slice From List    \${full_list}    start=\${${item}_start}    end=\${${item}_end}" >> $testSuite
            getTopicParameters $file $itemIndex
            readLogger_params $file $item $itemIndex $testSuite
			echo "    Should Contain X Times    \${output.stdout}    priority : 1    1" >> $testSuite
            (( itemIndex++ ))
        done
    fi
    echo "    Log    \${output.stdout}" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    === Event ${topic} received =     1" >> $testSuite
    for parameter in "${parametersArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    $parameter : ${argumentsArray[$i]}" >>$testSuite
		(( i++ ))
    done
}

function readLogger_params() {
	local file=$1
    local topic=$2
    local topicIndex=$3
    local testSuite=$4
    for parameter in "${parametersArray[@]}"; do
		parameterIndex=$(getParameterIndex $parameter)
        parameterType="$(getParameterType $file $topicIndex $parameterIndex)"
        parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
        if [[ ( $parameterCount -eq 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x01    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" == "boolean" ) ]]; then
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
            #echo "$parameter $parameterType String or Char"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : LSST    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
            #echo "$parameter $parameterType Count 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            for num in `seq 0 9`; do
                echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x0${num}    1" >>$testSuite
            done
        else
            #echo "$parameter $parameterType Else"
            for num in `seq 0 9`; do
                echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : $num    1" >>$testSuite
            done
        fi
    done
}

function createTestSuite() {
	subSystem=$1
    messageType="events"
	file=$2
	topicIndex=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    # Generate the test suite for each topic.
    echo ============== Generating Combined messaging test suite ==============
	testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
    echo $testSuiteCombined
    createSettings $subSystem $messageType $testSuiteCombined
    createVariables $subSystem $testSuiteCombined "all"
    echo "*** Test Cases ***" >> $testSuiteCombined
    verifyCompSenderLogger $testSuiteCombined
    startLogger $testSuiteCombined
    startSender $testSuiteCombined
    readLogger $file $topicIndex $testSuiteCombined
    echo Generation complete
    echo ""
    # Generate the test suite for each topic.
    echo ============== Generating Separate messaging test suites ==============
	topicIndex=1
	for topic in "${topicsArray[@]}"; do
		device=$EMPTY
		property=$EMPTY
		#  Define test suite name
		testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot

		#  Get EFDB_Topic elements
		getTopicParameters $file $topicIndex
		device=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Device" -v . -n $file )
		property=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Property" -v . -n $file )

        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $topic $messageType)

		#  Create test suite.
		echo $testSuite
		createSettings $subSystem $topic $testSuite
		createVariables $subSystem $testSuite $topic
		echo "*** Test Cases ***" >> $testSuite
        verifyCompSenderLogger $testSuite
		startLogger $testSuite

		# Get the arguments to the sender.
		unset argumentsArray
		# Determine the parameter type and create a test value, accordingly.
        for parameter in "${parametersArray[@]}"; do
            parameterIndex=$(getParameterIndex $parameter)
            parameterType=$(getParameterType $file $topicIndex $parameterIndex)
            parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
			parameterIDLSize=$(getParameterIDLSize $subSystem $topicIndex $parameterIndex)
			#echo "parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "parameterIDLSize:"$parameterIDLSize
			for i in $(seq 1 $parameterCount); do
                testValue=$(generateArgument "$parameterType" $parameterIDLSize)
                argumentsArray+=( $testValue )
            done
		done
		# The Event priority is a required argument to ALL senders, but is not in the XML definitions.
		# ... As such, manually add this argument as the first element in argumentsArray and parametersArray.
		parametersArray=("${parametersArray[@]}" "priority")
		priority=$(python random_value.py long)
		argumentsArray=("${argumentsArray[@]}" "$priority")
		# Create the Start Sender test case.
		startSender $testSuite $device $property
		# Create the Read Logger test case.
		readLogger $file $topicIndex $testSuite $device $property
    	# Move to next Topic.
		(( topicIndex++ ))
	done
	echo ""
}

#### Call the main() function ####
main $1
