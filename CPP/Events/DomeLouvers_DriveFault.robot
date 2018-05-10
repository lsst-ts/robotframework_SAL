*** Settings ***
Documentation    DomeLouvers_DriveFault sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    domeLouvers
${component}    DriveFault
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 9406 -21756 orYpAFLWONefYoDNAooJzOOQcqajnVIdfHbFhVYNSwigCYqajrjJCnFBaGVKzzALWHgpgZrnGaMBKKMzuTnRKQzSPfmKRqQYDjbGSqPhcsIIkTJQfisuXmkPwMeFKzgwcnTuGJUvgxHEBaBrhgYAUhUJSqPTABTbciCfUoOyrhRRpyjwLBCANnTdmQEseAYioPKAQenxQqycOvjDbVpyUAfrpztXlNRNSoYRAzvbUXGBHdyzSlySFYdctTtOSJMixTSrYafeDxEtQGTndweetKtAyQiqzrNYKgiQblzfJMiaJUMAAaPIHfJJyJarRATVlfjQRsgtxBEMyvHOmrYOOfZuZzPCHBadnKGXdqbcmznZqgSQXBeaGOuyKBwKixvwjPNRdacPPaqucAUomqqNvKgwLyzJtJrjukxculFGcHGkJyknMJwYzgRKnYLlGEyeAbLoxXNLnPKkUmhBDVMJcCbYSFBrxUtQcSfkEoxmvNrhEMcbSgyWgFUDavuGAvqgxVdWXABDUiiqxNUzFVUCSVmZxsWTIlnJECcPgdcwbamSNQmvtnOsJXMFGWHaoMoAMatGpFqAshtTfKupVPThMRLHNwvOoPIZLSWvSMBTMWZoqSnJBnMlVHqhTemCsOiYrSWDFmeRMAmnrMdkUpUpvIjELVOXQGteKeZIfBNMwoluFlipzFGVpNiuomuJaYcRujIKwIum 349594295
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] domeLouvers::logevent_DriveFault writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event DriveFault generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 349594295
    Log    ${output}
    Should Contain X Times    ${output}    === Event DriveFault received =     1
    Should Contain    ${output}    louverID : 9406
    Should Contain    ${output}    driveId : -21756
    Should Contain    ${output}    errorCode : orYpAFLWONefYoDNAooJzOOQcqajnVIdfHbFhVYNSwigCYqajrjJCnFBaGVKzzALWHgpgZrnGaMBKKMzuTnRKQzSPfmKRqQYDjbGSqPhcsIIkTJQfisuXmkPwMeFKzgwcnTuGJUvgxHEBaBrhgYAUhUJSqPTABTbciCfUoOyrhRRpyjwLBCANnTdmQEseAYioPKAQenxQqycOvjDbVpyUAfrpztXlNRNSoYRAzvbUXGBHdyzSlySFYdctTtOSJMixTSrYafeDxEtQGTndweetKtAyQiqzrNYKgiQblzfJMiaJUMAAaPIHfJJyJarRATVlfjQRsgtxBEMyvHOmrYOOfZuZzPCHBadnKGXdqbcmznZqgSQXBeaGOuyKBwKixvwjPNRdacPPaqucAUomqqNvKgwLyzJtJrjukxculFGcHGkJyknMJwYzgRKnYLlGEyeAbLoxXNLnPKkUmhBDVMJcCbYSFBrxUtQcSfkEoxmvNrhEMcbSgyWgFUDavuGAvqgxVdWXABDUiiqxNUzFVUCSVmZxsWTIlnJECcPgdcwbamSNQmvtnOsJXMFGWHaoMoAMatGpFqAshtTfKupVPThMRLHNwvOoPIZLSWvSMBTMWZoqSnJBnMlVHqhTemCsOiYrSWDFmeRMAmnrMdkUpUpvIjELVOXQGteKeZIfBNMwoluFlipzFGVpNiuomuJaYcRujIKwIum
    Should Contain    ${output}    priority : 349594295
