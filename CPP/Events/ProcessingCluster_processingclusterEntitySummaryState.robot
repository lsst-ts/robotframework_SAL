*** Settings ***
Documentation    ProcessingCluster_processingclusterEntitySummaryState sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    processingcluster
${component}    processingclusterEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send SykwHXnkHWCuXZuvvxbTgLRaGOhzxLOfVHFUGlNfurPVSmHnDUppRafzjNcwZFeeEbQhNfEsluIoqWuBWqQezrChTCprATOmRwEumykFKapUyRAhedcRMBzHNYiEgKBh 65.0816 ldkwSUYniaBhTBsBgXFDKFqlBlUDLBEPdbjRpmUNZuAIPdavkBWqtCNPQhphGNtDNNukmEOdZrOsEqOQlcYxGXuPWCgXpTLJuZTSFngjTHelxqgvRbJtTEJGgOZddHrdxvDeVeHnUTmReNYBMWQxkpYIMVxXqXHSVxEyelyVPpiGKhpZaDJedMOTMaHsQXlCRDAHlXrRAupTgELVijwtkCpIpSFyrscjJuwRYzZkhexRZiyxRefjOvehmwtzjMnn 1332755944 GlNmEhgZdsCswUmfLOHOXtrXIxWfykXhVnlnCTavabfSZTAwIbihNVwEKtUiXaplCSdcCIOnCxYGMIrVxDefgbrqawWbamXmkRcmVaYuDbSeCYFXvkBhDFbycgdrPmRP sQQeHYrmOXdsiWUgUDMJfEDPtpflUKGvgujiXGJZLNHycgQGGknxUBspLCanPmgxTkswREDfSQIbZWGDJqFlZVodUoLzZUUpNnvGrapiDoklmUkhBMmfUNXuTCVmbNwA vRIjsmCcQlFWRdchQHWPjCnhfMYlDqrMKMZOUqQjVdQKFgpZVEMijcsZdztbDrpWSXQFtvRwzDAxheduuQwSdMQFQpUrLPDztFZNHKWHpTDRTeRCYPKbYcpvzqlRWCSq GjZjxLsCnqJdiwCdHQqaMPfpCJGNPAhwLSSVbjQdGQMCXIKSGoHhiWocEochWmPuVcNvHwvpryEIvfwwQVjLkUzYxFAyOlqEIgLgxrtiOwUKwyptXMmsCkXYIdzQoSqi gEKrXwVbCDMrmTfFSwdQKMAYZbOpbGHNaixoKXqshwgeqHlnKNSOTifFEAImmKBKnRqafTCWxuSHHnNwHdscOWhZgRCtqsdrusfnlIVPJJDQTPvsEzuhdJRfzgGMNTJa 1417248378
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] processingcluster::logevent_processingclusterEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event processingclusterEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1417248378
    Log    ${output}
    Should Contain X Times    ${output}    === Event processingclusterEntitySummaryState received =     1
    Should Contain    ${output}    Name : SykwHXnkHWCuXZuvvxbTgLRaGOhzxLOfVHFUGlNfurPVSmHnDUppRafzjNcwZFeeEbQhNfEsluIoqWuBWqQezrChTCprATOmRwEumykFKapUyRAhedcRMBzHNYiEgKBh
    Should Contain    ${output}    Identifier : 65.0816
    Should Contain    ${output}    Timestamp : ldkwSUYniaBhTBsBgXFDKFqlBlUDLBEPdbjRpmUNZuAIPdavkBWqtCNPQhphGNtDNNukmEOdZrOsEqOQlcYxGXuPWCgXpTLJuZTSFngjTHelxqgvRbJtTEJGgOZddHrdxvDeVeHnUTmReNYBMWQxkpYIMVxXqXHSVxEyelyVPpiGKhpZaDJedMOTMaHsQXlCRDAHlXrRAupTgELVijwtkCpIpSFyrscjJuwRYzZkhexRZiyxRefjOvehmwtzjMnn
    Should Contain    ${output}    Address : 1332755944
    Should Contain    ${output}    CurrentState : GlNmEhgZdsCswUmfLOHOXtrXIxWfykXhVnlnCTavabfSZTAwIbihNVwEKtUiXaplCSdcCIOnCxYGMIrVxDefgbrqawWbamXmkRcmVaYuDbSeCYFXvkBhDFbycgdrPmRP
    Should Contain    ${output}    PreviousState : sQQeHYrmOXdsiWUgUDMJfEDPtpflUKGvgujiXGJZLNHycgQGGknxUBspLCanPmgxTkswREDfSQIbZWGDJqFlZVodUoLzZUUpNnvGrapiDoklmUkhBMmfUNXuTCVmbNwA
    Should Contain    ${output}    Executing : vRIjsmCcQlFWRdchQHWPjCnhfMYlDqrMKMZOUqQjVdQKFgpZVEMijcsZdztbDrpWSXQFtvRwzDAxheduuQwSdMQFQpUrLPDztFZNHKWHpTDRTeRCYPKbYcpvzqlRWCSq
    Should Contain    ${output}    CommandsAvailable : GjZjxLsCnqJdiwCdHQqaMPfpCJGNPAhwLSSVbjQdGQMCXIKSGoHhiWocEochWmPuVcNvHwvpryEIvfwwQVjLkUzYxFAyOlqEIgLgxrtiOwUKwyptXMmsCkXYIdzQoSqi
    Should Contain    ${output}    ConfigurationsAvailable : gEKrXwVbCDMrmTfFSwdQKMAYZbOpbGHNaixoKXqshwgeqHlnKNSOTifFEAImmKBKnRqafTCWxuSHHnNwHdscOWhZgRCtqsdrusfnlIVPJJDQTPvsEzuhdJRfzgGMNTJa
    Should Contain    ${output}    priority : 1417248378
