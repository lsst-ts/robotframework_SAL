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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 36.1446 -11847 -23582 -4537 -19726 -6607 13730 -3017 -31127 11984 2707 -15170 -17629 9047 -10017 -2759 -7547 -21738 19853 test test test test test test -30959 -7085 -14277 -24100 7098 -7585 25962 7132 10682 -16388 -20402 -375 25939 -14042 -20569 14835 -8554 24234 12791 12735 9707 3499 5653 -4636 test test test test test test -26692 -19728 12274 9470 -16351 2760 27059 2216 4493 -27027 -14920 -31907 29398 31440 8554 -26605 -150 18135 -1881374018
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1881374018
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 36.1446
    Should Contain    ${output}    ReferenceId : -11847
    Should Contain    ${output}    ModbusSubnet : -23582
    Should Contain    ${output}    ModbusAddress : -4537
    Should Contain    ${output}    ILCUniqueId : -19726
    Should Contain    ${output}    ILCApplicationType : -6607
    Should Contain    ${output}    NetworkNodeType : 13730
    Should Contain    ${output}    MajorRevision : -3017
    Should Contain    ${output}    MinorRevision : -31127
    Should Contain    ${output}    MezzanineUniqueId : 11984
    Should Contain    ${output}    MezzanineFirmwareType : 2707
    Should Contain    ${output}    MezzanineMajorRevision : -15170
    Should Contain    ${output}    MezzanineMinorRevision : -17629
    Should Contain    ${output}    priority : 9047
