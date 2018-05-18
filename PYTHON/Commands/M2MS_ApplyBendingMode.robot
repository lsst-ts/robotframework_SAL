*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 29419 23634 8329 4400 -1990 -26228 15487 30318 26524 -20147 8389 102 20945 6609 12240 -348 30471 27332 16 -4561 -6734 22670 8344 29228 4908 -17004 16350 -8774 -180 19758 -24686 32109 69.4154 88.9844 27.0526 46.4716 40.4573 27.404 54.1 7.5555 91.0919 84.8561 0.4462 31.6825 39.11 24.1337 93.8833 80.0131 36.4269 7.5627 14.7755 50.388 22.6512 9.0748 29.2236 62.3589 5.9494 86.6814 76.1127 98.8237 5.125 52.3755 7.7319 66.8344
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 29419 23634 8329 4400 -1990 -26228 15487 30318 26524 -20147 8389 102 20945 6609 12240 -348 30471 27332 16 -4561 -6734 22670 8344 29228 4908 -17004 16350 -8774 -180 19758 -24686 32109 69.4154 88.9844 27.0526 46.4716 40.4573 27.404 54.1 7.5555 91.0919 84.8561 0.4462 31.6825 39.11 24.1337 93.8833 80.0131 36.4269 7.5627 14.7755 50.388 22.6512 9.0748 29.2236 62.3589 5.9494 86.6814 76.1127 98.8237 5.125 52.3755 7.7319 66.8344
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 29419    1
    Should Contain X Times    ${output}    bendingModeValue : 69.4154    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [29419, 23634, 8329, 4400, -1990, -26228, 15487, 30318, 26524, -20147, 8389, 102, 20945, 6609, 12240, -348, 30471, 27332, 16, -4561, -6734, 22670, 8344, 29228, 4908, -17004, 16350, -8774, -180, 19758, -24686, 32109]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [69.4154, 88.9844, 27.0526, 46.4716, 40.4573, 27.404, 54.1, 7.5555, 91.0919, 84.8561, 0.4462, 31.6825, 39.11, 24.1337, 93.8833, 80.0131, 36.4269, 7.5627, 14.7755, 50.388, 22.6512, 9.0748, 29.2236, 62.3589, 5.9494, 86.6814, 76.1127, 98.8237, 5.125, 52.3755, 7.7319, 66.8344]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
