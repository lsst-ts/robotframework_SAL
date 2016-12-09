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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 49.5871 81.7537 85.681 94.9004 66.7385 90.9417 16.2929 35.7374 94.1497 23.2711 29.4286 17.9306
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 49.5871 81.7537 85.681 94.9004 66.7385 90.9417 16.2929 35.7374 94.1497 23.2711 29.4286 17.9306
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 49.5871    1
    Should Contain X Times    ${output}    xmax : 81.7537    1
    Should Contain X Times    ${output}    ymin : 85.681    1
    Should Contain X Times    ${output}    ymax : 94.9004    1
    Should Contain X Times    ${output}    zmin : 66.7385    1
    Should Contain X Times    ${output}    zmax : 90.9417    1
    Should Contain X Times    ${output}    umin : 16.2929    1
    Should Contain X Times    ${output}    umax : 35.7374    1
    Should Contain X Times    ${output}    vmin : 94.1497    1
    Should Contain X Times    ${output}    vmax : 23.2711    1
    Should Contain X Times    ${output}    wmin : 29.4286    1
    Should Contain X Times    ${output}    wmax : 17.9306    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 49.5871    1
    Should Contain X Times    ${output}    xmax = 81.7537    1
    Should Contain X Times    ${output}    ymin = 85.681    1
    Should Contain X Times    ${output}    ymax = 94.9004    1
    Should Contain X Times    ${output}    zmin = 66.7385    1
    Should Contain X Times    ${output}    zmax = 90.9417    1
    Should Contain X Times    ${output}    umin = 16.2929    1
    Should Contain X Times    ${output}    umax = 35.7374    1
    Should Contain X Times    ${output}    vmin = 94.1497    1
    Should Contain X Times    ${output}    vmax = 23.2711    1
    Should Contain X Times    ${output}    wmin = 29.4286    1
    Should Contain X Times    ${output}    wmax = 17.9306    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
