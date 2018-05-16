*** Settings ***
Documentation    M1M3_GyroWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    GyroWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 66.2534 0 0 1 0 1 1 1 1 1 0 0 0 1 1 0 1 1 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 1678292124
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_GyroWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event GyroWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1678292124
    Log    ${output}
    Should Contain X Times    ${output}    === Event GyroWarning received =     1
    Should Contain    ${output}    Timestamp : 66.2534
    Should Contain    ${output}    AnyWarning : 0
    Should Contain    ${output}    GyroXStatusWarning : 0
    Should Contain    ${output}    GyroYStatusWarning : 1
    Should Contain    ${output}    GyroZStatusWarning : 0
    Should Contain    ${output}    SequenceNumberWarning : 1
    Should Contain    ${output}    CRCMismatchWarning : 1
    Should Contain    ${output}    InvalidLengthWarning : 1
    Should Contain    ${output}    InvalidHeaderWarning : 1
    Should Contain    ${output}    IncompleteFrameWarning : 1
    Should Contain    ${output}    GyroXSLDWarning : 0
    Should Contain    ${output}    GyroXMODDACWarning : 0
    Should Contain    ${output}    GyroXPhaseWarning : 0
    Should Contain    ${output}    GyroXFlashWarning : 1
    Should Contain    ${output}    GyroYSLDWarning : 1
    Should Contain    ${output}    GyroYMODDACWarning : 0
    Should Contain    ${output}    GyroYPhaseWarning : 1
    Should Contain    ${output}    GyroYFlashWarning : 1
    Should Contain    ${output}    GyroZSLDWarning : 1
    Should Contain    ${output}    GyroZMODDACWarning : 1
    Should Contain    ${output}    GyroZPhaseWarning : 1
    Should Contain    ${output}    GyroZFlashWarning : 0
    Should Contain    ${output}    GyroXSLDTemperatureStatusWarning : 0
    Should Contain    ${output}    GyroYSLDTemperatureStatusWarning : 1
    Should Contain    ${output}    GyroZSLDTemperatureStatusWarning : 1
    Should Contain    ${output}    GCBTemperatureStatusWarning : 1
    Should Contain    ${output}    TemperatureStatusWarning : 0
    Should Contain    ${output}    GCBDSPSPIFlashStatusWarning : 0
    Should Contain    ${output}    GCBFPGASPIFlashStatusWarning : 0
    Should Contain    ${output}    DSPSPIFlashStatusWarning : 0
    Should Contain    ${output}    FPGASPIFlashStatusWarning : 0
    Should Contain    ${output}    GCB1_2VStatusWarning : 0
    Should Contain    ${output}    GCB3_3VStatusWarning : 0
    Should Contain    ${output}    GCB5VStatusWarning : 1
    Should Contain    ${output}    V1_2StatusWarning : 1
    Should Contain    ${output}    V3_3StatusWarning : 1
    Should Contain    ${output}    V5StatusWarning : 0
    Should Contain    ${output}    GCBFPGAStatusWarning : 0
    Should Contain    ${output}    FPGAStatusWarning : 1
    Should Contain    ${output}    HiSpeedSPORTStatusWarning : 1
    Should Contain    ${output}    AuxSPORTStatusWarning : 0
    Should Contain    ${output}    SufficientSoftwareResourcesWarning : 0
    Should Contain    ${output}    GyroEOVoltsPositiveWarning : 1
    Should Contain    ${output}    GyroEOVoltsNegativeWarning : 1
    Should Contain    ${output}    GyroXVoltsWarning : 0
    Should Contain    ${output}    GyroYVoltsWarning : 0
    Should Contain    ${output}    GyroZVoltsWarning : 1
    Should Contain    ${output}    GCBADCCommsWarning : 1
    Should Contain    ${output}    MSYNCExternalTimingWarning : 0
    Should Contain    ${output}    priority : 1678292124
