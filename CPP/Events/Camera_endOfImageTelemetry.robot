*** Settings ***
Documentation    Camera_endOfImageTelemetry sender/logger tests.
Force Tags    cpp    TSS-2677
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    endOfImageTelemetry
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send WcNKtKANqNzruwSEVdtMmJNsBeOTGzuYjJobcrOupySIqLSdEsCoZWIyboCqJKYNTwCOwntLTytfVhlUMOplByPhQrSVIWabIeTZsKSbPRzxEMUqHiywEzBKvJkweNpdphadUQjCwcSqxnKPpbwiMZIejdbproAHUEWcbnZcqkwYOJoesRIVJelGpcBQRCvxSFrsoHuRsdxGbbAmtzxjDMWLOkbFlmkHMhcrsKDamUZkeoqJxIygJesFXiTIzALV dLHkDGuRviNpjlWsWqEDftzbkFCtXwcKcTBWWrtKFDPnTkmttkEPTsdrDKySzItFNFEDfhmmgbcOUKTCpJaNeguAXaeIpESPalRTPlZihIBESswZVamAUNxgMAZESgxmmAKLofXDQKSCSFqTrqhCsWqlfyKnqEhorfaCeIbcqWjzRWJQNrvKQnWRQXtDsXMnJrZwsgPUueeIirRfQbQzZNGIKDNElBhFSHcIqYAxYEdnQKcgmADkwsRIiuZULGQw -84433425 78.341 91.6517 -789721167
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] camera::logevent_endOfImageTelemetry writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event endOfImageTelemetry generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -789721167
    Log    ${output}
    Should Contain X Times    ${output}    === Event endOfImageTelemetry received =     1
    Should Contain    ${output}    imageSequenceName : WcNKtKANqNzruwSEVdtMmJNsBeOTGzuYjJobcrOupySIqLSdEsCoZWIyboCqJKYNTwCOwntLTytfVhlUMOplByPhQrSVIWabIeTZsKSbPRzxEMUqHiywEzBKvJkweNpdphadUQjCwcSqxnKPpbwiMZIejdbproAHUEWcbnZcqkwYOJoesRIVJelGpcBQRCvxSFrsoHuRsdxGbbAmtzxjDMWLOkbFlmkHMhcrsKDamUZkeoqJxIygJesFXiTIzALV
    Should Contain    ${output}    imageName : dLHkDGuRviNpjlWsWqEDftzbkFCtXwcKcTBWWrtKFDPnTkmttkEPTsdrDKySzItFNFEDfhmmgbcOUKTCpJaNeguAXaeIpESPalRTPlZihIBESswZVamAUNxgMAZESgxmmAKLofXDQKSCSFqTrqhCsWqlfyKnqEhorfaCeIbcqWjzRWJQNrvKQnWRQXtDsXMnJrZwsgPUueeIirRfQbQzZNGIKDNElBhFSHcIqYAxYEdnQKcgmADkwsRIiuZULGQw
    Should Contain    ${output}    imageIndex : -84433425
    Should Contain    ${output}    timeStamp : 78.341
    Should Contain    ${output}    exposureTime : 91.6517
    Should Contain    ${output}    priority : -789721167
