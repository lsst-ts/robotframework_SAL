#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOT_FRAMEWORK_REPO_DIR/scripts/_common.sh

#  Define variables to be used in script
workDir=$ROBOT_FRAMEWORK_REPO_DIR/CPP/GenericEvents
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
    file=($TS_XML_REPO_DIR/sal_interfaces/SALGenerics.xml)

    # Delete all associated test suites first, to catch any removed topics.
    clearTestSuites $arg "CPP" "GenericEvents" || exit 1

    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

# Get EFDB_Topics from Events XML.
function getTopics() {
    subSystem=$(getEntity $1)
    file=$2
    output=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent/EFDB_Topic" -v . -n $file |cut -d"_" -f 3 )
    topicsArray=($output)
}

function getTopicParameters() {
    file=$1
    index=$2
    unset parametersArray
    output=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$index]/item/EFDB_Name" -v . -n $file )
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
    parameterType=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Type" -v . -n $file )
    echo $parameterType
}

function getParameterIDLSize() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterIDLSize=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Size" -v . -n $file )
    echo $parameterIDLSize
}

function getParameterCount() {
    file=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$index]/item[$itemIndex]/Count" -v . -n $file )
    echo $parameterCount
}

function createSettings() {
    local subSystem=$1
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    ${subSystem}_${event} communications tests." >> $testSuite
    echo "Force Tags    cpp    $skipped" >> $testSuite
    echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
    echo "...    AND    Create Session    Sender    AND    Create Session    Logger" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
    echo "" >> $testSuite
}

function createVariables() {
    subSystem=$1
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompSenderLogger() {
	event=$1
    echo "Verify $event Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${event}_send" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${event}_log" >> $testSuite
    echo "" >> $testSuite
}

function startLogger() {
	event=$1
    echo "Start $event Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Logger." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_${event}_log" >> $testSuite
    echo "    \${output}=    Read Until    logger ready =" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    Event ${event} logger ready" >> $testSuite
    echo "" >> $testSuite
}

function startSender() {
    i=0
	event=$1
    device=$2
    property=$3
    echo "Start $event Sender" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Sender" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_${event}_send ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [putSample] ${subSystem}::logevent_${event}_    1" >> $testSuite
    echo "    Should Contain    \${output}    revCode \ :" >>$testSuite
    echo "    Should Contain    \${output}    === Event ${event} generated =" >> $testSuite
    #for parameter in "${parametersArray[@]}"; do
        #echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$i]}    1" >>$testSuite
        #(( i++ ))
    #done
    echo "" >> $testSuite
}

function readLogger() {
    i=0
	event=$1
    device=$2
    property=$3
    echo "Read $event Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    \${output}=    Read Until    priority : ${argumentsArray[${#argumentsArray[@]}-1]}" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === Event ${event} received =     1" >> $testSuite
    for parameter in "${parametersArray[@]}"; do
        echo "    Should Contain    \${output}    $parameter : ${argumentsArray[$i]}" >>$testSuite
        (( i++ ))
    done
    echo "" >> $testSuite
}

function terminateController() {
    event=$1
    echo "Terminate $event Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite 
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    \${crtl_c}    Evaluate    chr(int(3))" >> $testSuite
    echo "    Write Bare    \${crtl_c}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Should Contain    \${output}    ^C" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
	subSystem=$1
	messageType="events"
	topicIndex=1

	# Check if CSC uses the Generic topics (most do, but a few do not).
	# ... If not, skip this CSC.
	output=$( xml sel -t -m "//SALSubsystems/Subsystem/Name[text()='${subSystem}']/../Generics" -v . -n $TS_XML_REPO_DIR/sal_interfaces/SALSubsystems.xml )
	if [ "$output" == "no" ]; then
		echo "The $subSystem CSC does not use the Generic topics. Exiting."; exit 0
	fi

	# Generate the test suite for each topic.
	testSuite=$workDir/${subSystem}_GenericEvents.robot
    echo Generating $testSuite:
	#  Create test suite.
	createSettings $subSystem
	createVariables $subSystem
	echo "*** Test Cases ***" >> $testSuite
	for event in "settingVersions" "errorCode" "summaryState" "appliedSettingsMatchStart"; do
		
        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $event $messageType)

		#  Get EFDB_Topic elements
        getTopicParameters $file $topicIndex
        device=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$topicIndex]/Device" -v . -n $file )
        property=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent[$topicIndex]/Property" -v . -n $file )
		
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

        verifyCompSenderLogger $event
		# Create the Start Controller test case.
		startLogger $event
		# Create the Start Sender test case.
        startSender $event $device $property
        # Create the Read Logger test case.
        readLogger $event $device $property
        # Kill the Controller process.
        terminateController $event
    	# Move to next Topic.
		(( topicIndex++ ))
	done
    echo ""
}

#### Call the main() function ####
main $1
