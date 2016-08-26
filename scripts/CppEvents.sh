#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/CPP/Events
arg=${1-all}
arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a subSystemArray=(camera dome dm hexapod m1m3 m2ms mtmount rotator scheduler tcs)
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a argumentsArray=($EMPTY)

#  FUNCTIONS
# Get the subsystem variable in the correct format.
function getSubSystem() {
	if [ "$1" == "mtmount" ]; then
		echo MTMount
	else
		echo $1
	fi
}

# Get EFDB_Topics from Telemetry XML.
function getTopics() {
	subSystem=$1
	if [ $(xml sel -t -v "count(//SALEventSet/SALEvent/Alias)" $HOME/trunk/ts_xml/sal_interfaces/$subSystem/${subSystem}_Events.xml) ]; then
		output=$( xml sel -t -m "//SALEventSet/SALEvent/Alias" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$subSystem/${subSystem}_Events.xml )
	else
		output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$subSystem/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" )
	fi
	topicsArray=($output)
}

function getTopicParameters() {
	subSystem=$1
	index=$2
	unset parametersArray
	output=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item/EFDB_Name" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
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
	parameterType=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Type" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
	echo $parameterType
}

function getParameterCount() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/Count" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
    echo $parameterCount
}

function clearTestSuite() {
    if [ -f $testSuite ]; then
        echo $testSuite exists.  Deleting it before creating a new one.
        rm -rf $testSuite
    fi
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

function createSenderSession() {
    echo "Create Sender Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Sender    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "" >> $testSuite
}

function createLoggerSession() {
    echo "Create Logger Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Logger    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
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
		device=$EMPTY
		property=$EMPTY
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${topic}.robot
		
		#  Check to see if the TestSuite exists then, if it does, delete it.
		clearTestSuite
		
		#  Get EFDB_Topic elements
		getTopicParameters $subSystem $topicIndex
		device=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Device" -v . -n ~/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
		property=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Property" -v . -n ~/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml )

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables
		echo "*** Test Cases ***" >> $testSuite
		createSenderSession
		createLoggerSession
        verifyCompSenderLogger
		startSenderInputs
		startLogger

		# Get the arguments to the sender.
		unset argumentsArray
		# If the Topic has no parameters (items), just send a string.
		if [ ! ${parametersArray[0]} ]; then
			testValue=$(python random_value.py "int")
			argumentsArray+=($testValue)
		# Otherwise, determine the parameter type and create a test value, accordingly.
		else
                for i in "${parametersArray[@]}"; do
                    parameterIndex=$(getParameterIndex $i)
                    parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
                    parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
                    for i in $(seq 1 $parameterCount); do
                        testValue=$(python random_value.py $parameterType)
                        argumentsArray+=($testValue)
                    done
            done
        fi
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
	for i in "${subSystemArray[@]}"; do
		subSystem=$(getSubSystem $i)
		getTopics $subSystem
		createTestSuite $subSystem
	done
	echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $arg ]]; then
	subSystem=$(getSubSystem $arg)
	getTopics $subSystem
	createTestSuite $subSystem
	echo COMPLETED all test suites for the $arg.
else
	echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

