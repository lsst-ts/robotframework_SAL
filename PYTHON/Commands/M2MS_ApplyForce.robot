*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 26.1791 94.7294 79.6405 68.0173 62.0615 31.1715 28.3588 46.5422 19.0244 57.2653 44.6621 28.6133 23.0396 18.6229 64.1459 63.984 13.9154 91.8926 22.9592 53.6206 28.4834 28.4198 26.4055 53.0246 87.5676 3.4646 35.4127 79.7441 66.9948 87.9476 37.6753 77.7008 50.0608 0.9198 82.7804 90.0917 21.4897 80.7319 34.9841 24.5155 88.7473 27.4337 85.7245 76.722 62.1571 96.6461 18.2753 49.3146 80.5552 36.3637 70.8685 19.1546 89.6143 4.9401 85.8422 43.1926 96.7447 12.403 55.2792 20.3484 95.4963 16.4344 93.6549 87.156 18.6033 97.0238 96.8019 62.8694 86.1701 40.5086 69.5537 54.2552
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 26.1791 94.7294 79.6405 68.0173 62.0615 31.1715 28.3588 46.5422 19.0244 57.2653 44.6621 28.6133 23.0396 18.6229 64.1459 63.984 13.9154 91.8926 22.9592 53.6206 28.4834 28.4198 26.4055 53.0246 87.5676 3.4646 35.4127 79.7441 66.9948 87.9476 37.6753 77.7008 50.0608 0.9198 82.7804 90.0917 21.4897 80.7319 34.9841 24.5155 88.7473 27.4337 85.7245 76.722 62.1571 96.6461 18.2753 49.3146 80.5552 36.3637 70.8685 19.1546 89.6143 4.9401 85.8422 43.1926 96.7447 12.403 55.2792 20.3484 95.4963 16.4344 93.6549 87.156 18.6033 97.0238 96.8019 62.8694 86.1701 40.5086 69.5537 54.2552
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 26.1791    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [26.1791, 94.7294, 79.6405, 68.0173, 62.0615, 31.1715, 28.3588, 46.5422, 19.0244, 57.2653, 44.6621, 28.6133, 23.0396, 18.6229, 64.1459, 63.984, 13.9154, 91.8926, 22.9592, 53.6206, 28.4834, 28.4198, 26.4055, 53.0246, 87.5676, 3.4646, 35.4127, 79.7441, 66.9948, 87.9476, 37.6753, 77.7008, 50.0608, 0.9198, 82.7804, 90.0917, 21.4897, 80.7319, 34.9841, 24.5155, 88.7473, 27.4337, 85.7245, 76.722, 62.1571, 96.6461, 18.2753, 49.3146, 80.5552, 36.3637, 70.8685, 19.1546, 89.6143, 4.9401, 85.8422, 43.1926, 96.7447, 12.403, 55.2792, 20.3484, 95.4963, 16.4344, 93.6549, 87.156, 18.6033, 97.0238, 96.8019, 62.8694, 86.1701, 40.5086, 69.5537, 54.2552]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
