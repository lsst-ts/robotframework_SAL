*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntitySummaryState sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntitySummaryState
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Name Identifier Timestamp Address CurrentState PreviousState Executing CommandsAvailable ConfigurationsAvailable priority priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py ihiAbMWACGNbIdjYLjLurhXxFpMAPohIlxNZCRxFOlFbtwDfRREkCjKEwoepQEzIzgQGatlhjcPXQCBZsmHydpJYBWqYQrdANyhjOOIEcyENVEyRCwEGDDgKihLEdLyjkddMeHgdKnxxLZCOyMkhnrckTbucDheLkowBvsPMGmhqEboXATmbOayJqjtnkeaJYsfiYNBlGFyHBsmMNXRiJbmTzRsEmTcBxsBgDcvLwUtcvOogYaeuWWEnfBroNFew 52.1541 VBMHitURUiaKjsJusswwKzMBYJCljEiZXEfkhrYRkjUXwsDUfFhpnZHOzLywEjAbnPowfEHDttaYFuhOyyZykxlqUmWNmLmqZHPdOOTNAxktxIWaVtJyTnxAsUOOOOyiRAwfRbTzLCoysMAvmoJFqepTKwBhRjPoHHaAvfTwoDenMUOIHFMMhpcsDmvHVlLXsIFoRJSTlSOuKQethNgplECxecJDnuuEXKyWYydnvBPzrPAPtnDBSZnbhqDhFLzO -944409660 kMDuYxQymNfGlNYtyUkqlBkhWZCRLLorlZSYlbbVmEvqChtHlkfJJLAqbZkswcBzjpadhleotFWlPcqCFKIjwtgqSmarZuicOaTRykBJxgkJfeZNPWSJilqOwNtNioyUWfamcRbPGSEiCuOVhISEpIgSawaYifIIkprDpDjErbrZiRfbXbxUDCvIubFqSBYJVvmSUuZYNYWYQimqgDXLbXYLVlzbCViPRaDXZDrlPWKJzystWSvpISAIAXWeikfs ZFjkxuxdQeniWlyVDJcCzvjZtGKCtjWJvuXWozRRabUzAqTpeHhyHgbMKQDkdyCaDViHdVTooShzUBYPvmZAisNEdJBsDOzhMWBswLNzIrrNyvtOeaskAmaVqlOZLOILQUUwOllcgOkERBawCRnQgJcUewGIqagCbliAVnUNiTESenHSTHCTPnrynZkFpeSZpSJxKrvFNEndjXQyutaHbGXvksCzCIJkwLffSqomlQyLYiMHEBRgYgWSylGOQNyd sEzHqzOFPwElCJAsMfIdLICTaLtDRyrSmIZEOeUDSGeorgfrmSMYMQJLzMEsAeYxNYTMDJBwjOOAXhtEdsfWjFQfChMcUyPgOREypUFyQmiMboevpIpKICXCQZhpLQVSBLLMbrdzBRwMeNCrpsKrDnTmBokgdFVCxzgerhrHDHmHLXuEmbJWZblMUNMAwyeSfnTkzBbYmIMFBWPQULZsWztHMnQQNJtzgNScqQyLQeLpptjWxPRXKdmTfhXwaQRJ ItWVOGLaHlHlUnGWhRTnliyWFDvYvjuYirdNOTGKIDuLviUeDrxZnzNNtBEbZddDdZEmEswUkZhDAdljWoZmPdPRQxWGZGmIjUSXgxNoyxpwFiFTbIjCxJNBeINsrpTQPfHUIlylpZzwxlEujaiFEgwuAEMxJKkfKFAXpTxIlmZEYdPincWqswJLultZYvGrWgfgepQcrKyvVsvnAMIklkGhQgwsBWwhOFOabOzBiQgPyKAKqpGvdgtEECPsSgSY KQdyAkuBROsUvfOCncfcULdcTAtpcsowBdOnBpIQdwrofVqfvPUokUInPsSUbScWZKHDMavhzCWJaCjxsEYGdiaMSVlNPxVEPPKBCPtMhNrkLcrFRcQGRdBCekcUdPEXXbEHJodeJTjICPyKVzdPAKDrBWIwfoxFfHPheUbvmNbLTlaaYcXuAcFrdVHaBaQZhzLSDQBGBADHehCMtYBrgZzsmhfGXFKqMUHkyCGOpdYXfMnEeCQOMwmtkgGILyTn -747391801 -280677648
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
