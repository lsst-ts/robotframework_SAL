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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 66.2516 -286 -29966 20432 -3979 -19092 -4858 13835 30179 -16417 -24409 -9795 20290 17509 1752 -26816 -18190 28578 32492 test test test test test test -1460 16061 -8343 -18519 -32120 -14599 2182 -5057 31068 -28576 12964 -24857 -11645 25886 -28079 26575 26043 -5759 5665 9799 16677 19769 -25547 -28605 test test test test test test 24913 -2212 -19737 19925 -32750 28093 4986 20531 -1311 10477 -22421 25304 562 25120 -3503 28651 -6137 -10593 -948470662
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointMonitorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointMonitorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -948470662
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointMonitorInfo received =     1
    Should Contain    ${output}    Timestamp : 66.2516
    Should Contain    ${output}    ReferenceId : -286
    Should Contain    ${output}    ModbusSubnet : -29966
    Should Contain    ${output}    ModbusAddress : 20432
    Should Contain    ${output}    ILCUniqueId : -3979
    Should Contain    ${output}    ILCApplicationType : -19092
    Should Contain    ${output}    NetworkNodeType : -4858
    Should Contain    ${output}    MajorRevision : 13835
    Should Contain    ${output}    MinorRevision : 30179
    Should Contain    ${output}    MezzanineUniqueId : -16417
    Should Contain    ${output}    MezzanineFirmwareType : -24409
    Should Contain    ${output}    MezzanineMajorRevision : -9795
    Should Contain    ${output}    MezzanineMinorRevision : 20290
    Should Contain    ${output}    priority : 17509
