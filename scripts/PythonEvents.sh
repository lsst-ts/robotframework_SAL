#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/PYTHON/Events
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
    clearTestSuites $arg "PYTHON" "Events" || exit 1

    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

# Get EFDB_Topics from Telemetry XML.
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
    file=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterIDLSize=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Size" -v . -n $file )
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
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    python    $skipped" >> $testSuite
	echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
	echo "...    AND    Create Session    Sender    AND    Create Session    Logger" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
	subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompSenderLogger() {
    echo "Verify Component Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Event_\${component}.py" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_EventLogger_\${component}.py" >> $testSuite
    echo "" >> $testSuite
}

function startSenderInputs() {
    parameter=$EMPTY
    echo "Start Sender - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Sender" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Event_\${component}.py $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
	if [ ${#parametersArray[@]} -eq 0 ]; then
		echo "    Should Contain    \${output}   ERROR : Invalid or missing arguments : priority" >> $testSuite
	else
		echo "    Should Contain    \${output}   ERROR : Invalid or missing arguments : ${parametersArray[@]} priority" >> $testSuite
	fi
    echo "" >> $testSuite
}

function startLogger() {
    echo "Start Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Logger." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_EventLogger_\${component}.py" >> $testSuite
    echo "    \${output}=    Read Until    logger ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    \${subSystem}_\${component} logger ready" >> $testSuite
    echo "" >> $testSuite
}

function startSender() {
	i=0
	device=$1
	property=$2
    echo "Start Sender" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Sender" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Event_\${component}.py ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [putSample] ${subSystem}::logevent_${topic} writing a message containing :    1" >> $testSuite
    echo "    Should Contain    \${output}    revCode \ : LSST TEST REVCODE" >>$testSuite
    echo "" >> $testSuite
}

function readLogger() {
	i=0
	device=$1
	property=$2
    echo "Read Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    \${output}=    Read Until    \${component} received" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    Event \${subSystem} \${component} received     1" >> $testSuite
    #for parameter in "${parametersArray[@]}"; do
        #echo "    Should Contain    \${output}    $parameter : ${argumentsArray[$i]}" >>$testSuite
		#(( i++ ))
    #done
}

function createTestSuite() {
	subSystem=$1
    messageType="events"
	file=$2
	topicIndex=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    # Generate the test suite for each topic.
    echo Generating:
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
		createSettings $subSystem
		createVariables $subSystem
		echo "*** Test Cases ***" >> $testSuite
        verifyCompSenderLogger
		startSenderInputs

		# Get the arguments to the sender.
		unset argumentsArray
		# Determine the parameter type and create a test value, accordingly.
		for parameter in "${parametersArray[@]}"; do
            parameterIndex=$(getParameterIndex $parameter)
            parameterType=$(getParameterType $file $topicIndex $parameterIndex)
            parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
            parameterIDLSize=$(getParameterIDLSize $file $topicIndex $parameterIndex)
            #echo $parameter $parameterIndex $parameterType $parameterCount $parameterIDLSize
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
        # Create the Sender Timeout test case.
		#startSenderTimeout
        # Create the Start Logger test case.
		startLogger
		# Create the Start Sender test case.
		startSender $device $property
		# Create the Read Logger test case.
		readLogger $device $property
		# Indicate completion of the test suite.
		echo Done with test suite.
    	# Move to next Topic.
		(( topicIndex++ ))
	done
    echo ""
}

#### Call the main() function ####
main $1
