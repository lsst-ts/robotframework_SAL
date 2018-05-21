*** Settings ***
Documentation    Sequencer_sequencerScriptError sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send TjIKYBLRxjRcmpyekfCiTIKPVOCaQWiNDpMOBUcouKpjGCzhBTXKToZbIsLKgIHBXPZYlOfRKUlTctKycMzbaFqwjWoxUrjsinUkggunKzjQpekEWHzTibfmenUrfaUmTtLxGIUcJpmmCHZNSjGJAwsRczFNFaIWrFNIWAvoPVhAPXOEaEnwuGMGIAsxniewdtnsJaXjTOmKQUGuLcfxlmgWaopJCsGJlSHvyHXzVeGwtbRfPYVysxooxTozNGUh 75.3552 QWDYsWMDJOmliKtrjBJxqsWaoMTwUxmMnWHBvOKNDPHStXFqBeRbdhyHUxzfryuRSxePdvEhhfDolzQWLSLpfPVSFTcLhkJWbtVWearXWBiNhUJIJDlQnVvASFkKUPAiOOAlsyuQhqgmFQeBkNxgmvNitqtvQSnFaWUlPViNtKxrIdwfCXjlhbyplLGDiWtGxixNuzQImxmppRlZgfKsBAzVwkJLWEhERkrVwprFCsKeCofdsqGKfLwlzbmNIQnL 1479990329 -1840842601 odTTTpJdDejjsgalSMJmKaxbMhQBjrhTDOsmFdtSSTcqLmjUxKYpZdtGUxsipkZlvSUsHGdyrRcRdPxLUNylbPoCKmJyHxYcoqfUxEaepyGHDJhQkKNPraGmdcqFQCkczBDtYuWnoSSdfwVCpcbTAVigaNitxZGBRQfFgYiskzTJixHnCvpkburdqzDkVILLjPaGOwpIpKAsSleXxQjNJcoHdxeIGxnZfIbTCJBfilplfVwGrQigNbmVDFodyCXk -1647382925
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1647382925
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptError received =     1
    Should Contain    ${output}    sequencerScriptName : TjIKYBLRxjRcmpyekfCiTIKPVOCaQWiNDpMOBUcouKpjGCzhBTXKToZbIsLKgIHBXPZYlOfRKUlTctKycMzbaFqwjWoxUrjsinUkggunKzjQpekEWHzTibfmenUrfaUmTtLxGIUcJpmmCHZNSjGJAwsRczFNFaIWrFNIWAvoPVhAPXOEaEnwuGMGIAsxniewdtnsJaXjTOmKQUGuLcfxlmgWaopJCsGJlSHvyHXzVeGwtbRfPYVysxooxTozNGUh
    Should Contain    ${output}    sequencerScriptIdentifier : 75.3552
    Should Contain    ${output}    sequencerScriptTimestamp : QWDYsWMDJOmliKtrjBJxqsWaoMTwUxmMnWHBvOKNDPHStXFqBeRbdhyHUxzfryuRSxePdvEhhfDolzQWLSLpfPVSFTcLhkJWbtVWearXWBiNhUJIJDlQnVvASFkKUPAiOOAlsyuQhqgmFQeBkNxgmvNitqtvQSnFaWUlPViNtKxrIdwfCXjlhbyplLGDiWtGxixNuzQImxmppRlZgfKsBAzVwkJLWEhERkrVwprFCsKeCofdsqGKfLwlzbmNIQnL
    Should Contain    ${output}    sequencerScriptLineNumber : 1479990329
    Should Contain    ${output}    sequencerScriptErrorCode : -1840842601
    Should Contain    ${output}    sequencerScriptErrorText : odTTTpJdDejjsgalSMJmKaxbMhQBjrhTDOsmFdtSSTcqLmjUxKYpZdtGUxsipkZlvSUsHGdyrRcRdPxLUNylbPoCKmJyHxYcoqfUxEaepyGHDJhQkKNPraGmdcqFQCkczBDtYuWnoSSdfwVCpcbTAVigaNitxZGBRQfFgYiskzTJixHnCvpkburdqzDkVILLjPaGOwpIpKAsSleXxQjNJcoHdxeIGxnZfIbTCJBfilplfVwGrQigNbmVDFodyCXk
    Should Contain    ${output}    priority : -1647382925
