*** Settings ***
Documentation    M1M3_PowerSupplyStatus sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    PowerSupplyStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 56.3407 1 1 1 1 1 0 0 0 1 0 1 0 1 1 0 1 1 1 0 1 0 1 0 -1413643993
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PowerSupplyStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PowerSupplyStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1413643993
    Log    ${output}
    Should Contain X Times    ${output}    === Event PowerSupplyStatus received =     1
    Should Contain    ${output}    Timestamp : 56.3407
    Should Contain    ${output}    RCPMirrorCellUtility220VAC1Status : 1
    Should Contain    ${output}    RCPCabinetUtility220VACStatus : 1
    Should Contain    ${output}    RCPExternalEquipment220VACStatus : 1
    Should Contain    ${output}    RCPMirrorCellUtility220VAC2Status : 1
    Should Contain    ${output}    RCPMirrorCellUtility220VAC3Status : 1
    Should Contain    ${output}    PowerNetworkARedundancyControlStatus : 0
    Should Contain    ${output}    PowerNetworkBRedundancyControlStatus : 0
    Should Contain    ${output}    PowerNetworkCRedundancyControlStatus : 0
    Should Contain    ${output}    PowerNetworkDRedundancyControlStatus : 1
    Should Contain    ${output}    ControlsPowerNetworkRedundancyControlStatus : 0
    Should Contain    ${output}    PowerNetworkAStatus : 1
    Should Contain    ${output}    PowerNetworkARedundantStatus : 0
    Should Contain    ${output}    PowerNetworkBStatus : 1
    Should Contain    ${output}    PowerNetworkBRedundantStatus : 1
    Should Contain    ${output}    PowerNetworkCStatus : 0
    Should Contain    ${output}    PowerNetworkCRedundantStatus : 1
    Should Contain    ${output}    PowerNetworkDStatus : 1
    Should Contain    ${output}    PowerNetworkDRedundantStatus : 1
    Should Contain    ${output}    ControlsPowerNetworkStatus : 0
    Should Contain    ${output}    ControlsPowerNetworkRedundantStatus : 1
    Should Contain    ${output}    LightPowerNetworkStatus : 0
    Should Contain    ${output}    ExternalEquipmentPowerNetworkStatus : 1
    Should Contain    ${output}    LaserTrackerPowerNetworkStatus : 0
    Should Contain    ${output}    priority : -1413643993
