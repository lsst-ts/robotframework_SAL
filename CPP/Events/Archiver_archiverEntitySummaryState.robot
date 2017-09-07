*** Settings ***
Documentation    Archiver_archiverEntitySummaryState sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    archiver
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send JXeSFHuJgenKvGRnwrJpWmpqnbQBvFFThHZtLwnwuqHpYoOEyPSmsabfqcxqjtiKjLJZTHTdXyJsHicURESKouREbrsAyeGwSldzSUtkVmsSmSSRjEDEEUMgXnqUAkTr 3.0425 cKdWFlvZJCNJidTqiSbJCmrsnxRClxsaMXUcfYpKcDCHODaoRNInavkLfuqlmISGTsGSowCtzXzSWTFIdhBQbawSXwrDbcrbkVHtQsZpDwvrsmluCAESsBtmXwAuNSNfZLvJMeJgskldNzLXbDtVRVUjeJmUrFRalaCZDgqYThKGpyxFsqKnwLzYBtEwXyzyEJaPxTNvsQGyzbrFtTEnBQZZKKMBvYudQkoxoxiNGqFUEnOpIcCbokySBSxdBPFQ -582405565 rwoweiKwwlMHslVcvvxisFZckemsqnYNMsSNdUROdvZRTxBDZMFCSMxQhTnaiJNRqyHubhdfpmxNvElUjUMUFfWbirGOpsOFlSOzAhnyemRoAsiMGMpSDtElLkyOcGAG iyaYHITwVKfQjbPPrGUPkxKYwDAORBPlwWhteWCxtBYVDswngmauiHvXQTMiLWLJtXyYGGZHNVavbIBLDlzjorAXxxEcvjBPQOjXEJbBLWUdciCWftouDpYBIMOSATcR HKSEMiaFjIeidWTeriiGvFHuOcjeqbFJfJkvXaRZEgsvVUHkBwkIymULXRfHQGQIFxqGmbzchkOuJNKrDiJmQioePYXNRFkpgopfdVlmBNuJeJrrFBSBNrGGJRYuZgoU MLXjAAOzEebimFUTQUVCzrLasORdJWQrMzXauVvtrUVHUzsHORxgGBWXEMVdFdHsSJVzxoyGtZXdEOMiBGUzuZeNKaUutpKUIXcexIzngFUvMgpxkUjqzggFpjBzbGkE fbdGpdBnxEGjYFbGbhKJPmvHQFvXevJAZUVWKMxaqotOnAkesgNLUZnukcBwcYxYdiwoKeupDtJDFWxAmPVhOvoTdqPAKvQceetdEwzQBFYCcyulbZmyVOErhoRXzgqz -1074548564
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1074548564
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : JXeSFHuJgenKvGRnwrJpWmpqnbQBvFFThHZtLwnwuqHpYoOEyPSmsabfqcxqjtiKjLJZTHTdXyJsHicURESKouREbrsAyeGwSldzSUtkVmsSmSSRjEDEEUMgXnqUAkTr
    Should Contain    ${output}    Identifier : 3.0425
    Should Contain    ${output}    Timestamp : cKdWFlvZJCNJidTqiSbJCmrsnxRClxsaMXUcfYpKcDCHODaoRNInavkLfuqlmISGTsGSowCtzXzSWTFIdhBQbawSXwrDbcrbkVHtQsZpDwvrsmluCAESsBtmXwAuNSNfZLvJMeJgskldNzLXbDtVRVUjeJmUrFRalaCZDgqYThKGpyxFsqKnwLzYBtEwXyzyEJaPxTNvsQGyzbrFtTEnBQZZKKMBvYudQkoxoxiNGqFUEnOpIcCbokySBSxdBPFQ
    Should Contain    ${output}    Address : -582405565
    Should Contain    ${output}    CurrentState : rwoweiKwwlMHslVcvvxisFZckemsqnYNMsSNdUROdvZRTxBDZMFCSMxQhTnaiJNRqyHubhdfpmxNvElUjUMUFfWbirGOpsOFlSOzAhnyemRoAsiMGMpSDtElLkyOcGAG
    Should Contain    ${output}    PreviousState : iyaYHITwVKfQjbPPrGUPkxKYwDAORBPlwWhteWCxtBYVDswngmauiHvXQTMiLWLJtXyYGGZHNVavbIBLDlzjorAXxxEcvjBPQOjXEJbBLWUdciCWftouDpYBIMOSATcR
    Should Contain    ${output}    Executing : HKSEMiaFjIeidWTeriiGvFHuOcjeqbFJfJkvXaRZEgsvVUHkBwkIymULXRfHQGQIFxqGmbzchkOuJNKrDiJmQioePYXNRFkpgopfdVlmBNuJeJrrFBSBNrGGJRYuZgoU
    Should Contain    ${output}    CommandsAvailable : MLXjAAOzEebimFUTQUVCzrLasORdJWQrMzXauVvtrUVHUzsHORxgGBWXEMVdFdHsSJVzxoyGtZXdEOMiBGUzuZeNKaUutpKUIXcexIzngFUvMgpxkUjqzggFpjBzbGkE
    Should Contain    ${output}    ConfigurationsAvailable : fbdGpdBnxEGjYFbGbhKJPmvHQFvXevJAZUVWKMxaqotOnAkesgNLUZnukcBwcYxYdiwoKeupDtJDFWxAmPVhOvoTdqPAKvQceetdEwzQBFYCcyulbZmyVOErhoRXzgqz
    Should Contain    ${output}    priority : -1074548564
