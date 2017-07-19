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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 22568 4511 5409 -3278 25859 -8111 22714 23000 21326 31216 9247 -42 -31273 -30524 3341 -9415 4023 16758 -10716 31298 -2163 -6707 21342 -19582 8908 -23842 13483 -18512 -14315 -7390 -1188 20649 55.8175 11.6551 87.2252 23.5838 72.5054 92.978 22.1489 1.3089 20.1029 41.8845 69.8294 54.1133 87.0696 46.9775 39.0298 68.727 22.4321 19.3089 4.648 39.4473 99.7968 68.8219 83.6084 54.706 91.6386 65.6326 11.1472 1.6662 23.6854 70.7045 4.565 97.8927
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 22568 4511 5409 -3278 25859 -8111 22714 23000 21326 31216 9247 -42 -31273 -30524 3341 -9415 4023 16758 -10716 31298 -2163 -6707 21342 -19582 8908 -23842 13483 -18512 -14315 -7390 -1188 20649 55.8175 11.6551 87.2252 23.5838 72.5054 92.978 22.1489 1.3089 20.1029 41.8845 69.8294 54.1133 87.0696 46.9775 39.0298 68.727 22.4321 19.3089 4.648 39.4473 99.7968 68.8219 83.6084 54.706 91.6386 65.6326 11.1472 1.6662 23.6854 70.7045 4.565 97.8927
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 22568    1
    Should Contain X Times    ${output}    bendingModeValue : 55.8175    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [22568, 4511, 5409, -3278, 25859, -8111, 22714, 23000, 21326, 31216, 9247, -42, -31273, -30524, 3341, -9415, 4023, 16758, -10716, 31298, -2163, -6707, 21342, -19582, 8908, -23842, 13483, -18512, -14315, -7390, -1188, 20649]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [55.8175, 11.6551, 87.2252, 23.5838, 72.5054, 92.978, 22.1489, 1.3089, 20.1029, 41.8845, 69.8294, 54.1133, 87.0696, 46.9775, 39.0298, 68.727, 22.4321, 19.3089, 4.648, 39.4473, 99.7968, 68.8219, 83.6084, 54.706, 91.6386, 65.6326, 11.1472, 1.6662, 23.6854, 70.7045, 4.565, 97.8927]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
