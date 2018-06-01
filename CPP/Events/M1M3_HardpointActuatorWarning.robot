*** Settings ***
Documentation    M1M3_HardpointActuatorWarning communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 55.5883 1 0 1 0 0 1 1 0 0 0 0 1 1 0 0 1 0 0 1 0 1 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 0 1 0 1 0 0 0 1 0 1 1 1 0 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 1 1 0 0 1 1 1 1 0 0 0 1 1 1 0 1 1 1 1 1 1 0 0 0 0 0 0 0 1 1 0 1 1 1 1 1 0 1 1 1 0 0 0 0 1 0 0 1 1 0 1 1 1 0 1 1 1 0 0 1 1 1 1 957811063
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 957811063
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorWarning received =     1
    Should Contain    ${output}    Timestamp : 55.5883
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    AnyMajorFault : 0
    Should Contain    ${output}    MajorFault : 1
    Should Contain    ${output}    AnyMinorFault : 0
    Should Contain    ${output}    MinorFault : 0
    Should Contain    ${output}    AnyFaultOverride : 1
    Should Contain    ${output}    FaultOverride : 1
    Should Contain    ${output}    AnyMainCalibrationError : 0
    Should Contain    ${output}    MainCalibrationError : 0
    Should Contain    ${output}    AnyBackupCalibrationError : 0
    Should Contain    ${output}    BackupCalibrationError : 0
    Should Contain    ${output}    AnyLimitSwitch1Operated : 1
    Should Contain    ${output}    LimitSwitch1Operated : 1
    Should Contain    ${output}    AnyLimitSwitch2Operated : 0
    Should Contain    ${output}    LimitSwitch2Operated : 0
    Should Contain    ${output}    AnyUniqueIdCRCError : 1
    Should Contain    ${output}    UniqueIdCRCError : 0
    Should Contain    ${output}    AnyApplicationTypeMismatch : 0
    Should Contain    ${output}    ApplicationTypeMismatch : 1
    Should Contain    ${output}    AnyApplicationMissing : 0
    Should Contain    ${output}    ApplicationMissing : 1
    Should Contain    ${output}    AnyApplicationCRCMismatch : 0
    Should Contain    ${output}    ApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyOneWireMissing : 0
    Should Contain    ${output}    OneWireMissing : 1
    Should Contain    ${output}    AnyOneWire1Mismatch : 0
    Should Contain    ${output}    OneWire1Mismatch : 0
    Should Contain    ${output}    AnyOneWire2Mismatch : 0
    Should Contain    ${output}    OneWire2Mismatch : 1
    Should Contain    ${output}    AnyWatchdogReset : 0
    Should Contain    ${output}    WatchdogReset : 1
    Should Contain    ${output}    AnyBrownOut : 1
    Should Contain    ${output}    BrownOut : 0
    Should Contain    ${output}    AnyEventTrapReset : 0
    Should Contain    ${output}    EventTrapReset : 0
    Should Contain    ${output}    AnyMotorDriverFault : 0
    Should Contain    ${output}    MotorDriverFault : 0
    Should Contain    ${output}    AnySSRPowerFault : 0
    Should Contain    ${output}    SSRPowerFault : 1
    Should Contain    ${output}    AnyAuxPowerFault : 1
    Should Contain    ${output}    AuxPowerFault : 1
    Should Contain    ${output}    AnySMCPowerFault : 0
    Should Contain    ${output}    SMCPowerFault : 0
    Should Contain    ${output}    AnyILCFault : 0
    Should Contain    ${output}    ILCFault : 0
    Should Contain    ${output}    AnyBroadcastCounterWarning : 0
    Should Contain    ${output}    BroadcastCounterWarning : 0
    Should Contain    ${output}    priority : 1
