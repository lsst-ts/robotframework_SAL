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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.756963180 23.006477013 18.929683845 44.552592805 34.591188289 75.664591345 20.752925314 16.978368865 29.521139553 64.247092877 15.468603533 6.404594405    #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommandC configureLimits] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : limits    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
	Comment    TSS-677.
    Should Contain X Times    ${output}    xmin :    1    #0.756963180    1
    Should Contain X Times    ${output}    xmax :    1    #23.006477013    1
    Should Contain X Times    ${output}    ymin :    1    #18.929683845    1
    Should Contain X Times    ${output}    ymax :    1    #44.552592805    1
    Should Contain X Times    ${output}    zmin :    1    #34.591188289    1
    Should Contain X Times    ${output}    zmax :    1    #75.664591345    1
    Should Contain X Times    ${output}    umin :    1    #20.752925314    1
    Should Contain X Times    ${output}    umax :    1    #16.978368865    1
    Should Contain X Times    ${output}    vmin :    1    #29.521139553    1
    Should Contain X Times    ${output}    vmax :    1    #64.247092877    1
    Should Contain X Times    ${output}    wwmin :    1    #15.468603533    1
    Should Contain X Times    ${output}    wmax :    1    #6.404594405    1
    Should Contain    ${output}    === command configureLimits issued =
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
    Should Contain    ${output}    === [acceptCommandC configureLimits] reading a command containing :
    Should Contain X Times    ${output}    seqNum \ \ :    3
    Should Contain X Times    ${output}    error \ \ \ :    2
    Should Contain    ${output}    device : actuators
    Should Contain    ${output}    device \ \ : actuators
    Should Contain X Times    ${output}    property : limits    2
    Should Contain    ${output}    action : 
    Should Contain    ${output}    action \ \ : 
    Should Contain    ${output}    value : 
    Should Contain    ${output}    value \ \ \ : 
    Should Contain    ${output}    === command configureLimits received =
	Comment    TSS-677.
    Should Contain X Times    ${output}    xmin :    1    #0.756963180    1
    Should Contain X Times    ${output}    xmax :    1    #23.006477013    1
    Should Contain X Times    ${output}    ymin :    1    #18.929683845    1
    Should Contain X Times    ${output}    ymax :    1    #44.552592805    1
    Should Contain X Times    ${output}    zmin :    1    #34.591188289    1
    Should Contain X Times    ${output}    zmax :    1    #75.664591345    1
    Should Contain X Times    ${output}    umin :    1    #20.752925314    1
    Should Contain X Times    ${output}    umax :    1    #16.978368865    1
    Should Contain X Times    ${output}    vmin :    1    #29.521139553    1
    Should Contain X Times    ${output}    vmax :    1    #64.247092877    1
    Should Contain X Times    ${output}    wwmin :    1    #15.468603533    1
    Should Contain X Times    ${output}    wmax :    1    #6.404594405    1
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 301
    Should Contain    ${output}    error    : 1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    === [ackCommand] acknowledging a command with :
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    error    : 0
    Should Contain    ${output}    result   : Done : OK
