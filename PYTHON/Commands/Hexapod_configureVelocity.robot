*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
Force Tags    python
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 43.6736 0.9466 11.4702 98.1987 68.3269 37.2853 1.8749 15.3408 46.7201 59.1343 87.2289 56.6556
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 43.6736 0.9466 11.4702 98.1987 68.3269 37.2853 1.8749 15.3408 46.7201 59.1343 87.2289 56.6556
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 43.6736    1
    Should Contain X Times    ${output}    xmax : 0.9466    1
    Should Contain X Times    ${output}    ymin : 11.4702    1
    Should Contain X Times    ${output}    ymax : 98.1987    1
    Should Contain X Times    ${output}    zmin : 68.3269    1
    Should Contain X Times    ${output}    zmax : 37.2853    1
    Should Contain X Times    ${output}    umin : 1.8749    1
    Should Contain X Times    ${output}    umax : 15.3408    1
    Should Contain X Times    ${output}    vmin : 46.7201    1
    Should Contain X Times    ${output}    vmax : 59.1343    1
    Should Contain X Times    ${output}    wmin : 87.2289    1
    Should Contain X Times    ${output}    wmax : 56.6556    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 43.6736    1
    Should Contain X Times    ${output}    xmax = 0.9466    1
    Should Contain X Times    ${output}    ymin = 11.4702    1
    Should Contain X Times    ${output}    ymax = 98.1987    1
    Should Contain X Times    ${output}    zmin = 68.3269    1
    Should Contain X Times    ${output}    zmax = 37.2853    1
    Should Contain X Times    ${output}    umin = 1.8749    1
    Should Contain X Times    ${output}    umax = 15.3408    1
    Should Contain X Times    ${output}    vmin = 46.7201    1
    Should Contain X Times    ${output}    vmax = 59.1343    1
    Should Contain X Times    ${output}    wmin = 87.2289    1
    Should Contain X Times    ${output}    wmax = 56.6556    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
