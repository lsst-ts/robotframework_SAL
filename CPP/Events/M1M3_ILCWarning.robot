*** Settings ***
Documentation    M1M3_ILCWarning communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ILCWarning
${timeout}    30s

*** Test Cases ***
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 97.8395 -782731322 1 1 0 1 0 1 0 0 1 0 339194795
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ILCWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ILCWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 339194795
    Log    ${output}
    Should Contain X Times    ${output}    === Event ILCWarning received =     1
    Should Contain    ${output}    Timestamp : 97.8395
    Should Contain    ${output}    ActuatorId : -782731322
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    ResponseTimeout : 1
    Should Contain    ${output}    InvalidCRC : 0
    Should Contain    ${output}    IllegalFunction : 1
    Should Contain    ${output}    IllegalDataValue : 0
    Should Contain    ${output}    InvalidLength : 1
    Should Contain    ${output}    UnknownSubnet : 0
    Should Contain    ${output}    UnknownAddress : 0
    Should Contain    ${output}    UnknownFunction : 1
    Should Contain    ${output}    UnknownProblem : 0
    Should Contain    ${output}    priority : 339194795
