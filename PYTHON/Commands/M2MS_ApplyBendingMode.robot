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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 14920 25588 7485 10236 857 5300 31788 26478 29569 31240 28700 20999 16235 4847 1057 3213 25300 2039 30552 24144 13060 23228 23510 18193 18841 14972 21043 5219 22519 4409 21209 7474 5.9413 93.9902 80.3059 10.2481 77.3186 84.3161 0.5921 48.6941 1.6682 2.4832 51.4835 95.7782 14.5408 10.0317 36.3261 88.4397 72.5078 19.2197 77.9908 41.2909 42.3142 0.5577 39.7039 80.2381 9.8166 87.0031 11.9182 24.1357 28.5212 90.4955 32.4677 23.2523
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 14920 25588 7485 10236 857 5300 31788 26478 29569 31240 28700 20999 16235 4847 1057 3213 25300 2039 30552 24144 13060 23228 23510 18193 18841 14972 21043 5219 22519 4409 21209 7474 5.9413 93.9902 80.3059 10.2481 77.3186 84.3161 0.5921 48.6941 1.6682 2.4832 51.4835 95.7782 14.5408 10.0317 36.3261 88.4397 72.5078 19.2197 77.9908 41.2909 42.3142 0.5577 39.7039 80.2381 9.8166 87.0031 11.9182 24.1357 28.5212 90.4955 32.4677 23.2523
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 14920    1
    Should Contain X Times    ${output}    bendingModeValue : 5.9413    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [14920, 25588, 7485, 10236, 857, 5300, 31788, 26478, 29569, 31240, 28700, 20999, 16235, 4847, 1057, 3213, 25300, 2039, 30552, 24144, 13060, 23228, 23510, 18193, 18841, 14972, 21043, 5219, 22519, 4409, 21209, 7474]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [5.9413, 93.9902, 80.3059, 10.2481, 77.3186, 84.3161, 0.5921, 48.6941, 1.6682, 2.4832, 51.4835, 95.7782, 14.5408, 10.0317, 36.3261, 88.4397, 72.5078, 19.2197, 77.9908, 41.2909, 42.3142, 0.5577, 39.7039, 80.2381, 9.8166, 87.0031, 11.9182, 24.1357, 28.5212, 90.4955, 32.4677, 23.2523]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
