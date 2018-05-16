*** Settings ***
Documentation    AtArchiver_archiverEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2674
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atArchiver
${component}    archiverEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send DtyMTxLkyqLQcHhbwBytbfWGFOyhiMaIFVEdWgaTENdVbnnjrqbybxsPKmSOPNTQazpUmBHXSQawGDwaDvGYMLnEYHAUjyJCRwBwiChHMGWUdSmrAIkWOuMYIMjJJIGp 88.9093 funQvBVHdzCUWgfHaTuDCjhFQXmwDWZQSbVNuHohUZJokNQVvrbeaHFBVDnUkDnJMVqMqapqMwzblSvnJrGZHGabCjIeAGlLCpxXRejYXLmhPrJxByDGElRexIRltnngOqlfsVxJQWOYhjvONmJiiEkhadbZMUPyFlrcAgxtHgwCswQbezkpYZxvngoHhPNcCVxOVIXVCHaazEdapSfHHHsRVaiuqLGigmIlNhMiAeqQaNglTItrdLTNVLJPeood -1776540772 AvemOheoURYDANjmTvpQjXtKCQqhDOtVOuOnasnYkdbjGdjcgkreOjGDHVzLPNauwDozFcUOfEIHVMBluovNJEIEdXCakWciOSMlnjzzrZwEpnHTwwOADjXHTuYjNnSR hZoGFAonOHbRaEbGiKiRGCNThLkAjkxmKUweZMbSrxUMcwNFaBBdEXwppiegchKixHDmPKIfpaKlUILbEoSAETFWtlYkGpgmKVIuMOzmiBqsnRQdLdpjFhyZacooxrVS qVlXyEMfZjYTNCkJigztVdnenNleNZZgADWfAmFkggFxZdfiGGJVMZulbpYZlSpKihQYmjSPldRYbyLbpFadCbgpSiNRpKfpblvhPoWGJtjAVBQCWGINRZPfpPQEPBOI BvRmMcAxgeyCZRYfnLPHuNyKpUbnHhjkkQIvCsKSghfzhgeVhBfdstovofdsLFTKfxVbnTchfaVzbxYPDqDqwXqiHSeHrqbqwHLUgBvnCPEIRuApEnkFrMaRHxGJnkwb JpvzgDFUSIeFPbPxuvwpUJUwGKkQCEBiYYzIguxjnFfYXMkLkgrFHtphVlhfiDXvvxLfrwpccgvYYcSMnZfNdgmKMiNflZVKAhTxenExNbNycwHIBqaImegtbaFYQSZw -1885806987 -1245189448
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atArchiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1245189448
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : DtyMTxLkyqLQcHhbwBytbfWGFOyhiMaIFVEdWgaTENdVbnnjrqbybxsPKmSOPNTQazpUmBHXSQawGDwaDvGYMLnEYHAUjyJCRwBwiChHMGWUdSmrAIkWOuMYIMjJJIGp
    Should Contain    ${output}    Identifier : 88.9093
    Should Contain    ${output}    Timestamp : funQvBVHdzCUWgfHaTuDCjhFQXmwDWZQSbVNuHohUZJokNQVvrbeaHFBVDnUkDnJMVqMqapqMwzblSvnJrGZHGabCjIeAGlLCpxXRejYXLmhPrJxByDGElRexIRltnngOqlfsVxJQWOYhjvONmJiiEkhadbZMUPyFlrcAgxtHgwCswQbezkpYZxvngoHhPNcCVxOVIXVCHaazEdapSfHHHsRVaiuqLGigmIlNhMiAeqQaNglTItrdLTNVLJPeood
    Should Contain    ${output}    Address : -1776540772
    Should Contain    ${output}    CurrentState : AvemOheoURYDANjmTvpQjXtKCQqhDOtVOuOnasnYkdbjGdjcgkreOjGDHVzLPNauwDozFcUOfEIHVMBluovNJEIEdXCakWciOSMlnjzzrZwEpnHTwwOADjXHTuYjNnSR
    Should Contain    ${output}    PreviousState : hZoGFAonOHbRaEbGiKiRGCNThLkAjkxmKUweZMbSrxUMcwNFaBBdEXwppiegchKixHDmPKIfpaKlUILbEoSAETFWtlYkGpgmKVIuMOzmiBqsnRQdLdpjFhyZacooxrVS
    Should Contain    ${output}    Executing : qVlXyEMfZjYTNCkJigztVdnenNleNZZgADWfAmFkggFxZdfiGGJVMZulbpYZlSpKihQYmjSPldRYbyLbpFadCbgpSiNRpKfpblvhPoWGJtjAVBQCWGINRZPfpPQEPBOI
    Should Contain    ${output}    CommandsAvailable : BvRmMcAxgeyCZRYfnLPHuNyKpUbnHhjkkQIvCsKSghfzhgeVhBfdstovofdsLFTKfxVbnTchfaVzbxYPDqDqwXqiHSeHrqbqwHLUgBvnCPEIRuApEnkFrMaRHxGJnkwb
    Should Contain    ${output}    ConfigurationsAvailable : JpvzgDFUSIeFPbPxuvwpUJUwGKkQCEBiYYzIguxjnFfYXMkLkgrFHtphVlhfiDXvvxLfrwpccgvYYcSMnZfNdgmKMiNflZVKAhTxenExNbNycwHIBqaImegtbaFYQSZw
    Should Contain    ${output}    priority : -1885806987
    Should Contain    ${output}    priority : -1245189448
