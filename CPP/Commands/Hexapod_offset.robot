*** Settings ***
Documentation    Hexapod_offset commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    offset
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 69.8921 60.0996 42.209 3.0247 96.4399 7.2429 1    #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommandC offset] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : position    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    x : 69.8921    1
    Should Contain X Times    ${output}    y : 60.0996    1
    Should Contain X Times    ${output}    z : 42.209    1
    Should Contain X Times    ${output}    u : 3.0247    1
    Should Contain X Times    ${output}    v : 96.4399    1
    Should Contain X Times    ${output}    w : 7.2429    1
    Should Contain X Times    ${output}    sync : 1    1
    Should Contain    ${output}    === command offset issued =
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
    Should Contain    ${output}    === [acceptCommandC offset] reading a command containing :
    Should Contain X Times    ${output}    seqNum \ \ :    3
    Should Contain X Times    ${output}    error \ \ \ :    2
    Should Contain    ${output}    device : actuators
    Should Contain    ${output}    device \ \ : actuators
    Should Contain X Times    ${output}    property : position    2
    Should Contain    ${output}    action : 
    Should Contain    ${output}    action \ \ : 
    Should Contain    ${output}    value : 
    Should Contain    ${output}    value \ \ \ : 
    Should Contain    ${output}    === command offset received =
    Should Contain X Times    ${output}    x : 69.8921    1
    Should Contain X Times    ${output}    y : 60.0996    1
    Should Contain X Times    ${output}    z : 42.209    1
    Should Contain X Times    ${output}    u : 3.0247    1
    Should Contain X Times    ${output}    v : 96.4399    1
    Should Contain X Times    ${output}    w : 7.2429    1
    Should Contain X Times    ${output}    sync : 1    1
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 301
    Should Contain    ${output}    error    : 1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    error    : 0
    Should Contain    ${output}    result   : Done : OK
