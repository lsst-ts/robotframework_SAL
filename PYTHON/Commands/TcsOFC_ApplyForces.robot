*** Settings ***
Documentation    TcsOFC_ApplyForces commander/controller tests.
Force Tags    python    Checking if skipped: tcsOfc
TSS-2625
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 93.6224 86.0534 52.6266 3.7375 80.2246 20.5379 88.4317 7.0702 76.4936 30.3006 13.0456 33.7475 17.052 15.9239 61.2104 41.0244 20.7668 34.7495 95.0236 51.9467 39.7859 11.4183 59.7571 34.0744 52.0863 51.2511 6.7562 43.8793 24.408 35.4139 33.9034 7.6564 11.8671 75.9316 56.3598 39.9562 13.1174 61.2932 24.3316 59.2452 98.5487 47.0118 96.4594 42.4316 87.2348 11.7143 19.3094 75.6756 64.3976 61.1382 74.2701 92.2872 49.5946 9.8978 64.93 73.4198 89.9983 65.7043 48.4481 87.5167 89.8848 0.8988 12.7476 20.1534 57.8084 70.4942 82.3337 1.0062 74.1535 92.2243 86.5392 51.6519
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 93.6224 86.0534 52.6266 3.7375 80.2246 20.5379 88.4317 7.0702 76.4936 30.3006 13.0456 33.7475 17.052 15.9239 61.2104 41.0244 20.7668 34.7495 95.0236 51.9467 39.7859 11.4183 59.7571 34.0744 52.0863 51.2511 6.7562 43.8793 24.408 35.4139 33.9034 7.6564 11.8671 75.9316 56.3598 39.9562 13.1174 61.2932 24.3316 59.2452 98.5487 47.0118 96.4594 42.4316 87.2348 11.7143 19.3094 75.6756 64.3976 61.1382 74.2701 92.2872 49.5946 9.8978 64.93 73.4198 89.9983 65.7043 48.4481 87.5167 89.8848 0.8988 12.7476 20.1534 57.8084 70.4942 82.3337 1.0062 74.1535 92.2243 86.5392 51.6519
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 93.6224    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [93.6224, 86.0534, 52.6266, 3.7375, 80.2246, 20.5379, 88.4317, 7.0702, 76.4936, 30.3006, 13.0456, 33.7475, 17.052, 15.9239, 61.2104, 41.0244, 20.7668, 34.7495, 95.0236, 51.9467, 39.7859, 11.4183, 59.7571, 34.0744, 52.0863, 51.2511, 6.7562, 43.8793, 24.408, 35.4139, 33.9034, 7.6564, 11.8671, 75.9316, 56.3598, 39.9562, 13.1174, 61.2932, 24.3316, 59.2452, 98.5487, 47.0118, 96.4594, 42.4316, 87.2348, 11.7143, 19.3094, 75.6756, 64.3976, 61.1382, 74.2701, 92.2872, 49.5946, 9.8978, 64.93, 73.4198, 89.9983, 65.7043, 48.4481, 87.5167, 89.8848, 0.8988, 12.7476, 20.1534, 57.8084, 70.4942, 82.3337, 1.0062, 74.1535, 92.2243, 86.5392, 51.6519]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
