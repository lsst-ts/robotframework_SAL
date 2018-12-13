#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $HOME/trunk/robotframework_SAL/scripts/_common.sh

#  Define variables to be used in script
workDir=$HOME/trunk/robotframework_SAL/JAVA/StateMachine
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
    clearTestSuites $arg "JAVA" "StateMachine" || exit 1

    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

function createSettings() {
    local subSystem=$1
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    java    $skipped" >> $testSuite
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
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${timeout}    60s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompCommanderController() {
    state=$1
    echo "Verify $state Component Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}Commander_${state}Test.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}Controller_${state}Test.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Commander_${state}Test.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Controller_${state}Test.java" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderInputs() {
	state=$1
    parameter=$EMPTY
    echo "Start $state Commander - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_${state}_commander $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    Usage : \\ input parameters..." >> $testSuite
    echo "    Should Contain    \${output}    $parameterType;" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderTimeout() {
	state=$1
	echo "Start $state Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Run the Commander test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Commander_${state}Test test" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -16" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_${state}\\\] command )([0-9]+)( timed out)" >>$testSuite
    echo "" >> $testSuite
}

function startController() {
	state=$1
    echo "Start $state Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Start the Controller test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Controller_${state}Test test" >> $testSuite
    #echo "    \${output}=    Read Until    Scanning for projects..." >> $testSuite
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
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Run the Commander test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Commander_${state}Test test" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand] ${state} writing a command containing :    1" >> $testSuite
	echo "    \${CmdComplete}=    Get Line    \${output}    -15" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_${state}\\\] command )[0-9]+( completed ok)" >>$testSuite
    echo "" >> $testSuite
}

function readController() {
	state=$1
    echo "Read $state Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >>$testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    \${subSystem}_${state} controller ready" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 301" >>$testSuite
    echo "    Should Contain    \${output}    result   : Ack : OK" >>$testSuite
    echo "    Should Contain    \${output}    ack      : 303" >>$testSuite
    echo "    Should Contain    \${output}    result   : Done : OK" >>$testSuite
    echo "    Should Contain X Times    \${output}    seqNum \ \ :    2" >>$testSuite
    echo "    Should Contain X Times    \${output}    error \ \ \ : 0    2" >> $testSuite
	echo "    Should Contain X Times    \${output}    === [ackCommand_${state}] acknowledging a command with :    2" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
	subSystem=$1
    messageType="state"
	stateIndex=1

	#  Define test suite name
	testSuite=$workDir/$(capitializeSubsystem $subSystem)_StateMachine.robot

	# Check if CSC uses the Generic topics (most do, but a few do not).
    # ... If not, skip this CSC.
    output=$( xml sel -t -m "//SALSubsystems/Subsystem/Name[text()='${subSystem}']/../Generics" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    if [ "$output" == "no" ]; then
        echo "The $subSystem CSC does not use the Generic topics. Exiting."; exit 0
    fi 

    # Generate the test suite for each topic.
    echo Generating $testSuite:
	createSettings $subSystem
	createVariables $subSystem
	echo "*** Test Cases ***" >> $testSuite
	for state in "start" "enable" "disable" "standby" "exitControl"; do
		if [ "$state" == "start" ]; then
			parameterType="settingsToApply"
		else
			parameterType="value"
		fi
		property=$EMPTY
		
        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $topic $messageType)

        verifyCompCommanderController $state
		# Create the Start Controller test case.
		startController $state
		# Create the Start Commander test case.
		startCommander $state $device $property
		# Create the Read Controller test case.
		readController $state $device $property
    	# Move to next Topic.
		(( stateIndex++ ))
	done
    echo ""
}

#### Call the main() function ####
main $1
