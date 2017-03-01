#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/CPP/Events
arg=${1-all}
arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a subSystemArray=(camera dome dm hexapod m1m3 m2ms mtmount rotator tcs) # The scheduler does not currently publish events.
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a argumentsArray=($EMPTY)

#  FUNCTIONS
# Get EFDB_Topics from Events XML.
function getTopics() {
	subSystem=$1
	file=$2
	output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $file |sed "s/${subSystem}_//" |sed "s/logevent_//" )
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

function getParameterCount() {
    file=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/Count" -v . -n $file )
    echo $parameterCount
}

function createSettings() {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    ${subSystemUp}_${topic} sender/logger tests." >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompSenderLogger() {
    echo "Verify Component Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_send" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_log" >> $testSuite
    echo "" >> $testSuite
}

function startSenderInputs() {
    parameter=$EMPTY
    echo "Start Sender - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Sender" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_send $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}   Usage :  input parameters..." >> $testSuite
    echo "" >> $testSuite
}

function startLogger() {
    echo "Start Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Logger." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_log" >> $testSuite
    echo "    \${output}=    Read Until    logger ready =" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    Event \${component} logger ready" >> $testSuite
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
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_send ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [putSample] ${subSystem}::logevent_${topic} writing a message containing :    1" >> $testSuite
    echo "    Should Contain    \${output}    revCode \ :" >>$testSuite
	echo "    Should Contain    \${output}    === Event ${topic} generated =" >> $testSuite
	#for parameter in "${parametersArray[@]}"; do
        #echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$i]}    1" >>$testSuite
		#(( i++ ))
    #done
    echo "" >> $testSuite
}

function readLogger() {
	i=0
	device=$1
	property=$2
    echo "Read Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Logger" >> $testSuite
	# TSS-682
    echo "    \${output}=    Read Until    priority : ${argumentsArray[${#argumentsArray[@]}-1]}" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === Event ${topic} received =     1" >> $testSuite
    for parameter in "${parametersArray[@]}"; do
        echo "    Should Contain    \${output}    $parameter : ${argumentsArray[$i]}" >>$testSuite
		(( i++ ))
    done
}

function createTestSuite() {
	subSystem=$1
	file=$2
	topicIndex=1
	# Get the Subsystem in the correct capitalization.
    subSystemUp=$( capitializeSubsystem $subSystem )
	for topic in "${topicsArray[@]}"; do
		device=$EMPTY
		property=$EMPTY
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${topic}.robot
		
		#  Get EFDB_Topic elements
		getTopicParameters $file $topicIndex
		device=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Device" -v . -n $file )
		property=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Property" -v . -n $file )

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables
		echo "*** Test Cases ***" >> $testSuite
        createSession "Sender"
        createSession "Logger"
        verifyCompSenderLogger
		startSenderInputs
		startLogger

		# Get the arguments to the sender.
		unset argumentsArray
		# Determine the parameter type and create a test value, accordingly.
        for parameter in "${parametersArray[@]}"; do
            parameterIndex=$(getParameterIndex $parameter)
            parameterType=$(getParameterType $file $topicIndex $parameterIndex)
            parameterCount=$(getParameterCount $file $topicIndex $parameterIndex)
            for i in $(seq 1 $parameterCount); do
                testValue=$(python random_value.py $parameterType)
                argumentsArray+=($testValue)
            done
		done
		# The Event priority is a required argument to ALL senders, but is not in the XML definitions.
		# ... As such, manually add this argument as the first element in argumentsArray and parametersArray.
		parametersArray=("${parametersArray[@]}" "priority")
		priority=$(python random_value.py long)
		argumentsArray=("${argumentsArray[@]}" "$priority")
		# Create the Start Sender test case.
		startSender $device $property
		# Create the Read Logger test case.
		readLogger $device $property
		# Indicate completion of the test suite.
		echo Done with test suite.
    	# Move to next Topic.
		(( topicIndex++ ))
	done
}


#  MAIN
if [ "$arg" == "all" ]; then
    for subSystem in "${subSystemArray[@]}"; do
        declare -a filesArray=($HOME/trunk/ts_xml/sal_interfaces/${subSystem}/*_Events.xml)
        # Get the Subsystem in the correct capitalization.
        subSystemUp=$(capitializeSubsystem $subSystem)
        # Delete all the test suites.  This is will expose deprecated topics.
        clearTestSuites $subSystemUp "CPP" "Events"

        for file in "${filesArray[@]}"; do
            getTopics $subSystem $file
            createTestSuite $subSystem $file
        done
    done
    echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $arg ]]; then
    declare -a filesArray=(~/trunk/ts_xml/sal_interfaces/$arg/*_Events.xml)
    subSystemUp=$(capitializeSubsystem $arg)
    #  Delete all the test suites.  This is will expose deprecated topics.
    clearTestSuites $subSystemUp "CPP" "Events"

    for file in "${filesArray[@]}"; do
        getTopics $arg $file
        createTestSuite $arg $file
    done
    echo COMPLETED all test suites for the $arg.
else
    echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

