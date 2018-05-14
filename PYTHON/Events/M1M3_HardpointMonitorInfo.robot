*** Settings ***
Documentation    M1M3_HardpointMonitorInfo sender/logger tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointMonitorInfo
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ModbusSubnet ModbusAddress ILCUniqueId ILCApplicationType NetworkNodeType MajorRevision MinorRevision MezzanineUniqueId MezzanineFirmwareType MezzanineMajorRevision MezzanineMinorRevision priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 52.6666 -4724 6756 14042 -11736 10529 30226 -5498 13553 21777 25624 -32557 -8960 19097 -27832 4079 -16759 -17929 29253 test test test test test test 2254 -28497 -5852 -24451 -29071 -12973 3673 -1608 192 -5227 21825 847 7263 19288 14618 -19510 -22740 2053 7032 26954 -8301 -13878 26589 -7382 test test test test test test 7441 2384 16487 -24171 -23895 -1819 1707 19598 5178 -22563 -18544 27892 -25496 -11441 6160 -16380 9590 8110 1721479504
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
