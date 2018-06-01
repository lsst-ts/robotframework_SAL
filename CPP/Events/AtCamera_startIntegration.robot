*** Settings ***
Documentation    AtCamera_startIntegration communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    startIntegration
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send VYSmhmuyYtoaZAfNopkgJfqysoZXdxenwTrIYnkqaamSvyYYJAoJdMJRaWYSsaXWiFnZqDKHczRwAXoPQXQGVKlnRtRHhMNNVWAZtQBwwQDhJkUOOeqyxVvtAxmiqaOgjpAVAiKMLaOKIqFwYAcqsBqPSaMGdRvGOkyxacmmBmRpLiazvmbJRUxknewCBlavqrVomAkBkbLuVNJXQQxcGMtmoCIxDihDqYvkrzWUxFSSBCuppUFWqxsWsNeuguoL 849554156 jyUnzTgWIRmYutiSdcceuonYDJstHjssenyXeAymofYarGQOfhHAkSPDNNMvXEchQEjZJJZJIEGWJGDGBPImNpbkoMjNyfVcceHgpLhinrgjHTysbibZnPUuSduGIYWXJpzFeqUYJixNYYwwwDkrMOeIfEngNznxNVsBAJunehvrpDRoAjsEbaxeUPjcifvkqMEapBoOxoKxEDSzFneLprcowjYAubmtcmgUnVNqmYeNmtWWGCCgEYYaJlNtclAn 1901070522 80.043 0.9738 -1078265474
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_startIntegration writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startIntegration generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1078265474
    Log    ${output}
    Should Contain X Times    ${output}    === Event startIntegration received =     1
    Should Contain    ${output}    imageSequenceName : VYSmhmuyYtoaZAfNopkgJfqysoZXdxenwTrIYnkqaamSvyYYJAoJdMJRaWYSsaXWiFnZqDKHczRwAXoPQXQGVKlnRtRHhMNNVWAZtQBwwQDhJkUOOeqyxVvtAxmiqaOgjpAVAiKMLaOKIqFwYAcqsBqPSaMGdRvGOkyxacmmBmRpLiazvmbJRUxknewCBlavqrVomAkBkbLuVNJXQQxcGMtmoCIxDihDqYvkrzWUxFSSBCuppUFWqxsWsNeuguoL
    Should Contain    ${output}    imagesInSequence : 849554156
    Should Contain    ${output}    imageName : jyUnzTgWIRmYutiSdcceuonYDJstHjssenyXeAymofYarGQOfhHAkSPDNNMvXEchQEjZJJZJIEGWJGDGBPImNpbkoMjNyfVcceHgpLhinrgjHTysbibZnPUuSduGIYWXJpzFeqUYJixNYYwwwDkrMOeIfEngNznxNVsBAJunehvrpDRoAjsEbaxeUPjcifvkqMEapBoOxoKxEDSzFneLprcowjYAubmtcmgUnVNqmYeNmtWWGCCgEYYaJlNtclAn
    Should Contain    ${output}    imageIndex : 1901070522
    Should Contain    ${output}    timeStamp : 80.043
    Should Contain    ${output}    exposureTime : 0.9738
    Should Contain    ${output}    priority : -1078265474
