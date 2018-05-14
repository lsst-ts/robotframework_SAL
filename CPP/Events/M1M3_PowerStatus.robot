*** Settings ***
Documentation    M1M3_PowerStatus sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    PowerStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 58.2136 0 0 0 0 0 1 0 0 0 1 0 0 0 1 0 0 -873451707
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PowerStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PowerStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -873451707
    Log    ${output}
    Should Contain X Times    ${output}    === Event PowerStatus received =     1
    Should Contain    ${output}    Timestamp : 58.2136
    Should Contain    ${output}    PowerNetworkACommandedOn : 0
    Should Contain    ${output}    PowerNetworkAOutputOn : 0
    Should Contain    ${output}    PowerNetworkBCommandedOn : 0
    Should Contain    ${output}    PowerNetworkBOutputOn : 0
    Should Contain    ${output}    PowerNetworkCCommandedOn : 0
    Should Contain    ${output}    PowerNetworkCOutputOn : 1
    Should Contain    ${output}    PowerNetworkDCommandedOn : 0
    Should Contain    ${output}    PowerNetworkDOutputOn : 0
    Should Contain    ${output}    AuxPowerNetworkACommandedOn : 0
    Should Contain    ${output}    AuxPowerNetworkAOutputOn : 1
    Should Contain    ${output}    AuxPowerNetworkBCommandedOn : 0
    Should Contain    ${output}    AuxPowerNetworkBOutputOn : 0
    Should Contain    ${output}    AuxPowerNetworkCCommandedOn : 0
    Should Contain    ${output}    AuxPowerNetworkCOutputOn : 1
    Should Contain    ${output}    AuxPowerNetworkDCommandedOn : 0
    Should Contain    ${output}    AuxPowerNetworkDOutputOn : 0
    Should Contain    ${output}    priority : -873451707
