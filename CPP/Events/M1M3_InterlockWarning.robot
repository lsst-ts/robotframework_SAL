*** Settings ***
Documentation    M1M3_InterlockWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    InterlockWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 6.6238 1 0 1 1 0 1 1 1 1974755523
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_InterlockWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InterlockWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1974755523
    Log    ${output}
    Should Contain X Times    ${output}    === Event InterlockWarning received =     1
    Should Contain    ${output}    Timestamp : 6.6238
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    HeartbeatStateOutputMismatch : 0
    Should Contain    ${output}    AuxPowerNetworksOff : 1
    Should Contain    ${output}    ThermalEquipmentOff : 1
    Should Contain    ${output}    AirSupplyOff : 0
    Should Contain    ${output}    TMAMotionStop : 1
    Should Contain    ${output}    GISHeartbeatLost : 1
    Should Contain    ${output}    CabinetDoorOpen : 1
    Should Contain    ${output}    priority : 1974755523
