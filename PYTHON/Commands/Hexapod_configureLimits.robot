*** Settings ***
Documentation    Hexapod_configureLimits commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureLimits
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -264936976 530168877 1359623707 -621479627 -2135859228 -1501876659 569514872 1569813641 -560545897 1146157068 -1261830892 -637545289
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -264936976 530168877 1359623707 -621479627 -2135859228 -1501876659 569514872 1569813641 -560545897 1146157068 -1261830892 -637545289
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : -264936976    1
    Should Contain X Times    ${output}    xmax : 530168877    1
    Should Contain X Times    ${output}    ymin : 1359623707    1
    Should Contain X Times    ${output}    ymax : -621479627    1
    Should Contain X Times    ${output}    zmin : -2135859228    1
    Should Contain X Times    ${output}    zmax : -1501876659    1
    Should Contain X Times    ${output}    umin : 569514872    1
    Should Contain X Times    ${output}    umax : 1569813641    1
    Should Contain X Times    ${output}    vmin : -560545897    1
    Should Contain X Times    ${output}    vmax : 1146157068    1
    Should Contain X Times    ${output}    wwmin : -1261830892    1
    Should Contain X Times    ${output}    wmax : -637545289    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = -264936976    1
    Should Contain X Times    ${output}    xmax = 530168877    1
    Should Contain X Times    ${output}    ymin = 1359623707    1
    Should Contain X Times    ${output}    ymax = -621479627    1
    Should Contain X Times    ${output}    zmin = -2135859228    1
    Should Contain X Times    ${output}    zmax = -1501876659    1
    Should Contain X Times    ${output}    umin = 569514872    1
    Should Contain X Times    ${output}    umax = 1569813641    1
    Should Contain X Times    ${output}    vmin = -560545897    1
    Should Contain X Times    ${output}    vmax = 1146157068    1
    Should Contain X Times    ${output}    wwmin = -1261830892    1
    Should Contain X Times    ${output}    wmax = -637545289    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
