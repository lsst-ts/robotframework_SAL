*** Settings ***
Documentation    M1M3_PIDInfo communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 80.1629 2.3637 83.1831 74.0544 12.5294 52.9825 91.5435 77.4044 79.6494 14.2749 44.807 65.6694 53.735 51.0823 41.1649 72.9168 59.3692 55.0977 90.781 62.1153 51.5846 71.772 43.9355 46.4361 16.7042 81.3953 42.7987 29.2588 65.626 81.2203 3.1575 43.0729 13.9339 95.7728 96.8652 63.3054 91.2203 69.1234 49.7694 7.3879 60.3597 77.4691 38.7234 89.7687 9.9888 21.2143 5.573 97.8746 20.3644 20.3582 93.4023 45.7526 76.2782 54.0971 39.4165 40.1172 83.0054 28.4658 83.164 54.1414 61.0019 -468327778
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -468327778
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 80.1629
    Should Contain    ${output}    Timestep : 2.3637
    Should Contain    ${output}    P : 83.1831
    Should Contain    ${output}    I : 74.0544
    Should Contain    ${output}    D : 12.5294
    Should Contain    ${output}    N : 52.9825
    Should Contain    ${output}    CalculatedA : 91.5435
    Should Contain    ${output}    CalculatedB : 77.4044
    Should Contain    ${output}    CalculatedC : 79.6494
    Should Contain    ${output}    CalculatedD : 14.2749
    Should Contain    ${output}    CalculatedE : 44.807
    Should Contain    ${output}    priority : 65.6694
