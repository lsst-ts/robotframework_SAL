*** Settings ***
Documentation    Hexapod_configureLimits commander/controller tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 1510005603 633221442 2090311519 966679959 1240133165 1800526862 2008818323 225284097 1656785580 1699343308 1451691000 834087062
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 1510005603 633221442 2090311519 966679959 1240133165 1800526862 2008818323 225284097 1656785580 1699343308 1451691000 834087062
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : limits    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 1510005603    1
    Should Contain X Times    ${output}    xmax : 633221442    1
    Should Contain X Times    ${output}    ymin : 2090311519    1
    Should Contain X Times    ${output}    ymax : 966679959    1
    Should Contain X Times    ${output}    zmin : 1240133165    1
    Should Contain X Times    ${output}    zmax : 1800526862    1
    Should Contain X Times    ${output}    umin : 2008818323    1
    Should Contain X Times    ${output}    umax : 225284097    1
    Should Contain X Times    ${output}    vmin : 1656785580    1
    Should Contain X Times    ${output}    vmax : 1699343308    1
    Should Contain X Times    ${output}    wwmin : 1451691000    1
    Should Contain X Times    ${output}    wmax : 834087062    1
    Should Contain    ${output}    === command configureLimits issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureLimits received =
    Should Contain    ${output}    device : actuators
    Should Contain    ${output}    property : limits
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : 1510005603    1
    Should Contain X Times    ${output}    xmax : 633221442    1
    Should Contain X Times    ${output}    ymin : 2090311519    1
    Should Contain X Times    ${output}    ymax : 966679959    1
    Should Contain X Times    ${output}    zmin : 1240133165    1
    Should Contain X Times    ${output}    zmax : 1800526862    1
    Should Contain X Times    ${output}    umin : 2008818323    1
    Should Contain X Times    ${output}    umax : 225284097    1
    Should Contain X Times    ${output}    vmin : 1656785580    1
    Should Contain X Times    ${output}    vmax : 1699343308    1
    Should Contain X Times    ${output}    wwmin : 1451691000    1
    Should Contain X Times    ${output}    wmax : 834087062    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
