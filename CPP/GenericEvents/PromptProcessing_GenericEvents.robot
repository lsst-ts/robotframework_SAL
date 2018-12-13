*** Settings ***
Documentation    PromptProcessing_ communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    PromptProcessing
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
    ${input}=    Write    ./sacpp_${subSystem}_settingVersions_send gcVvxjHjwyTpNpXpJTvUYaBxShVDNKZNjVxUpOrsoIqhsBbOtfSCLdCysPhYWkgslgDEqUoKHqGuTGJRJSPRzHlXzAkgwqSqKnwDrQknpIcGqRIQVqOrzRwokVQelEYtqKkAijBDuetgOmulFsizYfyHRTOXhGubgLIhCDXZrlOLcqZPlFGRaEtFVbhCioHbFhhXrRmZEZrMtRYJFtfoEpmOIpbvcHVUTdWaKQevjOiejgUQiXYoHQJtxbCiokNh UNhTCGRQUPWGNDLdFPurPnOxJtVDdVcsJZmLwOYjUAhwSPPLulIClWHIEPoawzQOzDluKCfzyiLUBmQcevtvBkLECXylrjCHzTHPpapXXDsczUQluIKLJJKftkyTCUlwyKgeXXuEjxmmlAGEqkGDkafjlzfbTnMSOqHsNEORJSgkCBzbyXRrNxRXshOkLyVhyRltDcLmbNJlCHSFsURvIMePlQJWxCaaEEkoGgJAKwmsqjPLrLpXStkXJzulJuXD -796464011
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] PromptProcessing::logevent_settingVersions_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event settingVersions generated =

Read settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -796464011
    Log    ${output}
    Should Contain X Times    ${output}    === Event settingVersions received =     1
    Should Contain    ${output}    recommendedSettingsVersion : gcVvxjHjwyTpNpXpJTvUYaBxShVDNKZNjVxUpOrsoIqhsBbOtfSCLdCysPhYWkgslgDEqUoKHqGuTGJRJSPRzHlXzAkgwqSqKnwDrQknpIcGqRIQVqOrzRwokVQelEYtqKkAijBDuetgOmulFsizYfyHRTOXhGubgLIhCDXZrlOLcqZPlFGRaEtFVbhCioHbFhhXrRmZEZrMtRYJFtfoEpmOIpbvcHVUTdWaKQevjOiejgUQiXYoHQJtxbCiokNh
    Should Contain    ${output}    recommendedSettingsLabels : UNhTCGRQUPWGNDLdFPurPnOxJtVDdVcsJZmLwOYjUAhwSPPLulIClWHIEPoawzQOzDluKCfzyiLUBmQcevtvBkLECXylrjCHzTHPpapXXDsczUQluIKLJJKftkyTCUlwyKgeXXuEjxmmlAGEqkGDkafjlzfbTnMSOqHsNEORJSgkCBzbyXRrNxRXshOkLyVhyRltDcLmbNJlCHSFsURvIMePlQJWxCaaEEkoGgJAKwmsqjPLrLpXStkXJzulJuXD
    Should Contain    ${output}    priority : -796464011

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
    ${input}=    Write    ./sacpp_${subSystem}_errorCode_send 250599285 fwFJCvdfgsnYNZUmwGymNJtFoidZPvSUzNoJptpecDavDosMquooVKchskqmbgngVrRzVeBVAFAgelgNBeRwDPfQTVdMuNjSucqOtXqAzWMhsvncLoOvflNZslHjeBrqNIImNfCylEIUKFXKfDjYgbBJhSUKdGYexUSLwiczKBahcDZLHmwgMrGnSmRaEfQwJUyTwZoGuhgVaTwibPxjNBPkYuNuQnTACGAdlIXdiVDMvoQuXeWISuIedZUYYsUAXiczvbZKensbWYlcbYVGhOtNXzPQHmSkOADvPsQAhAymVbekFTsotUBvDhuAFVCbPjJwsjynAoQQSiutMyjVURSDdOqlIbYwdXsXmafckzRPZBfitMrhMJYgBKfNdPOLQaYtdpztcjqCPbvqualQxNuiQXsUOwJMFaNLEBLOmmDmBgeBFzxVAseSdnzXKRFPjHgsvVUCVIhqUtYBBaPJqwJkNOEtxXLycRlMBfhzyahIuZFdNWvZxvscAWuPzqxrennzCJHlqGBWZXPLLhciFeUiJfvkxFQSqGvrVtwnuPGUwJREGXQxudoNgQeFtROkkSDAsSKJqhMqDtBaIrBHhWQPufrNDTPalYeZOUqnOAyKtwtlecEqbNAdpvCQdTPxQvymxpJIpIfQiYiPTxNjuSDodUVcayAgKIqJnMiKWwFeACwpYNtDyjvyTxbxccRvoyuxkNtVVDjsTufFaCnCsjtJfwxRVitSjZGskqlyHzzRWJAmeCTAvZneXNziHzsfLBAHLdMYCuUGExopMEoyrWnUPuVZWZhbgQNKiKVWiGnCEgWDgMkeKeawgEzJemXmadQRiVxWWSkwvkdnfm xHbpIISXRlgOAUarxWSzyidfuRqSIsRfyUNspVUlPnpFBpBqNrRQTLpkCWwBbUpDscxebOhAMDWsgsDAUForMPgruxUzXgscsa 1414755311
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] PromptProcessing::logevent_errorCode_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event errorCode generated =

Read errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1414755311
    Log    ${output}
    Should Contain X Times    ${output}    === Event errorCode received =     1
    Should Contain    ${output}    errorCode : 250599285
    Should Contain    ${output}    errorReport : fwFJCvdfgsnYNZUmwGymNJtFoidZPvSUzNoJptpecDavDosMquooVKchskqmbgngVrRzVeBVAFAgelgNBeRwDPfQTVdMuNjSucqOtXqAzWMhsvncLoOvflNZslHjeBrqNIImNfCylEIUKFXKfDjYgbBJhSUKdGYexUSLwiczKBahcDZLHmwgMrGnSmRaEfQwJUyTwZoGuhgVaTwibPxjNBPkYuNuQnTACGAdlIXdiVDMvoQuXeWISuIedZUYYsUAXiczvbZKensbWYlcbYVGhOtNXzPQHmSkOADvPsQAhAymVbekFTsotUBvDhuAFVCbPjJwsjynAoQQSiutMyjVURSDdOqlIbYwdXsXmafckzRPZBfitMrhMJYgBKfNdPOLQaYtdpztcjqCPbvqualQxNuiQXsUOwJMFaNLEBLOmmDmBgeBFzxVAseSdnzXKRFPjHgsvVUCVIhqUtYBBaPJqwJkNOEtxXLycRlMBfhzyahIuZFdNWvZxvscAWuPzqxrennzCJHlqGBWZXPLLhciFeUiJfvkxFQSqGvrVtwnuPGUwJREGXQxudoNgQeFtROkkSDAsSKJqhMqDtBaIrBHhWQPufrNDTPalYeZOUqnOAyKtwtlecEqbNAdpvCQdTPxQvymxpJIpIfQiYiPTxNjuSDodUVcayAgKIqJnMiKWwFeACwpYNtDyjvyTxbxccRvoyuxkNtVVDjsTufFaCnCsjtJfwxRVitSjZGskqlyHzzRWJAmeCTAvZneXNziHzsfLBAHLdMYCuUGExopMEoyrWnUPuVZWZhbgQNKiKVWiGnCEgWDgMkeKeawgEzJemXmadQRiVxWWSkwvkdnfm
    Should Contain    ${output}    traceback : xHbpIISXRlgOAUarxWSzyidfuRqSIsRfyUNspVUlPnpFBpBqNrRQTLpkCWwBbUpDscxebOhAMDWsgsDAUForMPgruxUzXgscsa
    Should Contain    ${output}    priority : 1414755311

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
    ${input}=    Write    ./sacpp_${subSystem}_summaryState_send -1670512453 1239168540
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] PromptProcessing::logevent_summaryState_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event summaryState generated =

Read summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1239168540
    Log    ${output}
    Should Contain X Times    ${output}    === Event summaryState received =     1
    Should Contain    ${output}    summaryState : -1670512453
    Should Contain    ${output}    priority : 1239168540

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
    ${input}=    Write    ./sacpp_${subSystem}_appliedSettingsMatchStart_send 0 1813486119
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] PromptProcessing::logevent_appliedSettingsMatchStart_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event appliedSettingsMatchStart generated =

Read appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1813486119
    Log    ${output}
    Should Contain X Times    ${output}    === Event appliedSettingsMatchStart received =     1
    Should Contain    ${output}    appliedSettingsMatchStartIsTrue : 0
    Should Contain    ${output}    priority : 1813486119

Terminate appliedSettingsMatchStart Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

