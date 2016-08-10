*** Settings ***
Documentation    M2MS_M2AssemblyInPosition sender/logger tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    M2AssemblyInPosition
${timeout}    30s
#${conOut}    ${subSystem}_${component}_sub.out
#${comOut}    ${subSystem}_${component}_pub.out

*** Test Cases ***
Create Sender Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Sender    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Logger Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Logger    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send     #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log    #|tee ${conOut}
    ${output}=    Read
    Log    ${output}
    Should Be Empty    ${output}
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${conOut}

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 1527021892 1    #|tee ${comOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m2ms::logevent_M2AssemblyInPosition writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event M2AssemblyInPosition generated =
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${comOut}

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read    delay=10s
    Log    ${output}
    Should Contain X Times    ${output}    === [GetSample] message received :1    2
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    2
    Should Contain X Times    ${output}    sndStamp \ :    2
    Should Contain X Times    ${output}    origin \ : 1    2
    Should Contain X Times    ${output}    host \ : 1    2
    Should Contain X Times    ${output}    === Event M2AssemblyInPosition received =     2
    Should Contain X Times    ${output}    priority : 1527021892    2
    Should Contain X Times    ${output}    priority :    2
    Should Contain    ${output}    priority : 1527021892
    Should Contain X Times    ${output}    inPosition :    2
    Should Contain    ${output}    inPosition : 1