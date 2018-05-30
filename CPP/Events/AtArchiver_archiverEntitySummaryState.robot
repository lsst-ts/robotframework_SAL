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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send wbLxwfjEiKjgEVsHQCQhbStFZGXpXFhsruRhCjpoqxtTxJpbwnBjfuJFPVNRRRQPwQadxYhijhsxdfqCqGpEVzoCjnNxhyzJNZvDBATFtPLUKkvHeldyKsgnsXiMSXGk 62.8055 ZHWLtBgJEyptYQXekhPdCvUmXvjKzBGBabdarqwXRxmzeVsKuPaGGPTZQNlCtdhNJhqEsQMdhLjnagpRvDpRgJWZuYJwRQgeDszOHjYAEphyuPjyCUnHyBgXqCMfoaXCaCCHfRFkKhCBtFIzYXaXRRQkYYnKrrgHYMEXyQaIrOyZIYIyThMxDamwfXIVKetahiSIoxHakKDxLdUNJxMLFtXgRHOOHHbrmvAMohekhAWHuuQzqsaMSncwvMvAQCTg -1598208650 YhmQCLBrjTwCWYkFaILBgCvMIqzdfYHdmnKQXpnJnTPSvBTuQmxGBZuOuwhfGDfYitHqZFtAEuRugLNHCPShOFCJJLfMVZhbBSvZTdqrjGzAMeeDMPcpiJVRYKVDHDHR mXFzQuBIMljXqubiYzuarWjsapSrqfPSLvhfRuHRsvvdlhmOBfGLPRujaTClmYLgywRaIaTgBqHwmaPebOQQRSJPFBFcDxtWtGtKpkatCOrAZCRXCKtJIPIZlmWyLqYZ ppTeoNFzQwlHHniASCmzTVSZNjZnnaUNAlNuSKZsPOVSRWyrMgtQmLqOWrYKOkiRkCrKpQsAPKPTDEmdXTdEOxCutKLTWdfeUIqfgVCpXmIlaBUibEUrbcJFsVkqoNtM ufQlpkQtwrPOIXasUSWAYRnupAKdQSsqGMGQmKAnYpfEGvkAXnMjENPmOrxBGwkfCuSFXkbLcMhLJjPSMvltyryuTEkBVVCmpCTwdaeoltuHXiBHEWUfXbmkfIJYJrqI LyXOhwHdBKsQekLhciMmUQMvldLoYqpacWXdeLVEhabOeFlrCBIuffxhVFMDIfBzXBeexnmIIojmmaZWJJfCkKDHUCTsPYcfHqTMMkLgoePIOlVEnbkybGDDzNZinYuv 274686465
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atArchiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 274686465
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : wbLxwfjEiKjgEVsHQCQhbStFZGXpXFhsruRhCjpoqxtTxJpbwnBjfuJFPVNRRRQPwQadxYhijhsxdfqCqGpEVzoCjnNxhyzJNZvDBATFtPLUKkvHeldyKsgnsXiMSXGk
    Should Contain    ${output}    Identifier : 62.8055
    Should Contain    ${output}    Timestamp : ZHWLtBgJEyptYQXekhPdCvUmXvjKzBGBabdarqwXRxmzeVsKuPaGGPTZQNlCtdhNJhqEsQMdhLjnagpRvDpRgJWZuYJwRQgeDszOHjYAEphyuPjyCUnHyBgXqCMfoaXCaCCHfRFkKhCBtFIzYXaXRRQkYYnKrrgHYMEXyQaIrOyZIYIyThMxDamwfXIVKetahiSIoxHakKDxLdUNJxMLFtXgRHOOHHbrmvAMohekhAWHuuQzqsaMSncwvMvAQCTg
    Should Contain    ${output}    Address : -1598208650
    Should Contain    ${output}    CurrentState : YhmQCLBrjTwCWYkFaILBgCvMIqzdfYHdmnKQXpnJnTPSvBTuQmxGBZuOuwhfGDfYitHqZFtAEuRugLNHCPShOFCJJLfMVZhbBSvZTdqrjGzAMeeDMPcpiJVRYKVDHDHR
    Should Contain    ${output}    PreviousState : mXFzQuBIMljXqubiYzuarWjsapSrqfPSLvhfRuHRsvvdlhmOBfGLPRujaTClmYLgywRaIaTgBqHwmaPebOQQRSJPFBFcDxtWtGtKpkatCOrAZCRXCKtJIPIZlmWyLqYZ
    Should Contain    ${output}    Executing : ppTeoNFzQwlHHniASCmzTVSZNjZnnaUNAlNuSKZsPOVSRWyrMgtQmLqOWrYKOkiRkCrKpQsAPKPTDEmdXTdEOxCutKLTWdfeUIqfgVCpXmIlaBUibEUrbcJFsVkqoNtM
    Should Contain    ${output}    CommandsAvailable : ufQlpkQtwrPOIXasUSWAYRnupAKdQSsqGMGQmKAnYpfEGvkAXnMjENPmOrxBGwkfCuSFXkbLcMhLJjPSMvltyryuTEkBVVCmpCTwdaeoltuHXiBHEWUfXbmkfIJYJrqI
    Should Contain    ${output}    ConfigurationsAvailable : LyXOhwHdBKsQekLhciMmUQMvldLoYqpacWXdeLVEhabOeFlrCBIuffxhVFMDIfBzXBeexnmIIojmmaZWJJfCkKDHUCTsPYcfHqTMMkLgoePIOlVEnbkybGDDzNZinYuv
    Should Contain    ${output}    priority : 274686465
