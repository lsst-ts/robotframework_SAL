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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 52.1273 28871 -29050 26406 12628 21944 29454 -28149 -16476 28481 23307 -7166 18387 25770 -19825 -17817 -23732 -11986 127 test test test test test test -14475 -13684 7160 -23934 21544 -24246 -29185 -24282 9123 19140 13643 -8717 -20865 -5098 16424 -26047 3773 17503 1859 -17079 8452 15475 -26734 -12518 test test test test test test -28622 -2910 -6001 16058 14529 25734 -6876 32212 -16835 2549 -4817 -27040 -14679 -2499 -32091 1097 20272 -5339 -378988506
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -378988506
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 52.1273
    Should Contain    ${output}    ReferenceId : 28871
    Should Contain    ${output}    ModbusSubnet : -29050
    Should Contain    ${output}    ModbusAddress : 26406
    Should Contain    ${output}    ILCUniqueId : 12628
    Should Contain    ${output}    ILCApplicationType : 21944
    Should Contain    ${output}    NetworkNodeType : 29454
    Should Contain    ${output}    MajorRevision : -28149
    Should Contain    ${output}    MinorRevision : -16476
    Should Contain    ${output}    MezzanineUniqueId : 28481
    Should Contain    ${output}    MezzanineFirmwareType : 23307
    Should Contain    ${output}    MezzanineMajorRevision : -7166
    Should Contain    ${output}    MezzanineMinorRevision : 18387
    Should Contain    ${output}    priority : 25770
