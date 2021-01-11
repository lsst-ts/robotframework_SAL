#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/JAVA/Events
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/JAVA/Events
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a argumentsArray=($EMPTY)
declare -a generic_events=($(xml sel -t -m "//SALObjects/SALEventSet/SALEvent/EFDB_Topic" -v . -n $TS_XML_DIR/sal_interfaces/SALGenerics.xml |cut -d"_" -f 3 ))

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
    arg=$1

    # Get the XML definition file. This requires the CSC be capitalized properly. This in done in the _common.sh.getEntity() function.
    subsystem=$(getEntity $arg)
    file=($TS_XML_DIR/sal_interfaces/$subsystem/*_Events.xml)

    # Now generate the test suites.
    if [[ "$rtlang" =~ "java" ]]; then
        # Delete all test associated test suites first, to catch any removed topics.
        clearTestSuites $arg "JAVA" "Events" || exit 1
        # Create test suite.
        createTestSuite $arg $file || exit 1
    else
        echo Skipping: $subsystem has no Java Event topics.
        return 0
    fi
}

#  Local FUNCTIONS

# Get EFDB_Topics from Events XML.
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
    subSystem=$1
    index=$2
    itemIndex=$(($3 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    parameterIDLSize=$( xml sel -t -m "//SALEventSet/SALEvent[$index]/item[$itemIndex]/IDL_Size" -v . -n $TS_XML_DIR/sal_interfaces/${subSystem}/${subSystem}_Events.xml )
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
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3

    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    messaging    java    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${Build_Number}    \${MavenVersion}    \${timeout}" >> $testSuite
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
    local testSuite=$2
    local topic=$3

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

function verifyCompSenderLogger() {
    local testSuite=$1
    echo "Verify Component Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}Event_\${component}.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/\${subSystem}EventLogger_\${component}.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}-\${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}/src/test/java/\${subSystem}Event_\${component}.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}-\${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}/src/test/java/\${subSystem}EventLogger_\${component}.java" >> $testSuite
    echo "" >> $testSuite
}

function startJavaCombinedLoggerProcess() {
    # Starts the Java Combined Sender program in the background. Verifies that 
    # the process is executing. Since "Start Process" is being used, the 
    # startJavaCombinedSenderProcess function creates a robot test that will 
    # wait for text indicating that the logger is ready to appear or timeout. 
    # This is necessary otherwise the robot program will close before any of the 
    # processes have time to complete and communicate with each other which is 
    # what these robot files are testing.

    local subSystem=$1
    local topic=$2
    local testSuite=$3

    echo "Start Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Executing Combined Java Logger Program." >> $testSuite
    echo "    \${loggerOutput}=    Start Process    mvn    -Dtest\=\${subSystem}EventLogger_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}-\${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}/    alias=logger    stdout=\${EXECDIR}\${/}stdoutLogger.txt    stderr=\${EXECDIR}\${/}stderrLogger.txt" >> $testSuite    
    echo "    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    \${EXECDIR}\${/}stdoutLogger.txt" >> $testSuite
    echo "" >> $testSuite
}

function startJavaCombinedSenderProcess() {
    # Wait for the Logger program to be ready. It will know by a specific text
    # that the program generates. 

    local subSystem=$1
    local topic=$2
    local testSuite=$3

    echo "Start Sender" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Sender program waiting for Logger program to be Ready." >> $testSuite
    echo "    \${loggerOutput}=    Get File    \${EXECDIR}\${/}stdoutLogger.txt" >> $testSuite
    echo "    FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "        Exit For Loop If     '${subSystem} all loggers ready' in \$loggerOutput" >> $testSuite
    echo "        \${loggerOutput}=    Get File    \${EXECDIR}\${/}stdoutLogger.txt" >> $testSuite
    echo "        Sleep    3s" >> $testSuite
    echo "    END" >> $testSuite
    echo "    Comment    Executing Combined Java Sender Program." >> $testSuite
    echo "    \${senderOutput}=    Start Process    mvn    -Dtest\=\${subSystem}Event_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}-\${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}/    alias=sender    stdout=\${EXECDIR}\${/}stdoutSender.txt    stderr=\${EXECDIR}\${/}stderrSender.txt" >> $testSuite    
    echo "    FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "        \${loggerOutput}=    Get File    \${EXECDIR}\${/}stdoutLogger.txt" >> $testSuite
    echo "        Run Keyword If    'BUILD SUCCESS' in \$loggerOutput    Set Test Variable    \${loggerCompletionTextFound}    \"TRUE\"" >> $testSuite
    echo "        Exit For Loop If     'BUILD SUCCESS' in \$loggerOutput" >> $testSuite
    echo "        Sleep    3s" >> $testSuite
    echo "    END" >> $testSuite
    echo "    Should Be True    \${loggerCompletionTextFound} == \"TRUE\"" >> $testSuite
}

function createTestSuite() {
    subSystem=$1
    messageType="events"
    file=$2
    topicIndex=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    # Generate the test suite for each topic.
    echo ============== Generating Combined messaging test suite ==============
    testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
    echo $testSuiteCombined
    createSettings $subSystem $messageType $testSuiteCombined
    createVariables $subSystem $testSuiteCombined "all"
    echo "*** Test Cases ***" >> $testSuiteCombined
    verifyCompSenderLogger $testSuiteCombined

    startJavaCombinedLoggerProcess $subSystem $messageType $testSuiteCombined
    startJavaCombinedSenderProcess $subSystem $messageType $testSuiteCombined
    #readLogger $file $topicIndex $testSuiteCombined    

    echo ==== Combined test generation complete ====
    echo ""
}

#### Call the main() function ####
main $1
