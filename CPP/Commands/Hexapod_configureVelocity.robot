*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 29.3139 75.1848 47.8306 88.2416 58.6048 91.0898 42.8165 24.4369 75.5436 48.9238 7.7388 43.146
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 29.3139 75.1848 47.8306 88.2416 58.6048 91.0898 42.8165 24.4369 75.5436 48.9238 7.7388 43.146
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : velocity    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 29.3139    1
    Should Contain X Times    ${output}    xmax : 75.1848    1
    Should Contain X Times    ${output}    ymin : 47.8306    1
    Should Contain X Times    ${output}    ymax : 88.2416    1
    Should Contain X Times    ${output}    zmin : 58.6048    1
    Should Contain X Times    ${output}    zmax : 91.0898    1
    Should Contain X Times    ${output}    umin : 42.8165    1
    Should Contain X Times    ${output}    umax : 24.4369    1
    Should Contain X Times    ${output}    vmin : 75.5436    1
    Should Contain X Times    ${output}    vmax : 48.9238    1
    Should Contain X Times    ${output}    wmin : 7.7388    1
    Should Contain X Times    ${output}    wmax : 43.146    1
    Should Contain    ${output}    === command configureVelocity issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

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
    Should Contain X Times    ${output}    xmin : 29.3139    1
    Should Contain X Times    ${output}    xmax : 75.1848    1
    Should Contain X Times    ${output}    ymin : 47.8306    1
    Should Contain X Times    ${output}    ymax : 88.2416    1
    Should Contain X Times    ${output}    zmin : 58.6048    1
    Should Contain X Times    ${output}    zmax : 91.0898    1
    Should Contain X Times    ${output}    umin : 42.8165    1
    Should Contain X Times    ${output}    umax : 24.4369    1
    Should Contain X Times    ${output}    vmin : 75.5436    1
    Should Contain X Times    ${output}    vmax : 48.9238    1
    Should Contain X Times    ${output}    wmin : 7.7388    1
    Should Contain X Times    ${output}    wmax : 43.146    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
