*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureVelocity
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.0407 31.4062 42.4837 82.8755 39.8264 43.468 6.3357 61.2387 90.8177 1.4489 35.7782 29.2602
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.0407 31.4062 42.4837 82.8755 39.8264 43.468 6.3357 61.2387 90.8177 1.4489 35.7782 29.2602
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : velocity    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 25.0407    1
    Should Contain X Times    ${output}    xmax : 31.4062    1
    Should Contain X Times    ${output}    ymin : 42.4837    1
    Should Contain X Times    ${output}    ymax : 82.8755    1
    Should Contain X Times    ${output}    zmin : 39.8264    1
    Should Contain X Times    ${output}    zmax : 43.468    1
    Should Contain X Times    ${output}    umin : 6.3357    1
    Should Contain X Times    ${output}    umax : 61.2387    1
    Should Contain X Times    ${output}    vmin : 90.8177    1
    Should Contain X Times    ${output}    vmax : 1.4489    1
    Should Contain X Times    ${output}    wmin : 35.7782    1
    Should Contain X Times    ${output}    wmax : 29.2602    1
    Should Contain    ${output}    === command configureVelocity issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureVelocity received =
    Should Contain    ${output}    device : drive
    Should Contain    ${output}    property : velocity
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : 25.0407    1
    Should Contain X Times    ${output}    xmax : 31.4062    1
    Should Contain X Times    ${output}    ymin : 42.4837    1
    Should Contain X Times    ${output}    ymax : 82.8755    1
    Should Contain X Times    ${output}    zmin : 39.8264    1
    Should Contain X Times    ${output}    zmax : 43.468    1
    Should Contain X Times    ${output}    umin : 6.3357    1
    Should Contain X Times    ${output}    umax : 61.2387    1
    Should Contain X Times    ${output}    vmin : 90.8177    1
    Should Contain X Times    ${output}    vmax : 1.4489    1
    Should Contain X Times    ${output}    wmin : 35.7782    1
    Should Contain X Times    ${output}    wmax : 29.2602    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
