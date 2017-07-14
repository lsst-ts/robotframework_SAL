*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    cpp
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 14413 27769 26239 26210 -23006 27097 -11848 -22420 25345 32458 24177 18577 -9075 -11414 243 10671 31113 15548 1749 5767 6914 -8433 -23603 3734 21538 -15114 -14274 15301 -17322 -25725 5277 27080 68.9387 10.3119 38.1317 60.2689 41.6458 36.5213 18.9224 68.6986 4.9327 86.8503 76.8333 17.1312 64.0674 81.0755 50.3182 31.4175 68.473 65.5805 70.0579 72.8757 79.6149 16.1009 40.5432 83.6914 39.7946 78.4722 62.4516 42.7832 72.8765 97.268 86.6136 79.8822
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 14413 27769 26239 26210 -23006 27097 -11848 -22420 25345 32458 24177 18577 -9075 -11414 243 10671 31113 15548 1749 5767 6914 -8433 -23603 3734 21538 -15114 -14274 15301 -17322 -25725 5277 27080 68.9387 10.3119 38.1317 60.2689 41.6458 36.5213 18.9224 68.6986 4.9327 86.8503 76.8333 17.1312 64.0674 81.0755 50.3182 31.4175 68.473 65.5805 70.0579 72.8757 79.6149 16.1009 40.5432 83.6914 39.7946 78.4722 62.4516 42.7832 72.8765 97.268 86.6136 79.8822
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    bendingModeNbr : 14413    1
    Should Contain X Times    ${output}    bendingModeValue : 68.9387    1
    Should Contain    ${output}    === command ApplyBendingMode issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyBendingMode received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    bendingModeNbr : 14413    1
    Should Contain X Times    ${output}    bendingModeValue : 68.9387    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
