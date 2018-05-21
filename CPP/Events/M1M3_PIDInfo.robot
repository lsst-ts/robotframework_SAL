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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 95.6984 36.4614 73.7136 70.3647 67.6154 91.4388 58.5942 62.8805 37.7879 34.8101 79.0822 12.762 56.829 49.8136 76.9717 67.403 7.3513 13.4983 38.7296 50.6372 42.5263 47.1078 31.7714 20.6275 58.163 57.3218 23.8973 22.1395 39.5337 57.1538 5.9933 55.7756 70.607 46.0972 41.4716 84.6302 83.4113 55.1878 78.1018 47.2284 68.2053 53.4099 72.3995 3.306 25.9768 18.3179 24.1415 86.7799 36.0471 31.7896 85.1208 74.7337 59.7056 37.9107 96.6121 1.9517 23.1923 73.4488 20.2975 78.659 40.4184 -2119744363
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2119744363
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 95.6984
    Should Contain    ${output}    Timestep : 36.4614
    Should Contain    ${output}    P : 73.7136
    Should Contain    ${output}    I : 70.3647
    Should Contain    ${output}    D : 67.6154
    Should Contain    ${output}    N : 91.4388
    Should Contain    ${output}    CalculatedA : 58.5942
    Should Contain    ${output}    CalculatedB : 62.8805
    Should Contain    ${output}    CalculatedC : 37.7879
    Should Contain    ${output}    CalculatedD : 34.8101
    Should Contain    ${output}    CalculatedE : 79.0822
    Should Contain    ${output}    priority : 12.762
