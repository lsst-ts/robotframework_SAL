*** Settings ***
Documentation    OCS_ocsScriptEnd sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsScriptEnd
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send NyJdGMlPpTpIzUMolvQiZtdLwFtNpMsCUwokplZCosklEeLIWboTjIwpznMzYpBsNZtwbKmJREBultBKWjClJQqGlzRabUYpSCimxTywiuABocmQzzVgPggkKegUxwnpeyYVWtYKzQbmzGSuIYlQRbcmMbjWFlFvyuFsaOtTROZPZVaiitfRbAXtginwzkAXLQggQYUIbtoJioTqqyHvikvTQMHZMdbixQBCufuQUcvepunQkasUftFtFxpJykRt 22.7378 FhrBVtJVfMivREKXiXjwlCaiuAOAVyWnPCPXeXQhFdHsFMSDscAaONfossYcLKmdfTdkXBRITpJePBLfwKYrjmHtodINDCcFLsRDLeCXulLJcXGpZnIiGrBdGkbDtCdGbOZnkDeXsaANnBBGTtXwsfISkBcKCuJBPMAqfjeWBhfQTaGbaazixfMUMTIkvGcnPvDBewoigfMdljiFeoGYbIwVaOuzwcBxTWCmGZpyWPgSHxdWZwRCeahwrhyyxqFk -1402850652 fDPJfeuiNUowVybZpMoNkDaqQQltKEcuKzXFdSITVnFSmskaxlPKdbMbxVktJHualddSsvnvyJwiBQJMUWyDrZScgghWCsSZGuwXHqjNKGXPWlmkQtWnDIHbkSphAitXrMQYSigkYXAddjJYsQtiPmrlMgXYTwhtapeNYntjaTEFafbzHcSIkbZVcJfEtcLxOwKRyefNGIRDMuQearhqEfnDPHvEHIFEaJPcGXBsapyMGxrvMfMkrDCcqvWpZnOB -1413249810
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsScriptEnd writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsScriptEnd generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1413249810
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsScriptEnd received =     1
    Should Contain    ${output}    ocsScriptName : NyJdGMlPpTpIzUMolvQiZtdLwFtNpMsCUwokplZCosklEeLIWboTjIwpznMzYpBsNZtwbKmJREBultBKWjClJQqGlzRabUYpSCimxTywiuABocmQzzVgPggkKegUxwnpeyYVWtYKzQbmzGSuIYlQRbcmMbjWFlFvyuFsaOtTROZPZVaiitfRbAXtginwzkAXLQggQYUIbtoJioTqqyHvikvTQMHZMdbixQBCufuQUcvepunQkasUftFtFxpJykRt
    Should Contain    ${output}    ocsScriptIdentifier : 22.7378
    Should Contain    ${output}    ocsScriptTimestamp : FhrBVtJVfMivREKXiXjwlCaiuAOAVyWnPCPXeXQhFdHsFMSDscAaONfossYcLKmdfTdkXBRITpJePBLfwKYrjmHtodINDCcFLsRDLeCXulLJcXGpZnIiGrBdGkbDtCdGbOZnkDeXsaANnBBGTtXwsfISkBcKCuJBPMAqfjeWBhfQTaGbaazixfMUMTIkvGcnPvDBewoigfMdljiFeoGYbIwVaOuzwcBxTWCmGZpyWPgSHxdWZwRCeahwrhyyxqFk
    Should Contain    ${output}    ocsScriptStatusCode : -1402850652
    Should Contain    ${output}    ocsScriptStatusText : fDPJfeuiNUowVybZpMoNkDaqQQltKEcuKzXFdSITVnFSmskaxlPKdbMbxVktJHualddSsvnvyJwiBQJMUWyDrZScgghWCsSZGuwXHqjNKGXPWlmkQtWnDIHbkSphAitXrMQYSigkYXAddjJYsQtiPmrlMgXYTwhtapeNYntjaTEFafbzHcSIkbZVcJfEtcLxOwKRyefNGIRDMuQearhqEfnDPHvEHIFEaJPcGXBsapyMGxrvMfMkrDCcqvWpZnOB
    Should Contain    ${output}    priority : -1413249810
