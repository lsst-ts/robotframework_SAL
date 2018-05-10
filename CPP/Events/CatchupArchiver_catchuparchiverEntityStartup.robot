*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntityStartup sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send VdYSFpvKvCPlgYiivvjWKbQDRGjQGFQriipHsDihYVsWmxIMJHnTnCldcfyefxMgYaYtssBqwDCzyvqflkaFXGsSJCgXDWKAbTVUkMMJxFWMmGVsIGdqfRtyCnJSqKnAtgdjSQjqXbtNudOikjypdJNZGPUFuCeRWfKsOedkAheEjVTwdpbPCTJOrPmSBHojyQimSVNQUFJdUYJyTESGtcHUVwyEAQOKUIEYcvWMTzsquTrCCQeYCnciamDwQTOg 95.6004 JajCJnVVTdZTZNRIlnTzTsIQifpfwfxXywakSAHSnhCfOFbtSoPgPzkWsNNifbmQmXMKZtRkIPMfsrWVkUBiyWmiRehNsteEGSFUZnVgKlQznsKZBqMVmzprErZVNRnSrakkQXkNtxfgGInWQLQAejOLQGjbCphaaUWjezHEpfLyagPkSGNJElVqmGpcxpplRLopiewwUzJpmvCtsOLMtNBwQezCgsgmqZKZlIkfCyWShtniFbeFwFrKMIDTcFxJ 1425319389 1842298533 -210552705
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -210552705
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntityStartup received =     1
    Should Contain    ${output}    Name : VdYSFpvKvCPlgYiivvjWKbQDRGjQGFQriipHsDihYVsWmxIMJHnTnCldcfyefxMgYaYtssBqwDCzyvqflkaFXGsSJCgXDWKAbTVUkMMJxFWMmGVsIGdqfRtyCnJSqKnAtgdjSQjqXbtNudOikjypdJNZGPUFuCeRWfKsOedkAheEjVTwdpbPCTJOrPmSBHojyQimSVNQUFJdUYJyTESGtcHUVwyEAQOKUIEYcvWMTzsquTrCCQeYCnciamDwQTOg
    Should Contain    ${output}    Identifier : 95.6004
    Should Contain    ${output}    Timestamp : JajCJnVVTdZTZNRIlnTzTsIQifpfwfxXywakSAHSnhCfOFbtSoPgPzkWsNNifbmQmXMKZtRkIPMfsrWVkUBiyWmiRehNsteEGSFUZnVgKlQznsKZBqMVmzprErZVNRnSrakkQXkNtxfgGInWQLQAejOLQGjbCphaaUWjezHEpfLyagPkSGNJElVqmGpcxpplRLopiewwUzJpmvCtsOLMtNBwQezCgsgmqZKZlIkfCyWShtniFbeFwFrKMIDTcFxJ
    Should Contain    ${output}    Address : 1425319389
    Should Contain    ${output}    priority : 1842298533
    Should Contain    ${output}    priority : -210552705
