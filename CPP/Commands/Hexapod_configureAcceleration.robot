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
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 83.4872 85.5292 39.5809 92.7437 20.7605 33.0624 39.7454 62.1504 82.5376 20.3993 28.6584 1.7782
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
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 83.4872 85.5292 39.5809 92.7437 20.7605 33.0624 39.7454 62.1504 82.5376 20.3993 28.6584 1.7782
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 83.4872    1
    Should Contain X Times    ${output}    xmax : 85.5292    1
    Should Contain X Times    ${output}    ymin : 39.5809    1
    Should Contain X Times    ${output}    ymax : 92.7437    1
    Should Contain X Times    ${output}    zmin : 20.7605    1
    Should Contain X Times    ${output}    zmax : 33.0624    1
    Should Contain X Times    ${output}    umin : 39.7454    1
    Should Contain X Times    ${output}    umax : 62.1504    1
    Should Contain X Times    ${output}    vmin : 82.5376    1
    Should Contain X Times    ${output}    vmax : 20.3993    1
    Should Contain X Times    ${output}    wmin : 28.6584    1
    Should Contain X Times    ${output}    wmax : 1.7782    1
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
    Should Contain X Times    ${output}    xmin : 83.4872    1
    Should Contain X Times    ${output}    xmax : 85.5292    1
    Should Contain X Times    ${output}    ymin : 39.5809    1
    Should Contain X Times    ${output}    ymax : 92.7437    1
    Should Contain X Times    ${output}    zmin : 20.7605    1
    Should Contain X Times    ${output}    zmax : 33.0624    1
    Should Contain X Times    ${output}    umin : 39.7454    1
    Should Contain X Times    ${output}    umax : 62.1504    1
    Should Contain X Times    ${output}    vmin : 82.5376    1
    Should Contain X Times    ${output}    vmax : 20.3993    1
    Should Contain X Times    ${output}    wmin : 28.6584    1
    Should Contain X Times    ${output}    wmax : 1.7782    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
