*** Settings ***
Documentation    Hexapod_configureAcceleration commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 65.5834 75.8386 26.6627 30.1867 29.1362 73.6082 80.4647 60.3398 15.6512 38.7923 45.7099 86.019
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 65.5834 75.8386 26.6627 30.1867 29.1362 73.6082 80.4647 60.3398 15.6512 38.7923 45.7099 86.019
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 65.5834    1
    Should Contain X Times    ${output}    xmax : 75.8386    1
    Should Contain X Times    ${output}    ymin : 26.6627    1
    Should Contain X Times    ${output}    ymax : 30.1867    1
    Should Contain X Times    ${output}    zmin : 29.1362    1
    Should Contain X Times    ${output}    zmax : 73.6082    1
    Should Contain X Times    ${output}    umin : 80.4647    1
    Should Contain X Times    ${output}    umax : 60.3398    1
    Should Contain X Times    ${output}    vmin : 15.6512    1
    Should Contain X Times    ${output}    vmax : 38.7923    1
    Should Contain X Times    ${output}    wmin : 45.7099    1
    Should Contain X Times    ${output}    wmax : 86.019    1
    Should Contain    ${output}    === command configureAcceleration issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

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
    Should Contain X Times    ${output}    xmin : 65.5834    1
    Should Contain X Times    ${output}    xmax : 75.8386    1
    Should Contain X Times    ${output}    ymin : 26.6627    1
    Should Contain X Times    ${output}    ymax : 30.1867    1
    Should Contain X Times    ${output}    zmin : 29.1362    1
    Should Contain X Times    ${output}    zmax : 73.6082    1
    Should Contain X Times    ${output}    umin : 80.4647    1
    Should Contain X Times    ${output}    umax : 60.3398    1
    Should Contain X Times    ${output}    vmin : 15.6512    1
    Should Contain X Times    ${output}    vmax : 38.7923    1
    Should Contain X Times    ${output}    wmin : 45.7099    1
    Should Contain X Times    ${output}    wmax : 86.019    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
