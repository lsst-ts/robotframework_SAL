*** Settings ***
Documentation    OCS_ocsScriptEntititesInUse communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsScriptEntititesInUse
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send outCoXMJofmHSfEEDArMEKfhUOppOjgWGKNSgzTHfHOPXRrVTHCbsHSWNkMadXPhmlwyfeMMBmXsZvmrKWYldYSiDkxRMKfBRuvkYnSinVHjXsocbQskczZuQikshjuSsAJZtiXMWQFCEVUIEOHIkvUUuohjFZDQGDzjqWhHSwSvvOlPGwDPlOlapdjADrmHyNkQMkOWDCPeTVnRYtfKgutvnRggQoHmKavoHiuMdYUIdxlyDMutpDKPvuKpdXAu 28.6171 PJoEodNwTkIeBETUwUiMZehLgJXXuemqSMiIooCSFlDNGXXszrwBUJScgEZUzyMgRBUrtRzEtHIvPUrmHmPbihOBBaarUbUIaSMXGMyobqhSVcDQclsNYGLvhBbweaVDZvSyThMTkVFIaWyalRSUZrgvlkSpgxrrjsqYAKWcRUmghDadzRPMSqKnrbNxKuLfbIOsEhAawoQDjdTMYirtlNAbPYKnILmKUTiVRuMeYhBKPcmZWXSPblPFkqMUetng KmiGFokKqpkDdNMukyzhbeLITvEvfefzKIaUvlyFrYnrLhAxnvaPNFFvMguWryKkxGyTlmnQTnRRvIniBJFGzxVDPAUiRPNcdgVGmJsCZHvSgiGfkutGrFLJNtuzrQnJUYPcTuiDqlngfgBVwqpUlQvHWbtoIhfcDShKhnDFoYMwtsUJzssZVdljwCwahWMVRnPtBzyQOgjpfIQWIPlJeOiHGVaWXQwCXgZHvyateTZEjXtXninYYzyCfpBjqEZJ -2084289516
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsScriptEntititesInUse writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsScriptEntititesInUse generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2084289516
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsScriptEntititesInUse received =     1
    Should Contain    ${output}    ocsScriptName : outCoXMJofmHSfEEDArMEKfhUOppOjgWGKNSgzTHfHOPXRrVTHCbsHSWNkMadXPhmlwyfeMMBmXsZvmrKWYldYSiDkxRMKfBRuvkYnSinVHjXsocbQskczZuQikshjuSsAJZtiXMWQFCEVUIEOHIkvUUuohjFZDQGDzjqWhHSwSvvOlPGwDPlOlapdjADrmHyNkQMkOWDCPeTVnRYtfKgutvnRggQoHmKavoHiuMdYUIdxlyDMutpDKPvuKpdXAu
    Should Contain    ${output}    ocsScriptIdentifier : 28.6171
    Should Contain    ${output}    ocsScriptTimestamp : PJoEodNwTkIeBETUwUiMZehLgJXXuemqSMiIooCSFlDNGXXszrwBUJScgEZUzyMgRBUrtRzEtHIvPUrmHmPbihOBBaarUbUIaSMXGMyobqhSVcDQclsNYGLvhBbweaVDZvSyThMTkVFIaWyalRSUZrgvlkSpgxrrjsqYAKWcRUmghDadzRPMSqKnrbNxKuLfbIOsEhAawoQDjdTMYirtlNAbPYKnILmKUTiVRuMeYhBKPcmZWXSPblPFkqMUetng
    Should Contain    ${output}    ocsEntititesList : KmiGFokKqpkDdNMukyzhbeLITvEvfefzKIaUvlyFrYnrLhAxnvaPNFFvMguWryKkxGyTlmnQTnRRvIniBJFGzxVDPAUiRPNcdgVGmJsCZHvSgiGfkutGrFLJNtuzrQnJUYPcTuiDqlngfgBVwqpUlQvHWbtoIhfcDShKhnDFoYMwtsUJzssZVdljwCwahWMVRnPtBzyQOgjpfIQWIPlJeOiHGVaWXQwCXgZHvyateTZEjXtXninYYzyCfpBjqEZJ
    Should Contain    ${output}    priority : -2084289516
