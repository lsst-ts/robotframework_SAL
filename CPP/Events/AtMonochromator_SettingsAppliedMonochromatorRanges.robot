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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 0.0031815839215 0.550860180576 0.74788497838 0.192415111731 0.350327528121 0.507385569347 0.48065507982 301187011
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_SettingsAppliedMonochromatorRanges writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingsAppliedMonochromatorRanges generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 301187011
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingsAppliedMonochromatorRanges received =     1
    Should Contain    ${output}    wavelengthGR1 : 0.0031815839215
    Should Contain    ${output}    wavelenlengthGR1_GR2 : 0.550860180576
    Should Contain    ${output}    wavelenlengthGR2 : 0.74788497838
    Should Contain    ${output}    minSlitWidth : 0.192415111731
    Should Contain    ${output}    maxSlitWidth : 0.350327528121
    Should Contain    ${output}    minWavelength : 0.507385569347
    Should Contain    ${output}    maxWavelength : 0.48065507982
    Should Contain    ${output}    priority : 301187011
