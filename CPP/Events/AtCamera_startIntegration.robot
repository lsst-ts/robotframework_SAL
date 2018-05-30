*** Settings ***
Documentation    AtCamera_startIntegration communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    startIntegration
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send lpFtoioeXNfHhHABwZkQcYNsgxkruNJIiZxIbTqpHbOFCniTxCVQxWQsSXGtFwCitDMnbdlyAuNizLnGYsaDUDQyfbTqeBhCsjvNDrFOhhEjLzlwvGeuSalNZjuguqDhdLUjDMvPdHqqoSeAjLRNAJECgeIaVyKNahoCrPWjdApqewPdSPWLiwWwGnLGYdcOJUHEVQJYxawmoLfpMvZMGyUebKfYEoiNCieXCMUINWvHDIjxExKkABRTxEdyMySE 2128089582 ZydqEkTQJXLOcfpItnqjyfUptyUpAnaGysbhtvCSFiXPnAJFMJHbsddUpWttVxJFqrUHrgZjGFFMfjbBSQznjPOyDMSbDhnnksotWQLiaSNtPUPfURqYNlaZVMZePCTViZaFJCRJjtVivaldLtUgBNKQoEdIuQMKeSYvOVhTwjcMlsXTWMfCBzRcLWKVDhDQuDKtlMgRHvVoaRaeDXsJPogBqwCtJhfODJlUmoDoCIOQEoeXGHKCLxsTvlSCOEmH -1905323833 39.91 34.2218 729250033
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_startIntegration writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startIntegration generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 729250033
    Log    ${output}
    Should Contain X Times    ${output}    === Event startIntegration received =     1
    Should Contain    ${output}    imageSequenceName : lpFtoioeXNfHhHABwZkQcYNsgxkruNJIiZxIbTqpHbOFCniTxCVQxWQsSXGtFwCitDMnbdlyAuNizLnGYsaDUDQyfbTqeBhCsjvNDrFOhhEjLzlwvGeuSalNZjuguqDhdLUjDMvPdHqqoSeAjLRNAJECgeIaVyKNahoCrPWjdApqewPdSPWLiwWwGnLGYdcOJUHEVQJYxawmoLfpMvZMGyUebKfYEoiNCieXCMUINWvHDIjxExKkABRTxEdyMySE
    Should Contain    ${output}    imagesInSequence : 2128089582
    Should Contain    ${output}    imageName : ZydqEkTQJXLOcfpItnqjyfUptyUpAnaGysbhtvCSFiXPnAJFMJHbsddUpWttVxJFqrUHrgZjGFFMfjbBSQznjPOyDMSbDhnnksotWQLiaSNtPUPfURqYNlaZVMZePCTViZaFJCRJjtVivaldLtUgBNKQoEdIuQMKeSYvOVhTwjcMlsXTWMfCBzRcLWKVDhDQuDKtlMgRHvVoaRaeDXsJPogBqwCtJhfODJlUmoDoCIOQEoeXGHKCLxsTvlSCOEmH
    Should Contain    ${output}    imageIndex : -1905323833
    Should Contain    ${output}    timeStamp : 39.91
    Should Contain    ${output}    exposureTime : 34.2218
    Should Contain    ${output}    priority : 729250033
