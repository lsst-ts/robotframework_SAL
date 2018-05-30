*** Settings ***
Documentation    AtMonochromator_SettingVersions communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send jsUMqzLqmVTRthjeaytWAiUqCgArWhljeWLSAWSMpitDwuWMSIvrcYaMFaqkeKJcXtiaUetpwHFJAVMupVPpmmZvetKnZErIueYxpAfChhuabwYliwwLZthXZKIucIhzZtFReJvOoSlzHZQzCKOftiEaEGgpwdveSuASqZXtjJnrAhXFJvPGxcPPOhlnNvjoLNncfQaoFVyDDgqBTEoMhJaNALgHEWJRbdNVdWTjNThTHxBmonMRQDiwRuDGVVrn KqPhGkOZzGYyHhxZAKZbQTcEAhbxhDOVQyDgxNlLirDUXRWOWnuoeseAmbsHEcaqTenUabZDLhLyiCqJIGvZHzJGUhHIrbgtnTEpVchpOkKlrxDzfoOEYwIJkXggPqVITIBYyPwEOUrzAYMdHHaFxAXsPafwFazUbHsFaNuAwsgUyqDdgKlXnOALUWIXuPOyNlIgTTnDKTHshomEcsDVFHFQlcTCtcrArzqvkYOhkJgUOczXTeXYxInjUoMjqTHG 867028858
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_SettingVersions writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingVersions generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 867028858
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingVersions received =     1
    Should Contain    ${output}    recommendedSettingsVersion : jsUMqzLqmVTRthjeaytWAiUqCgArWhljeWLSAWSMpitDwuWMSIvrcYaMFaqkeKJcXtiaUetpwHFJAVMupVPpmmZvetKnZErIueYxpAfChhuabwYliwwLZthXZKIucIhzZtFReJvOoSlzHZQzCKOftiEaEGgpwdveSuASqZXtjJnrAhXFJvPGxcPPOhlnNvjoLNncfQaoFVyDDgqBTEoMhJaNALgHEWJRbdNVdWTjNThTHxBmonMRQDiwRuDGVVrn
    Should Contain    ${output}    recommendedSettingsLabels : KqPhGkOZzGYyHhxZAKZbQTcEAhbxhDOVQyDgxNlLirDUXRWOWnuoeseAmbsHEcaqTenUabZDLhLyiCqJIGvZHzJGUhHIrbgtnTEpVchpOkKlrxDzfoOEYwIJkXggPqVITIBYyPwEOUrzAYMdHHaFxAXsPafwFazUbHsFaNuAwsgUyqDdgKlXnOALUWIXuPOyNlIgTTnDKTHshomEcsDVFHFQlcTCtcrArzqvkYOhkJgUOczXTeXYxInjUoMjqTHG
    Should Contain    ${output}    priority : 867028858
