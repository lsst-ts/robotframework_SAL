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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 59.0463 68.6404 5.1587 1.2916 51.7133 26.3609 53.5703 76.1341 2.6746 80.2942 54.0832 8.0257 31.2167 59.2385 34.108 68.3974 13.4454 60.8674 99.9089 90.515 79.3436 16.6 47.9483 33.0432 79.1212 44.3654 79.9458 80.2626 79.8811 22.0016 90.8049 44.6342 83.4598 46.0692 12.9051 61.0326 60.0044 52.0217 50.0345 64.6756 21.2146 36.385 18.2886 19.1157 81.487 70.6883 12.0033 4.2503 78.8228 97.5787 46.7616 70.9944 89.6067 4.3846 24.174 37.1751 55.2335 92.9558 71.9873 89.8627 96.5541 -1555153962
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1555153962
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 59.0463
    Should Contain    ${output}    Timestep : 68.6404
    Should Contain    ${output}    P : 5.1587
    Should Contain    ${output}    I : 1.2916
    Should Contain    ${output}    D : 51.7133
    Should Contain    ${output}    N : 26.3609
    Should Contain    ${output}    CalculatedA : 53.5703
    Should Contain    ${output}    CalculatedB : 76.1341
    Should Contain    ${output}    CalculatedC : 2.6746
    Should Contain    ${output}    CalculatedD : 80.2942
    Should Contain    ${output}    CalculatedE : 54.0832
    Should Contain    ${output}    priority : 8.0257
