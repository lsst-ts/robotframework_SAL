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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 4.1302 1821 -9677 -25923 23261 29267 -31331 23927 1789 24253 -9399 -21193 -30658 31685 4998 13959 16429 -29569 -4858 test test test test test test -17672 -13556 -25539 19780 28481 19159 -24468 -23998 32347 -16953 -23502 -18749 -20282 -26899 11438 6494 -19823 -17966 13666 2257 -14457 -24090 -1695 19166 test test test test test test -21323 14692 -21911 -6347 17396 6961 -631 -19151 -10654 20399 25131 -1359 32650 21889 -12821 24908 28935 2497 -1495634950
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1495634950
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 4.1302
    Should Contain    ${output}    ReferenceId : 1821
    Should Contain    ${output}    ModbusSubnet : -9677
    Should Contain    ${output}    ModbusAddress : -25923
    Should Contain    ${output}    ILCUniqueId : 23261
    Should Contain    ${output}    ILCApplicationType : 29267
    Should Contain    ${output}    NetworkNodeType : -31331
    Should Contain    ${output}    MajorRevision : 23927
    Should Contain    ${output}    MinorRevision : 1789
    Should Contain    ${output}    MezzanineUniqueId : 24253
    Should Contain    ${output}    MezzanineFirmwareType : -9399
    Should Contain    ${output}    MezzanineMajorRevision : -21193
    Should Contain    ${output}    MezzanineMinorRevision : -30658
    Should Contain    ${output}    priority : 31685
