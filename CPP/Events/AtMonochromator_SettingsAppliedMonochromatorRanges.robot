*** Settings ***
Documentation    AtMonochromator_SettingsAppliedMonochromatorRanges sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    SettingsAppliedMonochromatorRanges
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 0.538250818606 0.538402679948 0.371352292595 0.577928736287 0.161072730527 0.892292523148 0.843654650532 -1090250067
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_SettingsAppliedMonochromatorRanges writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingsAppliedMonochromatorRanges generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1090250067
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingsAppliedMonochromatorRanges received =     1
    Should Contain    ${output}    wavelengthGR1 : 0.538250818606
    Should Contain    ${output}    wavelenlengthGR1_GR2 : 0.538402679948
    Should Contain    ${output}    wavelenlengthGR2 : 0.371352292595
    Should Contain    ${output}    minSlitWidth : 0.577928736287
    Should Contain    ${output}    maxSlitWidth : 0.161072730527
    Should Contain    ${output}    minWavelength : 0.892292523148
    Should Contain    ${output}    maxWavelength : 0.843654650532
    Should Contain    ${output}    priority : -1090250067
