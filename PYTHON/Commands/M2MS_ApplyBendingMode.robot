*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 4669 18541 31916 24268 29410 31472 9600 3425 831 18401 17533 6406 3704 20721 21654 13797 13401 21175 11236 18616 16408 8319 28394 12796 6383 5433 20380 10162 32764 15171 20180 31885 64.4068 57.0541 38.4267 34.5241 96.0753 37.7089 19.0683 7.5213 60.0739 47.8231 70.166 79.6221 20.565 78.6121 49.0939 97.7945 31.6501 80.6621 36.0186 18.9947 23.4917 28.9127 75.9429 45.5474 99.5091 42.5021 57.4217 34.6704 67.7448 48.2642 31.5555 89.8428
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 4669 18541 31916 24268 29410 31472 9600 3425 831 18401 17533 6406 3704 20721 21654 13797 13401 21175 11236 18616 16408 8319 28394 12796 6383 5433 20380 10162 32764 15171 20180 31885 64.4068 57.0541 38.4267 34.5241 96.0753 37.7089 19.0683 7.5213 60.0739 47.8231 70.166 79.6221 20.565 78.6121 49.0939 97.7945 31.6501 80.6621 36.0186 18.9947 23.4917 28.9127 75.9429 45.5474 99.5091 42.5021 57.4217 34.6704 67.7448 48.2642 31.5555 89.8428
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 4669    1
    Should Contain X Times    ${output}    bendingModeValue : 64.4068    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [4669, 18541, 31916, 24268, 29410, 31472, 9600, 3425, 831, 18401, 17533, 6406, 3704, 20721, 21654, 13797, 13401, 21175, 11236, 18616, 16408, 8319, 28394, 12796, 6383, 5433, 20380, 10162, 32764, 15171, 20180, 31885]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [64.4068, 57.0541, 38.4267, 34.5241, 96.0753, 37.7089, 19.0683, 7.5213, 60.0739, 47.8231, 70.166, 79.6221, 20.565, 78.6121, 49.0939, 97.7945, 31.6501, 80.6621, 36.0186, 18.9947, 23.4917, 28.9127, 75.9429, 45.5474, 99.5091, 42.5021, 57.4217, 34.6704, 67.7448, 48.2642, 31.5555, 89.8428]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
