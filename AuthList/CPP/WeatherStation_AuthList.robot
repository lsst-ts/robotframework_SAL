*** Settings ***
Documentation    WeatherStation AuthList tests.
Force Tags    authlist    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    WeatherStation
${component}    all
${timeout}    15s

*** Test Cases ***
Verify WeatherStation AuthList test files
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/testAuthList.sh

Execute WeatherStation AuthList test script
    [Tags]    functional
    Comment    Start script.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/testAuthList.sh    alias=${subSystem}_authlist    shell=True    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem} AuthList test messages =======
    Should Contain    ${output.stdout}    Starting sacpp_${subSystem}_setLogLevel_controller
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
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers :${SPACE}
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}
    Should Contain    ${test_output}    === command setAuthList issued =${SPACE}
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain    ${test_output}    === command setLogLevel received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: WeatherStation:1    3
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} completed ok :

Verify Second AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList not set at all, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList not set at all, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} Not permitted by authList

Verify Third AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === command setAuthList issued =${SPACE}
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain    ${test_output}    === command setLogLevel received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: user@host    3
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} completed ok :

Verify Fourth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user@host
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === command setAuthList issued =${SPACE}
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain    ${test_output}    === command setLogLevel received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: user@host    3
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} completed ok :

Verify Fifth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, identity=user2@other
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === command setAuthList issued =${SPACE}
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain    ${test_output}    === command setLogLevel received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK
    Should Contain    ${test_output}    === [ackCommand_setLogLevel] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs :${SPACE}    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: user2@other    3
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} completed ok :

Verify Sixth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=user2@other
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    === command setAuthList issued =${SPACE}
    Should Contain    ${test_output}    === command setAuthList received =${SPACE}
    Should Contain    ${test_output}    === [ackCommand_setAuthList] acknowledging a command with :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: OK
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : Test    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: user2@other    3
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} completed ok :

Verify Seventh AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=Test identity=Test
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} Not permitted by authList

Verify Eighth AuthList Test
    [Tags]    functional
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,MTM2,Test identity=MTM2
    ${start}=    Get Index From List    ${full_list}    Test with authList authorizedUsers=user@host,user2@other, nonAuthorizedCSCs=MTM1M3,MTM2,Test identity=MTM2
    ${end}=    Get Index From List    ${full_list}    =====================================================================    start=${start}
    ${test_output}=    Get Slice From List    ${full_list}    start=${start}    end=${end}
    Log    ${test_output}
    Should Contain    ${test_output}    === [issueCommand_setAuthList] writing a command containing :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other
    Should Contain    ${test_output}    === [issueCommand_setLogLevel] writing a command containing :
    Should Contain    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1
    Should Contain    ${test_output}    === command setLogLevel issued =${SPACE}
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : user@host,user2@other    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : MTM1M3,MTM2,Test    2
    Should Contain X Times    ${test_output}    ${SPACE}${SPACE}${SPACE}${SPACE}identity${SPACE}${SPACE}${SPACE}${SPACE}: MTM2    1
    Should Match Regexp    ${test_output}[-1]    === \\[waitForCompletion_setLogLevel\\] command [0-9]{10,} Not permitted by authList

