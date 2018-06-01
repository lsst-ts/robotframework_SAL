*** Settings ***
Documentation    TcsOFC_ApplyForces communications tests.
Force Tags    cpp    TSS-2625
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 72.492 22.6643 83.9562 32.0511 24.2433 99.1185 48.7021 53.6007 94.558 5.4013 80.1334 39.9055 23.663 94.7569 35.9779 5.8338 25.8799 63.1424 13.4955 60.8784 70.8926 56.0313 88.5934 2.1531 71.7666 16.9252 75.2875 65.3519 73.6713 37.0838 78.414 75.8262 5.4702 49.3228 36.1279 78.8106 97.4761 53.8377 73.3694 35.5454 14.3392 38.8156 64.8057 80.7388 56.2754 12.281 81.7727 71.9199 66.5373 77.5779 30.1162 1.2425 88.4188 44.9367 88.312 2.3561 13.2552 92.454 34.7604 90.6652 60.5667 58.194 7.9285 5.9089 7.0069 4.3232 33.2722 13.0033 1.8055 45.1084 22.1473 61.9211
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 72.492 22.6643 83.9562 32.0511 24.2433 99.1185 48.7021 53.6007 94.558 5.4013 80.1334 39.9055 23.663 94.7569 35.9779 5.8338 25.8799 63.1424 13.4955 60.8784 70.8926 56.0313 88.5934 2.1531 71.7666 16.9252 75.2875 65.3519 73.6713 37.0838 78.414 75.8262 5.4702 49.3228 36.1279 78.8106 97.4761 53.8377 73.3694 35.5454 14.3392 38.8156 64.8057 80.7388 56.2754 12.281 81.7727 71.9199 66.5373 77.5779 30.1162 1.2425 88.4188 44.9367 88.312 2.3561 13.2552 92.454 34.7604 90.6652 60.5667 58.194 7.9285 5.9089 7.0069 4.3232 33.2722 13.0033 1.8055 45.1084 22.1473 61.9211
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetpoint : 72.492    1
    Should Contain    ${output}    === command ApplyForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetpoint : 72.492    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
