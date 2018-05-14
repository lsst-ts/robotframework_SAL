*** Settings ***
Documentation    AtCamera_startReadout sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    startReadout
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send aCIvmoaWPdzEnbCYTARzrYKWbExVMJtdIjeENYEMsHFilmhTESGjrDfDkEUVYqbnPpfMZslUgKlhUIdrTYBfXppJXPjUPvzQplKTJGintxpCARUMYAuGNbPlGxzFIbWuHjPueFExIoYnnazrkQjjtUwNABuypFEEdQJHjjtwwgVekloxwBFDxYuFGqMnlLuSYeGRftgQLLOXBDOONJICyJAxlVsVVCfMQtypBYWwkRvchxgoMMncXYUvcaDxTkWu -922557711 oRpySBMiywzvRoDoOMQExMWKCpjUqDSxAqGstBlMDVBEFRUzJiCrEdNVpIwbYpLDlPLHxtTqmKcbrIPsnGPFNEMIvaadtzDSYrlwloFgGmfdYcdtsJafGHZZUxqXRiaGGmtlQHLfcXsKarYUKpnYmOtTHvdfTgjHpSDWjopnRtaFLSKCkmIwzskKrnXYgDhGrQjPTJJZHiRnemUceMoWHmJZJVUCHPMWAHeiKihRcCekfyEmZjFvoQzhgweJitIw 492924041 37.8733 56.9614 455268546
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_startReadout writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startReadout generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 455268546
    Log    ${output}
    Should Contain X Times    ${output}    === Event startReadout received =     1
    Should Contain    ${output}    imageSequenceName : aCIvmoaWPdzEnbCYTARzrYKWbExVMJtdIjeENYEMsHFilmhTESGjrDfDkEUVYqbnPpfMZslUgKlhUIdrTYBfXppJXPjUPvzQplKTJGintxpCARUMYAuGNbPlGxzFIbWuHjPueFExIoYnnazrkQjjtUwNABuypFEEdQJHjjtwwgVekloxwBFDxYuFGqMnlLuSYeGRftgQLLOXBDOONJICyJAxlVsVVCfMQtypBYWwkRvchxgoMMncXYUvcaDxTkWu
    Should Contain    ${output}    imagesInSequence : -922557711
    Should Contain    ${output}    imageName : oRpySBMiywzvRoDoOMQExMWKCpjUqDSxAqGstBlMDVBEFRUzJiCrEdNVpIwbYpLDlPLHxtTqmKcbrIPsnGPFNEMIvaadtzDSYrlwloFgGmfdYcdtsJafGHZZUxqXRiaGGmtlQHLfcXsKarYUKpnYmOtTHvdfTgjHpSDWjopnRtaFLSKCkmIwzskKrnXYgDhGrQjPTJJZHiRnemUceMoWHmJZJVUCHPMWAHeiKihRcCekfyEmZjFvoQzhgweJitIw
    Should Contain    ${output}    imageIndex : 492924041
    Should Contain    ${output}    timeStamp : 37.8733
    Should Contain    ${output}    exposureTime : 56.9614
    Should Contain    ${output}    priority : 455268546
