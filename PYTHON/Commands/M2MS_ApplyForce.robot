*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    python
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 42.9644 55.4768 24.7089 82.6512 87.879 1.9263 73.9941 96.8206 95.7268 95.9291 79.5216 61.2891 10.6613 75.7777 69.9159 67.6588 12.8046 11.6785 78.8758 65.875 14.5871 20.3584 1.7909 4.5056 72.8373 88.8235 64.2024 55.4942 18.1817 8.2998 43.1063 80.9347 30.4509 33.9982 56.4659 47.8778 16.6794 80.0572 50.5025 16.925 72.7379 28.1292 88.5651 59.7874 32.7537 45.4962 28.8588 6.087 19.311 82.184 7.993 57.128 95.2962 68.7753 29.0857 80.4844 93.5009 71.8849 67.2271 35.0282 57.8583 77.6901 85.0586 69.6104 83.9345 36.0523 99.6209 82.9752 81.5637 18.8971 57.6727 14.0028
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 42.9644 55.4768 24.7089 82.6512 87.879 1.9263 73.9941 96.8206 95.7268 95.9291 79.5216 61.2891 10.6613 75.7777 69.9159 67.6588 12.8046 11.6785 78.8758 65.875 14.5871 20.3584 1.7909 4.5056 72.8373 88.8235 64.2024 55.4942 18.1817 8.2998 43.1063 80.9347 30.4509 33.9982 56.4659 47.8778 16.6794 80.0572 50.5025 16.925 72.7379 28.1292 88.5651 59.7874 32.7537 45.4962 28.8588 6.087 19.311 82.184 7.993 57.128 95.2962 68.7753 29.0857 80.4844 93.5009 71.8849 67.2271 35.0282 57.8583 77.6901 85.0586 69.6104 83.9345 36.0523 99.6209 82.9752 81.5637 18.8971 57.6727 14.0028
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 42.9644    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [42.9644, 55.4768, 24.7089, 82.6512, 87.879, 1.9263, 73.9941, 96.8206, 95.7268, 95.9291, 79.5216, 61.2891, 10.6613, 75.7777, 69.9159, 67.6588, 12.8046, 11.6785, 78.8758, 65.875, 14.5871, 20.3584, 1.7909, 4.5056, 72.8373, 88.8235, 64.2024, 55.4942, 18.1817, 8.2998, 43.1063, 80.9347, 30.4509, 33.9982, 56.4659, 47.8778, 16.6794, 80.0572, 50.5025, 16.925, 72.7379, 28.1292, 88.5651, 59.7874, 32.7537, 45.4962, 28.8588, 6.087, 19.311, 82.184, 7.993, 57.128, 95.2962, 68.7753, 29.0857, 80.4844, 93.5009, 71.8849, 67.2271, 35.0282, 57.8583, 77.6901, 85.0586, 69.6104, 83.9345, 36.0523, 99.6209, 82.9752, 81.5637, 18.8971, 57.6727, 14.0028]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
