*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    python    Checking if skipped: m2ms
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 30.0407 41.5184 48.7065 90.4792 66.8158 27.187 73.2984 58.9222 77.5703 58.6027 8.5633 24.2931 3.1222 54.8502 91.9617 1.4336 49.4508 61.5628 99.6198 80.3812 75.4563 12.5363 67.6919 73.6916 5.5749 62.4532 92.4446 52.4944 42.5018 31.02 48.3111 41.4757 98.1155 24.2073 29.7531 53.3934 89.429 6.7055 97.933 57.5262 48.1919 64.0077 14.336 83.2323 28.1424 29.2089 51.8607 6.5993 41.8377 80.8993 75.5359 79.1549 88.4898 1.2247 29.0245 69.2439 86.3238 52.9831 30.9203 55.0891 43.1827 42.79 39.9673 9.5207 75.0409 16.7811 13.6078 89.2391 88.5161 89.2369 25.2705 66.1101
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 30.0407 41.5184 48.7065 90.4792 66.8158 27.187 73.2984 58.9222 77.5703 58.6027 8.5633 24.2931 3.1222 54.8502 91.9617 1.4336 49.4508 61.5628 99.6198 80.3812 75.4563 12.5363 67.6919 73.6916 5.5749 62.4532 92.4446 52.4944 42.5018 31.02 48.3111 41.4757 98.1155 24.2073 29.7531 53.3934 89.429 6.7055 97.933 57.5262 48.1919 64.0077 14.336 83.2323 28.1424 29.2089 51.8607 6.5993 41.8377 80.8993 75.5359 79.1549 88.4898 1.2247 29.0245 69.2439 86.3238 52.9831 30.9203 55.0891 43.1827 42.79 39.9673 9.5207 75.0409 16.7811 13.6078 89.2391 88.5161 89.2369 25.2705 66.1101
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 30.0407    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [30.0407, 41.5184, 48.7065, 90.4792, 66.8158, 27.187, 73.2984, 58.9222, 77.5703, 58.6027, 8.5633, 24.2931, 3.1222, 54.8502, 91.9617, 1.4336, 49.4508, 61.5628, 99.6198, 80.3812, 75.4563, 12.5363, 67.6919, 73.6916, 5.5749, 62.4532, 92.4446, 52.4944, 42.5018, 31.02, 48.3111, 41.4757, 98.1155, 24.2073, 29.7531, 53.3934, 89.429, 6.7055, 97.933, 57.5262, 48.1919, 64.0077, 14.336, 83.2323, 28.1424, 29.2089, 51.8607, 6.5993, 41.8377, 80.8993, 75.5359, 79.1549, 88.4898, 1.2247, 29.0245, 69.2439, 86.3238, 52.9831, 30.9203, 55.0891, 43.1827, 42.79, 39.9673, 9.5207, 75.0409, 16.7811, 13.6078, 89.2391, 88.5161, 89.2369, 25.2705, 66.1101]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
