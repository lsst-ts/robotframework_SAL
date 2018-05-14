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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 34.6907 55.1333 12.7549 27.1671 15.9799 41.1327 66.4867 20.4225 96.9088 30.4449 56.8712 85.8291 27.2428 13.1175 16.1222 62.9535 19.7046 6.7489 47.1346 27.2226 82.6674 13.0384 43.6611 85.5989 60.5733 21.0802 33.3058 65.9273 71.4367 34.3573 17.8384 73.657 57.6807 9.7924 87.692 97.6814 83.591 5.4818 35.7404 41.9181 46.7647 3.5946 23.8233 80.4748 30.7744 64.0501 64.5856 34.6564 4.1492 38.7505 16.4183 72.3047 52.5004 39.3986 60.7703 74.0051 44.5014 38.2211 64.185 15.3135 49.5292 1067865058
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1067865058
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 34.6907
    Should Contain    ${output}    Timestep : 55.1333
    Should Contain    ${output}    P : 12.7549
    Should Contain    ${output}    I : 27.1671
    Should Contain    ${output}    D : 15.9799
    Should Contain    ${output}    N : 41.1327
    Should Contain    ${output}    CalculatedA : 66.4867
    Should Contain    ${output}    CalculatedB : 20.4225
    Should Contain    ${output}    CalculatedC : 96.9088
    Should Contain    ${output}    CalculatedD : 30.4449
    Should Contain    ${output}    CalculatedE : 56.8712
    Should Contain    ${output}    priority : 85.8291
