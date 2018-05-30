*** Settings ***
Documentation    M1M3_HardpointMonitorInfo communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 0.5957 -27109 13803 5855 -14859 -28057 22387 -18193 24184 -12414 -30294 -1049 1906 -8475 -13666 29605 -21845 -30525 20701 test test test test test test -18462 -27809 -15445 8603 -15410 -2995 17428 -8831 5210 -20754 -14626 -7072 -28942 3269 5222 20819 -31066 27024 -20725 28587 -9189 -13492 -30419 -23818 test test test test test test -8909 -8215 -14713 -26598 10560 23848 20828 -2597 14605 16989 -27610 -11185 -25772 -5850 4097 5911 6983 21076 1178150169
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1178150169
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 0.5957
    Should Contain    ${output}    ReferenceId : -27109
    Should Contain    ${output}    ModbusSubnet : 13803
    Should Contain    ${output}    ModbusAddress : 5855
    Should Contain    ${output}    ILCUniqueId : -14859
    Should Contain    ${output}    ILCApplicationType : -28057
    Should Contain    ${output}    NetworkNodeType : 22387
    Should Contain    ${output}    MajorRevision : -18193
    Should Contain    ${output}    MinorRevision : 24184
    Should Contain    ${output}    MezzanineUniqueId : -12414
    Should Contain    ${output}    MezzanineFirmwareType : -30294
    Should Contain    ${output}    MezzanineMajorRevision : -1049
    Should Contain    ${output}    MezzanineMinorRevision : 1906
    Should Contain    ${output}    priority : -8475
