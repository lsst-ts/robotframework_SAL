*** Settings ***
Documentation    M1M3_SettingVersions communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 85.0219 eKMrmQpSYWlJRlhHBExrvKPKtGEsYzqBSUGNoIWcYsGDrTkTldqhDTKPWYVpVFXxHwIJRAEMPjEaaMQkbzFWYGDVijNUMJTzfPcGMrYLbXJNyOjAXwzWGaiMhxAcmdwmnRZsqcgsCRETZCHzNMfYwBQzHuaxsjaQaDMiOSlHgtIZXCCcbGbExEopdDjxzdDyAvUNqEMRhiAkkWEnhcFIKUroHYobdCNWVfnwVVTFNausBFcwaIXDPLNhiMTFortE -1795387129
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_SettingVersions writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingVersions generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1795387129
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingVersions received =     1
    Should Contain    ${output}    Timestamp : 85.0219
    Should Contain    ${output}    RecommendedSettingsVersion : eKMrmQpSYWlJRlhHBExrvKPKtGEsYzqBSUGNoIWcYsGDrTkTldqhDTKPWYVpVFXxHwIJRAEMPjEaaMQkbzFWYGDVijNUMJTzfPcGMrYLbXJNyOjAXwzWGaiMhxAcmdwmnRZsqcgsCRETZCHzNMfYwBQzHuaxsjaQaDMiOSlHgtIZXCCcbGbExEopdDjxzdDyAvUNqEMRhiAkkWEnhcFIKUroHYobdCNWVfnwVVTFNausBFcwaIXDPLNhiMTFortE
    Should Contain    ${output}    priority : -1795387129
