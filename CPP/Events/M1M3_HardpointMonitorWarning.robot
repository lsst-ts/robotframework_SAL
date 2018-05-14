*** Settings ***
Documentation    M1M3_HardpointMonitorWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointMonitorWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 96.7209 1 0 0 1 1 0 1 0 0 0 1 0 1 0 0 0 0 0 0 1 0 0 0 0 0 1 0 1 1 1 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 0 1 1 1 1 0 1 1 0 0 0 1 0 0 1 0 1 0 1 0 0 1 1 0 1 1 1 0 1 1 0 1 0 1 1 1 0 1 1 0 1 1 0 0 0 1 1 0 0 0 0 1 1 1 1 0 0 1 0 1 1 1 1 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 1 1 0 0 0 0 1 1 1 1 0 0 1 1 1 0 1 0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0 1 1 1 1 0 0 0 1 0 1 0 1 1 1 0 0 1 0 1 0 0 0 0 0 0 0 1 1 0 0 0 -1965976816
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1965976816
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorWarning received =     1
    Should Contain    ${output}    Timestamp : 96.7209
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    AnyMajorFault : 0
    Should Contain    ${output}    MajorFault : 0
    Should Contain    ${output}    AnyMinorFault : 1
    Should Contain    ${output}    MinorFault : 1
    Should Contain    ${output}    AnyFaultOverride : 0
    Should Contain    ${output}    FaultOverride : 1
    Should Contain    ${output}    AnyInstrumentError : 0
    Should Contain    ${output}    InstrumentError : 0
    Should Contain    ${output}    AnyMezzanineError : 0
    Should Contain    ${output}    MezzanineError : 1
    Should Contain    ${output}    AnyMezzanineBootloaderActive : 0
    Should Contain    ${output}    MezzanineBootloaderActive : 1
    Should Contain    ${output}    AnyUniqueIdCRCError : 0
    Should Contain    ${output}    UniqueIdCRCError : 0
    Should Contain    ${output}    AnyApplicationTypeMismatch : 0
    Should Contain    ${output}    ApplicationTypeMismatch : 0
    Should Contain    ${output}    AnyApplicationMissing : 0
    Should Contain    ${output}    ApplicationMissing : 0
    Should Contain    ${output}    AnyApplicationCRCMismatch : 1
    Should Contain    ${output}    ApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyOneWireMissing : 0
    Should Contain    ${output}    OneWireMissing : 0
    Should Contain    ${output}    AnyOneWire1Mismatch : 0
    Should Contain    ${output}    OneWire1Mismatch : 0
    Should Contain    ${output}    AnyOneWire2Mismatch : 1
    Should Contain    ${output}    OneWire2Mismatch : 0
    Should Contain    ${output}    AnyWatchdogReset : 1
    Should Contain    ${output}    WatchdogReset : 1
    Should Contain    ${output}    AnyBrownOut : 1
    Should Contain    ${output}    BrownOut : 1
    Should Contain    ${output}    AnyEventTrapReset : 1
    Should Contain    ${output}    EventTrapReset : 0
    Should Contain    ${output}    AnySSRPowerFault : 1
    Should Contain    ${output}    SSRPowerFault : 0
    Should Contain    ${output}    AnyAuxPowerFault : 0
    Should Contain    ${output}    AuxPowerFault : 1
    Should Contain    ${output}    AnyMezzanineS1AInterface1Fault : 1
    Should Contain    ${output}    MezzanineS1AInterface1Fault : 1
    Should Contain    ${output}    AnyMezzanineS1ALVDT1Fault : 0
    Should Contain    ${output}    MezzanineS1ALVDT1Fault : 0
    Should Contain    ${output}    AnyMezzanineS1AInterface2Fault : 1
    Should Contain    ${output}    MezzanineS1AInterface2Fault : 0
    Should Contain    ${output}    AnyMezzanineS1ALVDT2Fault : 1
    Should Contain    ${output}    MezzanineS1ALVDT2Fault : 1
    Should Contain    ${output}    AnyMezzanineUniqueIdCRCError : 0
    Should Contain    ${output}    MezzanineUniqueIdCRCError : 1
    Should Contain    ${output}    AnyMezzanineEventTrapReset : 1
    Should Contain    ${output}    MezzanineEventTrapReset : 1
    Should Contain    ${output}    AnyMezzanineDCPRS422ChipFault : 1
    Should Contain    ${output}    MezzanineDCPRS422ChipFault : 0
    Should Contain    ${output}    AnyMezzanineApplicationMissing : 1
    Should Contain    ${output}    MezzanineApplicationMissing : 1
    Should Contain    ${output}    AnyMezzanineApplicationCRCMismatch : 0
    Should Contain    ${output}    MezzanineApplicationCRCMismatch : 0
    Should Contain    ${output}    priority : 0
