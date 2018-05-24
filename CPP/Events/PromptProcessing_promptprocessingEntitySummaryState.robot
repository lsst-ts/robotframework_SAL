*** Settings ***
Documentation    PromptProcessing_promptprocessingEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2633
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptprocessing
${component}    promptprocessingEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send wRmYiJAZKehwBBHeYsOChumLOSZKfaAdpVGrciyCUuKDvgeaqeSLhBtVQNAjmDCuhcDJRzUGaYQKGOMrfEfNwESnjulZhYWUdrnwBmRprqRICQUbqPWcGGkWASrEvTsslSKDLRcXYxgIOJMQCwdoDsqnhURpoMTzUPjuuMtnxmapxFjYmsXgGCHxaEPFfkZOZGfwFJCkzRjLdzBgLWOycDOitarSeWKMizVxuSRVlgPGpDclqjBQkDeqpGEXMlLk 89.3348 UwblFwWzIUhnzewHRSsLiJilpjGYCYFUiLlJbQBtbbmcKebYQeRnixUfqXqneDhcSARhouqutDlzvvUXzJNtAGsWVyLGNNiLWURqetEELQEeesWMDjKTTaDmVErBTJoaIVOhaznJeGwoVTWhRQVmdqkeooJzMeeAPHFpzWiCnBjRCamRxZNshCJCzDxinGAKWPkqVVIOhdzJBOdsZuKFHQiuYOQujoUvEGvDRGwDOvsXFxZYyaTjwxScJNOIXlde -826240089 aqBKzdXnZzwqEzYMgqQHczWtoGIgGLceQJaVRYezXPmBsFLCsOplqlzzvQibKTrahZipEVadMKHlTLgXrGZRTMSKAOZjqAMgegBJJAFAPXmoLsIvEqoJeNQctSTVhhZvORKpsudqtabBMhNRCfNfoluJptDvCTrjApfCoCKUVRGlGuTPcYdNTNTFPGlfVtUVxhkkAMhjUZgFPVCTtZeKaoyZBLICjUToPCuecvLFaIGOIQCTROriWJBeAASZGbvq rNKQxXNkXidVButvssAnZaTLrdUtmmFWtImIODKfsKBWxgKiNekcbESAYhRuuTdECLkvlKALORimlQfigkQXJPlthtCKiuUTAAiuhwuhvIudXHKjAAjQUBfLWqALDHpLdpZuLeCBlmPBJeweEyVkLjPOFHaQwnFxgudrlyfGxgFlBzZfNKtfwOIRIpwEhAgqQeftddgqBpbOtMeWdbkwwPWhSKwjLhpDTjzNMdFLxdjOddVOtzjYavhgddZiovrx BGKhHAiEPSreGTleUApdkLLYGIuqZSXJFJOmQBeUvZlOgWrxwLEhadnaEXeGsNGsKXqocRUAocHPdUSSrrYLCkewBdfaImNjPMkROSitZrTnAeqWLdvcVszuAapuyGeXKXKppOAuAsBOGhzivkSvZArSAuprPayanCIREVOVdtiuZLenpyPVJWZgLPhHyuhgGvulHvSaTfKynEumGcfsnwaiBVsYvURLcuYZjMghOBJkGvJsWHkUIqodjHZcjxwx BeWnHWOWFVeCxsgKCYbNGDerdjOLnDNyhzhlSijUJMGBVVpkBGfKBYlJCIDkbzgQmeXTgCLwjmKJXeCosKFiqEkEDbgzbEYfYoXAeKbXJerKrhygunicOwYbBBLzGqhiyJXMHYQPXNPYcXiJwFpJCrLHBdcrnWowVDOqmYNSPcjBHLPokFjhAJcZpKMOxIjNrUTRLurnrUNIptbbYKpGgsIXqSakAiqgpkpacrpwEIaWVnotHbeYTImQzkBvTvDw MXYDywDdAKjndxKNNXFOWymhenBQPfXcQwTMPSCUHzUAhfKuFWrOKLfSxsEAusPCPYoVOTjHRqoCxeDtCwiVwnwOQApiKznvMfSDCuCXJwEkYWmQbRtTNqcPyTpgSJpBxwoETIZoBwVKNPKHgYdRbsWvmDNthGUwlpmutsUvDKRqeWujRHHbiIIaxOdhDwvtJuuWuzgCeJSVoHaAjHKDMPEqfxPVtDmYAzAtoOdVyTyEVnsmPEbDQNtuFGGUMXaF -417587736
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptprocessing::logevent_promptprocessingEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -417587736
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntitySummaryState received =     1
    Should Contain    ${output}    Name : wRmYiJAZKehwBBHeYsOChumLOSZKfaAdpVGrciyCUuKDvgeaqeSLhBtVQNAjmDCuhcDJRzUGaYQKGOMrfEfNwESnjulZhYWUdrnwBmRprqRICQUbqPWcGGkWASrEvTsslSKDLRcXYxgIOJMQCwdoDsqnhURpoMTzUPjuuMtnxmapxFjYmsXgGCHxaEPFfkZOZGfwFJCkzRjLdzBgLWOycDOitarSeWKMizVxuSRVlgPGpDclqjBQkDeqpGEXMlLk
    Should Contain    ${output}    Identifier : 89.3348
    Should Contain    ${output}    Timestamp : UwblFwWzIUhnzewHRSsLiJilpjGYCYFUiLlJbQBtbbmcKebYQeRnixUfqXqneDhcSARhouqutDlzvvUXzJNtAGsWVyLGNNiLWURqetEELQEeesWMDjKTTaDmVErBTJoaIVOhaznJeGwoVTWhRQVmdqkeooJzMeeAPHFpzWiCnBjRCamRxZNshCJCzDxinGAKWPkqVVIOhdzJBOdsZuKFHQiuYOQujoUvEGvDRGwDOvsXFxZYyaTjwxScJNOIXlde
    Should Contain    ${output}    Address : -826240089
    Should Contain    ${output}    CurrentState : aqBKzdXnZzwqEzYMgqQHczWtoGIgGLceQJaVRYezXPmBsFLCsOplqlzzvQibKTrahZipEVadMKHlTLgXrGZRTMSKAOZjqAMgegBJJAFAPXmoLsIvEqoJeNQctSTVhhZvORKpsudqtabBMhNRCfNfoluJptDvCTrjApfCoCKUVRGlGuTPcYdNTNTFPGlfVtUVxhkkAMhjUZgFPVCTtZeKaoyZBLICjUToPCuecvLFaIGOIQCTROriWJBeAASZGbvq
    Should Contain    ${output}    PreviousState : rNKQxXNkXidVButvssAnZaTLrdUtmmFWtImIODKfsKBWxgKiNekcbESAYhRuuTdECLkvlKALORimlQfigkQXJPlthtCKiuUTAAiuhwuhvIudXHKjAAjQUBfLWqALDHpLdpZuLeCBlmPBJeweEyVkLjPOFHaQwnFxgudrlyfGxgFlBzZfNKtfwOIRIpwEhAgqQeftddgqBpbOtMeWdbkwwPWhSKwjLhpDTjzNMdFLxdjOddVOtzjYavhgddZiovrx
    Should Contain    ${output}    Executing : BGKhHAiEPSreGTleUApdkLLYGIuqZSXJFJOmQBeUvZlOgWrxwLEhadnaEXeGsNGsKXqocRUAocHPdUSSrrYLCkewBdfaImNjPMkROSitZrTnAeqWLdvcVszuAapuyGeXKXKppOAuAsBOGhzivkSvZArSAuprPayanCIREVOVdtiuZLenpyPVJWZgLPhHyuhgGvulHvSaTfKynEumGcfsnwaiBVsYvURLcuYZjMghOBJkGvJsWHkUIqodjHZcjxwx
    Should Contain    ${output}    CommandsAvailable : BeWnHWOWFVeCxsgKCYbNGDerdjOLnDNyhzhlSijUJMGBVVpkBGfKBYlJCIDkbzgQmeXTgCLwjmKJXeCosKFiqEkEDbgzbEYfYoXAeKbXJerKrhygunicOwYbBBLzGqhiyJXMHYQPXNPYcXiJwFpJCrLHBdcrnWowVDOqmYNSPcjBHLPokFjhAJcZpKMOxIjNrUTRLurnrUNIptbbYKpGgsIXqSakAiqgpkpacrpwEIaWVnotHbeYTImQzkBvTvDw
    Should Contain    ${output}    ConfigurationsAvailable : MXYDywDdAKjndxKNNXFOWymhenBQPfXcQwTMPSCUHzUAhfKuFWrOKLfSxsEAusPCPYoVOTjHRqoCxeDtCwiVwnwOQApiKznvMfSDCuCXJwEkYWmQbRtTNqcPyTpgSJpBxwoETIZoBwVKNPKHgYdRbsWvmDNthGUwlpmutsUvDKRqeWujRHHbiIIaxOdhDwvtJuuWuzgCeJSVoHaAjHKDMPEqfxPVtDmYAzAtoOdVyTyEVnsmPEbDQNtuFGGUMXaF
    Should Contain    ${output}    priority : -417587736
