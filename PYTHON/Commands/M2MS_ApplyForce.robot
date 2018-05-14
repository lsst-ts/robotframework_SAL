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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 57.3317 90.1361 12.4098 62.5629 45.2221 20.0219 83.2801 93.6771 0.7279 72.7365 36.7529 53.0164 20.6334 53.6428 69.2999 95.716 5.0095 38.3377 46.122 90.5234 87.639 27.3456 81.7698 85.2912 59.946 45.7788 89.8651 22.1063 86.5979 87.3732 86.8678 24.8027 99.3636 0.1672 28.6251 38.0386 29.0927 63.7845 48.6001 1.1113 26.0569 91.3357 81.4259 55.581 48.5366 54.6434 50.3999 55.6856 17.9733 89.6282 4.3732 21.9355 47.6002 68.9442 35.9469 2.7863 86.1208 20.9434 80.5676 42.9371 6.3747 39.5694 52.7393 93.8467 58.3483 46.7398 61.1211 71.1402 42.5327 60.6534 44.8506 28.3849
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 57.3317 90.1361 12.4098 62.5629 45.2221 20.0219 83.2801 93.6771 0.7279 72.7365 36.7529 53.0164 20.6334 53.6428 69.2999 95.716 5.0095 38.3377 46.122 90.5234 87.639 27.3456 81.7698 85.2912 59.946 45.7788 89.8651 22.1063 86.5979 87.3732 86.8678 24.8027 99.3636 0.1672 28.6251 38.0386 29.0927 63.7845 48.6001 1.1113 26.0569 91.3357 81.4259 55.581 48.5366 54.6434 50.3999 55.6856 17.9733 89.6282 4.3732 21.9355 47.6002 68.9442 35.9469 2.7863 86.1208 20.9434 80.5676 42.9371 6.3747 39.5694 52.7393 93.8467 58.3483 46.7398 61.1211 71.1402 42.5327 60.6534 44.8506 28.3849
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 57.3317    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [57.3317, 90.1361, 12.4098, 62.5629, 45.2221, 20.0219, 83.2801, 93.6771, 0.7279, 72.7365, 36.7529, 53.0164, 20.6334, 53.6428, 69.2999, 95.716, 5.0095, 38.3377, 46.122, 90.5234, 87.639, 27.3456, 81.7698, 85.2912, 59.946, 45.7788, 89.8651, 22.1063, 86.5979, 87.3732, 86.8678, 24.8027, 99.3636, 0.1672, 28.6251, 38.0386, 29.0927, 63.7845, 48.6001, 1.1113, 26.0569, 91.3357, 81.4259, 55.581, 48.5366, 54.6434, 50.3999, 55.6856, 17.9733, 89.6282, 4.3732, 21.9355, 47.6002, 68.9442, 35.9469, 2.7863, 86.1208, 20.9434, 80.5676, 42.9371, 6.3747, 39.5694, 52.7393, 93.8467, 58.3483, 46.7398, 61.1211, 71.1402, 42.5327, 60.6534, 44.8506, 28.3849]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
