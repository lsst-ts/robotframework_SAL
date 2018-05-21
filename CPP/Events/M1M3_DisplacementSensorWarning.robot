*** Settings ***
Documentation    M1M3_DisplacementSensorWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    DisplacementSensorWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 89.156 1 1 0 1 0 1 0 0 1 1 1 1 1 0 1 1006149599
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_DisplacementSensorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event DisplacementSensorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1006149599
    Log    ${output}
    Should Contain X Times    ${output}    === Event DisplacementSensorWarning received =     1
    Should Contain    ${output}    Timestamp : 89.156
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    SensorReportsInvalidCommand : 1
    Should Contain    ${output}    SensorReportsCommunicationTimeoutError : 0
    Should Contain    ${output}    SensorReportsDataLengthError : 1
    Should Contain    ${output}    SensorReportsNumberOfParametersError : 0
    Should Contain    ${output}    SensorReportsParameterError : 1
    Should Contain    ${output}    SensorReportsCommunicationError : 0
    Should Contain    ${output}    SensorReportsIDNumberError : 0
    Should Contain    ${output}    SensorReportsExpansionLineError : 1
    Should Contain    ${output}    SensorReportsWriteControlError : 1
    Should Contain    ${output}    ResponseTimeout : 1
    Should Contain    ${output}    InvalidLength : 1
    Should Contain    ${output}    InvalidResponse : 1
    Should Contain    ${output}    UnknownCommand : 0
    Should Contain    ${output}    UnknownProblem : 1
    Should Contain    ${output}    priority : 1006149599
