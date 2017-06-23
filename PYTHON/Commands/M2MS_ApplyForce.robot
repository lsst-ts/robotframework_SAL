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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 58.4683 69.9935 68.3281 90.664 63.9145 9.3339 55.3749 58.1986 95.008 15.2875 22.0433 13.032 27.9156 9.3351 82.7593 55.4349 53.8838 92.5175 33.2069 1.2717 56.4668 71.9492 56.2742 69.2766 72.6225 27.7725 48.9121 52.0188 69.9538 14.8964 6.9532 4.7272 18.5111 62.1903 34.0934 33.5848 53.912 10.7764 85.9433 76.8831 13.9379 34.335 68.3937 94.7285 58.975 18.4183 17.4521 3.1013 77.6503 62.9088 82.4464 41.0526 62.1537 73.5221 55.7955 64.3574 76.1816 5.2849 13.0051 26.2769 23.9884 22.1003 63.3494 75.0191 65.5082 87.824 90.7845 85.0336 22.3724 54.4322 17.3067 3.1356
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 58.4683 69.9935 68.3281 90.664 63.9145 9.3339 55.3749 58.1986 95.008 15.2875 22.0433 13.032 27.9156 9.3351 82.7593 55.4349 53.8838 92.5175 33.2069 1.2717 56.4668 71.9492 56.2742 69.2766 72.6225 27.7725 48.9121 52.0188 69.9538 14.8964 6.9532 4.7272 18.5111 62.1903 34.0934 33.5848 53.912 10.7764 85.9433 76.8831 13.9379 34.335 68.3937 94.7285 58.975 18.4183 17.4521 3.1013 77.6503 62.9088 82.4464 41.0526 62.1537 73.5221 55.7955 64.3574 76.1816 5.2849 13.0051 26.2769 23.9884 22.1003 63.3494 75.0191 65.5082 87.824 90.7845 85.0336 22.3724 54.4322 17.3067 3.1356
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 58.4683    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [58.4683, 69.9935, 68.3281, 90.664, 63.9145, 9.3339, 55.3749, 58.1986, 95.008, 15.2875, 22.0433, 13.032, 27.9156, 9.3351, 82.7593, 55.4349, 53.8838, 92.5175, 33.2069, 1.2717, 56.4668, 71.9492, 56.2742, 69.2766, 72.6225, 27.7725, 48.9121, 52.0188, 69.9538, 14.8964, 6.9532, 4.7272, 18.5111, 62.1903, 34.0934, 33.5848, 53.912, 10.7764, 85.9433, 76.8831, 13.9379, 34.335, 68.3937, 94.7285, 58.975, 18.4183, 17.4521, 3.1013, 77.6503, 62.9088, 82.4464, 41.0526, 62.1537, 73.5221, 55.7955, 64.3574, 76.1816, 5.2849, 13.0051, 26.2769, 23.9884, 22.1003, 63.3494, 75.0191, 65.5082, 87.824, 90.7845, 85.0336, 22.3724, 54.4322, 17.3067, 3.1356]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
