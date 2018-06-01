*** Settings ***
Documentation    M1M3_PowerWarning communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    PowerWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 79.0288 1 1 1 0 0 1 1 0 1 -1675386135
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PowerWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PowerWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1675386135
    Log    ${output}
    Should Contain X Times    ${output}    === Event PowerWarning received =     1
    Should Contain    ${output}    Timestamp : 79.0288
    Should Contain    ${output}    AnyWarning : 1
    Should Contain    ${output}    PowerNetworkAOutputMismatch : 1
    Should Contain    ${output}    PowerNetworkBOutputMismatch : 1
    Should Contain    ${output}    PowerNetworkCOutputMismatch : 0
    Should Contain    ${output}    PowerNetworkDOutputMismatch : 0
    Should Contain    ${output}    AuxPowerNetworkAOutputMismatch : 1
    Should Contain    ${output}    AuxPowerNetworkBOutputMismatch : 1
    Should Contain    ${output}    AuxPowerNetworkCOutputMismatch : 0
    Should Contain    ${output}    AuxPowerNetworkDOutputMismatch : 1
    Should Contain    ${output}    priority : -1675386135
