*** Settings ***
Documentation    PromptProcessing_SettingVersions sender/logger tests.
Force Tags    cpp    TSS-2633
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptprocessing
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send hueeVyHXWQyLalYSEkYHwqIOfxiteMWNkxEaKuGNPsIFAIcpaASAyTrYJCAPyjgtoMPImdqTgaoMdtwqRYVjzJKEHFPfeQdKAxlumIthrZbTbwdqIWaEgkKZDxOPGSzVGojQoHQWksDSoeMkaaqPzdWTpKbolboDrDpNujSzHNdrUdLAGjONzztVQVSFmAxCsKgqPjyqjDrcHuOxXlXxmkdlVHonDNmmqPcQBaJasFCIFhTSFlUXEahsenJuzUea 57888349
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptprocessing::logevent_SettingVersions writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingVersions generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 57888349
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingVersions received =     1
    Should Contain    ${output}    recommendedSettingVersion : hueeVyHXWQyLalYSEkYHwqIOfxiteMWNkxEaKuGNPsIFAIcpaASAyTrYJCAPyjgtoMPImdqTgaoMdtwqRYVjzJKEHFPfeQdKAxlumIthrZbTbwdqIWaEgkKZDxOPGSzVGojQoHQWksDSoeMkaaqPzdWTpKbolboDrDpNujSzHNdrUdLAGjONzztVQVSFmAxCsKgqPjyqjDrcHuOxXlXxmkdlVHonDNmmqPcQBaJasFCIFhTSFlUXEahsenJuzUea
    Should Contain    ${output}    priority : 57888349
