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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 39.1905 88.5691 26.4682 4.9584 59.1669 61.5234 37.2179 48.1922 25.0598 99.2955 66.0761 40.2852 79.1255 99.7427 21.0248 66.694 40.3315 88.0158 41.4354 24.2293 67.103 97.5045 37.586 70.3569 7.4547 90.4999 1.8246 89.8176 29.4353 96.6858 82.7913 46.7563 93.79 75.2764 55.0118 14.7128 60.5442 17.4285 40.0381 55.5659 41.0285 25.4225 66.743 36.5192 44.8058 63.0314 87.9625 79.6863 59.4037 46.757 69.6986 63.5929 33.72 98.3695 2.4 96.3963 17.4767 33.9812 66.8428 6.4872 7.1659 5.7853 41.0634 33.2772 95.4226 64.5934 88.0733 3.6689 68.3497 88.8271 57.8103 26.0553
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 39.1905 88.5691 26.4682 4.9584 59.1669 61.5234 37.2179 48.1922 25.0598 99.2955 66.0761 40.2852 79.1255 99.7427 21.0248 66.694 40.3315 88.0158 41.4354 24.2293 67.103 97.5045 37.586 70.3569 7.4547 90.4999 1.8246 89.8176 29.4353 96.6858 82.7913 46.7563 93.79 75.2764 55.0118 14.7128 60.5442 17.4285 40.0381 55.5659 41.0285 25.4225 66.743 36.5192 44.8058 63.0314 87.9625 79.6863 59.4037 46.757 69.6986 63.5929 33.72 98.3695 2.4 96.3963 17.4767 33.9812 66.8428 6.4872 7.1659 5.7853 41.0634 33.2772 95.4226 64.5934 88.0733 3.6689 68.3497 88.8271 57.8103 26.0553
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetpoint : 39.1905    1
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
    Should Contain X Times    ${output}    forceSetpoint : 39.1905    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
