*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntitySummaryState sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send VhHsoVevOYxVxYtdYvLCRvqcjcdixmISTqbanUrtqBQLJTYrQWtLZVzpiGYmDWKrwdBbPawUrgrxAnLazkgcIfhWHsKCzzNvnUNjeHhcYwXOvMxTUXwDlajyMiXpeLpGLyOHxLzSQluWofYskOzYFgjSyTyGdcwLtEunDFrEblXARaHXSybUvIrsRaURZjGfkYhVmOhYmjzDVfjWenhMHRgXmEeMIrpQTEOoprCxwgFmjQqsFHQIDrYyLKjILohx 9.774 HLNMPpUUgcxtcJwaKuIVYsWJbIEkFObAJXPKDjFhiMfFrgheyshhGqCgqAiqYkkDwDQGbkpnVoyJeLYSuwfTUkeHZTxvrKEJcVixsMofpotoqamLxIVZYiszRzIGOPwsboHbKFqUINjjMnnlrtUQolGFRBAooUGjVemRbtDCnSyhIJZvvBrfOCEnJQGjjSQsgGpeZfmVbzkLuvegPiEKNBgDhKTPiocJhaACvtQZNQCWOySUOUmcZSahSIzfxSuF 217460255 rXmKaiuqWLTJpqWWsgzcTtAtzakHZmEDinaaOuArhEGPsznmNHwFNtGaCBGtaagVVvceWzqzqVaKAnEebqEdpstrIKFlinYXuhLipdyvIJlYsBWszKGTqnMZOEGMeRZmyYuVwixgYSGLjpkKDoQKLravLVEDuJxFURmrxajKrSQaAJFyWVtuUtVOlOOJXtKclGsjWljYBGXmMARXbIRgfgUzcFtwTLblBxUaWOgefIVaJETZaTnPlKoIMNsDhrBx WTPcoRdpWnVrtKzBzaZJzhfhIHVxzSLPoSwmGytnEoPFrMLYpUFTYplvcIiXPlKKEgLgEjIrcwjAozzZaGsEHafMCbmjjYwLmaWdsvPwNLFGVvYYErYeBvpZaUudKdqyeMPuASmJobXliXWSkfjpJRoXLCutWWGZaVrOvkFtSCtxhgDoLHkMAHkASBVmqKklUDAwceJgfQLOyJucZrfvHioRygPXBjHRKGUzUHrAiwLdZsOaWnxbqewwBlIjpTMi rqRBrfUdFnlzCKvHtjfsHDLPvLkFKBoJHbKFKaeGxwALZyMNzPUJYOLATodvEZLrOMdLxIgDYTWnnVvQrymMRAFSlCdnEGallsjaolEiSHqBqYMtJFvosVNATJDEfeyUTkHfvOqqOwSmXskEitknFVkKYEZjlRPgwNFjrBlVviNyLaKqdgmlBecSJgwwUwGeqYRRnOdvEVsKrTUZINlUgCOOlHiLuIPMVuJgweqnqwYckUFgKHWNvKfrDeOYuZKB AUDCIEkxcOxfLFOxGesvWWVSAbiTQejYyyMOklTKpqTypFaHqBGIgRSYClfeDIFWnNHIkqAgBmHfLpGltFZdkpDTkVtbXewlTJOUgsiQhQCrfquYFQFKgILiowiELPdpMDDCkWJLtzTwDeskczEhopPrbgyfTIxBzoKArsJicidCowGTqIzHkzyoQSZGDPxEAFPlcQcBIorMswfJxLCrOsvPCshKGdJWVzsaehmYzjOZNjvKzaoJvmZgQbjNuNfm XwmzGJqcEEVGhbYXzCNyYcVRWYhxfcvfVNQTEkXFTsiOtwjRLTxksBtOrkEULrxeIlaWGCDugeEmBBNbsniRvQMJfQEMRBwfYjsjPPwnYowdcoHEgugSBJYdCWNRcKGzyhqGkIhbtUDqjwoaouinPNbCNScTXcOsaOkBiOMcGyrpmbPdXRwYrpIgCeowZJcovHBiUnXAuUdoYAyseWqvTIkfDBqyTfJlZRnMLcDMWlZcXWCAmuuSHMOuITvgEfQI -55989333 734512750
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 734512750
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : VhHsoVevOYxVxYtdYvLCRvqcjcdixmISTqbanUrtqBQLJTYrQWtLZVzpiGYmDWKrwdBbPawUrgrxAnLazkgcIfhWHsKCzzNvnUNjeHhcYwXOvMxTUXwDlajyMiXpeLpGLyOHxLzSQluWofYskOzYFgjSyTyGdcwLtEunDFrEblXARaHXSybUvIrsRaURZjGfkYhVmOhYmjzDVfjWenhMHRgXmEeMIrpQTEOoprCxwgFmjQqsFHQIDrYyLKjILohx
    Should Contain    ${output}    Identifier : 9.774
    Should Contain    ${output}    Timestamp : HLNMPpUUgcxtcJwaKuIVYsWJbIEkFObAJXPKDjFhiMfFrgheyshhGqCgqAiqYkkDwDQGbkpnVoyJeLYSuwfTUkeHZTxvrKEJcVixsMofpotoqamLxIVZYiszRzIGOPwsboHbKFqUINjjMnnlrtUQolGFRBAooUGjVemRbtDCnSyhIJZvvBrfOCEnJQGjjSQsgGpeZfmVbzkLuvegPiEKNBgDhKTPiocJhaACvtQZNQCWOySUOUmcZSahSIzfxSuF
    Should Contain    ${output}    Address : 217460255
    Should Contain    ${output}    CurrentState : rXmKaiuqWLTJpqWWsgzcTtAtzakHZmEDinaaOuArhEGPsznmNHwFNtGaCBGtaagVVvceWzqzqVaKAnEebqEdpstrIKFlinYXuhLipdyvIJlYsBWszKGTqnMZOEGMeRZmyYuVwixgYSGLjpkKDoQKLravLVEDuJxFURmrxajKrSQaAJFyWVtuUtVOlOOJXtKclGsjWljYBGXmMARXbIRgfgUzcFtwTLblBxUaWOgefIVaJETZaTnPlKoIMNsDhrBx
    Should Contain    ${output}    PreviousState : WTPcoRdpWnVrtKzBzaZJzhfhIHVxzSLPoSwmGytnEoPFrMLYpUFTYplvcIiXPlKKEgLgEjIrcwjAozzZaGsEHafMCbmjjYwLmaWdsvPwNLFGVvYYErYeBvpZaUudKdqyeMPuASmJobXliXWSkfjpJRoXLCutWWGZaVrOvkFtSCtxhgDoLHkMAHkASBVmqKklUDAwceJgfQLOyJucZrfvHioRygPXBjHRKGUzUHrAiwLdZsOaWnxbqewwBlIjpTMi
    Should Contain    ${output}    Executing : rqRBrfUdFnlzCKvHtjfsHDLPvLkFKBoJHbKFKaeGxwALZyMNzPUJYOLATodvEZLrOMdLxIgDYTWnnVvQrymMRAFSlCdnEGallsjaolEiSHqBqYMtJFvosVNATJDEfeyUTkHfvOqqOwSmXskEitknFVkKYEZjlRPgwNFjrBlVviNyLaKqdgmlBecSJgwwUwGeqYRRnOdvEVsKrTUZINlUgCOOlHiLuIPMVuJgweqnqwYckUFgKHWNvKfrDeOYuZKB
    Should Contain    ${output}    CommandsAvailable : AUDCIEkxcOxfLFOxGesvWWVSAbiTQejYyyMOklTKpqTypFaHqBGIgRSYClfeDIFWnNHIkqAgBmHfLpGltFZdkpDTkVtbXewlTJOUgsiQhQCrfquYFQFKgILiowiELPdpMDDCkWJLtzTwDeskczEhopPrbgyfTIxBzoKArsJicidCowGTqIzHkzyoQSZGDPxEAFPlcQcBIorMswfJxLCrOsvPCshKGdJWVzsaehmYzjOZNjvKzaoJvmZgQbjNuNfm
    Should Contain    ${output}    ConfigurationsAvailable : XwmzGJqcEEVGhbYXzCNyYcVRWYhxfcvfVNQTEkXFTsiOtwjRLTxksBtOrkEULrxeIlaWGCDugeEmBBNbsniRvQMJfQEMRBwfYjsjPPwnYowdcoHEgugSBJYdCWNRcKGzyhqGkIhbtUDqjwoaouinPNbCNScTXcOsaOkBiOMcGyrpmbPdXRwYrpIgCeowZJcovHBiUnXAuUdoYAyseWqvTIkfDBqyTfJlZRnMLcDMWlZcXWCAmuuSHMOuITvgEfQI
    Should Contain    ${output}    priority : -55989333
    Should Contain    ${output}    priority : 734512750
