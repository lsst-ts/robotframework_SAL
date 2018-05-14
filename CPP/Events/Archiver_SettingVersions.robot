*** Settings ***
Documentation    Archiver_SettingVersions sender/logger tests.
Force Tags    cpp    TSS-2623
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    archiver
${component}    SettingVersions
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send SeOfHBYmISwWCxLrldvngzjtMFfFXQUmsezFxvbLMDzbsCcLqoHCJyleczVcoBLLXAabgKytNbFPXFzqXNOgzuMuEYsnxinDxyMAStsrGsJTqyfAgDbtFAXcQtQOUiflZIPlhSmDNTTPaTwdmKjqFaClGdFZbCYupZdDzMNzoFUEbWLrqKrfUIglRCsxWhzgfwAAEAPebDXIovoNYIfdLeCIgIxsnuvVEGuzFdghCcsnkjIUNnFYonitHNvKJeKN 2116569644 -1689355921
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_SettingVersions writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingVersions generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1689355921
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingVersions received =     1
    Should Contain    ${output}    recommendedSettingVersion : SeOfHBYmISwWCxLrldvngzjtMFfFXQUmsezFxvbLMDzbsCcLqoHCJyleczVcoBLLXAabgKytNbFPXFzqXNOgzuMuEYsnxinDxyMAStsrGsJTqyfAgDbtFAXcQtQOUiflZIPlhSmDNTTPaTwdmKjqFaClGdFZbCYupZdDzMNzoFUEbWLrqKrfUIglRCsxWhzgfwAAEAPebDXIovoNYIfdLeCIgIxsnuvVEGuzFdghCcsnkjIUNnFYonitHNvKJeKN
    Should Contain    ${output}    priority : 2116569644
    Should Contain    ${output}    priority : -1689355921
