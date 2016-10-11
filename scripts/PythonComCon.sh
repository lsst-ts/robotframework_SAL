#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/PYTHON/Commands
arg=${1-all}
arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a subSystemArray=(camera dome hexapod m1m3 m2ms mtmount rotator tcs)    # dm and scheduler have no commands
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
	output=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/$subSystem/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" )
	topicsArray=($output)
}

function getTopicParameters() {
	subSystem=$1
	index=$2
	unset parametersArray
	output=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item/EFDB_Name" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
	parametersArray=($output)
}

function getParameterIndex() {
	value=$1
	for i in "${!parametersArray[@]}"; do
		if [[ "${parametersArray[$i]}" == "$value" ]]; then
			parameterIndex="${i}";
		fi
	done
	echo $parameterIndex
}

function getParameterType() {
	subSystem=$1
	index=$2
	itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
	parameterType=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/IDL_Type" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
	echo $parameterType
}

function getParameterCount() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/Count" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
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
    echo "Documentation    ${subSystemUp}_${topic} commander/controller tests." >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Library    String" >> $testSuite
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

function createCommanderSession() {
    echo "Create Commander Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Commander    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "" >> $testSuite
}

function createControllerSession() {
    echo "Create Controller Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=Controller    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"false\"    Login    \${UserName}    \${PassWord}" >> $testSuite
    echo "    Run Keyword If    \"\${ContInt}\"==\"true\"    Login With Public Key    \${UserName}    keyfile=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompCommanderController() {
    echo "Verify Component Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Commander_\${component}.py" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Controller_\${component}.py" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderInputs() {
    parameter=$EMPTY
    echo "Start Commander - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_\${component}.py $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}   ERROR : Invalid or missing arguments :" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderTimeout() {
	echo "Start Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_\${component}.py ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -2" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_\${component}\\\] command )[0-9]+( timed out :)" >>$testSuite
    echo "" >> $testSuite
}
function startController() {
    echo "Start Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Controller." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Controller_\${component}.py" >> $testSuite
    echo "    \${output}=    Read Until    controller ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    \${subSystem}_\${component} controller ready" >> $testSuite
    echo "" >> $testSuite
}

function startCommander() {
	i=0
	n=0
	device=$1
	property=$2
    echo "Start Commander" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_\${component}.py ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand_\${component}] writing a command containing :    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    device :    1" >> $testSuite    #$device TSS-861
    echo "    Should Contain X Times    \${output}    property :    1" >> $testSuite    #$property TSS-861
    echo "    Should Contain X Times    \${output}    action :    1" >> $testSuite    #$action TSS-861
    echo "    Should Contain X Times    \${output}    value :    1" >> $testSuite    #$value TSS-861
	for parameter in "${parametersArray[@]}"; do
		parameterIndex=$(getParameterIndex $parameter)
        parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
        parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
        if [ $i -gt 0 ];then n=$i*$(getParameterCount $subSystem $topicIndex $(($i - 1)));fi # n is the FIRST element in the sub-array (array of arguments associated with a parameter).
        echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$n]}    1" >>$testSuite
		(( i++ ))
    done
	echo "    \${CmdComplete}=    Get Line    \${output}    -2" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_\${component}\\\] command )[0-9]+( completed ok :)" >>$testSuite
    echo "" >> $testSuite
}

function readController() {
	i=0
	n=0
	device=$1
	property=$2
    echo "Read Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    \${output}=    Read Until    result \ \ : Done : OK" >>$testSuite
    echo "    Log    \${output}" >> $testSuite
    #echo "    Should Contain    \${output}    device :" >> $testSuite    #$device TSS-861
    #echo "    Should Contain    \${output}    property :" >> $testSuite    #$property TSS-861
    #echo "    Should Contain    \${output}    action :" >> $testSuite    #$action TSS-861
    #echo "    Should Contain    \${output}    value :" >> $testSuite    #$value TSS-861
    for parameter in "${parametersArray[@]}"; do
		parameterIndex=$(getParameterIndex $parameter)
       	parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
       	parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
		if [ $i -gt 0 ];then n=$i*$(getParameterCount $subSystem $topicIndex $(($i - 1)));fi # n is the FIRST element in the sub-array (array of arguments associated with a parameter).
		if [[ ( $parameterCount -gt 15 ) ]]; then
			string=$( IFS=$','; echo "${argumentsArray[*]:$n:$parameterCount}" |sed "s/,/, /g" )
           	echo "    Should Contain X Times    \${output}    $parameter($parameterCount) = [$string]    1" >>$testSuite
		else
       		echo "    Should Contain X Times    \${output}    $parameter = ${argumentsArray[$n]}    1" >>$testSuite
		fi
		(( i++ ))
    done
	echo "    Should Contain X Times    \${output}    === [ackCommand_${topic}] acknowledging a command with :    1" >> $testSuite
	echo "    Should Contain    \${output}    seqNum   :" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 301" >> $testSuite
    echo "    Should Contain X Times    \${output}    error \ \ \ : 0    1" >> $testSuite
    echo "    Should Contain    \${output}    result   : Ack : OK" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 303" >> $testSuite
    echo "    Should Contain    \${output}    result   : Done : OK" >> $testSuite
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
		device=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Device" -v . -n ~/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
		property=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Property" -v . -n ~/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )

		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables
		echo "*** Test Cases ***" >> $testSuite
		createCommanderSession
		createControllerSession
        verifyCompCommanderController
		startCommanderInputs

		# Get the arguments to the commander.
		unset argumentsArray
		# If the Topic has no parameters (items), just send a string.
		if [ ! ${parametersArray[0]} ]; then
			testValue=$(python random_value.py "string")
			argumentsArray+=($testValue)
		# Otherwise, determine the parameter type and create a test value, accordingly.
		else
				for parameter in "${parametersArray[@]}"; do
  					parameterIndex=$(getParameterIndex $parameter)
					parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
					parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
					for i in $(seq 1 $parameterCount); do
						testValue=$(python random_value.py $parameterType)
						argumentsArray+=($testValue)
					done
			done
		fi
		# Create the Commander Timeout test case.
		startCommanderTimeout
		# Create the Start Controller test case.
		startController
		# Create the Start Commander test case.
		startCommander $device $property
		# Create the Read Controller test case.
		readController $device $property
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
