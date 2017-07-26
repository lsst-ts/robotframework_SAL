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
arg=${1-all}
arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a subSystemArray=($(subsystemArray))
declare -a statesArray=($(stateArray))

#  FUNCTIONS
# Get the subsystem variable in the correct format.
function clearTestSuite() {
    if [ -f $testSuite ]; then
        echo $testSuite exists.  Deleting it before creating a new one.
        rm -rf $testSuite
    fi
}

function createSettings() {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    ${subSystemUp} State Machine tests." >> $testSuite
    echo "Force Tags    python" >> $testSuite
	echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
	echo "...    AND    Create Session    Commander    AND    Create Session    Controller" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
	local subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $state" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
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
    echo "    Should Contain    \${output}   ERROR : Invalid or missing arguments : $parameterType" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderTimeout() {
	echo "Start Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    python \${subSystem}_Commander_\${component}.py 0" >> $testSuite
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
    echo "    \${input}=    Write    python \${subSystem}_Commander_\${component}.py 1" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand_\${component}] writing a command containing :    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    device :    1" >> $testSuite    #$device TSS-861
    echo "    Should Contain X Times    \${output}    property :    1" >> $testSuite    #$property TSS-861
    echo "    Should Contain X Times    \${output}    action :    1" >> $testSuite    #$action TSS-861
    echo "    Should Contain X Times    \${output}    value :    1" >> $testSuite    #$value TSS-861
    echo "    Should Contain X Times    \${output}    $parameterType : 1    1" >>$testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -2" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_\${component}\\\] command )[0-9]+( completed ok :)" >>$testSuite
    echo "" >> $testSuite
}

function readController() {
    echo "Read Controller" >> $testSuite
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
}

function createTestSuite() {
	subSystem=$1
	stateIndex=1
	for state in "${statesArray[@]}"; do
		if [ "$state" == "start" ]; then
			parameterType="configuration"
		else
			parameterType="state"
		fi
		property=$EMPTY
		#  Define test suite name
		testSuite=$workDir/${subSystemUp}_${state}.robot
		
		#  Check to see if the TestSuite exists then, if it does, delete it.
		clearTestSuite
		
		#  Create test suite.
		echo Creating $testSuite
		createSettings
		createVariables $subSystem
		echo "*** Test Cases ***" >> $testSuite
        verifyCompCommanderController
		startCommanderInputs
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
		(( stateIndex++ ))
	done
    echo ""
}


#  MAIN
if [ "$arg" == "all" ]; then
	for subsystem in "${subSystemArray[@]}"; do
		# Get the Subsystem in the correct capitalization.
        subSystemUp=$(capitializeSubsystem $subsystem)
		subSystem=$(getEntity $subsystem)
		createTestSuite $subSystem
	done
	echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $arg ]]; then
	# Get the Subsystem in the correct capitalization.
    subSystemUp=$(capitializeSubsystem $arg)
	subSystem=$(getEntity $arg)
	createTestSuite $subSystem
	echo COMPLETED all test suites for the $arg.
else
	echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

