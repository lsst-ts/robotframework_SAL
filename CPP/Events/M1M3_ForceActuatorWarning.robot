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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 92.3288 0 0 1 1 0 0 1 1 1 0 1 0 1 1 1 0 0 0 1 1 1 0 1 1 1 0 1 1 1 0 0 0 1 0 0 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 0 0 1 1 1 0 0 1 1 0 1 1 1 1 0 1 0 0 0 0 0 1 1 1 1 0 0 0 1 1 0 0 0 0 1 0 0 0 1 1 1 1 1 1 0 0 1 1 0 0 0 0 0 0 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 0 0 0 1 0 1 1 1 0 0 0 1 1 1 0 0 1 0 1 1 1 1 0 0 0 1 0 0 0 1 0 1 0 0 0 0 1 0 0 0 1 0 1 1 1 1 0 1 1 0 0 1 1 0 0 0 1 1 0 0 0 0 1 0 1 1 1 1 1 0 1 0 1 0 0 1 1 0 0 1 0 0 1 0 1 0 1 0 0 1 0 1 0 0 1 1 1 1 0 1 1 1 0 1 1 0 0 0 1 1 0 1 1 0 1 0 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 0 0 1 1 0 1 1 0 0 0 1 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 1 0 0 1 0 1 1 1 1 1 0 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 1 0 0 0 0 1 0 0 0 0 1 1 1 1 1 0 0 1 0 0 1 0 0 1 1 0 0 0 1 0 1 0 0 0 0 1 1 1 1 0 1 0 0 0 1 1 0 1 1 0 1 1 1 1 0 1 0 0 1 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 1 1 1 1 1 0 1 0 0 1 1 0 1 0 1 1 1 0 1 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 0 1 1 0 0 0 1 0 1 1 1 0 0 0 0 1 1 0 0 1 0 1 0 1 0 1 0 1 0 0 1 0 0 0 0 0 1 1 0 1 1 0 1 1 0 0 1 0 1 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1 1 0 1 1 0 0 1 0 1 1 0 1 1 1 1 1 1 1 0 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 0 0 1 0 1 0 0 1 1 1 1 0 1 0 0 1 0 1 0 0 1 0 0 1 1 1 0 1 1 0 1 1 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 0 1 1 0 1 1 0 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 1 0 0 1 0 0 0 0 0 1 1 1 0 1 0 1 0 0 1 0 0 0 0 0 1 0 1 1 1 0 0 1 1 1 1 1 1 0 0 1 1 1 0 1 0 1 1 0 1 0 0 0 1 0 1 0 1 0 0 0 0 0 0 1 0 0 0 1 0 1 1 1 1 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 1 1 0 0 1 0 1 0 0 1 0 0 0 1 0 0 1 1 0 0 0 0 1 0 0 1 0 1 1 1 1 0 1 1 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 1 0 0 0 1 1 1 0 1 1 0 1 0 1 1 0 0 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 1 1 1 0 1 1 0 1 0 0 0 1 1 0 1 1 1 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 0 0 1 0 1 1 1 1 1 0 0 1 1 1 1 0 0 0 1 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 1 1 1 0 1 1 1 0 0 0 1 1 1 1 1 0 0 1 1 1 0 0 1 0 0 0 0 0 1 0 1 0 0 0 1 0 1 1 1 0 1 0 1 0 0 1 1 0 1 1 0 1 0 1 0 1 0 1 1 0 0 0 1 1 0 0 1 1 1 0 1 0 0 0 0 1 0 1 1 1 1 0 1 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0 1 0 1 0 1 1 0 0 0 1 0 0 1 0 0 1 0 1 1 0 0 1 1 1 0 1 1 1 1 1 0 1 1 0 1 0 1 1 1 1 0 0 1 0 1 1 1 0 1 1 1 0 0 1 0 1 1 0 0 0 0 0 0 0 0 1 1 1 1 0 0 1 1 1 1 1 1 0 1 1 1 1 0 0 1 1 0 0 1 0 0 1 0 1 0 0 1 1 0 1 0 0 0 1 1 0 1 0 0 1 0 1 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 1 1 0 1 1 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 1 1 1 1 0 0 0 1 0 0 0 1 1 1 0 0 1 0 1 1 1 0 0 1 0 1 1 1 1 1 0 0 0 0 1 0 1 1 1 0 1 1 0 0 1 0 0 0 1 0 1 0 0 0 0 1 0 0 0 1 0 1 1 1 0 0 1 0 1 1 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 1 1 1 0 1 1 1 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 1 1 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 1 0 0 1 1 0 1 1 1 1 0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 1 1 1 1 0 0 0 0 1 1 0 1 0 0 1 0 0 0 1 1 1 1 0 1 1 1 0 1 0 1 1 0 0 0 0 1 1 0 0 0 0 1 0 1 1 0 0 0 1 1 1 1 0 1 1 0 1 0 0 1 1 1 1 1 0 0 0 1 0 1 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 1 1 0 1 1 1 1 1 0 0 0 0 1 0 1 0 0 0 0 1 1 0 1 0 1 0 1 1 0 1 1 0 1 0 0 1 0 1 0 0 0 0 1 0 1 1 1 0 1 0 0 0 1 0 1 0 1 0 0 1 0 0 0 0 1 0 0 1 1 1 0 0 1 1 0 1 0 1 1 1 1 1 0 0 1 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 0 1 0 0 0 1 0 1 0 1 0 1 0 0 1 0 0 1 1 1 0 1 0 1 0 1 1 0 1 1 0 1 1 0 1 0 1 0 1 0 1 0 0 0 0 0 1 1 1 0 1 1 0 1 0 1 1 1 1 0 1 1 1 0 1 0 1 0 1 1 0 0 0 0 1 1 1 0 1 0 0 0 0 1 0 1 0 1 1 0 1 0 0 1 1 1 1 0 0 1 0 0 1 1 0 1 0 0 0 0 0 1 0 0 0 0 0 1 1 0 1 0 1 1 1 1 0 0 0 1 1 0 1 0 0 0 1 0 1 1 0 0 0 0 1 1 0 0 0 1 1 0 1 0 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 0 0 1 0 1 1 0 1 0 1 1 0 0 1 1 1 1 1 1 0 0 1 1 1 1 1 0 1 1 1 1 1 0 1 0 1 1 0 0 1 1 1 1 0 1 0 1 0 0 1 1 0 0 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 0 0 1 0 0 0 0 0 1 1 1 0 0 1 1 0 1 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 1 0 0 0 0 0 0 0 1 0 0 1 0 1 1 1 0 1 0 0 0 1 0 1 1 1 1 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 1 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 1 1 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 1 0 0 0 1 1 1 0 0 1 0 0 1 0 0 1 1 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 0 1 0 0 1 1 1 1 1 1 0 0 1 1 1 1 1 1 0 0 1 1 0 1 0 1 1 1 0 1 1 1 1 1 0 0 0 1 0 1 1 0 0 1 1 0 0 1 1 0 1 0 1 0 1 0 0 0 0 0 0 0 1 0 1 0 1 1 0 0 0 1 0 0 1 1 0 1 1 0 0 1 0 1 0 0 1 1 1 0 1 1 1 0 1 0 1 0 1 1 0 1 0 0 1 1 0 1 1 0 0 0 0 0 1 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 1 1 0 1 0 1 0 1 1 0 1 1 0 1 0 1 0 0 1 0 1 0 1 1 1 0 1 0 1 0 0 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 0 0 0 1 1 0 0 0 1 0 1 0 0 1 1 1 1 1 0 1 1 1 0 0 0 1 0 1 1 0 0 1 0 1 1 0 1 0 0 0 0 0 0 0 0 0 1 0 1 1 1 1 0 0 0 1 1 1 0 1 1 0 1 1 1 0 1 1 0 0 0 1 1 1 0 0 1 0 0 0 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 1 1 1 1 0 1 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 0 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 0 1 1 1 0 1 0 0 1 1 0 1 1 1 0 1 0 0 1 1 0 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 1 1 0 0 1 0 1 1 1 1 0 0 1 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 1 1 1 1 0 0 1 1 0 0 1 1 1 0 0 1 0 1 1 1 1 1 0 0 0 1 0 1 1 1 0 0 0 1 0 1 0 0 1 0 1 0 0 0 0 1 1 1 0 0 1 1 0 0 0 1 0 0 1 0 0 1 0 1 1 1 0 1 1 0 1 1 1 1 0 0 0 1 0 0 1 1 1 1 0 0 0 0 1 1 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 1 1 1 0 0 0 0 0 1 0 0 1 0 0 0 1 1 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 0 0 1 1 1 1 1 0 0 1 0 1 1 0 1 1 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 1 1 1 1 0 1 0 0 0 1 0 1 0 0 0 0 1 1 0 0 0 1 1 0 0 1 1 0 1 0 1 1 0 1 0 0 0 1 1 1 1 0 1 0 0 0 0 1 1 1 0 1 1 0 1 1 1 0 1 0 1 1 0 0 1 0 1 0 0 0 1 1 0 0 1 1 0 0 1 1 1 1 1 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 0 1 0 0 1 1 1 0 1 0 1 1 0 0 0 1 0 0 1 1 1 1 1 1 0 1 1 1 1 0 1 1 0 1 0 0 1 0 1 0 1 0 0 1 0 1 1 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 0 0 1 1 0 1 0 0 1 0 1 0 1 1 1 0 0 1 0 0 1 0 0 1 1 0 0 0 0 0 0 0 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0 0 1 0 0 0 1 1 0 0 1 0 1 1 0 1 1 0 0 0 0 1 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 0 0 0 1 0 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 0 1 0 0 0 1 1 1 1 0 0 0 1 0 1 1 0 0 0 0 1 1 0 1 1 1 0 1 1 1 0 1 0 0 1 0 0 0 0 1 1 1 1 1 0 0 0 1 1 0 1 1 1 1 1 0 0 0 0 1 0 0 1 0 1 1 1 1 0 1 0 1 0 1 0 0 0 1 0 1 0 1 1 0 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 1 0 1 1 0 0 0 0 0 1 0 0 0 1 0 0 1 1 0 1 1 0 0 0 1 1 0 1 1 1 0 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 1 1 0 1 1 1 0 0 1 0 1 1 1 0 0 1 0 0 0 0 1 1 1 0 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 1 1 1 0 0 1 1 0 1 0 1 0 1 1 1 0 0 1 0 0 0 0 1 1 1 0 0 0 1 1 1 0 1 0 1 1 0 1 1 0 0 0 1 1 1 1 0 0 0 1 1 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 0 0 1 1 1 1 1 1 1 0 1 1 1 1 0 0 1 0 1 1 0 1 1 1 0 1 1 1 1 0 1 1 0 1 1 0 1 0 1 0 1 1 1 0 0 0 0 0 1 1 0 1 0 0 0 1 1 0 0 1 1 0 0 0 1 1 0 0 1 1 1 1 0 0 0 1 0 1 1 0 1 0 1 1 1 1 0 0 0 0 0 1 1 1 1 0 0 1 0 0 1 0 0 0 1 0 1 1 0 0 1 1 0 1 1 0 1 0 1 0 1 1 0 1 1 0 1 0 0 1 1 0 0 1 1 0 0 0 1 1 0 0 1 1 0 1 1 1 0 0 0 1 0 1 1 0 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 1 0 1 1 0 0 1 1 1 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 1 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 0 0 0 1 1 0 0 0 0 0 0 1 0 0 0 1 1 1 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 0 1 0 0 0 0 1 1 0 0 1 1 0 0 0 0 1 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 1 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1 0 0 0 1 1 1 1 0 1 1 1 1 0 1 1 0 0 1 0 1 0 0 0 0 1 0 0 0 1 0 0 0 0 1 1 1 0 0 0 1 0 1 1 1 0 0 1 0 1 1 1 0 1 1 0 0 0 0 0 1 1 0 1 1 0 1 1 1 1 1 1 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1 0 0 1 1 0 1 1 1 1 1 0 1 0 1 0 0 0 1 1 1 0 1 0 1 1 1 0 1 0 1 1 1 0 0 1 0 0 0 0 1 1 1 1 0 1 1 0 1 1 1 1 0 1 1 0 0 1 0 1 0 1 0 1 1 0 0 0 0 0 1 0 0 0 0 1 1 0 1 1 1 1 0 1 0 0 0 1 0 0 0 1 0 0 0 0 1 1 1 1 0 1 0 0 1 1 0 0 1 1 1 1 0 1 0 0 1 0 1 0 1 1 1 1 0 0 0 1 1 1 0 1 0 1 0 0 1 1 1 1 0 1 1 1 1 1 1 0 0 0 1 1 0 1 0 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 1 0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 1 0 0 0 1 0 1 0 0 0 0 0 1 0 0 1 0 1 0 1 1 0 0 0 1 1 0 0 1 0 1 1 1 0 0 1 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0 1 0 1 1 0 1 1 0 0 1 1 1 0 0 1 1 1 1 1 1 1 0 1 0 1 0 0 0 0 1 1 1 1 1 0 0 0 0 0 1 0 0 0 1 0 0 0 1 1 0 1 1 0 0 0 0 0 1 0 1 0 0 0 0 1 0 0 1 0 1 1 0 1 0 1 0 1 1 0 1 0 1 1 1 0 1 0 1 1 0 0 1 0 1 1 1 1 0 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 1 1 0 0 0 1 0 1 0 1 0 0 0 0 1 0 0 0 1 1 1 1 1 1 0 0 1 1 0 0 0 1 1 0 0 0 1 0 1 1 0 1 0 0 1 0 1 0 0 1 0 1 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 1 0 1 1 0 0 1 0 0 0 0 0 1 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 1 0 0 1 0 1 0 1 1 1 0 1 1 1 0 1 0 0 0 1 1 1 1 1 0 1 1 0 1 0 0 0 1 1 0 1 1 1 0 0 0 0 0 1 1 0 1 1 0 1 1 1 0 1 1 1 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 1 1 0 0 1 0 1 0 1 0 0 0 0 1 1 1 1 0 1 1 0 1 1 0 0 1 1 0 0 1 1 1 0 0 1 0 1 0 0 0 1 1 1 1 1 0 1 1 1 1 1 1 0 1 0 0 1 0 0 1 0 0 0 1 1 1 1 0 1 0 1 1 0 0 1 0 0 1 0 1 0 0 0 1 0 1 0 1 1 1 0 1 1 0 0 1 1 0 1 1 0 0 1 0 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 0 0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 1 0 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 1 0 1 0 1 1 0 1 1 0 1 0 0 0 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 1 0 0 0 1 0 0 1 1 1 1 1 0 1 0 1 1 1 1 0 0 1 1 1 1 1 0 1 0 1 0 0 0 0 1 1 0 0 1 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 1 1 0 0 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 1 1 0 1 1 1 0 0 1 1 0 0 0 1 0 1 1 1 1 0 1 0 1 1 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 1 0 1 0 0 0 1 1 1 0 0 0 1 1 1 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 1 1 1 0 0 0 1 0 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 1 1 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 0 0 0 0 1 1 1 0 1 1 1 0 0 1 0 0 0 0 0 1 1 0 0 0 1 1 0 0 1 1 1 0 1 1 0 0 1 1 1 1 1 0 1 1 1 1 1 0 0 1 0 1 0 0 1 0 0 0 1 0 1 0 0 1 0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 1 0 0 0 1 0 1 1 0 1 0 1 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 1 0 1 1 1 1 1 0 0 1 1 1 0 0 0 0 1 1 1 1 0 1 1 1 0 0 0 0 1 0 1 1 0 1 0 0 1 0 1 1 0 1 1 0 0 0 0 0 1 0 1 0 1 0 0 0 1 1 0 0 0 1 0 1 1 0 0 0 0 0 1 0 0 1 0 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 1 1 1 1 0 0 1 0 0 1 0 1 1 0 1 1 1 0 0 0 1 1 1 1 0 1 0 0 1 1 1 0 0 0 1 1 0 1 0 1 0 0 0 1 0 1 0 1 0 1 1 0 0 1 1 0 0 0 0 1 1 0 1 0 0 1 1 0 1 1 0 1 1 1 0 0 1 1 1 1 0 0 1 1 0 0 0 1 0 1 0 1 1 1 1 1 0 0 -315800653
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -315800653
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorWarning received =     1
    Should Contain    ${output}    Timestamp : 92.3288
    Should Contain    ${output}    AnyWarning : 0
    Should Contain    ${output}    AnyMajorFault : 0
    Should Contain    ${output}    MajorFault : 1
    Should Contain    ${output}    AnyMinorFault : 1
    Should Contain    ${output}    MinorFault : 0
    Should Contain    ${output}    AnyFaultOverride : 0
    Should Contain    ${output}    FaultOverride : 1
    Should Contain    ${output}    AnyMainCalibrationError : 1
    Should Contain    ${output}    MainCalibrationError : 1
    Should Contain    ${output}    AnyBackupCalibrationError : 0
    Should Contain    ${output}    BackupCalibrationError : 1
    Should Contain    ${output}    AnyMezzanineError : 0
    Should Contain    ${output}    MezzanineError : 1
    Should Contain    ${output}    AnyMezzanineBootloaderActive : 1
    Should Contain    ${output}    MezzanineBootloaderActive : 1
    Should Contain    ${output}    AnyUniqueIdCRCError : 0
    Should Contain    ${output}    UniqueIdCRCError : 0
    Should Contain    ${output}    AnyApplicationTypeMismatch : 0
    Should Contain    ${output}    ApplicationTypeMismatch : 1
    Should Contain    ${output}    AnyApplicationMissing : 1
    Should Contain    ${output}    ApplicationMissing : 1
    Should Contain    ${output}    AnyApplicationCRCMismatch : 0
    Should Contain    ${output}    ApplicationCRCMismatch : 1
    Should Contain    ${output}    AnyOneWireMissing : 1
    Should Contain    ${output}    OneWireMissing : 1
    Should Contain    ${output}    AnyOneWire1Mismatch : 0
    Should Contain    ${output}    OneWire1Mismatch : 1
    Should Contain    ${output}    AnyOneWire2Mismatch : 1
    Should Contain    ${output}    OneWire2Mismatch : 1
    Should Contain    ${output}    AnyWatchdogReset : 0
    Should Contain    ${output}    WatchdogReset : 0
    Should Contain    ${output}    AnyBrownOut : 0
    Should Contain    ${output}    BrownOut : 1
    Should Contain    ${output}    AnyEventTrapReset : 0
    Should Contain    ${output}    EventTrapReset : 0
    Should Contain    ${output}    AnySSRPowerFault : 1
    Should Contain    ${output}    SSRPowerFault : 1
    Should Contain    ${output}    AnyAuxPowerFault : 0
    Should Contain    ${output}    AuxPowerFault : 0
    Should Contain    ${output}    AnyMezzaninePowerFault : 1
    Should Contain    ${output}    MezzaninePowerFault : 1
    Should Contain    ${output}    AnyMezzanineCurrentAmp1Fault : 1
    Should Contain    ${output}    MezzanineCurrentAmp1Fault : 0
    Should Contain    ${output}    AnyMezzanineCurrentAmp2Fault : 0
    Should Contain    ${output}    MezzanineCurrentAmp2Fault : 1
    Should Contain    ${output}    AnyMezzanineUniqueIdCRCError : 1
    Should Contain    ${output}    MezzanineUniqueIdCRCError : 1
    Should Contain    ${output}    AnyMezzanineMainCalibrationError : 0
    Should Contain    ${output}    MezzanineMainCalibrationError : 0
    Should Contain    ${output}    AnyMezzanineBackupCalibrationError : 1
    Should Contain    ${output}    MezzanineBackupCalibrationError : 0
    Should Contain    ${output}    AnyMezzanineEventTrapReset : 0
    Should Contain    ${output}    MezzanineEventTrapReset : 1
    Should Contain    ${output}    AnyMezzanineApplicationMissing : 1
    Should Contain    ${output}    MezzanineApplicationMissing : 1
    Should Contain    ${output}    AnyMezzanineApplicationCRCMismatch : 0
    Should Contain    ${output}    MezzanineApplicationCRCMismatch : 0
    Should Contain    ${output}    AnyILCFault : 1
    Should Contain    ${output}    ILCFault : 1
    Should Contain    ${output}    AnyBroadcastCounterWarning : 0
    Should Contain    ${output}    BroadcastCounterWarning : 1
    Should Contain    ${output}    priority : 1
