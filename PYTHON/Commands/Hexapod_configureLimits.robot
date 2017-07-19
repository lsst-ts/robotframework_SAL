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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1689416420 1261154196 -1723457214 1383900629 2095439469 216942575 -1296408345 1706129521 1385099090 1804595809 2045125646 92725224
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1689416420 1261154196 -1723457214 1383900629 2095439469 216942575 -1296408345 1706129521 1385099090 1804595809 2045125646 92725224
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 1689416420    1
    Should Contain X Times    ${output}    xmax : 1261154196    1
    Should Contain X Times    ${output}    ymin : -1723457214    1
    Should Contain X Times    ${output}    ymax : 1383900629    1
    Should Contain X Times    ${output}    zmin : 2095439469    1
    Should Contain X Times    ${output}    zmax : 216942575    1
    Should Contain X Times    ${output}    umin : -1296408345    1
    Should Contain X Times    ${output}    umax : 1706129521    1
    Should Contain X Times    ${output}    vmin : 1385099090    1
    Should Contain X Times    ${output}    vmax : 1804595809    1
    Should Contain X Times    ${output}    wwmin : 2045125646    1
    Should Contain X Times    ${output}    wmax : 92725224    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 1689416420    1
    Should Contain X Times    ${output}    xmax = 1261154196    1
    Should Contain X Times    ${output}    ymin = -1723457214    1
    Should Contain X Times    ${output}    ymax = 1383900629    1
    Should Contain X Times    ${output}    zmin = 2095439469    1
    Should Contain X Times    ${output}    zmax = 216942575    1
    Should Contain X Times    ${output}    umin = -1296408345    1
    Should Contain X Times    ${output}    umax = 1706129521    1
    Should Contain X Times    ${output}    vmin = 1385099090    1
    Should Contain X Times    ${output}    vmax = 1804595809    1
    Should Contain X Times    ${output}    wwmin = 2045125646    1
    Should Contain X Times    ${output}    wmax = 92725224    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
