*** Settings ***
Documentation    Hexapod_configureLimits commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 458379978 549078351 1253242761 203574083 1377150389 1629996482 1155931961 595903818 841320858 1073205437 328341834 190919623
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 458379978 549078351 1253242761 203574083 1377150389 1629996482 1155931961 595903818 841320858 1073205437 328341834 190919623
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : limits    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 458379978    1
    Should Contain X Times    ${output}    xmax : 549078351    1
    Should Contain X Times    ${output}    ymin : 1253242761    1
    Should Contain X Times    ${output}    ymax : 203574083    1
    Should Contain X Times    ${output}    zmin : 1377150389    1
    Should Contain X Times    ${output}    zmax : 1629996482    1
    Should Contain X Times    ${output}    umin : 1155931961    1
    Should Contain X Times    ${output}    umax : 595903818    1
    Should Contain X Times    ${output}    vmin : 841320858    1
    Should Contain X Times    ${output}    vmax : 1073205437    1
    Should Contain X Times    ${output}    wwmin : 328341834    1
    Should Contain X Times    ${output}    wmax : 190919623    1
    Should Contain    ${output}    === command configureLimits issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

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
    Should Contain X Times    ${output}    xmin : 458379978    1
    Should Contain X Times    ${output}    xmax : 549078351    1
    Should Contain X Times    ${output}    ymin : 1253242761    1
    Should Contain X Times    ${output}    ymax : 203574083    1
    Should Contain X Times    ${output}    zmin : 1377150389    1
    Should Contain X Times    ${output}    zmax : 1629996482    1
    Should Contain X Times    ${output}    umin : 1155931961    1
    Should Contain X Times    ${output}    umax : 595903818    1
    Should Contain X Times    ${output}    vmin : 841320858    1
    Should Contain X Times    ${output}    vmax : 1073205437    1
    Should Contain X Times    ${output}    wwmin : 328341834    1
    Should Contain X Times    ${output}    wmax : 190919623    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
