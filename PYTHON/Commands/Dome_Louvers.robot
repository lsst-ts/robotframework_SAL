*** Settings ***
Documentation    Dome_Louvers commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${component}    Louvers
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
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 3.5952 27.9496 43.767 71.9612 40.5455 28.7985 57.4872 15.9013 19.3577 72.6876 64.8657 42.3461 88.9135 23.3046 26.6716 35.7188 94.4337 2.3898 92.24 46.0869 74.5718 44.2743 20.9931 33.5964 60.4603 92.5988 19.6654 64.4323 66.5763 40.6909 8.4309 34.8107 37.5412 81.4481 18.9781 9.411 57.576 62.6996 51.0496 16.541 99.4606 29.7729 35.4077 69.192 51.0712 28.0818 73.1999 86.2609 26.2534 93.3893 19.5759 35.9894 65.378 59.706 40.4213 77.4531 27.3112 18.9588 15.3725 33.9235 98.2848 97.7496 24.4846 43.4928 64.6824 96.8402 56.8675 79.7183 61.2834 19.2778 51.9514 70.0554
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 3.5952 27.9496 43.767 71.9612 40.5455 28.7985 57.4872 15.9013 19.3577 72.6876 64.8657 42.3461 88.9135 23.3046 26.6716 35.7188 94.4337 2.3898 92.24 46.0869 74.5718 44.2743 20.9931 33.5964 60.4603 92.5988 19.6654 64.4323 66.5763 40.6909 8.4309 34.8107 37.5412 81.4481 18.9781 9.411 57.576 62.6996 51.0496 16.541 99.4606 29.7729 35.4077 69.192 51.0712 28.0818 73.1999 86.2609 26.2534 93.3893 19.5759 35.9894 65.378 59.706 40.4213 77.4531 27.3112 18.9588 15.3725 33.9235 98.2848 97.7496 24.4846 43.4928 64.6824 96.8402 56.8675 79.7183 61.2834 19.2778 51.9514 70.0554
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    openPercent : 3.5952    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    openPercent(72) = [3.5952, 27.9496, 43.767, 71.9612, 40.5455, 28.7985, 57.4872, 15.9013, 19.3577, 72.6876, 64.8657, 42.3461, 88.9135, 23.3046, 26.6716, 35.7188, 94.4337, 2.3898, 92.24, 46.0869, 74.5718, 44.2743, 20.9931, 33.5964, 60.4603, 92.5988, 19.6654, 64.4323, 66.5763, 40.6909, 8.4309, 34.8107, 37.5412, 81.4481, 18.9781, 9.411, 57.576, 62.6996, 51.0496, 16.541, 99.4606, 29.7729, 35.4077, 69.192, 51.0712, 28.0818, 73.1999, 86.2609, 26.2534, 93.3893, 19.5759, 35.9894, 65.378, 59.706, 40.4213, 77.4531, 27.3112, 18.9588, 15.3725, 33.9235, 98.2848, 97.7496, 24.4846, 43.4928, 64.6824, 96.8402, 56.8675, 79.7183, 61.2834, 19.2778, 51.9514, 70.0554]    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
