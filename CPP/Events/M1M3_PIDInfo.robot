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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 63.2966 27.775 65.0435 32.886 7.7705 44.2272 31.9994 0.8865 89.6029 29.125 21.1552 91.6896 16.673 11.2852 18.9788 69.4438 0.7953 77.2109 98.675 68.9072 75.3349 80.3003 90.239 47.936 13.4281 0.4713 98.4099 95.7782 98.8208 1.3641 29.0979 8.6648 92.0372 28.008 0.8048 19.1061 10.1554 7.1842 19.4566 63.7514 6.9881 65.1702 76.7942 44.8662 78.5361 21.3619 97.5212 24.3713 78.6749 94.3514 14.9078 96.3794 79.9305 68.3895 87.6368 92.6957 81.8512 61.9009 84.4607 81.8961 96.4768 -913158637
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_PIDInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event PIDInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -913158637
    Log    ${output}
    Should Contain X Times    ${output}    === Event PIDInfo received =     1
    Should Contain    ${output}    Timestamp : 63.2966
    Should Contain    ${output}    Timestep : 27.775
    Should Contain    ${output}    P : 65.0435
    Should Contain    ${output}    I : 32.886
    Should Contain    ${output}    D : 7.7705
    Should Contain    ${output}    N : 44.2272
    Should Contain    ${output}    CalculatedA : 31.9994
    Should Contain    ${output}    CalculatedB : 0.8865
    Should Contain    ${output}    CalculatedC : 89.6029
    Should Contain    ${output}    CalculatedD : 29.125
    Should Contain    ${output}    CalculatedE : 21.1552
    Should Contain    ${output}    priority : 91.6896
