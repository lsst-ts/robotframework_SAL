*** Settings ***
Documentation    AtArchiver_archiverEntitySummaryState communications tests.
Force Tags    cpp    
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send bZoIfVZxmTxVSIIfujxqhnmzfvfeJzDrhczpSKRKjlfayPLyWccutatcYAjJiGuZbojKBkeMxJroNZlMlHELJMrqnxqSkBbOPcntpJVPvPPnItdWwULZLDeAMlaGADoR 12.6672 nwpQbkMCLamnuVMDtbAqklSelUSoSjOdxcbKkzmVPHhkxfQsMuZrxIgePjmmPpnQebdJlCiFuIGqKizRuSiYNehWqrqfqzplJFaIvulkvgPORrWBUFzELqcMXnfRQZPnWbfDYqjjAwaAzPvegVwiwEMppPTNcPDgvyGmnAlrbsGhyUPSTpwTFSCHklpVEDhtretKlAgNLcKHgaAGQopKxtZtiHdFGKepRGcuhaotupzVPKNCXGwLueGRmLfIVIlZ 215540244 HxtQqAKkVWzTcjocSxnCRgsvgmWRDSHekxBhoCJSqpweIQgWJJRWWQzsmtQWmmHJRYyQTRwZSfafkcmfOndmksKdmBTJXwieevxZMdpSjaCxonknQgQPMNnMoXYZQvbn erJPCHdXjHvLMqgwXFBPtoSaMVGakgtIYpRntlxwNEMJzqvsDKzcmvUQsnzeVnxJnekNvXNtBClgYtLkdcBwEnsSTaUxKGzBQznBJqtXkYaDraQyOJugIhUTKKoCHElT hArVIJJmvRZTAHWNRaXdLZduJGcwBdbOrMvTpgLIykFqJocbFegmbILnUqhoTYhBCmeBUYBEUgffLTxwgIBewmpRegRLcDFbqGALXsBhyPFwTvNnwOTBvNgSkUZiqOrn jgJZdDzXAtVWqmPSiWZNqIlbGFcIRSEsNoyCUGiKkMIKGcDoTTPniFjFnWukaQgWVmvzXSjvlrJbjdJWVEsBFPRvLuPyLJhgAYLmwXMDIFcqLDErYHJGdukfzofPniXG zddLMvYuyluyqBhGUwYiQavTPSVXlzDbRQKfUoStBCWLiXfGlyznPhgPZGRZdZOiUtMepeZJiWrpPQzDfXAHPwmLbwZMyIKXdOpsLlpMQQUhhUeFXwpDPIdstRZfDtcO -1625490414
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atArchiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1625490414
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : bZoIfVZxmTxVSIIfujxqhnmzfvfeJzDrhczpSKRKjlfayPLyWccutatcYAjJiGuZbojKBkeMxJroNZlMlHELJMrqnxqSkBbOPcntpJVPvPPnItdWwULZLDeAMlaGADoR
    Should Contain    ${output}    Identifier : 12.6672
    Should Contain    ${output}    Timestamp : nwpQbkMCLamnuVMDtbAqklSelUSoSjOdxcbKkzmVPHhkxfQsMuZrxIgePjmmPpnQebdJlCiFuIGqKizRuSiYNehWqrqfqzplJFaIvulkvgPORrWBUFzELqcMXnfRQZPnWbfDYqjjAwaAzPvegVwiwEMppPTNcPDgvyGmnAlrbsGhyUPSTpwTFSCHklpVEDhtretKlAgNLcKHgaAGQopKxtZtiHdFGKepRGcuhaotupzVPKNCXGwLueGRmLfIVIlZ
    Should Contain    ${output}    Address : 215540244
    Should Contain    ${output}    CurrentState : HxtQqAKkVWzTcjocSxnCRgsvgmWRDSHekxBhoCJSqpweIQgWJJRWWQzsmtQWmmHJRYyQTRwZSfafkcmfOndmksKdmBTJXwieevxZMdpSjaCxonknQgQPMNnMoXYZQvbn
    Should Contain    ${output}    PreviousState : erJPCHdXjHvLMqgwXFBPtoSaMVGakgtIYpRntlxwNEMJzqvsDKzcmvUQsnzeVnxJnekNvXNtBClgYtLkdcBwEnsSTaUxKGzBQznBJqtXkYaDraQyOJugIhUTKKoCHElT
    Should Contain    ${output}    Executing : hArVIJJmvRZTAHWNRaXdLZduJGcwBdbOrMvTpgLIykFqJocbFegmbILnUqhoTYhBCmeBUYBEUgffLTxwgIBewmpRegRLcDFbqGALXsBhyPFwTvNnwOTBvNgSkUZiqOrn
    Should Contain    ${output}    CommandsAvailable : jgJZdDzXAtVWqmPSiWZNqIlbGFcIRSEsNoyCUGiKkMIKGcDoTTPniFjFnWukaQgWVmvzXSjvlrJbjdJWVEsBFPRvLuPyLJhgAYLmwXMDIFcqLDErYHJGdukfzofPniXG
    Should Contain    ${output}    ConfigurationsAvailable : zddLMvYuyluyqBhGUwYiQavTPSVXlzDbRQKfUoStBCWLiXfGlyznPhgPZGRZdZOiUtMepeZJiWrpPQzDfXAHPwmLbwZMyIKXdOpsLlpMQQUhhUeFXwpDPIdstRZfDtcO
    Should Contain    ${output}    priority : -1625490414
