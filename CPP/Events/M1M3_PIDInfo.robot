*** Settings ***
Documentation    M1M3_PIDInfo sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    PIDInfo
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 12.2118 37.3863 93.9051 0.8324 27.5318 77.3167 6.8869 84.2385 5.5468 32.7891 11.6385 5.1177 55.6024 26.5136 52.9144 50.5509 86.8072 29.9906 18.6988 38.1467 70.9466 97.4195 56.3954 7.23 32.7213 60.4344 92.3294 92.7709 97.3433 20.7439 58.0797 59.6417 70.8428 30.5659 49.1623 54.1786 58.4879 28.9737 49.2358 90.1671 45.3972 59.1189 42.6387 36.2029 70.1682 77.8033 86.044 19.695 86.0678 34.0481 27.1285 54.2867 65.3444 36.3875 94.8418 6.1231 40.8461 84.5328 3.8315 90.9211 24.8818 332858952
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 332858952
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 12.2118
    Should Contain    ${output}    Timestep : 37.3863
    Should Contain    ${output}    P : 93.9051
    Should Contain    ${output}    I : 0.8324
    Should Contain    ${output}    D : 27.5318
    Should Contain    ${output}    N : 77.3167
    Should Contain    ${output}    CalculatedA : 6.8869
    Should Contain    ${output}    CalculatedB : 84.2385
    Should Contain    ${output}    CalculatedC : 5.5468
    Should Contain    ${output}    CalculatedD : 32.7891
    Should Contain    ${output}    CalculatedE : 11.6385
    Should Contain    ${output}    priority : 5.1177
