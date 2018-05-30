*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntitySummaryState communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send mSdRahlKgGPJRlMfExZExSQcJETVSZSQMWqjiQQRkNHBWGbfZrZChRUFzPdAUkEvMOEBfTgkowsBnZvYhvfxuArlPKUEAsdpsXXCHdZGTVBHZkmHQLockFaqDOJuHzZS 75.7425 PtQSHOLHccgXxAnEagxQkQUBkhRPzDgbRNYUZHeQtEmpvKJufNAkiNdwbWBCqlJVftMdVffWRxgcLyGppoQePVutfXTuaFpkmmDrZcPzHCvVeUiBwUwkVwQrUBjERLRQiMzdqZMbwvmXvdtvXoYMdqfzskQEwGwoTBNhqTJxXIwnJEJhepqoUQfLawSjVlFkhmPvHJOPVFwShMpRQzELNbayKwYedAvoezdFBfDWmegfQLcqITyJiSeNMuckJPRL -1430285212 kXoQFyCdPeToqbYDhxCvCcDHmWfYGUIZpBEphJJgGioVkMJLoTHxfYSvEGQVysEhKCIOUEhFICIXRTBzBLdXsgsDlbkpbwWsMLyYOfdyrRgRRvncjUIxxJekIDftqwHs bEbONBxNnuJRoOUBqCgwMsDTDDrgeQFhILRaRBQcdBfmOcBqwCVtdgyDCiAvSTsVYivAVXmcOBHJyCEMSvuHyIfQUiwEqHafgrpbPmJseaHwRHYqsaFOMGIoyrqHeQFq mDPXJHTUCGzliTmPbKzjGAZFOvUAOJYNlwAqOQKvIIDgABuCkwXZUlcYLuWFAHUQpgmUpAQUKBcTmuAJmjFNbkusSFEVpKaJhCwbDaPdmUtFakmoWOwppnVZFMJYunyc NqEweFOyFvTxUxASiZYSGZKcdKztaRrkVlNJLqpUsZSHKLOazMamDUepZAcbmkKLlooOAAcbYlyKtPJKCZmijOEFfIQiNSSwNTxlTxpBWOOdLfwLmnwlTUQgFiDomRAR AKxinTdHBRGlvkBvitnsnNHdSczlPXYSByqrnaZubkgqhtDzaijmRfRGEGChRhhkdmGJBXmgDKeBhOymEoewYGWjTmIwzNKuZuubfDexxVxeyQpzRDEUIxKNgEzFDsQg 897689619
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 897689619
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : mSdRahlKgGPJRlMfExZExSQcJETVSZSQMWqjiQQRkNHBWGbfZrZChRUFzPdAUkEvMOEBfTgkowsBnZvYhvfxuArlPKUEAsdpsXXCHdZGTVBHZkmHQLockFaqDOJuHzZS
    Should Contain    ${output}    Identifier : 75.7425
    Should Contain    ${output}    Timestamp : PtQSHOLHccgXxAnEagxQkQUBkhRPzDgbRNYUZHeQtEmpvKJufNAkiNdwbWBCqlJVftMdVffWRxgcLyGppoQePVutfXTuaFpkmmDrZcPzHCvVeUiBwUwkVwQrUBjERLRQiMzdqZMbwvmXvdtvXoYMdqfzskQEwGwoTBNhqTJxXIwnJEJhepqoUQfLawSjVlFkhmPvHJOPVFwShMpRQzELNbayKwYedAvoezdFBfDWmegfQLcqITyJiSeNMuckJPRL
    Should Contain    ${output}    Address : -1430285212
    Should Contain    ${output}    CurrentState : kXoQFyCdPeToqbYDhxCvCcDHmWfYGUIZpBEphJJgGioVkMJLoTHxfYSvEGQVysEhKCIOUEhFICIXRTBzBLdXsgsDlbkpbwWsMLyYOfdyrRgRRvncjUIxxJekIDftqwHs
    Should Contain    ${output}    PreviousState : bEbONBxNnuJRoOUBqCgwMsDTDDrgeQFhILRaRBQcdBfmOcBqwCVtdgyDCiAvSTsVYivAVXmcOBHJyCEMSvuHyIfQUiwEqHafgrpbPmJseaHwRHYqsaFOMGIoyrqHeQFq
    Should Contain    ${output}    Executing : mDPXJHTUCGzliTmPbKzjGAZFOvUAOJYNlwAqOQKvIIDgABuCkwXZUlcYLuWFAHUQpgmUpAQUKBcTmuAJmjFNbkusSFEVpKaJhCwbDaPdmUtFakmoWOwppnVZFMJYunyc
    Should Contain    ${output}    CommandsAvailable : NqEweFOyFvTxUxASiZYSGZKcdKztaRrkVlNJLqpUsZSHKLOazMamDUepZAcbmkKLlooOAAcbYlyKtPJKCZmijOEFfIQiNSSwNTxlTxpBWOOdLfwLmnwlTUQgFiDomRAR
    Should Contain    ${output}    ConfigurationsAvailable : AKxinTdHBRGlvkBvitnsnNHdSczlPXYSByqrnaZubkgqhtDzaijmRfRGEGChRhhkdmGJBXmgDKeBhOymEoewYGWjTmIwzNKuZuubfDexxVxeyQpzRDEUIxKNgEzFDsQg
    Should Contain    ${output}    priority : 897689619
