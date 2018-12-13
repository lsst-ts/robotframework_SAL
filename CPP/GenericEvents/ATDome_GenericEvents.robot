*** Settings ***
Documentation    ATDome_ communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ATDome
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
    ${input}=    Write    ./sacpp_${subSystem}_settingVersions_send xytvOOXXXbVZEZXQfiYcpzygkOArtgKGiLgBxhcIwUPlFUnznganBhdOLwmNzSOvDOYMRjWvxfbGGsDYTOFdRQbGoIbxGFndJdtyqGkWDBRGcLeQguLsadjLlcPPdsLDhtKKfUzqtRePgGsCfdgBEoJpAjeQfOvzcxCGZSlLgyfDjDvUPOJzGvuFCvnoxKwqrwcsmVIEDwCVylBnTQjHkAbivCKVKkpOpOvTXYUPgdoKsRHDBNbQFJTTdAtllDXI BabenXPmbFPyngdxukSBQjQqBCHnYgbHEMojqggJAjEBHsrxmPAgUtYJPjlmTZVHERUFrMZvteEQndhLGDIzGOuBtaNirXgAYikrmPQbsevToLpoXByMRVDdBkFpIvIzhpCVjnuPbcQeowLlXpEcbrLJAlyNIkoKZQfZTTiGPnHeGLQMWkELteBophiaCIRdpyFGLYGkImjJnCaZVJTQKQusuDhtSQIAeWIJLyGEcsMWopXfxDAIGQGpGWMcgaHU -67336692
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATDome::logevent_settingVersions_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event settingVersions generated =

Read settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -67336692
    Log    ${output}
    Should Contain X Times    ${output}    === Event settingVersions received =     1
    Should Contain    ${output}    recommendedSettingsVersion : xytvOOXXXbVZEZXQfiYcpzygkOArtgKGiLgBxhcIwUPlFUnznganBhdOLwmNzSOvDOYMRjWvxfbGGsDYTOFdRQbGoIbxGFndJdtyqGkWDBRGcLeQguLsadjLlcPPdsLDhtKKfUzqtRePgGsCfdgBEoJpAjeQfOvzcxCGZSlLgyfDjDvUPOJzGvuFCvnoxKwqrwcsmVIEDwCVylBnTQjHkAbivCKVKkpOpOvTXYUPgdoKsRHDBNbQFJTTdAtllDXI
    Should Contain    ${output}    recommendedSettingsLabels : BabenXPmbFPyngdxukSBQjQqBCHnYgbHEMojqggJAjEBHsrxmPAgUtYJPjlmTZVHERUFrMZvteEQndhLGDIzGOuBtaNirXgAYikrmPQbsevToLpoXByMRVDdBkFpIvIzhpCVjnuPbcQeowLlXpEcbrLJAlyNIkoKZQfZTTiGPnHeGLQMWkELteBophiaCIRdpyFGLYGkImjJnCaZVJTQKQusuDhtSQIAeWIJLyGEcsMWopXfxDAIGQGpGWMcgaHU
    Should Contain    ${output}    priority : -67336692

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
    ${input}=    Write    ./sacpp_${subSystem}_errorCode_send 362796717 upFuDrYYvaFBfwpJQBzFySUfZetLXlstVZujHvyjekTscvgUTFluRCLrEjigLJzbkSpboRYOTUcYpFUylVfbtOpIpwKNtxQxWLQPdVVdTfTckOzYApLtrgyNQJjgFIIaGYcJtkrdiHfcLEznZhCICOkaVKKQVHubbsljtgmDHNgoUtzMMotlgIuirnxAfBOxGYPVNMTDiWWueVOifjIOmVacpvStscYiRqgBuesCzIsgitTldCBkFwErDbySstxVMxOGGKwLFxjPuiAFBdjTQVBwvKgcgfhypvbrHpVTtgKrvuwTHvUZfyUYhZzsZlCBQqpPDhSuMiYGRSGKlETLvwKJVVZPgBTIuDqRTrtFpqiZAjnRkMnaOcTmdVDlvgtdLhnAxcnYjaKEdzTINMxcmcyneNrokqEZILuibxQe rRezqmxsYOHRQZCcgfAPGKiQkEBkbisiZZeAPTVGVSlIPpRkrDEgUdCGylZWrEXIgchPmKkYCLRZUxRqUahlKMIGwqakEFxWpIkVDQDKtiQmIsyNlfCjXLxvxXCYvRrgDwAnvGNAMlWrLKtFpeRdeJueGgsEVyksLkwylAdckjCKcMmsLDCNpLBKZDfzvDbqxWnySiUaIPfsXnFnuIMYLyrXLLMjClZavAkRYOgfaPBrnwCjBiKXBuyboOwkLkESsfWugYQLIDmsCNnjLHPTlUgxVCGsjEYeMCcjGqHAQbwXdPRYGvcRQZRNeqSiLAFgCkQfFQdchSgpmFPTYMblBGgzzwuqsgGExTpUihUOUsGgUjSGiTAeHRmgWgFHLYRHbOTWjpETYXHfESRqivBtLPKhCgFAFQxybQMZUDsFElvArXHEwhOVeMmXHgZfdSNJEprHoXJNOvVCdzpUKAOPpbtNhwgJPGYnMdxshPmfurXFGtknMynFGHFXNUdQwA -1547095631
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATDome::logevent_errorCode_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event errorCode generated =

Read errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1547095631
    Log    ${output}
    Should Contain X Times    ${output}    === Event errorCode received =     1
    Should Contain    ${output}    errorCode : 362796717
    Should Contain    ${output}    errorReport : upFuDrYYvaFBfwpJQBzFySUfZetLXlstVZujHvyjekTscvgUTFluRCLrEjigLJzbkSpboRYOTUcYpFUylVfbtOpIpwKNtxQxWLQPdVVdTfTckOzYApLtrgyNQJjgFIIaGYcJtkrdiHfcLEznZhCICOkaVKKQVHubbsljtgmDHNgoUtzMMotlgIuirnxAfBOxGYPVNMTDiWWueVOifjIOmVacpvStscYiRqgBuesCzIsgitTldCBkFwErDbySstxVMxOGGKwLFxjPuiAFBdjTQVBwvKgcgfhypvbrHpVTtgKrvuwTHvUZfyUYhZzsZlCBQqpPDhSuMiYGRSGKlETLvwKJVVZPgBTIuDqRTrtFpqiZAjnRkMnaOcTmdVDlvgtdLhnAxcnYjaKEdzTINMxcmcyneNrokqEZILuibxQe
    Should Contain    ${output}    traceback : rRezqmxsYOHRQZCcgfAPGKiQkEBkbisiZZeAPTVGVSlIPpRkrDEgUdCGylZWrEXIgchPmKkYCLRZUxRqUahlKMIGwqakEFxWpIkVDQDKtiQmIsyNlfCjXLxvxXCYvRrgDwAnvGNAMlWrLKtFpeRdeJueGgsEVyksLkwylAdckjCKcMmsLDCNpLBKZDfzvDbqxWnySiUaIPfsXnFnuIMYLyrXLLMjClZavAkRYOgfaPBrnwCjBiKXBuyboOwkLkESsfWugYQLIDmsCNnjLHPTlUgxVCGsjEYeMCcjGqHAQbwXdPRYGvcRQZRNeqSiLAFgCkQfFQdchSgpmFPTYMblBGgzzwuqsgGExTpUihUOUsGgUjSGiTAeHRmgWgFHLYRHbOTWjpETYXHfESRqivBtLPKhCgFAFQxybQMZUDsFElvArXHEwhOVeMmXHgZfdSNJEprHoXJNOvVCdzpUKAOPpbtNhwgJPGYnMdxshPmfurXFGtknMynFGHFXNUdQwA
    Should Contain    ${output}    priority : -1547095631

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
    ${input}=    Write    ./sacpp_${subSystem}_summaryState_send -441182709 1478883035
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATDome::logevent_summaryState_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event summaryState generated =

Read summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1478883035
    Log    ${output}
    Should Contain X Times    ${output}    === Event summaryState received =     1
    Should Contain    ${output}    summaryState : -441182709
    Should Contain    ${output}    priority : 1478883035

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
    ${input}=    Write    ./sacpp_${subSystem}_appliedSettingsMatchStart_send 0 1882733084
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ATDome::logevent_appliedSettingsMatchStart_    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event appliedSettingsMatchStart generated =

Read appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1882733084
    Log    ${output}
    Should Contain X Times    ${output}    === Event appliedSettingsMatchStart received =     1
    Should Contain    ${output}    appliedSettingsMatchStartIsTrue : 0
    Should Contain    ${output}    priority : 1882733084

Terminate appliedSettingsMatchStart Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

