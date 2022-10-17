*** Settings ***
Documentation    MTCamera AuthList tests.
Force Tags    authlist    java    CAP-933
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
${component}    all
${timeout}    15s

*** Test Cases ***
Verify MTCamera AuthList test files
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/java_${subSystem}_authList_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/java_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/java_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/testAuthList.sh

Execute MTCamera AuthList test script
    [Tags]    functional
    Comment    Start script.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/java/src/testAuthList.sh    alias=${subSystem}_authlist    shell=True    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem} AuthList test messages =======
    Should Contain    ${output.stdout}    Starting java_${subSystem}_setLogLevel_controller
    Should Contain    ${output.stdout}    ${subSystem}_setLogLevel controller ready
    Should Contain    ${output.stdout}    Finished testing authList with ${subSystem}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Set Suite Variable    ${output}
    Set Suite Variable    ${full_list}

Verify First AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList not set at all, default identity=${subSystem}
    ${start}=    Get Index From List    ${full_list}    Test with authList not set at all, default identity=${subSystem}
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setAuthList writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers :${SPACE}
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [putSample logevent_authList] writing a message containing :
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : ${subSystem}    3
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * completed ok*

Verify Second AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList not set at all, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList not set at all, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*

Verify Third AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setAuthList writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [putSample logevent_authList] writing a message containing :
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : user@host    3
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * completed ok*

Verify Fourth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setAuthList writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [putSample logevent_authList] writing a message containing :
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : user@host    3
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * completed ok*

Verify Fifth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setAuthList writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [putSample logevent_authList] writing a message containing :
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : user2@other    3
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * completed ok*

Verify Sixth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setAuthList writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : Test    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : user2@other    3
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * completed ok*

Verify Seventh AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*

Verify Eighth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,Test identity=MTM1M3
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,Test identity=MTM1M3
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setAuthListTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other
    Should Contain    ${test_output}    Running org.lsst.sal.junit.${subSystem}.${subSystem}Commander_setLogLevelTest
    Should Contain    ${test_output}    === [issueCommand] setLogLevel writing a command
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [putSample logevent_authList] writing a message containing :
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : MTM1M3,Test    1
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : MTM1M3    1
    Should Contain Match    ${test_output}    *waitForCompletion_setLogLevel* command * Not permitted by authList*
    Sleep    10s    Allow DDS threads to finish

