*** Settings ***
Documentation    M1M3_ForceActuatorSafetyChecks sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceActuatorSafetyChecks
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 82.9576 0 0 0 0 1 1 1 0 0 0 0 1 0 0 1 0 0 0 1 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 1 1 1 0 1 0 1 1 1 0 1 1 0 1 1 0 1 0 0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 1 1 0 1 1 0 1 1 0 1 0 0 0 0 1 0 0 0 0 1 0 1 1 0 0 0 0 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 1 1 1 0 1 0 1 0 1 0 1 0 1 1 0 1 1 1 1 1 0 1 0 1 1 1 1 0 0 1 0 1 1 0 1 0 1 1 0 0 1 0 0 1 0 0 0 0 1 1 1 0 0 0 0 1 0 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 1 1 0 0 1 0 0 1 1 1 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 1 1 0 0 0 0 1 1 0 1 1 0 1 1 1 1 0 0 0 1 0 1 0 0 1 0 1 1 1 1 1 1 0 1 0 0 0 1 0 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 0 1 0 1 0 0 0 0 0 1 1 0 1 1 0 1 1 1 0 1 0 1 0 1 0 0 1 0 0 0 0 0 1 1 1 0 1 0 1 0 0 1 1 0 0 1 1 1 0 1 1 0 0 0 1 1 1 0 1 0 1 1 1 1 1 1 1 1 0 1 0 1 0 1 1 0 1 0 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 1 1 0 1 0 0 0 0 1 0 1 0 0 1 1 0 0 0 0 0 1 1 1 0 0 1 1 1 1 1 0 0 1 0 0 1 0 1 0 1 0 1 0 0 1 0 1 1 0 0 1 0 0 1 1 0 1 1 0 1 0 1 1 0 1 1 1 1 0 0 0 0 1 0 1 1 0 1 1 1 1 1 1 0 1 0 0 1 0 0 1 1 0 1 1 1 1 1 0 0 1 1 1 1 0 1 0 1 0 1 1 0 1 0 0 1 1 0 0 0 1 0 0 0 0 1 1 1 1 0 0 0 1 0 0 1 0 1 1 0 0 1 1 1 0 1 0 1 1 1 1 1 1 0 1 1 1 1 0 0 0 1 1 0 1 0 0 0 1 1 0 0 1 0 0 0 1 0 1 0 0 0 0 0 0 1 1 0 1 1 0 0 1 1 0 1 1 0 1 0 1 0 1 1 1 1 1 1 1 0 1 0 1 1 0 0 0 0 1 1 0 1 0 1 0 0 0 0 1 1 1 1 0 1 0 0 1 1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1 1 1 1 1 1 0 1 0 0 0 1 1 0 1 0 1 1 1 0 1 1 0 1 1 0 0 0 1 1 0 1 1 0 1 1 1 1 1 0 1 1 0 1 1 1 1 1 0 0 0 1 1 0 0 0 1 0 1 0 0 0 0 1 1 1 0 1 0 1 0 1 0 0 1 0 1 1 0 0 0 1 1 1 1 0 1 0 1 1 1 1 0 0 1 1 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 1 1 0 0 1 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 1 1 0 0 0 1 1 1 1 0 0 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 1 1 0 0 1 1 0 1 0 0 0 0 0 0 1 1 0 1 0 0 0 1 0 1 0 0 1 0 1 1 0 1 1 1 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 1 1 0 1 0 0 1 1 0 1 0 0 1 1 0 1 1 1 0 1 0 0 1 0 0 0 1 1 0 1 1 0 0 0 0 0 1 1 1 0 0 1 0 0 1 1 1 1 0 1 0 0 1 1 1 0 0 1 1 1 0 1 0 0 1 0 1 0 0 1 0 1 1 0 0 1 0 1 0 0 1 1 1 0 0 1 1 1 0 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0 0 0 0 1 0 1 0 0 0 0 1 0 1 1 0 0 0 1 1 1 0 0 0 1 0 1 1 0 0 1 0 1 1 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 1 1 1 1 0 0 0 1 0 0 1 0 0 0 0 0 1 1 1 1 0 1 0 1 1 1 1 0 0 0 1 0 0 0 1 0 1 1 1 0 1 0 0 1 0 1 0 1 0 0 0 1 1 0 1 1 1 1 0 1 0 0 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 0 1 0 1 0 0 1 0 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 1 1 1 1 1 1 0 0 0 0 1 0 1 0 0 0 0 1 0 0 0 1 1 0 0 1 1 0 1 1 0 0 1 1 0 1 1 0 1 1 0 0 1 1 0 1 1 1 0 1 1 1 0 1 1 0 1 1 1 0 0 1 1 0 1 0 0 0 1 0 1 1 0 1 0 0 1 0 0 0 1 0 0 0 1 1 1 1 1 0 1 1 1 0 1 0 0 1 0 1 1 1 1 0 1 1 0 1 1 1 0 1 0 0 0 0 1 1 1 1 1 0 1 1 0 1 1 1 0 1 1 0 1 1 1 0 1 0 1 1 1 0 1 0 0 0 0 1 1 1 1 1 1 1 0 0 1 0 0 0 0 1 0 0 1 1 1 0 1 1 1 1 0 0 0 0 0 1 1 0 1 1 0 0 0 1 1 0 1 1 0 1 0 1 0 1 1 1 0 1 0 1 1 0 0 1 0 1 1 0 0 0 0 1 0 1 1 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 1 1 1 1 0 0 1 0 1 1 1 1 1 0 0 1 1 0 1 0 0 1 0 1 1 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 0 0 0 1 1 0 0 1 1 1 0 1 1 -1719619306
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorSafetyChecks writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorSafetyChecks generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1719619306
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorSafetyChecks received =     1
    Should Contain    ${output}    Timestamp : 82.9576
    Should Contain    ${output}    AllInSafetyLimit : 0
    Should Contain    ${output}    SafetyLimitOk : 0
    Should Contain    ${output}    MirrorWeightOk : 0
    Should Contain    ${output}    XMomentOk : 0
    Should Contain    ${output}    YMomentOk : 1
    Should Contain    ${output}    AllNeighborsOk : 1
    Should Contain    ${output}    NeighborsOk : 1
    Should Contain    ${output}    MagnitudeOK : 0
    Should Contain    ${output}    AllGlobalBendingOk : 0
    Should Contain    ${output}    GlobalBendingOk : 0
    Should Contain    ${output}    FollowingErrorOk : 0
    Should Contain    ${output}    AxialFollowingErrorOk : 1
    Should Contain    ${output}    LateralFollowingErrorOk : 0
    Should Contain    ${output}    AOSNetForceOk : 0
    Should Contain    ${output}    AllElevationForcesOk : 1
    Should Contain    ${output}    ElevationForcesOk : 0
    Should Contain    ${output}    AllAzimuthForcesOk : 0
    Should Contain    ${output}    AzimuthForcesOk : 0
    Should Contain    ${output}    AllThermalForcesOk : 1
    Should Contain    ${output}    ThermalForcesOk : 1
    Should Contain    ${output}    AllAOSForcesOk : 1
    Should Contain    ${output}    AOSForcesOk : 1
    Should Contain    ${output}    priority : 1
