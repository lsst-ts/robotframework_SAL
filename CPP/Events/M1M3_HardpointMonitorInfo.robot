*** Settings ***
Documentation    M1M3_HardpointMonitorInfo sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointMonitorInfo
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 92.2576 6846 -20150 27362 -30608 19786 26440 -18396 24931 19265 -11167 6155 -9754 -29867 10426 -27367 29466 -29801 3607 test test test test test test -32575 -28189 -5164 -27018 -26149 -4955 -1853 10482 -14168 21611 -15095 2292 -31771 -20457 -32565 3493 29054 17830 26936 -20490 -9812 3014 31768 -25029 test test test test test test -29970 13632 28449 -20405 -24204 23024 11884 9428 -19788 20982 32186 31696 28844 209 21434 18431 27658 -9199 594234650
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 594234650
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 92.2576
    Should Contain    ${output}    ReferenceId : 6846
    Should Contain    ${output}    ModbusSubnet : -20150
    Should Contain    ${output}    ModbusAddress : 27362
    Should Contain    ${output}    ILCUniqueId : -30608
    Should Contain    ${output}    ILCApplicationType : 19786
    Should Contain    ${output}    NetworkNodeType : 26440
    Should Contain    ${output}    MajorRevision : -18396
    Should Contain    ${output}    MinorRevision : 24931
    Should Contain    ${output}    MezzanineUniqueId : 19265
    Should Contain    ${output}    MezzanineFirmwareType : -11167
    Should Contain    ${output}    MezzanineMajorRevision : 6155
    Should Contain    ${output}    MezzanineMinorRevision : -9754
    Should Contain    ${output}    priority : -29867
