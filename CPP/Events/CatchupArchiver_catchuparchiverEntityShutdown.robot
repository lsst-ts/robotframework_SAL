*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntityShutdown sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntityShutdown
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send SjdAnNGviaUNtZWdqBwEHQaRsOgDxGVLFzRvKxHRcZtPodLSURUAVMMzXRwmtbztZuwxXqBuPgyXmULroEVGxxEqjcyWvNhqxwlZnrVekFVtKCLahkNFxgMUkJRyVeIxuWNFQUuwCqRusKsPjyftHQpbVLrgVpxbBYeIKLDiKgrlbKqmbVWAKmiSnLYmMLXDgZWJUKOEffbjTdCckyLTnkfoXlWmdmUezwRkZMrKffNYdLbHFcGkvMjyLrQJZCGj 55.7348 YcCRHAFlpdFlDjTNrKERVVUoiBdkLsHoAxWLpjppVAYKvNgdlmgYIvCHSuYMntCNqpYPaQSqsAlvMnVsuzGibmvvvWXSobuoTTFLOFRYNUpPbcCdcnGmZtrjOXbmaEzLWolqivoztmxsAaanRyepzhcvmoqBPCGeLMMTjeqRlvnpnvjeRlekCUAsRVNKPzSehvbwYFafCWtYQkHfkLjmVzNWyfoScMmrqFRmLeDLqaIWrpzEkTYiwrsuvDDJgEji -1120323700 -1249670559 -934544890
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -934544890
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntityShutdown received =     1
    Should Contain    ${output}    Name : SjdAnNGviaUNtZWdqBwEHQaRsOgDxGVLFzRvKxHRcZtPodLSURUAVMMzXRwmtbztZuwxXqBuPgyXmULroEVGxxEqjcyWvNhqxwlZnrVekFVtKCLahkNFxgMUkJRyVeIxuWNFQUuwCqRusKsPjyftHQpbVLrgVpxbBYeIKLDiKgrlbKqmbVWAKmiSnLYmMLXDgZWJUKOEffbjTdCckyLTnkfoXlWmdmUezwRkZMrKffNYdLbHFcGkvMjyLrQJZCGj
    Should Contain    ${output}    Identifier : 55.7348
    Should Contain    ${output}    Timestamp : YcCRHAFlpdFlDjTNrKERVVUoiBdkLsHoAxWLpjppVAYKvNgdlmgYIvCHSuYMntCNqpYPaQSqsAlvMnVsuzGibmvvvWXSobuoTTFLOFRYNUpPbcCdcnGmZtrjOXbmaEzLWolqivoztmxsAaanRyepzhcvmoqBPCGeLMMTjeqRlvnpnvjeRlekCUAsRVNKPzSehvbwYFafCWtYQkHfkLjmVzNWyfoScMmrqFRmLeDLqaIWrpzEkTYiwrsuvDDJgEji
    Should Contain    ${output}    Address : -1120323700
    Should Contain    ${output}    priority : -1249670559
    Should Contain    ${output}    priority : -934544890
