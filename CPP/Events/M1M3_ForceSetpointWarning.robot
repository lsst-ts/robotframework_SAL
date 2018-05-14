*** Settings ***
Documentation    M1M3_ForceSetpointWarning sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceSetpointWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 70.7702 0 1 0 0 1 1 0 0 1 0 0 1 0 1 0 1 0 0 1 1 0 1 1 0 0 0 1 1 1 1 0 0 0 1 0 1 1 0 0 1 0 0 1 1 0 1 0 0 1 0 0 0 0 0 0 1 1 1 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 0 1 1 0 1 0 1 1 0 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 1 1 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 0 1 1 1 0 0 0 1 0 0 0 0 1 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 1 1 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0 0 1 0 1 1 1 0 1 1 1 0 0 0 0 1 1 1 0 0 0 1 0 1 1 0 1 0 1 0 1 0 1 1 0 0 0 1 0 1 1 0 1 1 1 1 0 0 0 0 0 1 0 0 1 1 0 0 1 1 1 1 0 1 1 1 1 0 0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 0 0 0 0 1 1 0 1 1 0 1 0 1 0 1 0 1 0 0 1 1 0 0 0 0 0 1 0 1 1 1 1 1 0 1 0 1 0 1 0 0 1 1 1 0 1 1 1 0 0 1 1 0 0 0 1 0 1 0 0 0 1 1 0 0 0 1 1 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0 0 1 0 0 1 0 1 1 1 0 1 0 1 1 1 0 1 0 1 0 0 1 0 0 0 1 0 0 1 0 1 1 1 0 0 0 0 1 0 0 1 1 0 1 1 1 1 0 1 1 0 0 0 1 1 1 0 1 0 0 1 0 1 0 0 1 1 1 1 1 1 0 1 1 1 1 0 0 1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 1 1 1 0 0 1 1 0 1 0 1 0 0 1 1 1 1 1 1 0 0 0 0 1 0 1 1 1 0 1 1 1 1 1 0 1 0 0 0 0 0 1 1 1 0 1 1 1 0 1 0 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 1 1 0 1 1 0 1 1 1 0 0 1 0 0 1 1 0 1 0 0 0 1 1 1 0 0 1 1 0 1 1 0 0 0 0 1 0 1 0 1 1 0 1 1 1 0 1 1 0 1 1 0 1 0 0 1 0 1 0 1 0 1 0 0 1 0 1 0 0 0 1 1 1 1 1 1 0 0 0 0 1 1 0 0 0 1 1 1 0 1 0 0 0 1 0 0 0 1 1 0 1 0 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 0 1 1 0 0 0 1 0 1 1 1 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 1 0 0 1 1 0 0 1 1 0 1 1 1 0 1 0 1 1 0 0 1 0 0 0 1 0 0 1 1 0 1 0 1 0 0 1 1 0 0 1 0 1 0 1 1 1 1 0 1 0 1 0 1 1 1 0 1 0 1 1 1 1 1 0 1 0 0 1 1 0 1 1 0 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 0 1 0 0 1 1 1 1 1 1 1 0 1 0 1 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 1 0 1 0 1 1 1 0 0 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1 1 0 1 1 0 0 0 0 1 0 0 1 0 0 1 1 1 0 0 1 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 0 1 1 0 1 0 1 1 0 0 0 0 0 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 1 1 1 1 0 0 1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 0 0 0 0 1 0 1 0 1 0 1 1 1 0 0 0 1 0 1 0 1 1 1 1 1 0 1 1 1 0 0 0 0 0 1 1 1 1 0 1 1 0 0 1 0 0 0 1 1 1 0 1 0 1 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0 0 0 1 0 1 0 1 0 1 0 0 0 1 1 0 0 0 1 0 1 0 0 0 0 0 1 1 0 1 1 1 0 0 1 0 1 1 0 0 0 1 0 1 0 1 0 1 1 0 0 1 0 0 1 1 1 0 0 1 0 1 0 1 1 1 0 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 1 0 1 1 1 0 0 1 0 1 1 0 0 0 1 1 1 1 1 0 0 1 1 0 1 1 1 0 1 0 1 1 1 1 1 1 0 0 1 0 0 1 0 0 0 1 0 1 1 1 1 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 1 1 0 1 0 0 1 1 0 1 0 0 0 0 0 1 1 0 1 1 0 1 1 1 0 1 0 1 0 1 1 1 1 1 1 0 0 1 0 0 0 0 0 1 1 0 1 0 1 1 1 1 0 0 1 1 0 1 0 0 1 1 1 0 0 0 0 0 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 1 0 0 1 1 1 1 1 1 0 1 0 0 1 1 1 0 0 0 1 1 1 0 0 1 0 1 1 0 1 1 1 0 0 1 0 1 1 1 0 0 0 1 0 1 1 0 0 1 0 1 0 1 1 0 1 1 1 1 1 1 0 0 1 0 0 1 1 1 1 1 1 1 0 1 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 1 1 0 0 1 1 1 0 1 1 1 1 1 1 0 0 1 1 0 1 0 1 1 1 1 1 0 0 1 0 0 0 1 1 1 1 0 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 0 1 1 0 0 1 0 0 1 1 1 0 0 1 0 0 1 1 0 0 1 1 0 1 0 1 1 0 0 1 1 1 1 1 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 0 1 1 1 0 1 0 0 1 0 0 1 1 1 0 0 0 1 0 0 0 1 1 0 1 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 0 0 1 1 0 0 1 1 1 1 0 0 1 1 1 0 1 0 0 0 1 1 0 1 1 0 1 0 1 0 1 0 0 1 0 1 1 0 1 1 1 1 1 1 1 1 0 0 0 0 1 0 1 0 0 0 0 1 0 1 0 1 1 0 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 0 1 1 1 0 1 0 0 0 1 0 1 0 1 0 1 0 0 1 0 0 1 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0 0 0 1 0 1 0 0 1 0 0 0 0 0 1 0 1 0 1 0 1 1 0 1 0 1 1 0 0 0 0 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 0 0 0 1 0 1 1 1 1 0 1 0 0 1 1 0 0 1 0 0 0 1 1 1 1 1 0 0 1 0 1 1 0 0 1 1 1 0 1 1 1 0 0 0 0 1 0 0 0 0 1 1 0 1 0 1 1 1 0 0 0 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 0 1 0 1 0 1 1 1 1 1 1 0 0 1 0 1 1 1 0 1 0 0 1 0 1 0 0 1 0 1 0 0 1 0 1 0 0 0 1 1 0 1 0 0 0 1 0 0 1 1 0 0 1 0 0 1 1 0 1 0 1 0 0 0 1 0 1 0 0 0 0 1 0 1 1 0 1 1 0 0 1 1 1 0 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 1 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0 1 1 0 1 1 0 1 1 0 0 1 1 1 1 0 0 1 0 1 1 0 1 1 0 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 0 1 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 1 1 0 1 0 0 1 1 1 0 0 1 1 0 1 1 0 1 0 0 0 1 1 1 0 0 1 0 0 1 1 0 0 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 0 0 0 1 0 0 1 0 0 0 0 1 1 0 1 0 0 0 1 0 1 1 0 1 0 1 0 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 1 0 1 0 0 0 1 0 0 1 0 0 1 1 1 1 1 0 1 0 0 1 0 0 1 1 1 1 1 1 0 1 0 0 0 1 1 1 1 1 1 0 0 0 0 1 0 0 0 1 1 0 1 1 1 1 1 0 1 1 0 1 0 1 0 0 1 0 1 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 1 0 0 1 1 1 0 0 1 0 1 1 0 1 1 0 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 0 0 1 0 0 1 0 0 1 0 1 0 0 1 1839513603
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceSetpointWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceSetpointWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1839513603
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceSetpointWarning received =     1
    Should Contain    ${output}    Timestamp : 70.7702
    Should Contain    ${output}    AnyWarning : 0
    Should Contain    ${output}    AnySafetyLimitWarning : 1
    Should Contain    ${output}    SafetyLimitWarning : 0
    Should Contain    ${output}    XMomentWarning : 0
    Should Contain    ${output}    YMomentWarning : 1
    Should Contain    ${output}    ZMomentWarning : 1
    Should Contain    ${output}    AnyNearNeighborWarning : 0
    Should Contain    ${output}    NearNeighborWarning : 0
    Should Contain    ${output}    MagnitudeWarning : 1
    Should Contain    ${output}    AnyFarNeighborWarning : 0
    Should Contain    ${output}    FarNeighborWarning : 0
    Should Contain    ${output}    AnyElevationForceWarning : 1
    Should Contain    ${output}    ElevationForceWarning : 0
    Should Contain    ${output}    AnyAzimuthForceWarning : 1
    Should Contain    ${output}    AzimuthForceWarning : 0
    Should Contain    ${output}    AnyThermalForceWarning : 1
    Should Contain    ${output}    ThermalForceWarning : 0
    Should Contain    ${output}    AnyBalanceForceWarning : 0
    Should Contain    ${output}    BalanceForceWarning : 1
    Should Contain    ${output}    AnyAccelerationForceWarning : 1
    Should Contain    ${output}    AccelerationForceWarning : 0
    Should Contain    ${output}    ActiveOpticNetForceWarning : 1
    Should Contain    ${output}    AnyActiveOpticForceWarning : 1
    Should Contain    ${output}    ActiveOpticForceWarning : 0
    Should Contain    ${output}    AnyStaticForceWarning : 0
    Should Contain    ${output}    StaticForceWarning : 0
    Should Contain    ${output}    AberrationNetForceWarning : 1
    Should Contain    ${output}    AnyAberrationForceWarning : 1
    Should Contain    ${output}    AberrationForceWarning : 1
    Should Contain    ${output}    AnyOffsetForceWarning : 1
    Should Contain    ${output}    OffsetForceWarning : 0
    Should Contain    ${output}    AnyVelocityForceWarning : 0
    Should Contain    ${output}    VelocityForceWarning : 0
    Should Contain    ${output}    AnyForceWarning : 1
    Should Contain    ${output}    ForceWarning : 0
    Should Contain    ${output}    priority : 1
