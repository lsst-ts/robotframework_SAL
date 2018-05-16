*** Settings ***
Documentation    M1M3_HardpointMonitorWarning sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointMonitorWarning
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning AnyMajorFault MajorFault AnyMinorFault MinorFault AnyFaultOverride FaultOverride AnyInstrumentError InstrumentError AnyMezzanineError MezzanineError AnyMezzanineBootloaderActive MezzanineBootloaderActive AnyUniqueIdCRCError UniqueIdCRCError AnyApplicationTypeMismatch ApplicationTypeMismatch AnyApplicationMissing ApplicationMissing AnyApplicationCRCMismatch ApplicationCRCMismatch AnyOneWireMissing OneWireMissing AnyOneWire1Mismatch OneWire1Mismatch AnyOneWire2Mismatch OneWire2Mismatch AnyWatchdogReset WatchdogReset AnyBrownOut BrownOut AnyEventTrapReset EventTrapReset AnySSRPowerFault SSRPowerFault AnyAuxPowerFault AuxPowerFault AnyMezzanineS1AInterface1Fault MezzanineS1AInterface1Fault AnyMezzanineS1ALVDT1Fault MezzanineS1ALVDT1Fault AnyMezzanineS1AInterface2Fault MezzanineS1AInterface2Fault AnyMezzanineS1ALVDT2Fault MezzanineS1ALVDT2Fault AnyMezzanineUniqueIdCRCError MezzanineUniqueIdCRCError AnyMezzanineEventTrapReset MezzanineEventTrapReset AnyMezzanineDCPRS422ChipFault MezzanineDCPRS422ChipFault AnyMezzanineApplicationMissing MezzanineApplicationMissing AnyMezzanineApplicationCRCMismatch MezzanineApplicationCRCMismatch priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 55.947 0 0 0 0 0 1 1 0 0 0 0 1 0 1 1 0 0 0 0 1 0 1 1 1 1 1 0 0 0 1 1 0 1 1 0 0 1 0 0 0 1 0 0 1 1 1 0 1 1 0 1 1 0 1 0 1 0 0 1 1 1 1 0 1 0 0 0 0 0 0 1 1 0 0 0 1 1 1 1 0 0 1 1 1 1 1 0 1 0 1 0 1 0 1 1 0 1 1 0 1 1 0 0 0 1 0 1 1 1 0 1 0 0 0 1 1 1 0 0 1 0 1 1 0 0 0 0 1 1 0 1 0 0 1 0 0 0 1 0 0 0 1 0 0 1 0 1 0 0 0 0 1 1 0 1 0 1 1 1 0 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 1 0 2081027053
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
