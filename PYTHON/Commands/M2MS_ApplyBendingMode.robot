*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 3253 22580 1224 9871 25167 4052 22460 25616 17113 30486 12876 24185 9230 21243 6863 32174 26751 4369 12487 21970 13177 14257 11763 19405 3043 2384 16498 30599 28267 16283 9282 24714 96.7343 76.1263 18.6125 49.4528 35.2139 42.1384 98.5049 54.3206 46.4589 55.6495 85.3026 10.0742 38.4813 36.572 27.5214 40.8049 4.3455 80.876 29.9052 43.554 69.7535 59.9269 92.7286 2.155 63.0167 66.8245 26.3941 3.7468 87.8521 13.2854 38.5365 17.4407
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 3253 22580 1224 9871 25167 4052 22460 25616 17113 30486 12876 24185 9230 21243 6863 32174 26751 4369 12487 21970 13177 14257 11763 19405 3043 2384 16498 30599 28267 16283 9282 24714 96.7343 76.1263 18.6125 49.4528 35.2139 42.1384 98.5049 54.3206 46.4589 55.6495 85.3026 10.0742 38.4813 36.572 27.5214 40.8049 4.3455 80.876 29.9052 43.554 69.7535 59.9269 92.7286 2.155 63.0167 66.8245 26.3941 3.7468 87.8521 13.2854 38.5365 17.4407
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 3253    1
    Should Contain X Times    ${output}    bendingModeValue : 96.7343    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [3253, 22580, 1224, 9871, 25167, 4052, 22460, 25616, 17113, 30486, 12876, 24185, 9230, 21243, 6863, 32174, 26751, 4369, 12487, 21970, 13177, 14257, 11763, 19405, 3043, 2384, 16498, 30599, 28267, 16283, 9282, 24714]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [96.7343, 76.1263, 18.6125, 49.4528, 35.2139, 42.1384, 98.5049, 54.3206, 46.4589, 55.6495, 85.3026, 10.0742, 38.4813, 36.572, 27.5214, 40.8049, 4.3455, 80.876, 29.9052, 43.554, 69.7535, 59.9269, 92.7286, 2.155, 63.0167, 66.8245, 26.3941, 3.7468, 87.8521, 13.2854, 38.5365, 17.4407]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
