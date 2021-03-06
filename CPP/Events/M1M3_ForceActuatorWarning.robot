*** Settings ***
Documentation    M1M3_ForceActuatorWarning communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceActuatorWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 2.6301 0 0 1 1 0 0 1 0 0 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 1 0 1 0 1 0 1 1 0 0 1 0 0 1 1 1 0 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 0 1 0 0 1 1 1 0 1 1 1 1 1 1 1 1 0 1 0 0 1 1 1 1 0 1 0 1 1 0 0 1 0 0 0 0 0 0 0 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 0 1 0 0 0 0 1 0 0 0 1 1 0 1 0 1 1 0 0 1 0 1 1 1 1 0 1 1 1 1 0 0 0 0 0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 0 0 1 0 0 1 0 0 1 1 0 1 1 0 0 0 0 0 0 0 0 1 0 1 1 1 1 0 0 1 0 1 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 0 0 1 1 0 1 0 0 0 0 1 0 1 1 1 0 1 0 1 0 1 0 0 1 1 1 1 1 0 1 1 1 0 0 1 1 0 0 1 1 1 0 1 1 1 0 0 0 1 0 0 1 0 0 1 1 1 1 0 0 1 0 1 0 1 1 1 0 0 0 1 1 0 0 1 0 1 0 0 1 1 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 0 1 0 0 1 1 1 1 0 0 0 1 1 1 1 0 1 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 1 1 1 1 1 1 0 1 1 0 1 0 1 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 1 1 1 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 0 1 0 1 0 1 0 0 0 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 0 1 0 0 1 0 1 1 1 0 0 0 1 0 0 0 1 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 0 1 0 1 0 1 1 0 1 0 1 1 0 0 0 0 0 0 1 0 0 0 0 1 1 0 0 1 0 1 0 0 0 1 1 0 0 0 1 1 0 1 0 1 1 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 1 0 1 1 0 1 1 1 1 1 1 0 0 1 1 1 0 0 0 0 0 1 1 0 0 0 1 0 0 1 1 0 0 0 0 1 1 1 1 1 0 1 0 0 0 1 1 0 1 0 0 1 0 1 1 1 1 1 0 0 0 1 0 1 1 0 0 0 1 1 1 0 0 0 0 1 1 0 0 1 1 0 1 1 0 1 0 0 1 1 1 0 0 0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 1 1 1 0 0 1 0 1 1 0 0 0 0 0 0 1 0 0 1 1 0 0 1 1 1 1 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 1 1 1 1 0 0 1 0 1 1 1 1 1 1 1 1 0 1 0 1 1 0 1 1 1 0 0 0 1 0 1 0 1 1 0 0 1 0 1 1 1 1 1 1 0 1 1 0 0 1 1 1 1 1 0 0 1 0 0 1 1 0 1 1 1 0 1 1 1 0 0 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 1 1 0 0 1 1 1 1 1 0 0 0 0 0 1 0 0 1 1 0 1 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 1 0 1 1 1 0 0 0 0 1 0 0 0 0 1 1 1 0 0 1 0 0 0 1 0 1 1 1 1 0 1 0 0 1 0 1 0 0 0 1 0 0 1 0 1 1 0 1 1 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 0 1 0 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 0 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 1 1 0 0 0 1 0 0 0 1 1 1 0 1 0 0 1 1 1 1 1 1 1 0 0 0 1 0 0 1 0 1 1 0 1 1 0 0 0 0 1 1 0 0 1 1 1 0 1 0 1 1 1 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 1 0 0 0 1 0 1 1 1 1 0 1 0 1 1 0 0 1 1 0 0 0 0 0 1 0 0 1 0 0 1 1 0 0 1 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 1 1 1 1 0 0 0 1 1 0 1 1 1 0 1 1 0 0 0 1 1 1 0 0 1 0 1 1 1 0 1 0 0 0 0 0 0 0 1 1 0 0 0 1 1 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 1 0 1 1 1 1 1 1 0 1 0 0 0 1 0 0 1 1 1 1 1 1 1 1 0 1 1 1 0 0 1 1 1 0 0 0 1 0 1 1 0 0 0 0 1 1 0 0 0 0 0 1 1 0 1 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 0 0 0 0 0 0 1 0 1 1 0 1 0 1 1 1 1 0 1 1 1 1 0 1 1 0 0 1 1 1 0 1 1 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 1 1 0 1 1 0 0 1 0 0 1 1 1 0 1 1 1 1 1 1 1 0 1 0 0 1 1 0 0 0 0 0 0 1 1 0 1 1 0 0 1 1 0 0 1 1 1 1 0 1 0 1 1 0 0 0 1 1 1 0 1 1 0 0 0 1 1 1 1 1 1 0 1 1 1 0 1 0 1 1 1 0 0 0 0 1 1 0 0 0 0 0 1 0 1 1 1 1 0 1 1 0 1 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 0 1 1 1 0 0 1 0 1 1 0 0 1 0 0 1 1 1 1 1 1 0 1 1 0 1 0 0 1 0 0 1 1 0 1 0 1 1 0 0 1 0 0 1 0 0 0 1 0 0 0 1 1 0 1 0 1 0 0 1 1 0 1 1 1 1 1 1 1 0 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 0 1 0 0 1 1 0 0 1 1 0 1 0 0 1 0 0 0 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 1 1 0 1 0 1 0 1 0 0 0 1 1 0 1 1 1 1 0 1 1 0 0 0 0 1 0 1 1 0 1 0 0 1 0 1 0 1 0 1 1 0 0 0 0 1 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0 0 0 1 1 0 1 0 0 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 1 1 0 0 0 0 1 0 0 0 0 1 1 1 0 0 1 0 0 0 1 0 0 1 1 1 1 0 0 0 1 1 0 1 0 1 0 0 0 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 1 0 0 1 0 0 0 0 0 1 1 0 0 1 1 1 0 1 1 0 0 1 1 1 1 0 0 1 1 0 0 1 1 0 0 0 0 1 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0 0 1 1 0 1 1 1 1 0 0 1 0 1 0 0 1 1 1 1 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 1 0 1 1 0 1 0 1 0 1 1 0 0 1 0 0 0 0 1 1 1 1 0 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 1 1 1 0 1 1 0 0 1 0 1 1 0 1 0 0 1 0 0 1 0 1 0 1 1 1 1 1 0 0 1 1 0 0 1 0 1 1 1 1 0 0 0 1 1 1 0 0 0 1 0 0 0 1 1 0 1 0 0 1 0 1 0 1 0 0 0 0 0 1 1 0 0 0 0 0 1 0 1 1 1 1 1 0 1 1 0 1 1 1 0 1 1 1 0 1 0 1 1 0 1 1 0 1 0 1 1 1 0 0 1 1 0 0 1 1 1 0 0 0 1 1 0 1 1 0 1 0 0 0 1 0 0 1 1 0 1 1 1 1 1 1 0 1 0 0 1 1 1 1 0 0 1 1 0 0 0 1 0 0 0 0 0 1 1 1 0 1 1 1 1 0 0 1 0 1 0 1 0 1 0 0 1 0 1 0 1 1 1 0 1 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 1 0 0 1 0 1 0 0 1 0 1 1 1 0 1 0 1 1 0 1 1 1 1 1 1 0 0 1 0 1 1 1 0 1 1 1 0 0 1 1 1 0 1 1 0 1 0 1 1 1 0 1 0 1 0 0 0 1 1 0 1 0 1 0 0 1 1 0 1 1 0 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0 1 0 1 0 0 0 0 0 0 1 0 0 1 0 0 1 0 1 1 0 1 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 1 0 1 1 0 1 0 1 0 1 0 1 1 0 1 1 1 0 0 1 0 1 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0 0 0 0 1 1 0 0 0 1 1 1 0 1 1 0 0 0 1 0 1 0 1 1 1 1 0 0 1 0 0 0 1 1 1 1 0 0 1 1 1 1 1 1 0 1 0 1 1 0 0 0 1 0 0 1 1 1 1 0 1 0 0 0 1 0 1 1 1 1 0 0 1 0 0 0 0 1 1 0 0 0 1 1 0 1 1 0 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 1 0 1 1 0 0 0 0 1 1 0 1 1 0 0 1 1 0 0 1 0 0 1 0 0 0 0 0 0 0 1 1 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 0 0 0 0 1 1 1 0 0 1 1 0 1 0 0 0 0 1 0 0 0 0 1 1 0 1 1 0 1 1 0 0 0 1 0 0 1 0 1 1 0 0 0 0 0 1 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 1 0 0 0 0 0 0 1 0 0 0 1 0 0 1 1 1 1 0 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0 0 1 0 1 1 0 1 1 1 1 1 1 1 0 1 1 1 0 1 0 1 1 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 1 1 0 0 1 0 0 0 1 1 1 1 0 0 0 0 0 0 1 0 0 1 0 1 0 1 1 1 0 1 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 1 1 0 1 0 0 1 0 1 1 0 0 0 0 0 0 0 0 1 0 1 1 0 0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 1 1 0 1 1 1 0 1 0 0 1 0 0 1 1 1 1 1 1 0 1 1 0 0 1 0 0 0 0 1 0 0 0 0 0 1 0 1 1 0 0 0 1 0 1 1 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1 1 0 1 0 0 0 1 0 0 0 1 0 1 0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 0 1 0 0 1 1 1 1 0 0 1 1 0 1 1 1 0 0 0 0 1 1 0 1 0 0 1 1 0 0 1 0 1 0 0 0 0 0 1 0 0 1 1 1 1 1 1 0 1 1 1 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 1 1 1 1 1 1 0 1 0 0 1 0 1 0 0 1 0 0 0 1 1 0 0 1 1 0 0 1 0 0 1 0 1 1 0 1 0 1 0 1 1 1 0 0 1 1 1 0 0 1 0 1 0 1 0 0 1 1 0 0 0 1 1 1 0 1 0 0 1 0 1 1 1 1 1 1 0 1 0 1 1 0 1 0 1 0 1 0 0 0 0 1 1 1 1 0 1 0 0 0 0 0 1 0 1 0 0 0 1 1 0 1 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 1 1 1 1 1 0 1 1 1 0 0 1 0 1 1 1 1 1 1 0 0 1 0 0 1 1 1 1 0 0 1 1 0 1 0 0 1 1 0 0 1 0 0 1 0 1 1 0 0 0 1 0 0 1 0 1 0 1 0 0 0 1 1 1 0 1 1 1 1 1 1 0 1 1 1 0 0 1 1 1 0 1 1 0 0 0 0 0 1 1 0 0 1 1 1 1 1 0 1 0 0 0 1 1 0 0 1 1 0 0 1 0 1 0 0 0 1 1 0 0 0 1 1 1 0 0 0 0 0 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 0 1 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 1 0 1 1 1 0 1 0 1 0 0 1 1 1 1 1 0 0 1 0 0 0 1 1 1 1 0 0 0 1 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 1 0 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 1 0 1 1 0 1 0 0 0 1 0 0 0 0 0 1 0 1 1 1 1 0 0 0 0 0 0 1 0 0 0 0 1 1 1 0 1 0 1 0 1 1 0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1 1 0 0 0 1 1 0 1 0 1 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 1 1 1 1 0 0 1 0 0 1 1 1 0 0 1 1 0 0 1 0 1 0 0 0 1 1 1 1 0 0 0 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1 0 0 0 0 0 1 0 0 1 1 0 0 1 1 1 1 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 1 0 1 0 1 0 1 1 1 0 0 0 1 0 1 0 1 0 0 1 0 0 1 0 0 0 1 0 1 1 0 1 1 0 0 1 0 1 0 1 0 1 1 0 1 1 1 0 0 0 0 0 1 0 1 1 0 0 1 1 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 1 0 0 1 0 0 0 1 1 0 1 0 0 1 1 1 1 0 1 0 0 0 0 1 0 1 1 0 1 1 0 1 0 1 0 0 0 1 1 0 0 0 0 1 0 1 1 1 0 1 0 0 0 0 0 0 1 1 1 1 0 0 0 1 0 1 0 0 0 0 1 0 1 0 0 0 1 0 0 1 0 0 1 1 1 0 0 1 0 1 1 0 0 1 1 0 1 0 0 0 1 1 0 0 1 0 1 1 1 1 1 1 0 0 1 1 0 1 1 1 0 0 0 0 1 0 0 1 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 0 0 0 1 0 1 0 1 0 0 1 0 1 0 1 0 0 1 1 1 0 0 1 1 1 0 0 0 1 1 1 0 0 1 0 0 0 0 1 1 0 1 0 1 1 0 1 1 0 0 1 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 0 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 0 1 1 0 0 0 1 1 1 1 0 1 1 0 0 1 1 0 0 1 1 1 0 1 0 0 0 0 0 0 0 1 0 1 1 0 1 1 0 1 1 0 0 1 1 1 1 0 0 1 0 0 0 1 1 1 0 1 1 0 0 0 0 1 0 0 1 0 1 0 1 1 1 0 0 1 1 1 0 1 1 1 1 0 1 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 1 0 0 1 1 1 0 0 0 0 0 1 0 0 0 1 0 0 0 0 1 1 1 0 1 0 1 1 1 0 0 1 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 0 1 1 0 0 1 1 1 1 1 0 0 0 1 1 1 0 1 0 1 0 1 1 0 0 0 0 1 0 0 0 1 1 1 1 1 1 1 0 0 1 0 1 1 1 0 1 0 1 1 0 1 1 0 1 0 0 0 0 1 0 1 0 1 1 1 1 0 1 1 0 0 1 1 1 1 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 1 0 1 0 0 1 1 1 0 0 1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 1 1 0 1 0 0 0 1 0 1 0 0 1 1 1 0 0 1 1 0 0 1 1 1 1 1 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 1 0 1 1 1 1 1 1 0 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 1 0 1 1 0 1 0 1 0 1 1 0 1 1 1 1 0 0 1 0 1 1 1 0 1 1 0 0 1 0 1 0 1 0 0 1 0 1 0 1 1 0 0 1 0 1 1 1 1 1 1 1 0 1 1 0 0 1 0 0 1 1 0 0 0 0 0 0 1 0 0 1 1 0 0 1 1 1 1 0 1 1 1 1 1 0 0 1 1 1 0 0 1 0 1 1 0 1 1 1 1 1 0 0 1 0 0 1 0 1 0 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 1 0 0 1 0 0 1 0 0 1 1 1 0 0 0 1 1 1 1 0 0 1 1 1 1 0 1 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 1 1 0 0 1 1 0 1 1 0 0 1 0 1 0 0 1 1 1 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 0 1 0 1 0 0 1 1 1 1 0 1 0 0 1 1 1 0 0 1 1 0 0 1 0 0 1 1 1 1 0 0 1 0 0 1 0 1 0 0 1 1 0 0 1 1 0 0 0 0 0 1 0 1 0 0 0 1 0 0 1 0 0 0 1 0 0 1 1 0 0 1 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 1 1 0 0 0 0 1 0 0 1 0 1 1 1 0 0 0 0 1 1 0 0 0 1 0 0 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 1 1 0 1 0 1 1 1 1 0 0 0 0 1 1 0 0 1 1 1 0 1 1 1 0 0 0 1 0 1 1 1 0 1 0 1 1 0 1 1 0 1 1 1 0 1 0 1 1 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 1 1 0 1 0 1 1 1 0 0 0 1 0 1 1 1 0 1 1 0 0 0 0 0 0 0 1 1 1 0 0 1 0 1 0 1 1 0 0 1 0 0 0 1 1 1 1 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 0 1 0 0 1 1 0 0 1 1 1 0 1 1 0 0 1 1 0 0 1 0 0 1 1 0 1 1 0 1 0 0 0 0 1 0 1 0 1 1 0 1 0 0 0 1 1 0 1 1 1 0 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 1 0 1 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 1 0 1 1 1 1 0 0 1 0 0 0 1 1 1 0 1 0 1 1 0 1 0 1 0 1 0 1 1 0 1 1 1 0 0 1 0 0 0 1 1 1 1 0 1 0 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 0 0 0 0 0 0 1 1 0 0 1 0 1 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0 1 0 1 0 0 1 0 0 1 0 1 1 0 1 1 0 1 1 0 0 0 0 1 1 1 0 0 1 0 1 0 0 1 1 1 0 0 1 0 0 0 0 1 1 297742752
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 297742752
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorWarning received =     1
    Should Contain    ${output}    Timestamp : 2.6301
    Should Contain    ${output}    AnyWarning : 0
    Should Contain    ${output}    AnyMajorFault : 0
    Should Contain    ${output}    MajorFault : 1
    Should Contain    ${output}    AnyMinorFault : 1
    Should Contain    ${output}    MinorFault : 0
    Should Contain    ${output}    AnyFaultOverride : 0
    Should Contain    ${output}    FaultOverride : 1
    Should Contain    ${output}    AnyMainCalibrationError : 0
    Should Contain    ${output}    MainCalibrationError : 0
    Should Contain    ${output}    AnyBackupCalibrationError : 0
    Should Contain    ${output}    BackupCalibrationError : 0
    Should Contain    ${output}    AnyMezzanineError : 1
    Should Contain    ${output}    MezzanineError : 0
    Should Contain    ${output}    AnyMezzanineBootloaderActive : 1
    Should Contain    ${output}    MezzanineBootloaderActive : 0
    Should Contain    ${output}    AnyUniqueIdCRCError : 1
    Should Contain    ${output}    UniqueIdCRCError : 1
    Should Contain    ${output}    AnyApplicationTypeMismatch : 1
    Should Contain    ${output}    ApplicationTypeMismatch : 0
    Should Contain    ${output}    AnyApplicationMissing : 0
    Should Contain    ${output}    ApplicationMissing : 1
    Should Contain    ${output}    AnyApplicationCRCMismatch : 1
    Should Contain    ${output}    ApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyOneWireMissing : 0
    Should Contain    ${output}    OneWireMissing : 0
    Should Contain    ${output}    AnyOneWire1Mismatch : 0
    Should Contain    ${output}    OneWire1Mismatch : 0
    Should Contain    ${output}    AnyOneWire2Mismatch : 1
    Should Contain    ${output}    OneWire2Mismatch : 1
    Should Contain    ${output}    AnyWatchdogReset : 1
    Should Contain    ${output}    WatchdogReset : 0
    Should Contain    ${output}    AnyBrownOut : 1
    Should Contain    ${output}    BrownOut : 0
    Should Contain    ${output}    AnyEventTrapReset : 0
    Should Contain    ${output}    EventTrapReset : 0
    Should Contain    ${output}    AnySSRPowerFault : 0
    Should Contain    ${output}    SSRPowerFault : 1
    Should Contain    ${output}    AnyAuxPowerFault : 1
    Should Contain    ${output}    AuxPowerFault : 1
    Should Contain    ${output}    AnyMezzaninePowerFault : 0
    Should Contain    ${output}    MezzaninePowerFault : 1
    Should Contain    ${output}    AnyMezzanineCurrentAmp1Fault : 0
    Should Contain    ${output}    MezzanineCurrentAmp1Fault : 1
    Should Contain    ${output}    AnyMezzanineCurrentAmp2Fault : 0
    Should Contain    ${output}    MezzanineCurrentAmp2Fault : 1
    Should Contain    ${output}    AnyMezzanineUniqueIdCRCError : 0
    Should Contain    ${output}    MezzanineUniqueIdCRCError : 1
    Should Contain    ${output}    AnyMezzanineMainCalibrationError : 1
    Should Contain    ${output}    MezzanineMainCalibrationError : 0
    Should Contain    ${output}    AnyMezzanineBackupCalibrationError : 0
    Should Contain    ${output}    MezzanineBackupCalibrationError : 1
    Should Contain    ${output}    AnyMezzanineEventTrapReset : 0
    Should Contain    ${output}    MezzanineEventTrapReset : 0
    Should Contain    ${output}    AnyMezzanineApplicationMissing : 1
    Should Contain    ${output}    MezzanineApplicationMissing : 1
    Should Contain    ${output}    AnyMezzanineApplicationCRCMismatch : 1
    Should Contain    ${output}    MezzanineApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyILCFault : 1
    Should Contain    ${output}    ILCFault : 1
    Should Contain    ${output}    AnyBroadcastCounterWarning : 1
    Should Contain    ${output}    BroadcastCounterWarning : 1
    Should Contain    ${output}    priority : 0
