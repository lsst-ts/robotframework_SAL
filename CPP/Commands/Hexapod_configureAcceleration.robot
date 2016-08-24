*** Settings ***
Documentation    Hexapod_configureAcceleration commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAcceleration
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
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
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    Should Contain    ${output}   Usage :  input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 76.8625 5.3427 50.3241 52.6057 78.7844 7.6516 64.3286 58.9336 2.8066 19.1234 45.4364 44.3597
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 timed out :

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read
    Log    ${output}
    Should Be Empty    ${output}

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 76.8625 5.3427 50.3241 52.6057 78.7844 7.6516 64.3286 58.9336 2.8066 19.1234 45.4364 44.3597
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 76.8625    1
    Should Contain X Times    ${output}    xmax : 5.3427    1
    Should Contain X Times    ${output}    ymin : 50.3241    1
    Should Contain X Times    ${output}    ymax : 52.6057    1
    Should Contain X Times    ${output}    zmin : 78.7844    1
    Should Contain X Times    ${output}    zmax : 7.6516    1
    Should Contain X Times    ${output}    umin : 64.3286    1
    Should Contain X Times    ${output}    umax : 58.9336    1
    Should Contain X Times    ${output}    vmin : 2.8066    1
    Should Contain X Times    ${output}    vmax : 19.1234    1
    Should Contain X Times    ${output}    wmin : 45.4364    1
    Should Contain X Times    ${output}    wmax : 44.3597    1
    Should Contain    ${output}    === command configureAcceleration issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureAcceleration received =
    Should Contain    ${output}    device : drive
    Should Contain    ${output}    property : acceleration
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : 76.8625    1
    Should Contain X Times    ${output}    xmax : 5.3427    1
    Should Contain X Times    ${output}    ymin : 50.3241    1
    Should Contain X Times    ${output}    ymax : 52.6057    1
    Should Contain X Times    ${output}    zmin : 78.7844    1
    Should Contain X Times    ${output}    zmax : 7.6516    1
    Should Contain X Times    ${output}    umin : 64.3286    1
    Should Contain X Times    ${output}    umax : 58.9336    1
    Should Contain X Times    ${output}    vmin : 2.8066    1
    Should Contain X Times    ${output}    vmax : 19.1234    1
    Should Contain X Times    ${output}    wmin : 45.4364    1
    Should Contain X Times    ${output}    wmax : 44.3597    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
