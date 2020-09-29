#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/CPP/Commands
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
    file=($TS_XML_DIR/sal_interfaces/$subsystem/*_Commands.xml)

    # Delete all test associated test suites first, to catch any removed topics.
    clearTestSuites $arg "CPP" "Commands" || exit 1

    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

# Get EFDB_Topics from Command XML.
function getTopics() {
    subSystem=$(getEntity $1)
    file=$2
    output=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n ${file} |cut -d"_" -f 3 )
    topicsArray=($output)
}

function getTopicParameters() {
    file=$1
    index=$2
    unset parametersArray
    output=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item/EFDB_Name" -v . -n ${file} )
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
    parameterType=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/IDL_Type" -v . -n $TS_XML_DIR/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
    echo $parameterType
}

function getParameterIDLSize() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterIDLSize=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/IDL_Size" -v . -n $TS_XML_DIR/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
    echo $parameterIDLSize
}

function getParameterCount() {
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterCount=$( xml sel -t -m "//SALCommandSet/SALCommand[$index]/item[$itemIndex]/Count" -v . -n $TS_XML_DIR/sal_interfaces/${subSystem}/${subSystem}_Commands.xml )
    echo $parameterCount
}

function createSettings() {
    local subSystem=$1
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    messaging    cpp    $skipped" >> $testSuite
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
    subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompCommanderController() {
    echo "Verify Component Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_commander" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_controller" >> $testSuite
    echo "" >> $testSuite
}

function startCommanderInputs() {
    parameter=$EMPTY
    echo "Start Commander - Verify Missing Inputs Error" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_commander $parameter" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}   Usage : \\ input parameters..." >> $testSuite
    echo "" >> $testSuite
}

function startCommanderTimeout() {
    echo "Start Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_commander ${argumentsArray[*]}" >> $testSuite
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
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Controller." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_controller" >> $testSuite
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
    echo "    Write    cd \${SALWorkDir}/\${subSystem}/cpp/src" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    echo "    \${input}=    Write    ./sacpp_\${subSystem}_\${component}_commander ${argumentsArray[*]}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand_\${component}] writing a command containing :    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    device : $device    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    property : $property    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    action : $action    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    value : $value    1" >> $testSuite
    if [ ! ${parametersArray[0]} ]; then
        echo "    Should Contain X Times    \${output}    state : ${argumentsArray[0]}    1" >>$testSuite
    else
        for parameter in "${parametersArray[@]}"; do
            if [ $i -gt 0 ];then n=$i*$(getParameterCount $subSystem $topicIndex $(($i - 1)));fi # n is the FIRST element in the sub-array (array of arguments associated with a parameter).
            echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$n]}    1" >>$testSuite
            (( i++ ))
        done
    fi
    echo "    Should Contain    \${output}    === command $topic issued =" >>$testSuite
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
    echo "    \${output}=    Read Until    result \ \ : Done : OK" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    === command ${topic} received =" >> $testSuite
    echo "    Should Contain    \${output}    device : $device" >> $testSuite
    echo "    Should Contain    \${output}    property : $property" >> $testSuite
    echo "    Should Contain    \${output}    action : $action" >> $testSuite
    echo "    Should Contain    \${output}    value : $value" >> $testSuite
    if [ ! ${parametersArray[0]} ]; then
        echo "    Should Contain X Times    \${output}    state : ${argumentsArray[0]}    1" >>$testSuite
    else
        for parameter in "${parametersArray[@]}"; do
            if [ $i -gt 0 ];then n=$i*$(getParameterCount $subSystem $topicIndex $(($i - 1)));fi # n is the FIRST element in the sub-array (array of arguments associated with a parameter).
            echo "    Should Contain X Times    \${output}    $parameter : ${argumentsArray[$n]}    1" >>$testSuite
            (( i++ ))
        done
    fi
    echo "    Should Contain X Times    \${output}    === [ackCommand_${topic}] acknowledging a command with :    2" >> $testSuite
    echo "    Should Contain    \${output}    seqNum   :" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 301" >> $testSuite
    echo "    Should Contain X Times    \${output}    error \ \ \ : 0    2" >> $testSuite
    echo "    Should Contain    \${output}    result   : Ack : OK" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 303" >> $testSuite
    echo "    Should Contain    \${output}    result   : Done : OK" >> $testSuite
}

function createTestSuite() {
    subSystem=$1
    messageType="commands"
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
        device=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Device" -v . -n ${file} )
        property=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Property" -v . -n ${file} )

        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $topic $messageType)

        #  Create test suite.
        echo $testSuite
        createSettings $subSystem
        createVariables $subSystem
        echo "*** Test Cases ***" >> $testSuite
        verifyCompCommanderController
        startCommanderInputs

        # Get the arguments to the commander.
        unset argumentsArray
        # If the Topic has no parameters (items), just send a string.
        if [ ! ${parametersArray[0]} ]; then
            testValue=$(python random_value.py "state")
            argumentsArray+=($testValue)
        # Otherwise, determine the parameter type and create a test value, accordingly.
        else
            for parameter in "${parametersArray[@]}"; do
                parameterIndex=$(getParameterIndex $parameter)
                parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
                parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
                parameterIDLSize=$(getParameterIDLSize $subSystem $topicIndex $parameterIndex)
                #echo "parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "parameterIDLSize:"$parameterIDLSize
                for i in $(seq 1 $parameterCount); do
                    testValue=$(generateArgument "$parameterType" $parameterIDLSize)
                    argumentsArray+=( $testValue )
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
        # Move to next Topic.
        (( topicIndex++ ))
    done
    echo ""
}

#### Call the main() function ####
main $1
