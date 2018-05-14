*** Settings ***
Documentation    M1M3_HardpointActuatorWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointActuatorWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 61.9191 1 0 0 1 0 1 0 0 0 0 1 1 0 1 0 0 0 0 1 1 0 1 0 0 0 1 1 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 0 1 0 0 1 0 1 1 0 0 1 0 1 0 0 0 1 0 0 1 1 0 0 0 1 0 0 1 0 0 0 1 0 0 1 1 1 1 0 1 0 0 1 0 1 1 1 0 1 1 1 0 1 1 0 1 0 1 0 1 0 0 0 1 0 1 0 0 1 1 1 0 0 1 0 1 1 1 0 0 0 0 1 0 0 0 0 1 0 1 1 0 0 1 0 1 1 0 1 1 1 1 0 0 1 1 1 1 0 1 1 1 1 0 0 1 1 0 1 0 -474286702
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -474286702
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorWarning received =     1
    Should Contain    ${output}    Timestamp : 61.9191
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    AnyMajorFault : 0
    Should Contain    ${output}    MajorFault : 0
    Should Contain    ${output}    AnyMinorFault : 1
    Should Contain    ${output}    MinorFault : 0
    Should Contain    ${output}    AnyFaultOverride : 1
    Should Contain    ${output}    FaultOverride : 0
    Should Contain    ${output}    AnyMainCalibrationError : 0
    Should Contain    ${output}    MainCalibrationError : 0
    Should Contain    ${output}    AnyBackupCalibrationError : 0
    Should Contain    ${output}    BackupCalibrationError : 1
    Should Contain    ${output}    AnyLimitSwitch1Operated : 1
    Should Contain    ${output}    LimitSwitch1Operated : 0
    Should Contain    ${output}    AnyLimitSwitch2Operated : 1
    Should Contain    ${output}    LimitSwitch2Operated : 0
    Should Contain    ${output}    AnyUniqueIdCRCError : 0
    Should Contain    ${output}    UniqueIdCRCError : 0
    Should Contain    ${output}    AnyApplicationTypeMismatch : 0
    Should Contain    ${output}    ApplicationTypeMismatch : 1
    Should Contain    ${output}    AnyApplicationMissing : 1
    Should Contain    ${output}    ApplicationMissing : 0
    Should Contain    ${output}    AnyApplicationCRCMismatch : 1
    Should Contain    ${output}    ApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyOneWireMissing : 0
    Should Contain    ${output}    OneWireMissing : 0
    Should Contain    ${output}    AnyOneWire1Mismatch : 1
    Should Contain    ${output}    OneWire1Mismatch : 1
    Should Contain    ${output}    AnyOneWire2Mismatch : 0
    Should Contain    ${output}    OneWire2Mismatch : 0
    Should Contain    ${output}    AnyWatchdogReset : 0
    Should Contain    ${output}    WatchdogReset : 0
    Should Contain    ${output}    AnyBrownOut : 0
    Should Contain    ${output}    BrownOut : 1
    Should Contain    ${output}    AnyEventTrapReset : 1
    Should Contain    ${output}    EventTrapReset : 1
    Should Contain    ${output}    AnyMotorDriverFault : 0
    Should Contain    ${output}    MotorDriverFault : 0
    Should Contain    ${output}    AnySSRPowerFault : 0
    Should Contain    ${output}    SSRPowerFault : 0
    Should Contain    ${output}    AnyAuxPowerFault : 0
    Should Contain    ${output}    AuxPowerFault : 0
    Should Contain    ${output}    AnySMCPowerFault : 1
    Should Contain    ${output}    SMCPowerFault : 0
    Should Contain    ${output}    AnyILCFault : 1
    Should Contain    ${output}    ILCFault : 0
    Should Contain    ${output}    AnyBroadcastCounterWarning : 0
    Should Contain    ${output}    BroadcastCounterWarning : 1
    Should Contain    ${output}    priority : 0
