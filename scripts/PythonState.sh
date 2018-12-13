#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/PYTHON/StateMachine
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a statesArray=($(stateArray))

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
    arg=$1

    # Get the XML definition file.
    file=($HOME/trunk/ts_xml/sal_interfaces/SALGenerics.xml)
    
    # Delete all test associated test suites first, to catch any removed topics.
    clearTestSuites $arg "PYTHON" "StateMachine" || exit 1
    
    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

function createSettings() {
    local subSystem=$1
    local topic=$2
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $subSystem StateMachine Python communications tests." >> $testSuite
    echo "Force Tags    python    $skipped" >> $testSuite
	echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
	echo "...    AND    Create Session    Commander    AND    Create Session    Controller" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
	local subSystem=$1
    local state=$2
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCommanderController() {
    state=$1
    echo "Verify $state Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Commander_${state}.py" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Controller_${state}.py" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderInputs() {
    state=$1
    parameter=$EMPTY
    echo "Start $state Commander - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_${state}.py $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}   ERROR : Invalid or missing arguments : $parameterType" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderTimeout() {
    state=$1
	echo "Start $state Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_${state}.py 0" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -2" >> $testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_${state}\\\] command )[0-9]+( timed out :)" >> $testSuite
    echo "" >> $testSuite
}

function startController() {
    state=$1
    echo "Start $state Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Controller." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Controller_${state}.py" >> $testSuite
    echo "    \${output}=    Read Until    controller ready" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    \${subSystem}_${state} controller ready" >> $testSuite
    echo "" >> $testSuite
}

function startCommander() {
	i=0
	n=0
    state=$1
	device=$2
	property=$3
    echo "Start $state Commander" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_${state}.py 1" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand_${state}] writing a command containing :    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    device :    1" >> $testSuite    #$device TSS-861
    echo "    Should Contain X Times    \${output}    property :    1" >> $testSuite    #$property TSS-861
    echo "    Should Contain X Times    \${output}    action :    1" >> $testSuite    #$action TSS-861
    echo "    Should Contain X Times    \${output}    itemValue :    1" >> $testSuite    #$value TSS-861
    echo "    Should Contain X Times    \${output}    $parameterType : 1    1" >> $testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -2" >> $testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_${state}\\\] command )[0-9]+( completed ok :)" >> $testSuite
    echo "" >> $testSuite
}

function readController() {
    state=$1
    echo "Read $state Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    \${output}=    Read Until    result \ \ : Done : OK" >>$testSuite
    echo "    Log    \${output}" >> $testSuite
    #echo "    Should Contain X Times    \${output}    device :    1" >> $testSuite    #$device TSS-861
    #echo "    Should Contain X Times    \${output}    property :    1" >> $testSuite    #$property TSS-861
    #echo "    Should Contain X Times    \${output}    action :    1" >> $testSuite    #$action TSS-861
    #echo "    Should Contain X Times    \${output}    value :    1" >> $testSuite    #$value TSS-861
    echo "    Should Contain X Times    \${output}    $parameterType = 1    1" >>$testSuite
	echo "    Should Contain X Times    \${output}    === [ackCommand_${state}] acknowledging a command with :    1" >> $testSuite
	echo "    Should Contain    \${output}    seqNum   :" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 303" >> $testSuite
    echo "    Should Contain    \${output}    error \ \ \ : 0    1" >> $testSuite
    echo "    Should Contain    \${output}    result   : Done : OK" >> $testSuite
    echo "" >> $testSuite
}

function terminateController() {
	state=$1
	echo "Terminate $state Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    \${crtl_c}    Evaluate    chr(int(3))" >> $testSuite
    echo "    Write Bare    \${crtl_c}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Should Contain    \${output}    KeyboardInterrupt" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
	subSystem=$1
    messageType="state"
	stateIndex=1

	# Check if CSC uses the Generic topics (most do, but a few do not).
    # ... If not, skip this CSC.
    output=$( xml sel -t -m "//SALSubsystems/Subsystem/Name[text()='${subSystem}']/../Generics" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    if [ "$output" == "no" ]; then
        echo "The $subSystem CSC does not use the Generic topics. Exiting."; exit 0
    fi

	# Generate the test suite for each topic.
	testSuite=$workDir/$(capitializeSubsystem $subSystem)_StateMachine.robot
    echo Generating $testSuite:
	#  Create test suite.
	echo $testSuite
	createSettings $subSystem
	createVariables $subSystem
	echo "*** Test Cases ***" >> $testSuite
	for state in "start" "enable" "disable" "standby" "exitControl"; do
		if [ "$state" == "start" ]; then
			parameterType="settingsToApply"
		elif [ "${state}" == "SetValue" ]; then
            parameterType="json_parameters"
		else
			parameterType="value"
		fi
		property=$EMPTY
		
        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $state $messageType)

        verifyCommanderController $state
		# Create the Start Controller test case.
		startController $state
		# Create the Start Commander test case.
		startCommander $state $device $property
		# Create the Read Controller test case.
		readController $state $device $property
		# Kill the Controller process.
		terminateController $state
    	# Move to next Topic.
		(( stateIndex++ ))
	done
    echo ""
}

#### Call the main() function ####
main $1
