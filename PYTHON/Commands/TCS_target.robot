*** Settings ***
Documentation    TCS_target communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    target
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1158696136 -279126635 1999603019 WhUXyrsuhNgofryqMoLbqUvhMtTOaznrqJJDnxvQCsIzhPYtDfZRuyIcDpTClYcd 91.464 39.4795 90.7219 22.1498 670945234 -1002796304 90.1368
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1158696136 -279126635 1999603019 WhUXyrsuhNgofryqMoLbqUvhMtTOaznrqJJDnxvQCsIzhPYtDfZRuyIcDpTClYcd 91.464 39.4795 90.7219 22.1498 670945234 -1002796304 90.1368
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    targetId : -1158696136    1
    Should Contain X Times    ${output}    fieldId : -279126635    1
    Should Contain X Times    ${output}    groupId : 1999603019    1
    Should Contain X Times    ${output}    filter : WhUXyrsuhNgofryqMoLbqUvhMtTOaznrqJJDnxvQCsIzhPYtDfZRuyIcDpTClYcd    1
    Should Contain X Times    ${output}    requestTime : 91.464    1
    Should Contain X Times    ${output}    ra : 39.4795    1
    Should Contain X Times    ${output}    decl : 90.7219    1
    Should Contain X Times    ${output}    angle : 22.1498    1
    Should Contain X Times    ${output}    num_exposures : 670945234    1
    Should Contain X Times    ${output}    exposure_times : -1002796304    1
    Should Contain X Times    ${output}    slew_time : 90.1368    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    targetId = -1158696136    1
    Should Contain X Times    ${output}    fieldId = -279126635    1
    Should Contain X Times    ${output}    groupId = 1999603019    1
    Should Contain X Times    ${output}    filter = WhUXyrsuhNgofryqMoLbqUvhMtTOaznrqJJDnxvQCsIzhPYtDfZRuyIcDpTClYcd    1
    Should Contain X Times    ${output}    requestTime = 91.464    1
    Should Contain X Times    ${output}    ra = 39.4795    1
    Should Contain X Times    ${output}    decl = 90.7219    1
    Should Contain X Times    ${output}    angle = 22.1498    1
    Should Contain X Times    ${output}    num_exposures = 670945234    1
    Should Contain X Times    ${output}    exposure_times = -1002796304    1
    Should Contain X Times    ${output}    slew_time = 90.1368    1
    Should Contain X Times    ${output}    === [ackCommand_target] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
