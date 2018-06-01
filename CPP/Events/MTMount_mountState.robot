*** Settings ***
Documentation    MTMount_mountState communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    MTMount
${component}    mountState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 1187613792 EYuipvqLjuTmzQgphuJqHtXcbavVBeTEiCyQyLTtqqNpQkHfzVWBLDiLPrzesBDKwIsSdKlyMBLGbouAXrpxihauaULBsmNfDvctTqggJQFvLNEYQxmKIvefgciibxRddzkVRUKJHGJwzmsjYUSORWnefobUIlIbveMyPxBjXmSYPnFhwrvzYVdbkUICrcXTJBRSGgXheBYXTkjuNMJPvwEUkyUcFxAvWJDmlxXFGBqtLasorqaPTPXqUNeiLYPStviDsTPwEXRJsPXHMAGXDowPtyCpeXwbOvXqHyfnpqmCynRBUcwcPxtrDvMTfpFpyePVpQNaRtAriuUmNWcdkFhKMoUpKxRWrRJyGsZmsIWdfzeQPGgAWsbrFsvGguZWsMwripFhfuytvVoEjbIAUBMmsOvVyoHvJIRIweZPGWAIJFgjcOVWkoHRIXZdhNdGToUNmoExgEMsRjDpuAHHIXeYseKIGCVliIufZCFzrd 640772667
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] MTMount::logevent_mountState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event mountState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 640772667
    Log    ${output}
    Should Contain X Times    ${output}    === Event mountState received =     1
    Should Contain    ${output}    id : 1187613792
    Should Contain    ${output}    text : EYuipvqLjuTmzQgphuJqHtXcbavVBeTEiCyQyLTtqqNpQkHfzVWBLDiLPrzesBDKwIsSdKlyMBLGbouAXrpxihauaULBsmNfDvctTqggJQFvLNEYQxmKIvefgciibxRddzkVRUKJHGJwzmsjYUSORWnefobUIlIbveMyPxBjXmSYPnFhwrvzYVdbkUICrcXTJBRSGgXheBYXTkjuNMJPvwEUkyUcFxAvWJDmlxXFGBqtLasorqaPTPXqUNeiLYPStviDsTPwEXRJsPXHMAGXDowPtyCpeXwbOvXqHyfnpqmCynRBUcwcPxtrDvMTfpFpyePVpQNaRtAriuUmNWcdkFhKMoUpKxRWrRJyGsZmsIWdfzeQPGgAWsbrFsvGguZWsMwripFhfuytvVoEjbIAUBMmsOvVyoHvJIRIweZPGWAIJFgjcOVWkoHRIXZdhNdGToUNmoExgEMsRjDpuAHHIXeYseKIGCVliIufZCFzrd
    Should Contain    ${output}    priority : 640772667
