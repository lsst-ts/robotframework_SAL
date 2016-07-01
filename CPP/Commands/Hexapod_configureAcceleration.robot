*** Settings ***
Documentation    Hexapod_configureAcceleration commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAcceleration
${timeout}    30s
#${conOut}    ${subSystem}_${component}_sub.out
#${comOut}    ${subSystem}_${component}_pub.out

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander     #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller    #|tee ${conOut}
    ${output}=    Read
    Log    ${output}
    Should Be Empty    ${output}
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${conOut}

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 31.96 22.88 6.29 57.46 48.49 63.78 83.37 18.4 81.07 61.68 42.33 4.28    #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommandC configureAcceleration] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 31.96    1
    Should Contain X Times    ${output}    xmax : 22.88    1
    Should Contain X Times    ${output}    ymin : 6.29    1
    Should Contain X Times    ${output}    ymax : 57.46    1
    Should Contain X Times    ${output}    zmin : 48.49    1
    Should Contain X Times    ${output}    zmax : 63.78    1
    Should Contain X Times    ${output}    umin : 83.37    1
    Should Contain X Times    ${output}    umax : 18.4    1
    Should Contain X Times    ${output}    vmin : 81.07    1
    Should Contain X Times    ${output}    vmax : 61.68    1
    Should Contain X Times    ${output}    wmin : 42.33    1
    Should Contain X Times    ${output}    wmax : 4.28    1
    Should Contain    ${output}    === command configureAcceleration issued =
    Should Contain    ${output}    === [getResponse] reading a message containing :
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    error \ \ \ :
    Should Contain    ${output}    ack \ \ \ \ \ : 300
    Should Contain    ${output}    result \ \ : SAL ACK
    Should Contain    ${output}    ack \ \ \ \ \ : 301
    Should Contain    ${output}    result \ \ : Ack : OK
    Should Contain    ${output}    ack \ \ \ \ \ : 303
    Should Contain    ${output}    result \ \ : Done : OK
    Should Contain    ${output}    === [waitForCompletion] command 0 completed ok :
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${comOut}

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === [acceptCommandC configureAcceleration] reading a command containing :
    Should Contain X Times    ${output}    seqNum \ \ :    3
    Should Contain X Times    ${output}    error \ \ \ :    2
    Should Contain    ${output}    device : drive
    Should Contain    ${output}    device \ \ : drive
    Should Contain X Times    ${output}    property : acceleration    2
    Should Contain    ${output}    action : 
    Should Contain    ${output}    action \ \ : 
    Should Contain    ${output}    value : 
    Should Contain    ${output}    value \ \ \ : 
    Should Contain    ${output}    === command configureAcceleration received =
    Should Contain X Times    ${output}    xmin : 31.96    1
    Should Contain X Times    ${output}    xmax : 22.88    1
    Should Contain X Times    ${output}    ymin : 6.29    1
    Should Contain X Times    ${output}    ymax : 57.46    1
    Should Contain X Times    ${output}    zmin : 48.49    1
    Should Contain X Times    ${output}    zmax : 63.78    1
    Should Contain X Times    ${output}    umin : 83.37    1
    Should Contain X Times    ${output}    umax : 18.4    1
    Should Contain X Times    ${output}    vmin : 81.07    1
    Should Contain X Times    ${output}    vmax : 61.68    1
    Should Contain X Times    ${output}    wmin : 42.33    1
    Should Contain X Times    ${output}    wmax : 4.28    1
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 301
    Should Contain    ${output}    error    : 1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    error    : 0
    Should Contain    ${output}    result   : Done : OK
