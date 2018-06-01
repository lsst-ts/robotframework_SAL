*** Settings ***
Documentation    TcsOFC_ApplyForces communications tests.
Force Tags    python    TSS-2625
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsOfc
${component}    ApplyForces
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 73.823 75.0128 73.299 51.8293 41.7075 93.1873 54.9466 49.7764 9.7618 24.4499 11.5253 28.046 45.4118 0.9164 7.9982 45.1541 22.6477 33.4957 22.3705 14.8777 30.3091 75.1199 79.0018 72.3706 76.2136 69.2399 81.0885 79.0348 54.1645 27.6197 20.2252 5.1905 25.9257 42.3759 36.5963 78.9215 82.2606 26.8868 10.751 87.232 44.4877 39.6641 56.1362 25.6877 82.9713 7.078 42.136 65.4002 53.9582 39.7162 92.8615 45.2925 6.9675 42.2524 58.9518 21.2139 33.3937 78.868 58.2435 16.4548 17.4239 48.8436 61.7587 84.5728 68.4786 71.6505 20.1239 37.8753 31.1153 67.4392 58.475 41.1378
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 73.823 75.0128 73.299 51.8293 41.7075 93.1873 54.9466 49.7764 9.7618 24.4499 11.5253 28.046 45.4118 0.9164 7.9982 45.1541 22.6477 33.4957 22.3705 14.8777 30.3091 75.1199 79.0018 72.3706 76.2136 69.2399 81.0885 79.0348 54.1645 27.6197 20.2252 5.1905 25.9257 42.3759 36.5963 78.9215 82.2606 26.8868 10.751 87.232 44.4877 39.6641 56.1362 25.6877 82.9713 7.078 42.136 65.4002 53.9582 39.7162 92.8615 45.2925 6.9675 42.2524 58.9518 21.2139 33.3937 78.868 58.2435 16.4548 17.4239 48.8436 61.7587 84.5728 68.4786 71.6505 20.1239 37.8753 31.1153 67.4392 58.475 41.1378
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 73.823    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [73.823, 75.0128, 73.299, 51.8293, 41.7075, 93.1873, 54.9466, 49.7764, 9.7618, 24.4499, 11.5253, 28.046, 45.4118, 0.9164, 7.9982, 45.1541, 22.6477, 33.4957, 22.3705, 14.8777, 30.3091, 75.1199, 79.0018, 72.3706, 76.2136, 69.2399, 81.0885, 79.0348, 54.1645, 27.6197, 20.2252, 5.1905, 25.9257, 42.3759, 36.5963, 78.9215, 82.2606, 26.8868, 10.751, 87.232, 44.4877, 39.6641, 56.1362, 25.6877, 82.9713, 7.078, 42.136, 65.4002, 53.9582, 39.7162, 92.8615, 45.2925, 6.9675, 42.2524, 58.9518, 21.2139, 33.3937, 78.868, 58.2435, 16.4548, 17.4239, 48.8436, 61.7587, 84.5728, 68.4786, 71.6505, 20.1239, 37.8753, 31.1153, 67.4392, 58.475, 41.1378]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
