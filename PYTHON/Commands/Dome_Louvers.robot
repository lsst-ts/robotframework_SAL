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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 70.7758 62.5573 81.2921 25.2312 53.031 58.9303 49.8662 8.4626 10.8415 73.5557 22.2387 75.9051 87.4095 9.7462 75.2904 22.3092 16.258 44.863 38.9097 29.7992 80.7096 82.5747 49.1017 61.4161 33.5296 90.9004 69.6251 24.4263 29.2608 2.6392 91.0584 10.951 64.9583 86.6831 0.0066 70.9127 80.9177 29.1573 60.2499 79.625 45.4647 29.0842 25.2994 67.8724 82.4281 3.5999 13.8603 90.6444 55.2926 60.7385 84.2894 81.0648 59.3121 49.6582 58.4968 4.8495 86.1335 51.2617 53.6464 84.3373 62.0657 32.6743 79.2112 30.275 85.5254 37.2706 52.0674 13.1048 19.9679 48.1497 2.9959 61.8786
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 70.7758 62.5573 81.2921 25.2312 53.031 58.9303 49.8662 8.4626 10.8415 73.5557 22.2387 75.9051 87.4095 9.7462 75.2904 22.3092 16.258 44.863 38.9097 29.7992 80.7096 82.5747 49.1017 61.4161 33.5296 90.9004 69.6251 24.4263 29.2608 2.6392 91.0584 10.951 64.9583 86.6831 0.0066 70.9127 80.9177 29.1573 60.2499 79.625 45.4647 29.0842 25.2994 67.8724 82.4281 3.5999 13.8603 90.6444 55.2926 60.7385 84.2894 81.0648 59.3121 49.6582 58.4968 4.8495 86.1335 51.2617 53.6464 84.3373 62.0657 32.6743 79.2112 30.275 85.5254 37.2706 52.0674 13.1048 19.9679 48.1497 2.9959 61.8786
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    openPercent : 70.7758    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    openPercent(72) = [70.7758, 62.5573, 81.2921, 25.2312, 53.031, 58.9303, 49.8662, 8.4626, 10.8415, 73.5557, 22.2387, 75.9051, 87.4095, 9.7462, 75.2904, 22.3092, 16.258, 44.863, 38.9097, 29.7992, 80.7096, 82.5747, 49.1017, 61.4161, 33.5296, 90.9004, 69.6251, 24.4263, 29.2608, 2.6392, 91.0584, 10.951, 64.9583, 86.6831, 0.0066, 70.9127, 80.9177, 29.1573, 60.2499, 79.625, 45.4647, 29.0842, 25.2994, 67.8724, 82.4281, 3.5999, 13.8603, 90.6444, 55.2926, 60.7385, 84.2894, 81.0648, 59.3121, 49.6582, 58.4968, 4.8495, 86.1335, 51.2617, 53.6464, 84.3373, 62.0657, 32.6743, 79.2112, 30.275, 85.5254, 37.2706, 52.0674, 13.1048, 19.9679, 48.1497, 2.9959, 61.8786]    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
