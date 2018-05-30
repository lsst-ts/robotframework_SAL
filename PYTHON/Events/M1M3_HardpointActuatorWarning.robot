*** Settings ***
Documentation    M1M3_HardpointActuatorWarning sender/logger tests.
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
${component}    HardpointActuatorWarning
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning AnyMajorFault MajorFault AnyMinorFault MinorFault AnyFaultOverride FaultOverride AnyMainCalibrationError MainCalibrationError AnyBackupCalibrationError BackupCalibrationError AnyLimitSwitch1Operated LimitSwitch1Operated AnyLimitSwitch2Operated LimitSwitch2Operated AnyUniqueIdCRCError UniqueIdCRCError AnyApplicationTypeMismatch ApplicationTypeMismatch AnyApplicationMissing ApplicationMissing AnyApplicationCRCMismatch ApplicationCRCMismatch AnyOneWireMissing OneWireMissing AnyOneWire1Mismatch OneWire1Mismatch AnyOneWire2Mismatch OneWire2Mismatch AnyWatchdogReset WatchdogReset AnyBrownOut BrownOut AnyEventTrapReset EventTrapReset AnyMotorDriverFault MotorDriverFault AnySSRPowerFault SSRPowerFault AnyAuxPowerFault AuxPowerFault AnySMCPowerFault SMCPowerFault AnyILCFault ILCFault AnyBroadcastCounterWarning BroadcastCounterWarning priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 52.3169 1 0 0 1 1 0 0 0 1 1 0 1 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 1 1 1 0 1 1 0 0 0 1 0 1 0 1 1 0 0 1 0 0 1 1 1 1 0 0 1 0 1 1 1 1 1 0 1 0 0 1 1 1 0 1 1 0 0 0 1 1 0 1 0 0 0 0 1 1 0 1 1 0 1 0 1 1 1 1 1 1 1 0 0 0 0 1 1 0 1 0 0 1 1 1 1 0 1 0 0 1 0 0 1 0 0 1 1 1 1 0 0 0 0 0 1 1 0 1 0 0 0 1 0 0 1 1 1 0 1 1 0 0 1 0 0 0 0 1 1 0 1 0 0 0 0 -1043857296
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_HardpointActuatorWarning communications tests.
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
${component}    HardpointActuatorWarning
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning AnyMajorFault MajorFault AnyMinorFault MinorFault AnyFaultOverride FaultOverride AnyMainCalibrationError MainCalibrationError AnyBackupCalibrationError BackupCalibrationError AnyLimitSwitch1Operated LimitSwitch1Operated AnyLimitSwitch2Operated LimitSwitch2Operated AnyUniqueIdCRCError UniqueIdCRCError AnyApplicationTypeMismatch ApplicationTypeMismatch AnyApplicationMissing ApplicationMissing AnyApplicationCRCMismatch ApplicationCRCMismatch AnyOneWireMissing OneWireMissing AnyOneWire1Mismatch OneWire1Mismatch AnyOneWire2Mismatch OneWire2Mismatch AnyWatchdogReset WatchdogReset AnyBrownOut BrownOut AnyEventTrapReset EventTrapReset AnyMotorDriverFault MotorDriverFault AnySSRPowerFault SSRPowerFault AnyAuxPowerFault AuxPowerFault AnySMCPowerFault SMCPowerFault AnyILCFault ILCFault AnyBroadcastCounterWarning BroadcastCounterWarning priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 63.8466 0 0 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 1 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 1 0 1 1 1 1 0 0 0 0 1 0 1 1 1 0 1 1 1 1 1 1 1 0 1 0 0 0 0 1 0 1 0 1 0 0 0 1 1 1 0 1 0 1 0 1 0 1 1 1 0 1 0 0 1 0 0 1 0 1 0 0 1 0 0 0 1 1 1 1 0 1 1 0 1 0 0 0 1 0 1 1 0 0 0 0 1 1 1 0 0 1 0 1 1 0 1 0 1 1 1 1 1 0 1 1 0 1 0 1 0 0 607120092
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
