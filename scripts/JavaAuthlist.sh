#!/bin/bash
#  Shellscript to create test suites for the C++
#  AuthList test script.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh


#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/AuthList/JAVA

#  Determine what tests to generate.
function main() {
    subSystem=$1

    # Skip the Test CSC, as it is a testing artifact
    if [[ "$subSystem" == "Test" ]]; then
        echo "Skipping the Test CSC." && exit 0
    fi

    # Get the RuntimeLanguages list
    rtlang=($(getRuntimeLanguages $subSystem))

    # Now generate the test suites.
    if [[ "$rtlang" =~ "java" ]]; then
        # Delete all test associated test suites first, to catch any removed topics.
        echo "=== Deleting C++ AuthList test suite ==="
        rm -vf $workDir/${subSystem}* || exit 1
        # Create test suite.
        createTestSuite $subSystem || exit 1
    else
        echo Skipping: $subSystem has no Java AuthList topics.
        return 0
    fi
}

### Local FUNCTIONS ###

function createSettings {
    local subSystem=$1
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $subSystem AuthList tests." >> $testSuite
    echo "Force Tags    authlist    java    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${timeout}    \${subSystem}    \${component}" >> $testSuite
    echo "Suite Teardown    Terminate All Processes" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Collections" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}Global_Vars.robot" >> $testSuite
    echo "" >> $testSuite
}

function createVariables {
    local subSystem=$1
    local testSuite=$2
    local topic=$3
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    15s" >> $testSuite
    echo "" >> $testSuite
}

function verifyAuthlistTestFiles {
    local testSuite=$1
    echo "Verify ${subSystem} AuthList test files" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/java_\${subSystem}_authList_commander" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/java_\${subSystem}_setLogLevel_commander" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/java_\${subSystem}_setLogLevel_controller" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/testAuthList.sh" >> $testSuite
    echo "" >> $testSuite
}

function startAuthlistTestScript {
    local testSuite=$1
    echo "Execute ${subSystem} AuthList test script" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start script." >> $testSuite
    echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/java/src/testAuthList.sh    alias=\${subSystem}_authlist    shell=True    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Comment    ======= Verify \${subSystem} AuthList test messages =======" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Starting java_\${subSystem}_setLogLevel_controller" >> $testSuite
    echo "    Should Contain    \${output.stdout}    \${subSystem}_setLogLevel controller ready" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Finished testing authList with \${subSystem}" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=0" >> $testSuite
    echo "    Set Suite Variable    \${output}" >> $testSuite
    echo "    Set Suite Variable    \${full_list}" >> $testSuite
    echo "" >> $testSuite
}

function verifyFirstTest {
    local testSuite=$1
    local identity=$2
    echo "Verify First AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList not set at all, default identity=\${subSystem}" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList not set at all, default identity=\${subSystem}" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setAuthList writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers :\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs :\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setAuthList] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    === [putSample logevent_authList] writing a message containing :" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Ack : OK" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Done : OK" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    3" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * completed ok*" >> $testSuite
    echo "" >> $testSuite
}


function verifySecondTest {
    local testSuite=$1
    local identity="user@host"
    echo "Verify Second AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList not set at all, identity=user@host" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList not set at all, identity=user@host" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*" >> $testSuite
    echo "" >> $testSuite
}


function verifyThirdTest {
    local testSuite=$1
    local identity="user@host"
    echo "Verify Third AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host, identity=user@host" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host, identity=user@host" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setAuthList writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setAuthList] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    === [putSample logevent_authList] writing a message containing :" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Ack : OK" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Done : OK" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs :\${SPACE}    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    3" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * completed ok*" >> $testSuite
    echo "" >> $testSuite
}


function verifyFourthTest {
    local testSuite=$1
    local identity="user@host"
    echo "Verify Fourth AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setAuthList writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setAuthList] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Ack : OK" >> $testSuite
    echo "    Should Contain    \${test_output}    === [putSample logevent_authList] writing a message containing :" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Done : OK" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host,user2@other    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs :\${SPACE}    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    3" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * completed ok*" >> $testSuite
    echo "" >> $testSuite
}


function verifyFifthTest {
    local testSuite=$1
    local identity="user2@other"
    echo "Verify Fifth AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setAuthList writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setAuthList] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Ack : OK" >> $testSuite
    echo "    Should Contain    \${test_output}    === [putSample logevent_authList] writing a message containing :" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Done : OK" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs :\${SPACE}    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host,user2@other    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    3" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * completed ok*" >> $testSuite
    echo "" >> $testSuite
}


function verifySixthTest {
    local testSuite=$1
    local identity="user2@other"
    echo "Verify Sixth AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setAuthList writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    === [ackCommand_setAuthList] acknowledging a command with :" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs : Test    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host,user2@other    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    3" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * completed ok*" >> $testSuite
    echo "" >> $testSuite
}


function verifySeventhTest {
    local testSuite=$1
    local identity="Test"
    echo "Verify Seventh AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*" >> $testSuite
    echo "" >> $testSuite
}


function verifyEighthTest {
    local testSuite=$1
    local identity="MTM2"
    echo "Verify Eighth AuthList Test" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,MTM2,Test identity=MTM2" >> $testSuite
    echo "    \${start}=    Get Index From List    \${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,MTM2,Test identity=MTM2" >> $testSuite
    echo "    \${end}=    Get Index From List    \${full_list}    =====================================================================    start=\${start}" >> $testSuite
    echo "    \${test_output}=    Get Slice From List    \${full_list}    start=\${start}    end=\${end}" >> $testSuite
    echo "    Log    \${test_output}" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setAuthListTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    === command setAuthList received =\${SPACE}" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host,user2@other" >> $testSuite
    echo "    Should Contain    \${test_output}    Running org.lsst.sal.junit.\${subSystem}.\${subSystem}Commander_setLogLevelTest" >> $testSuite
    echo "    Should Contain    \${test_output}    === [issueCommand] setLogLevel writing a command" >> $testSuite
    echo "    Should Contain    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: OK" >> $testSuite
    echo "    Should Contain    \${test_output}    === [putSample logevent_authList] writing a message containing :" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}authorizedUsers : user@host,user2@other    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}nonAuthorizedCSCs : MTM1M3,MTM2,Test    1" >> $testSuite
    echo "    Should Contain X Times    \${test_output}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}identity : ${identity}    1" >> $testSuite
    echo "    Should Contain Match    \${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*" >> $testSuite
    echo "    Sleep    10s    Allow DDS threads to finish" >> $testSuite
    echo "" >> $testSuite
}


function createTestSuite {
    subSystem=$1
    messageType="authlist"

    # The identity value is different for indexed CSCs. 
    # This if-else block handles the various cases.
    enumeration=$( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']/IndexEnumeration" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    if [[ "$enumeration" == "no" ]]; then
        identity="$subSystem"
    elif [[ "$enumeration" == "any" ]]; then
        identity="${subSystem}:1"
    else
        identity="${subSystem}:1"
    fi

    # Generate the test suite for each message type.
    echo ==== Generating AuthList messaging test suite ====
    testSuite=$workDir/${subSystem}_AuthList.robot
    echo $testSuite
    createSettings $subSystem $messageType $testSuite
    createVariables $subSystem $testSuite "all"
    echo "*** Test Cases ***" >> $testSuite
    verifyAuthlistTestFiles $testSuite
    startAuthlistTestScript $testSuite
    verifyFirstTest $testSuite $identity
    verifySecondTest $testSuite $identity
    verifyThirdTest $testSuite $identity
    verifyFourthTest $testSuite $identity
    verifyFifthTest $testSuite $identity
    verifySixthTest $testSuite $identity
    verifySeventhTest $testSuite $identity
    verifyEighthTest $testSuite $identity
    echo ============== AuthList test generation complete ==============
    echo ""
}

#### Call the main() function ####
main $1
