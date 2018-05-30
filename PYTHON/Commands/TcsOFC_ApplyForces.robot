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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.8233 54.7443 61.5195 18.1452 20.4091 62.6411 88.6477 10.7347 64.5258 69.0874 56.9512 16.3182 19.7916 33.5219 2.764 10.637 81.1925 49.4196 48.0576 77.7327 19.4827 20.0153 17.9448 72.0355 67.5148 74.3776 74.0473 31.7239 47.2669 94.2349 35.5996 28.7268 50.416 25.1903 24.381 37.6566 53.6411 17.3253 36.6803 96.5902 15.3432 76.5827 92.0868 44.9929 60.9771 44.2072 26.4531 99.9487 48.9547 10.9593 68.5664 69.9792 73.7109 77.6376 40.7811 73.396 22.2767 50.3919 31.341 64.2107 62.8742 23.3352 17.6479 97.3253 34.6671 47.6502 52.0272 16.0986 92.4296 24.8993 48.8565 11.0872
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.8233 54.7443 61.5195 18.1452 20.4091 62.6411 88.6477 10.7347 64.5258 69.0874 56.9512 16.3182 19.7916 33.5219 2.764 10.637 81.1925 49.4196 48.0576 77.7327 19.4827 20.0153 17.9448 72.0355 67.5148 74.3776 74.0473 31.7239 47.2669 94.2349 35.5996 28.7268 50.416 25.1903 24.381 37.6566 53.6411 17.3253 36.6803 96.5902 15.3432 76.5827 92.0868 44.9929 60.9771 44.2072 26.4531 99.9487 48.9547 10.9593 68.5664 69.9792 73.7109 77.6376 40.7811 73.396 22.2767 50.3919 31.341 64.2107 62.8742 23.3352 17.6479 97.3253 34.6671 47.6502 52.0272 16.0986 92.4296 24.8993 48.8565 11.0872
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 16.8233    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [16.8233, 54.7443, 61.5195, 18.1452, 20.4091, 62.6411, 88.6477, 10.7347, 64.5258, 69.0874, 56.9512, 16.3182, 19.7916, 33.5219, 2.764, 10.637, 81.1925, 49.4196, 48.0576, 77.7327, 19.4827, 20.0153, 17.9448, 72.0355, 67.5148, 74.3776, 74.0473, 31.7239, 47.2669, 94.2349, 35.5996, 28.7268, 50.416, 25.1903, 24.381, 37.6566, 53.6411, 17.3253, 36.6803, 96.5902, 15.3432, 76.5827, 92.0868, 44.9929, 60.9771, 44.2072, 26.4531, 99.9487, 48.9547, 10.9593, 68.5664, 69.9792, 73.7109, 77.6376, 40.7811, 73.396, 22.2767, 50.3919, 31.341, 64.2107, 62.8742, 23.3352, 17.6479, 97.3253, 34.6671, 47.6502, 52.0272, 16.0986, 92.4296, 24.8993, 48.8565, 11.0872]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
