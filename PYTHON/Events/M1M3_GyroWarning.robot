*** Settings ***
Documentation    M1M3_GyroWarning sender/logger tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    GyroWarning
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning GyroXStatusWarning GyroYStatusWarning GyroZStatusWarning SequenceNumberWarning CRCMismatchWarning InvalidLengthWarning InvalidHeaderWarning IncompleteFrameWarning GyroXSLDWarning GyroXMODDACWarning GyroXPhaseWarning GyroXFlashWarning GyroYSLDWarning GyroYMODDACWarning GyroYPhaseWarning GyroYFlashWarning GyroZSLDWarning GyroZMODDACWarning GyroZPhaseWarning GyroZFlashWarning GyroXSLDTemperatureStatusWarning GyroYSLDTemperatureStatusWarning GyroZSLDTemperatureStatusWarning GCBTemperatureStatusWarning TemperatureStatusWarning GCBDSPSPIFlashStatusWarning GCBFPGASPIFlashStatusWarning DSPSPIFlashStatusWarning FPGASPIFlashStatusWarning GCB1_2VStatusWarning GCB3_3VStatusWarning GCB5VStatusWarning V1_2StatusWarning V3_3StatusWarning V5StatusWarning GCBFPGAStatusWarning FPGAStatusWarning HiSpeedSPORTStatusWarning AuxSPORTStatusWarning SufficientSoftwareResourcesWarning GyroEOVoltsPositiveWarning GyroEOVoltsNegativeWarning GyroXVoltsWarning GyroYVoltsWarning GyroZVoltsWarning GCBADCCommsWarning MSYNCExternalTimingWarning priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 19.6177 0 1 1 0 0 0 0 1 1 1 1 0 0 0 1 1 0 0 0 1 1 0 1 1 0 0 0 1 1 0 1 0 1 1 0 1 1 1 1 1 1 0 0 1 1 1 0 1 -1746036599
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_GyroWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
