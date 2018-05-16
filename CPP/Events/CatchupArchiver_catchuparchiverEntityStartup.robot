*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntityStartup sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send fMnKCIqJedGSsKZUowUHQYFkfuznEeEKDFqKklkRQXKeuyBHqOtPYSHpHUxGdIiBquAsVrTUQfRDGUnaczwRbJjmdiwifKfMTZEemgNbEMbyPuBIyTrAPqNHypletSNXZjegofNyKyWVoFGuiqbNPaJKxKLEHyiTcYmxbPEmjfwFNNYTkZlKhHhQbWRARzlQufFxOTtXXvbUAtBcfjiMlbdicRozxDiPPoReNwOFTfJwjDRuuuWvaOjVcSDHlTFz 89.7081 fcxOVBzlOxItYHIAwFrAfkuxFLvNpVyIUVoKOeIeKkSXLXBnBUZbqtxvHEZDlxXKJtPLTyNkmqdZrefbVJJIJNqYFkgjStaYXnEocDaBnFhPmdwMakNCaabXaYBjYSvorUQPnsqCxogJhKuilGQeEXinbScJbsZxoNEIWLImZuqsmsxYQvldAGfuqsBGZiUtaEjPtwOnCWySICOsyNejwgCXjWvqkakbFPbncLFuoNRqYbEvNZrnwqzEDfzmTWKK -794559937 1758669413 -2081552240
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2081552240
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntityStartup received =     1
    Should Contain    ${output}    Name : fMnKCIqJedGSsKZUowUHQYFkfuznEeEKDFqKklkRQXKeuyBHqOtPYSHpHUxGdIiBquAsVrTUQfRDGUnaczwRbJjmdiwifKfMTZEemgNbEMbyPuBIyTrAPqNHypletSNXZjegofNyKyWVoFGuiqbNPaJKxKLEHyiTcYmxbPEmjfwFNNYTkZlKhHhQbWRARzlQufFxOTtXXvbUAtBcfjiMlbdicRozxDiPPoReNwOFTfJwjDRuuuWvaOjVcSDHlTFz
    Should Contain    ${output}    Identifier : 89.7081
    Should Contain    ${output}    Timestamp : fcxOVBzlOxItYHIAwFrAfkuxFLvNpVyIUVoKOeIeKkSXLXBnBUZbqtxvHEZDlxXKJtPLTyNkmqdZrefbVJJIJNqYFkgjStaYXnEocDaBnFhPmdwMakNCaabXaYBjYSvorUQPnsqCxogJhKuilGQeEXinbScJbsZxoNEIWLImZuqsmsxYQvldAGfuqsBGZiUtaEjPtwOnCWySICOsyNejwgCXjWvqkakbFPbncLFuoNRqYbEvNZrnwqzEDfzmTWKK
    Should Contain    ${output}    Address : -794559937
    Should Contain    ${output}    priority : 1758669413
    Should Contain    ${output}    priority : -2081552240
