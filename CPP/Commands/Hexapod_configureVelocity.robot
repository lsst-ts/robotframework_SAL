*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
Force Tags    cpp
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 85.3044 74.0189 71.6778 18.1525 79.136 45.7974 19.0267 67.89 5.761 43.3978 83.9372 30.8193
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 85.3044 74.0189 71.6778 18.1525 79.136 45.7974 19.0267 67.89 5.761 43.3978 83.9372 30.8193
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : velocity    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 85.3044    1
    Should Contain X Times    ${output}    xmax : 74.0189    1
    Should Contain X Times    ${output}    ymin : 71.6778    1
    Should Contain X Times    ${output}    ymax : 18.1525    1
    Should Contain X Times    ${output}    zmin : 79.136    1
    Should Contain X Times    ${output}    zmax : 45.7974    1
    Should Contain X Times    ${output}    umin : 19.0267    1
    Should Contain X Times    ${output}    umax : 67.89    1
    Should Contain X Times    ${output}    vmin : 5.761    1
    Should Contain X Times    ${output}    vmax : 43.3978    1
    Should Contain X Times    ${output}    wmin : 83.9372    1
    Should Contain X Times    ${output}    wmax : 30.8193    1
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
    Should Contain X Times    ${output}    xmin : 85.3044    1
    Should Contain X Times    ${output}    xmax : 74.0189    1
    Should Contain X Times    ${output}    ymin : 71.6778    1
    Should Contain X Times    ${output}    ymax : 18.1525    1
    Should Contain X Times    ${output}    zmin : 79.136    1
    Should Contain X Times    ${output}    zmax : 45.7974    1
    Should Contain X Times    ${output}    umin : 19.0267    1
    Should Contain X Times    ${output}    umax : 67.89    1
    Should Contain X Times    ${output}    vmin : 5.761    1
    Should Contain X Times    ${output}    vmax : 43.3978    1
    Should Contain X Times    ${output}    wmin : 83.9372    1
    Should Contain X Times    ${output}    wmax : 30.8193    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
