*** Settings ***
Documentation    Sequencer_sequencerScriptError communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerScriptError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send hefJmkfvTslsSKeZVJztCTLlfarlgoFwIBLFbrbdmMsvKWGVBJrInFXDgfCGQpayodLJTaZuPFTwRuMmLXYXAhlEYGMywquHnIAfFMYYnQNSHuLvzquBlYubNBlxugZMHIRJOdAuGgAcllzkOXTYYGIMshlowwhBXuwyAQqNlxnlRiQtRUGCRwvhAPABScInQjOvLbAghiaBXBEPZIppbQYjqqfzFfPdFBvVLqffHqRcdfKvTSqGDQLsVIKETszj 78.8767 teGfuuRZPEAjSGfdRUiryFCdIbOgeWicdmSIBFrqbdyVhJcDgQEQrxRTjghEoZRwJvVBpqxoQauvsZxMfAxZdFfaHuHYzYSdEoLpJavKUylzSZVMvFbDSaijHmyUaSXgWjAPondvOCSsgWrdcAKWJBdPFaIUiLHdvgZWtgrdfVhNchgGPlMXSKyuniofiEUABvfsxPPYBbtYtPFOmsYZXpTyLmptxfpdLzEalHrQQhPyeSpIEAcTpeUyhABNsZKE 1631937519 -1385600219 gMjGEjgETeGAOaOclQVVXlRkaljKdzEQShYpXpbPxtfgFVNhBvkowaCwHxMxEEUVxAiFWgKffTrumtxkGJjMHAhLqxDCzUtIObsWpKEBsGwaTcyYBWtUtrttocbbgHtSSRdEYCYFAecPjflFokuTohzPNPFZXAfKTMQOINOYojXbdDuZYmmAEfRtCHXWOSkUwfpSgNgCmDTdidXeNvcRNEOYhjBJNajqyqYDRaOlPptWuoMsEfWYEIIxBvPQRqSu 2118724679
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2118724679
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptError received =     1
    Should Contain    ${output}    sequencerScriptName : hefJmkfvTslsSKeZVJztCTLlfarlgoFwIBLFbrbdmMsvKWGVBJrInFXDgfCGQpayodLJTaZuPFTwRuMmLXYXAhlEYGMywquHnIAfFMYYnQNSHuLvzquBlYubNBlxugZMHIRJOdAuGgAcllzkOXTYYGIMshlowwhBXuwyAQqNlxnlRiQtRUGCRwvhAPABScInQjOvLbAghiaBXBEPZIppbQYjqqfzFfPdFBvVLqffHqRcdfKvTSqGDQLsVIKETszj
    Should Contain    ${output}    sequencerScriptIdentifier : 78.8767
    Should Contain    ${output}    sequencerScriptTimestamp : teGfuuRZPEAjSGfdRUiryFCdIbOgeWicdmSIBFrqbdyVhJcDgQEQrxRTjghEoZRwJvVBpqxoQauvsZxMfAxZdFfaHuHYzYSdEoLpJavKUylzSZVMvFbDSaijHmyUaSXgWjAPondvOCSsgWrdcAKWJBdPFaIUiLHdvgZWtgrdfVhNchgGPlMXSKyuniofiEUABvfsxPPYBbtYtPFOmsYZXpTyLmptxfpdLzEalHrQQhPyeSpIEAcTpeUyhABNsZKE
    Should Contain    ${output}    sequencerScriptLineNumber : 1631937519
    Should Contain    ${output}    sequencerScriptErrorCode : -1385600219
    Should Contain    ${output}    sequencerScriptErrorText : gMjGEjgETeGAOaOclQVVXlRkaljKdzEQShYpXpbPxtfgFVNhBvkowaCwHxMxEEUVxAiFWgKffTrumtxkGJjMHAhLqxDCzUtIObsWpKEBsGwaTcyYBWtUtrttocbbgHtSSRdEYCYFAecPjflFokuTohzPNPFZXAfKTMQOINOYojXbdDuZYmmAEfRtCHXWOSkUwfpSgNgCmDTdidXeNvcRNEOYhjBJNajqyqYDRaOlPptWuoMsEfWYEIIxBvPQRqSu
    Should Contain    ${output}    priority : 2118724679
