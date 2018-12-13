*** Settings ***
Documentation    ATPneumatics_ communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ATPneumatics
${timeout}    30s

*** Test Cases ***
Verify settingVersions Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log

Start settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_settingVersions_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event settingVersions logger ready

Start settingVersions Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_settingVersions_send lfkfUiYRhzXIDvwjpQjiHVvUxFUCUzmBfkVikEvksQlIGWxTBPtWbipVfYQSBThQCnotrQzMnBepVBhqUpqSCqPWrVXbKsQXpchBmznjZhVPNOjoCnrGLZCQxbIpLKYvaSwfPimZxvAwoUwzxXRmfYhVFVuAADLTRdtukMpBHqLVVxYDxrrtxGVdbDfLjNFgIFzCXMMVVBApWdwWzfGBuArkwOElvUyAQdDvXtfdiIPsQwqvMeHnuzFXcZCWqIeJ rUovIHooFasugxHVRjktrutsYwGqkWoTYWvMPmFiwqGpkeTBzFkbqDSTUgADYqBKcDuPVhjEsCAehmdjdvLsaJhmKsdsuXRTHFzujgkolcDbWPXJrcXfnTOJbHLHHnYnokYqmIcOuQzGPsjdvvOFfdSLAPPHroTLtNUIeYyUDTRAROtbBAejCDuIeYvBLXpHkHlmWAuTLazPMkfkNQroWYDYZFVjcOarDDwWAfbvytEwhbaoIcROLVPQpUkygoly 541131066
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATPneumatics::logevent_settingVersions_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event settingVersions generated =

Read settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 541131066
    Log    ${output}
    Should Contain X Times    ${output}    === Event settingVersions received =     1
    Should Contain    ${output}    recommendedSettingsVersion : lfkfUiYRhzXIDvwjpQjiHVvUxFUCUzmBfkVikEvksQlIGWxTBPtWbipVfYQSBThQCnotrQzMnBepVBhqUpqSCqPWrVXbKsQXpchBmznjZhVPNOjoCnrGLZCQxbIpLKYvaSwfPimZxvAwoUwzxXRmfYhVFVuAADLTRdtukMpBHqLVVxYDxrrtxGVdbDfLjNFgIFzCXMMVVBApWdwWzfGBuArkwOElvUyAQdDvXtfdiIPsQwqvMeHnuzFXcZCWqIeJ
    Should Contain    ${output}    recommendedSettingsLabels : rUovIHooFasugxHVRjktrutsYwGqkWoTYWvMPmFiwqGpkeTBzFkbqDSTUgADYqBKcDuPVhjEsCAehmdjdvLsaJhmKsdsuXRTHFzujgkolcDbWPXJrcXfnTOJbHLHHnYnokYqmIcOuQzGPsjdvvOFfdSLAPPHroTLtNUIeYyUDTRAROtbBAejCDuIeYvBLXpHkHlmWAuTLazPMkfkNQroWYDYZFVjcOarDDwWAfbvytEwhbaoIcROLVPQpUkygoly
    Should Contain    ${output}    priority : 541131066

Terminate settingVersions Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify errorCode Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log

Start errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_errorCode_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event errorCode logger ready

Start errorCode Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_errorCode_send 859522921 MrGcuWYsnPLksXisnTnRoXyVaZOiVsCgbdykAoFMnpZGSsJXPCCOeLZclSyHzMCgCCchbgpCHlrHntoceHardmMEDdjuVcqNaMuNfwRueMxDlptxMCzTXXgLPxjqzZmtYXBMPlfNspwrKqtreNOXcMXklWmsDhCeDALNDqhZitpKjQStHJdjcSvSwxywBLtOUKWpaizjHcKoYWKJbAGscBKFvcpdqxtkvfRrGGjHdJszZHpkISbXMjhrHftcAbtoRkFwqmwkfYoAbvvuakBAwaChcwNpTRURjZJHnGzmMQsxEaDCWtpXNHxzFIzhKOsFtyIgWBjEhOMRnKSJxpOjUWHouftBPVOCjxldDngOOEhcpJUfqOxZKATUIRoOpzPAdOobkSErtDLDMTvBAbWueTwPorigodJcKDIzsIGfTHCQhGLZERXDYtNgtYuiEkYzgsiFOytDPKTaldzOqgDjqylLicFiJ OkJswBhTFBttBhGBSBjMGidrDamUDjleIZcIDTTuftCugIkNKMxcjumUbGvteoxuuqmZRyUglZjIkLyCbPoCNbHbhWmiXLKFscjjzhHbOukAHdAlLbkSDIDadUtegAPRAQMLXwPmspnezmEyiMyXGUCGDTFxwinkPhWJJxafpoBjVHcOEJTjmqgsIgRTGfxgCBiphbUODcLuOAiFlhIzUAKSpVJKnNityMCxLVdkFcJSdXhVVIpYhalRFRSefZTDHbSoFpLDMRqAExomKeynwgBTVcrJcOAlXidrDOwbcGmypBAmEoQDIWLOgtXVUYLYTyFrJsYGWTAXtYCldQOPleMHfuqwdWwPxLyupTbioXeUVhpyiFWwQYvpjpWIauTghtglMpTjbBDvlhGmvulSKcMSzLDpwNsEDFLWbZgEnNQIxvFnZJpbzNzoJXiTLGXeYymPHVIsjPSOYuRbHgskJSKWAbPoDKvKiYakmPLmfILPTybNkLJokwkfcOTudBkFBgxWSqziuPaoLsNDsWsXsTHjVDDayrgmxgbRURqavxEZGDwXdKfHFYuInNLlYsLVknSrShjadmYDUIFMDYqeHwbYbXLwzCfavmmJmlEjLqcNXjncWkTKuXdQvPqZRvcPfhJVSjDoxFKoSARrxoPZKFAZCTuviUFcTfUiOcvKXvnEfpkqmKQahtzixkHeAQiYfnklSOSWezDliMFyUxolc -1317397916
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATPneumatics::logevent_errorCode_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event errorCode generated =

Read errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1317397916
    Log    ${output}
    Should Contain X Times    ${output}    === Event errorCode received =     1
    Should Contain    ${output}    errorCode : 859522921
    Should Contain    ${output}    errorReport : MrGcuWYsnPLksXisnTnRoXyVaZOiVsCgbdykAoFMnpZGSsJXPCCOeLZclSyHzMCgCCchbgpCHlrHntoceHardmMEDdjuVcqNaMuNfwRueMxDlptxMCzTXXgLPxjqzZmtYXBMPlfNspwrKqtreNOXcMXklWmsDhCeDALNDqhZitpKjQStHJdjcSvSwxywBLtOUKWpaizjHcKoYWKJbAGscBKFvcpdqxtkvfRrGGjHdJszZHpkISbXMjhrHftcAbtoRkFwqmwkfYoAbvvuakBAwaChcwNpTRURjZJHnGzmMQsxEaDCWtpXNHxzFIzhKOsFtyIgWBjEhOMRnKSJxpOjUWHouftBPVOCjxldDngOOEhcpJUfqOxZKATUIRoOpzPAdOobkSErtDLDMTvBAbWueTwPorigodJcKDIzsIGfTHCQhGLZERXDYtNgtYuiEkYzgsiFOytDPKTaldzOqgDjqylLicFiJ
    Should Contain    ${output}    traceback : OkJswBhTFBttBhGBSBjMGidrDamUDjleIZcIDTTuftCugIkNKMxcjumUbGvteoxuuqmZRyUglZjIkLyCbPoCNbHbhWmiXLKFscjjzhHbOukAHdAlLbkSDIDadUtegAPRAQMLXwPmspnezmEyiMyXGUCGDTFxwinkPhWJJxafpoBjVHcOEJTjmqgsIgRTGfxgCBiphbUODcLuOAiFlhIzUAKSpVJKnNityMCxLVdkFcJSdXhVVIpYhalRFRSefZTDHbSoFpLDMRqAExomKeynwgBTVcrJcOAlXidrDOwbcGmypBAmEoQDIWLOgtXVUYLYTyFrJsYGWTAXtYCldQOPleMHfuqwdWwPxLyupTbioXeUVhpyiFWwQYvpjpWIauTghtglMpTjbBDvlhGmvulSKcMSzLDpwNsEDFLWbZgEnNQIxvFnZJpbzNzoJXiTLGXeYymPHVIsjPSOYuRbHgskJSKWAbPoDKvKiYakmPLmfILPTybNkLJokwkfcOTudBkFBgxWSqziuPaoLsNDsWsXsTHjVDDayrgmxgbRURqavxEZGDwXdKfHFYuInNLlYsLVknSrShjadmYDUIFMDYqeHwbYbXLwzCfavmmJmlEjLqcNXjncWkTKuXdQvPqZRvcPfhJVSjDoxFKoSARrxoPZKFAZCTuviUFcTfUiOcvKXvnEfpkqmKQahtzixkHeAQiYfnklSOSWezDliMFyUxolc
    Should Contain    ${output}    priority : -1317397916

Terminate errorCode Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify summaryState Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log

Start summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_summaryState_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event summaryState logger ready

Start summaryState Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_summaryState_send 335777623 321333820
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATPneumatics::logevent_summaryState_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event summaryState generated =

Read summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 321333820
    Log    ${output}
    Should Contain X Times    ${output}    === Event summaryState received =     1
    Should Contain    ${output}    summaryState : 335777623
    Should Contain    ${output}    priority : 321333820

Terminate summaryState Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify appliedSettingsMatchStart Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log

Start appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_appliedSettingsMatchStart_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event appliedSettingsMatchStart logger ready

Start appliedSettingsMatchStart Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_appliedSettingsMatchStart_send 0 1235242585
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATPneumatics::logevent_appliedSettingsMatchStart_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event appliedSettingsMatchStart generated =

Read appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1235242585
    Log    ${output}
    Should Contain X Times    ${output}    === Event appliedSettingsMatchStart received =     1
    Should Contain    ${output}    appliedSettingsMatchStartIsTrue : 0
    Should Contain    ${output}    priority : 1235242585

Terminate appliedSettingsMatchStart Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

