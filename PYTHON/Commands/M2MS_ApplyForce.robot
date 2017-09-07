*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
${component}    ApplyForce
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 2.8506 14.0151 49.4276 56.9183 89.4534 30.5117 27.7755 35.5672 36.9225 1.6021 13.3252 85.4176 64.706 10.1461 75.166 44.4316 41.6016 87.2828 95.056 67.2658 26.9168 41.8679 62.5053 33.2377 47.5608 45.1473 63.3354 56.7663 69.1476 67.9056 5.1318 90.098 13.1836 98.9058 85.3483 60.2361 69.292 67.1426 57.0606 79.9378 16.4589 16.9902 90.0082 77.3085 76.9231 2.875 95.7893 74.3157 78.2219 99.4541 26.316 68.1452 5.3278 23.1318 58.8563 88.575 67.3045 0.7495 33.9969 45.8912 72.6426 32.0692 53.1752 4.7195 81.0499 60.6813 59.1971 35.5918 17.2618 48.0115 81.1621 46.6228
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 2.8506 14.0151 49.4276 56.9183 89.4534 30.5117 27.7755 35.5672 36.9225 1.6021 13.3252 85.4176 64.706 10.1461 75.166 44.4316 41.6016 87.2828 95.056 67.2658 26.9168 41.8679 62.5053 33.2377 47.5608 45.1473 63.3354 56.7663 69.1476 67.9056 5.1318 90.098 13.1836 98.9058 85.3483 60.2361 69.292 67.1426 57.0606 79.9378 16.4589 16.9902 90.0082 77.3085 76.9231 2.875 95.7893 74.3157 78.2219 99.4541 26.316 68.1452 5.3278 23.1318 58.8563 88.575 67.3045 0.7495 33.9969 45.8912 72.6426 32.0692 53.1752 4.7195 81.0499 60.6813 59.1971 35.5918 17.2618 48.0115 81.1621 46.6228
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 2.8506    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [2.8506, 14.0151, 49.4276, 56.9183, 89.4534, 30.5117, 27.7755, 35.5672, 36.9225, 1.6021, 13.3252, 85.4176, 64.706, 10.1461, 75.166, 44.4316, 41.6016, 87.2828, 95.056, 67.2658, 26.9168, 41.8679, 62.5053, 33.2377, 47.5608, 45.1473, 63.3354, 56.7663, 69.1476, 67.9056, 5.1318, 90.098, 13.1836, 98.9058, 85.3483, 60.2361, 69.292, 67.1426, 57.0606, 79.9378, 16.4589, 16.9902, 90.0082, 77.3085, 76.9231, 2.875, 95.7893, 74.3157, 78.2219, 99.4541, 26.316, 68.1452, 5.3278, 23.1318, 58.8563, 88.575, 67.3045, 0.7495, 33.9969, 45.8912, 72.6426, 32.0692, 53.1752, 4.7195, 81.0499, 60.6813, 59.1971, 35.5918, 17.2618, 48.0115, 81.1621, 46.6228]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
