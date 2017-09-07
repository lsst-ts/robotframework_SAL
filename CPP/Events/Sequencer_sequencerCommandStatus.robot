*** Settings ***
Documentation    Sequencer_sequencerCommandStatus sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send RzMdipEvKUBljspEptfPCkuyzevfWYTKTxhjOAZXbfuswWGOTpKRyDpNrVPDGazVNQkRhOGyHkkgRsDFOgbNtLbBcrioRaHHSEsdJNSIaVtnTxuxWCcJmFTysjmuffRZGKmOHzurmuplUrsTLlOvELBxaOXxLfgeSusfkLPdBWZAXuyXzyBTFACGkgjSNudWrNIYePxfvmtpnUsNenfoeJFCUyGUSpsQLAySvigAIOLqSPlQCELbFxXmPHcnctHO 205169846 53.0014 WGTSVwdaYHPggYwtSWlhYtzoObSqTcmvbtGkSqdunVceXThydeIUcQFtEsZsaVFIFbpEVufMOnPQDuPjbmDFHsKfqoWcgoTTZzWUdwXzuYJAnbtCSfHsQMexwSnnWreEPxnjeObllIQpcaqgLzebyznVJFMcyvhTuzkqPxLbPudoZCcOFVrdYSGuOZdKlLGeBAFYKvLidkkgAAiSaqauAfeRbpJNphLXNDIwcJodbosBllEGGVjNObchTjZzbtsO AbevRMCDDfkSTyoxXazrpmVNgaVuxnytjhmdFEZnXQKVjMCWNfxJLtLTWTIrDnwGXUREinSDBFkughtFQSStKVKGhiufIVMFtUFHqBEvIPJKrUJyCAbKnLUVqIfsMYNiFuLwWBviHLxdaIdTunoqQrhGiZUebtovrvLwZsVxQDCkMWmYkBMcpYkbFsBwxcDIyBQcNUyPguVCSjhfpKNBvTZTRHfZjAZcYTpXUUrhXedBUqarlquwnbznneaoaghU -1717549045 PDETTPtPUitQfCSgUxytmFOnjsXByiARMduunudwUODjYnWdFDmfxFabiOxfYgWxkRELhucgJYPWRFCcGzoJBjgYbqWptSHVpnGEQRhJLqVTQMcgobcJLegswhTMPMLVQQsVVQoFACJncobgurqxNDnjqXDwwtCLuJATwuGlmQbLLJxNxOjLufSnxvRXAJRkvoPMOgzOhjpeYtwyOsChUwneOiJxsHkONpNHtXnLiPQNBNEaNFRkGZKcxvvQqaQU 190312383
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 190312383
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandStatus received =     1
    Should Contain    ${output}    CommandSource : RzMdipEvKUBljspEptfPCkuyzevfWYTKTxhjOAZXbfuswWGOTpKRyDpNrVPDGazVNQkRhOGyHkkgRsDFOgbNtLbBcrioRaHHSEsdJNSIaVtnTxuxWCcJmFTysjmuffRZGKmOHzurmuplUrsTLlOvELBxaOXxLfgeSusfkLPdBWZAXuyXzyBTFACGkgjSNudWrNIYePxfvmtpnUsNenfoeJFCUyGUSpsQLAySvigAIOLqSPlQCELbFxXmPHcnctHO
    Should Contain    ${output}    SequenceNumber : 205169846
    Should Contain    ${output}    Identifier : 53.0014
    Should Contain    ${output}    Timestamp : WGTSVwdaYHPggYwtSWlhYtzoObSqTcmvbtGkSqdunVceXThydeIUcQFtEsZsaVFIFbpEVufMOnPQDuPjbmDFHsKfqoWcgoTTZzWUdwXzuYJAnbtCSfHsQMexwSnnWreEPxnjeObllIQpcaqgLzebyznVJFMcyvhTuzkqPxLbPudoZCcOFVrdYSGuOZdKlLGeBAFYKvLidkkgAAiSaqauAfeRbpJNphLXNDIwcJodbosBllEGGVjNObchTjZzbtsO
    Should Contain    ${output}    CommandSent : AbevRMCDDfkSTyoxXazrpmVNgaVuxnytjhmdFEZnXQKVjMCWNfxJLtLTWTIrDnwGXUREinSDBFkughtFQSStKVKGhiufIVMFtUFHqBEvIPJKrUJyCAbKnLUVqIfsMYNiFuLwWBviHLxdaIdTunoqQrhGiZUebtovrvLwZsVxQDCkMWmYkBMcpYkbFsBwxcDIyBQcNUyPguVCSjhfpKNBvTZTRHfZjAZcYTpXUUrhXedBUqarlquwnbznneaoaghU
    Should Contain    ${output}    StatusValue : -1717549045
    Should Contain    ${output}    Status : PDETTPtPUitQfCSgUxytmFOnjsXByiARMduunudwUODjYnWdFDmfxFabiOxfYgWxkRELhucgJYPWRFCcGzoJBjgYbqWptSHVpnGEQRhJLqVTQMcgobcJLegswhTMPMLVQQsVVQoFACJncobgurqxNDnjqXDwwtCLuJATwuGlmQbLLJxNxOjLufSnxvRXAJRkvoPMOgzOhjpeYtwyOsChUwneOiJxsHkONpNHtXnLiPQNBNEaNFRkGZKcxvvQqaQU
    Should Contain    ${output}    priority : 190312383
