*** Settings ***
Documentation    PromptProcessing_promptprocessingEntityShutdown sender/logger tests.
Force Tags    cpp    TSS-2678
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptProcessing
${component}    promptprocessingEntityShutdown
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send mGgPqsVLQzoNwZfOCtAjABuLWoyOhbSOyIsXEHIpeAXAMdqTSrNWJJBjCoRQOzFpbziBBDSiRrPAoAeNHyUufFMOzihdIDaKtRxhgSoPJRRngDQLOjHEFaxehKDGdRZBmXIfpxKAzaxNUfkyzwWgehzuJjCHVfGJhMAhbHlGKjxGXbCYwsrrNMQxwGMDQYkosvBEcYAtvhZcyvBUOopWCvWTuRiatRaTMLBXdqIciKLnvVfpJEgBxDjwMFLwSdfe 30.3804 ZlcloeHoIsXBppxkenEcEUlvWMYYHPOYzngvDjhvQzlHiRQjIDmUCSYKrApjIUCxDviYAOCNlPguomiIXowwBIkcRYlriBmrxVGjqwkZTzWenRxaaBFrrFdNQdJAlGkTsugDgoCpPNQQIqEQrmSGvEZpYCYXyAuDajKSjzFvYRDvcBBAPSrrzLUXipPiFDCrMlsnzALDkvBzwCaarUiROQmZiCzdDkHUKnLDXojaRTDcxvTnnxfEjKRXiqAuXMuS -1991815713 13924635 1046624784
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptProcessing::logevent_promptprocessingEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1046624784
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntityShutdown received =     1
    Should Contain    ${output}    Name : mGgPqsVLQzoNwZfOCtAjABuLWoyOhbSOyIsXEHIpeAXAMdqTSrNWJJBjCoRQOzFpbziBBDSiRrPAoAeNHyUufFMOzihdIDaKtRxhgSoPJRRngDQLOjHEFaxehKDGdRZBmXIfpxKAzaxNUfkyzwWgehzuJjCHVfGJhMAhbHlGKjxGXbCYwsrrNMQxwGMDQYkosvBEcYAtvhZcyvBUOopWCvWTuRiatRaTMLBXdqIciKLnvVfpJEgBxDjwMFLwSdfe
    Should Contain    ${output}    Identifier : 30.3804
    Should Contain    ${output}    Timestamp : ZlcloeHoIsXBppxkenEcEUlvWMYYHPOYzngvDjhvQzlHiRQjIDmUCSYKrApjIUCxDviYAOCNlPguomiIXowwBIkcRYlriBmrxVGjqwkZTzWenRxaaBFrrFdNQdJAlGkTsugDgoCpPNQQIqEQrmSGvEZpYCYXyAuDajKSjzFvYRDvcBBAPSrrzLUXipPiFDCrMlsnzALDkvBzwCaarUiROQmZiCzdDkHUKnLDXojaRTDcxvTnnxfEjKRXiqAuXMuS
    Should Contain    ${output}    Address : -1991815713
    Should Contain    ${output}    priority : 13924635
    Should Contain    ${output}    priority : 1046624784
