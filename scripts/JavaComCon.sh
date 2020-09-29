#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controllers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/JAVA/Commands
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/JAVA/Commands
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
    clearTestSuites $arg "Java" "Commands" || exit 1

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
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3  

    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    messaging    java    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
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
    local topic=$2
    local testSuite=$3

    if [ "$topic" == "all" ]; then
        timeout="45s"
    else
        timeout="3s"
    fi
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompCommanderController() {

    local testSuite=$1
    
    echo "Verify Component Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}Commander_all.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}Controller_all.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Commander_all.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Controller_all.java" >> $testSuite
    echo "" >> $testSuite
}

function startJavaCombinedControllerProcess() {
    # Starts the Java Combined Sender program

    local subSystem=$1
    local topic=$2
    local testSuite=$3

    echo "Start Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Executing Combined Java Logger Program." >> $testSuite
    echo "    \${controllerOutput}=    Start Process    mvn    -Dtest\=\${subSystem}Controller_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=controller    stdout=\${EXECDIR}\${/}stdoutController.txt    stderr=\${EXECDIR}\${/}stderrController.txt" >> $testSuite
    echo "    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    \${EXECDIR}\${/}stdoutController.txt" >> $testSuite
    echo "" >> $testSuite
}

function startJavaCombinedCommanderProcess() {
    # Wait for the Controller program to be ready. It will know by a specific text
    # that the program generates. 

    local subSystem=$1
    local topic=$2
    local testSuite=$3

    echo "Start Commander" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    
    echo "    Comment    Commander program waiting for Controller program to be Ready." >> $testSuite
    echo "    \${controllerOutput}=    Get File    \${EXECDIR}\${/}stdoutController.txt" >> $testSuite
    echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "    \\    Exit For Loop If     '${subSystem} all controllers ready' in \$controllerOutput" >> $testSuite
    echo "    \\    \${controllerOutput}=    Get File    \${EXECDIR}\${/}stdoutController.txt" >> $testSuite
    echo "    \\    Sleep    3s" >> $testSuite
    
    echo "    Comment    Executing Combined Java Sender Program." >> $testSuite
    echo "    \${commanderOutput}=    Start Process    mvn    -Dtest\=\${subSystem}Commander_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=commander    stdout=\${EXECDIR}\${/}stdoutCommander.txt    stderr=\${EXECDIR}\${/}stderrCommander.txt" >> $testSuite    
    echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "    \\    \${controllerOutput}=    Get File    \${EXECDIR}\${/}stdoutController.txt" >> $testSuite
    echo "    \\    Run Keyword If    'BUILD SUCCESS' in \$controllerOutput    Set Test Variable    \${controllerCompletionTextFound}    \"TRUE\"" >> $testSuite
    echo "    \\    Exit For Loop If     'BUILD SUCCESS' in \$controllerOutput" >> $testSuite
    echo "    \\    Sleep    3s" >> $testSuite
    
    echo "    Should Be True    \${controllerCompletionTextFound} == \"TRUE\"" >> $testSuite
}

function startCommanderTimeout() {
    echo "Start Commander - Verify Timeout without Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Commander" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Run the Commander test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Commander_\${component}Test test" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    \${CmdComplete}=    Get Line    \${output}    -16" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_\${component}\\\] command )[0-9]+( timed out)" >>$testSuite
    echo "" >> $testSuite
}

function startController() {
    echo "Start Controller" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Controller" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Start the Controller test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Controller_\${component}Test test" >> $testSuite
    #echo "    \${output}=    Read Until    Scanning for projects..." >> $testSuite
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
    echo "    Write    cd \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}" >> $testSuite
    echo "    Comment    Run the Commander test." >> $testSuite
    echo "    \${input}=    Write    mvn -Dtest=\${subSystem}Commander_\${component}Test test" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [issueCommand] \${component} writing a command containing :    1" >> $testSuite
    echo "    \${CmdComplete}=    Get Line    \${output}    -15" >>$testSuite
    echo "    Should Match Regexp    \${CmdComplete}    (=== \\\[waitForCompletion_\${component}\\\] command )[0-9]+( completed ok)" >>$testSuite
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
    echo "    \${output}=    Read Until Prompt" >>$testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    \${subSystem}_\${component} controller ready" >> $testSuite
    echo "    Should Contain    \${output}    ack      : 301" >>$testSuite
    echo "    Should Contain    \${output}    result   : Ack : OK" >>$testSuite
    echo "    Should Contain    \${output}    ack      : 303" >>$testSuite
    echo "    Should Contain    \${output}    result   : Done : OK" >>$testSuite
    echo "    Should Contain X Times    \${output}    seqNum \ \ :    2" >>$testSuite
    echo "    Should Contain X Times    \${output}    error \ \ \ : 0    2" >> $testSuite
    echo "    Should Contain X Times    \${output}    === [ackCommand_\${component}] acknowledging a command with :    2" >> $testSuite
}

function createTestSuite() {
    subSystem=$1
    messageType="commands"
    file=$2
    topicIndex=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    # Generate the test suite for each topic.
    echo ============== Generating Combined messaging test suite ==============
    testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
    echo $testSuiteCombined

    createSettings $subSystem $messageType $testSuiteCombined
    createVariables $subSystem  "all" $testSuiteCombined
    echo "*** Test Cases ***" >> $testSuiteCombined
    verifyCompCommanderController $testSuiteCombined

    startJavaCombinedControllerProcess $subSystem $messageType $testSuiteCombined
    startJavaCombinedCommanderProcess $subSystem $messageType $testSuiteCombined

    # echo Generating:
    # for topic in "${topicsArray[@]}"; do
    #     device=$EMPTY
    #     property=$EMPTY
    #     #  Define test suite name
    #     testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
    #
    #     #  Get EFDB_Topic elements
    #     getTopicParameters $file $topicIndex
    #     device=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Device" -v . -n ${file} )
    #     property=$( xml sel -t -m "//SALCommandSet/SALCommand[$topicIndex]/Property" -v . -n ${file} )
    #
    #     #  Check if test suite should be skipped.
    #     skipped=$(checkIfSkipped $subSystem $topic $messageType)
    #
    #     #  Create test suite.
    #     echo $testSuite
    #     createSettings $subSystem
    #     createVariables $subSystem
    #     echo "*** Test Cases ***" >> $testSuite
    #     verifyCompCommanderController
    #     #startCommanderInputs
    #
    #     # Get the arguments to the commander.
    #     unset argumentsArray
    #     # If the Topic has no parameters (items), just send a string.
    #     if [ ! ${parametersArray[0]} ]; then
    #         testValue=$(python random_value.py "state")
    #         argumentsArray+=($testValue)
    #     # Otherwise, determine the parameter type and create a test value, accordingly.
    #     else
    #         for parameter in "${parametersArray[@]}"; do
      #             parameterIndex=$(getParameterIndex $parameter)
    #             parameterType=$(getParameterType $subSystem $topicIndex $parameterIndex)
    #             parameterCount=$(getParameterCount $subSystem $topicIndex $parameterIndex)
    #             parameterIDLSize=$(getParameterIDLSize $subSystem $topicIndex $parameterIndex)
    #             #echo "parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "parameterIDLSize:"$parameterIDLSize
    #             for i in $(seq 1 $parameterCount); do
    #                 testValue=$(generateArgument "$parameterType" $parameterIDLSize)
    #                 argumentsArray+=( $testValue )
    #             done
    #         done
    #     fi
    #     # Create the Commander Timeout test case.
    #     startCommanderTimeout
    #     # Create the Start Controller test case.
    #     startController
    #     # Create the Start Commander test case.
    #     startCommander $device $property
    #     # Create the Read Controller test case.
    #     readController $device $property
    #     # Move to next Topic.
    #     (( topicIndex++ ))
    # done
    echo ""
}

#### Call the main() function ####
main $1
