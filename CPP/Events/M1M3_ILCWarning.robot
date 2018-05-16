*** Settings ***
Documentation    M1M3_ILCWarning sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 2.7035 -2145607025 1 1 0 0 1 1 0 1 0 1 1515276461
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ILCWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ILCWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1515276461
    Log    ${output}
    Should Contain X Times    ${output}    === Event ILCWarning received =     1
    Should Contain    ${output}    Timestamp : 2.7035
    Should Contain    ${output}    ActuatorId : -2145607025
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    ResponseTimeout : 1
    Should Contain    ${output}    InvalidCRC : 0
    Should Contain    ${output}    IllegalFunction : 0
    Should Contain    ${output}    IllegalDataValue : 1
    Should Contain    ${output}    InvalidLength : 1
    Should Contain    ${output}    UnknownSubnet : 0
    Should Contain    ${output}    UnknownAddress : 1
    Should Contain    ${output}    UnknownFunction : 0
    Should Contain    ${output}    UnknownProblem : 1
    Should Contain    ${output}    priority : 1515276461
