*** Settings ***
Documentation    TcsOFC_ApplyForces commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 23.2661 60.4784 81.8062 40.0603 38.2454 59.7137 37.0222 62.2023 61.043 76.5125 40.7862 2.1612 48.3033 42.0796 94.9636 91.2387 30.7491 51.5129 11.6556 69.7223 31.9732 45.906 69.7898 38.3711 98.5073 96.0065 82.2599 8.0733 92.226 86.2036 42.5395 12.9273 35.6253 75.7921 47.8184 30.5727 16.9835 78.7823 86.369 31.4482 83.3996 28.6623 88.2389 77.3404 81.2678 26.8239 96.9601 79.8168 59.4389 49.4685 66.9882 76.7771 52.4676 21.1204 85.8269 55.0258 9.3326 12.0513 51.6568 82.7598 95.6398 35.7868 82.7053 76.2236 79.5642 91.2633 89.9563 0.5527 43.7556 40.2216 56.7583 27.4956
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 23.2661 60.4784 81.8062 40.0603 38.2454 59.7137 37.0222 62.2023 61.043 76.5125 40.7862 2.1612 48.3033 42.0796 94.9636 91.2387 30.7491 51.5129 11.6556 69.7223 31.9732 45.906 69.7898 38.3711 98.5073 96.0065 82.2599 8.0733 92.226 86.2036 42.5395 12.9273 35.6253 75.7921 47.8184 30.5727 16.9835 78.7823 86.369 31.4482 83.3996 28.6623 88.2389 77.3404 81.2678 26.8239 96.9601 79.8168 59.4389 49.4685 66.9882 76.7771 52.4676 21.1204 85.8269 55.0258 9.3326 12.0513 51.6568 82.7598 95.6398 35.7868 82.7053 76.2236 79.5642 91.2633 89.9563 0.5527 43.7556 40.2216 56.7583 27.4956
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 23.2661    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [23.2661, 60.4784, 81.8062, 40.0603, 38.2454, 59.7137, 37.0222, 62.2023, 61.043, 76.5125, 40.7862, 2.1612, 48.3033, 42.0796, 94.9636, 91.2387, 30.7491, 51.5129, 11.6556, 69.7223, 31.9732, 45.906, 69.7898, 38.3711, 98.5073, 96.0065, 82.2599, 8.0733, 92.226, 86.2036, 42.5395, 12.9273, 35.6253, 75.7921, 47.8184, 30.5727, 16.9835, 78.7823, 86.369, 31.4482, 83.3996, 28.6623, 88.2389, 77.3404, 81.2678, 26.8239, 96.9601, 79.8168, 59.4389, 49.4685, 66.9882, 76.7771, 52.4676, 21.1204, 85.8269, 55.0258, 9.3326, 12.0513, 51.6568, 82.7598, 95.6398, 35.7868, 82.7053, 76.2236, 79.5642, 91.2633, 89.9563, 0.5527, 43.7556, 40.2216, 56.7583, 27.4956]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
