*** Settings ***
Documentation    Sequencer_sequencerEntitySummaryState sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send BdxmxtMiQImthAQMECiRWBREMAgEqLyvRXKGVavGnyBjQOFpHySSmVESqQCDJSrbgTAMWcwESevazpnmLYbrxNdNFEQrKygoIaZSGjBsiScyrcjIXqwXliBblNfOIpUb 51.2279 owytKIEzuqAKhYwbRXEygJdTibsnLixIRSjJlvmQYpIVODoammVZWbaVkGxQDAMVNkajiUnORTJgHKAKunnvcIZXPidboDRdWomnhtaHeiJSnNLhrUdXUDDIQtTJOCZJKrYzAaQkKqTICZqpPnJBjBjKzLlMbrHIypKujkVEFBJzfKFxBmceRtFcQVmaPtmuNIxwgRhjBEFyqguMOtJZWktvcuYyLGyJqyonqzNglbJIuxPLsdxoJqHUWdvEuPlf -117385107 cmUxqxfuNuZrLPRuvxQxuxHGgLdOeXvMaEUfGCCNoRNtkfpCAxrhCtgSPFtCBCAZIIEPASmAxJTLPouNAwDqmWbDYtOLPdzjInAMRjhBoziIOdUbeZbhtUxdlsyutmLV vDOsHYJWxwppXpNvwosPbZWIhDNraeANcDWxpUEzykUZWBEEQYtxQUZQducKNXeqEstFFMAdetewitgyzLHSdTEGmFlcoLMMjhbhXoHYSCAkbvPQbnvrsVdziGGeiabt vTXyelYknuoPmjFlQTGmzwkNzXwtnqYpVhhBNpkowLcdEqkLWjHneYWNyROUctSHUwbcOFQgkBoJOzVTfHSuguCqvkDlPnxdIrCIdAyMVWKQXBoYxAQfJbqukKfebwmt JFniGSHLTUKOKBbYRjTINKKivmhmmfmYZwpibWHcanQHKROAkcfQeOtCIVKUQPgJJjOoJwCMuJymdGKAwsQDGLLmrubMmdRszXwnsOVReWljKWNMYIcWUcNBSxtcdGIx wBMgOxaiEFFeWcUwmqUlRqompCaKbIspMfiRPmKToswFEIvbPfOrFwXLidfIOBMKsdICRilVHOiqmKRUTRvREoJzHARTrAvZdBlNPgolFSbTwpTNOfHLXmSiPKthDbeE 2014675702
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2014675702
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerEntitySummaryState received =     1
    Should Contain    ${output}    Name : BdxmxtMiQImthAQMECiRWBREMAgEqLyvRXKGVavGnyBjQOFpHySSmVESqQCDJSrbgTAMWcwESevazpnmLYbrxNdNFEQrKygoIaZSGjBsiScyrcjIXqwXliBblNfOIpUb
    Should Contain    ${output}    Identifier : 51.2279
    Should Contain    ${output}    Timestamp : owytKIEzuqAKhYwbRXEygJdTibsnLixIRSjJlvmQYpIVODoammVZWbaVkGxQDAMVNkajiUnORTJgHKAKunnvcIZXPidboDRdWomnhtaHeiJSnNLhrUdXUDDIQtTJOCZJKrYzAaQkKqTICZqpPnJBjBjKzLlMbrHIypKujkVEFBJzfKFxBmceRtFcQVmaPtmuNIxwgRhjBEFyqguMOtJZWktvcuYyLGyJqyonqzNglbJIuxPLsdxoJqHUWdvEuPlf
    Should Contain    ${output}    Address : -117385107
    Should Contain    ${output}    CurrentState : cmUxqxfuNuZrLPRuvxQxuxHGgLdOeXvMaEUfGCCNoRNtkfpCAxrhCtgSPFtCBCAZIIEPASmAxJTLPouNAwDqmWbDYtOLPdzjInAMRjhBoziIOdUbeZbhtUxdlsyutmLV
    Should Contain    ${output}    PreviousState : vDOsHYJWxwppXpNvwosPbZWIhDNraeANcDWxpUEzykUZWBEEQYtxQUZQducKNXeqEstFFMAdetewitgyzLHSdTEGmFlcoLMMjhbhXoHYSCAkbvPQbnvrsVdziGGeiabt
    Should Contain    ${output}    Executing : vTXyelYknuoPmjFlQTGmzwkNzXwtnqYpVhhBNpkowLcdEqkLWjHneYWNyROUctSHUwbcOFQgkBoJOzVTfHSuguCqvkDlPnxdIrCIdAyMVWKQXBoYxAQfJbqukKfebwmt
    Should Contain    ${output}    CommandsAvailable : JFniGSHLTUKOKBbYRjTINKKivmhmmfmYZwpibWHcanQHKROAkcfQeOtCIVKUQPgJJjOoJwCMuJymdGKAwsQDGLLmrubMmdRszXwnsOVReWljKWNMYIcWUcNBSxtcdGIx
    Should Contain    ${output}    ConfigurationsAvailable : wBMgOxaiEFFeWcUwmqUlRqompCaKbIspMfiRPmKToswFEIvbPfOrFwXLidfIOBMKsdICRilVHOiqmKRUTRvREoJzHARTrAvZdBlNPgolFSbTwpTNOfHLXmSiPKthDbeE
    Should Contain    ${output}    priority : 2014675702
