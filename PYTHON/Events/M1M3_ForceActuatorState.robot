*** Settings ***
Documentation    M1M3_ForceActuatorState sender/logger tests.
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
${component}    ForceActuatorState
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ILCState SlewFlag StaticForcesApplied ElevationForcesApplied AzimuthForcesApplied ThermalForcesApplied OffsetForcesApplied AccelerationForcesApplied VelocityForcesApplied ActiveOpticForcesApplied AberrationForcesApplied BalanceForcesApplied SupportPercentage priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 16.4308 -26995 1053 15434 25771 16362 13579 28796 16721 -566 28664 16636 -23892 22955 -21069 -30320 -17578 -24337 8993 9385 -18472 16601 -7538 -31937 23725 -3199 19978 14378 7200 -28071 -29407 29983 12777 29882 24273 -7610 26602 881 -1114 -9 2156 13708 -16042 3451 -16692 -2940 -28286 -12872 -17843 -269 -24948 -13357 23189 -26756 19944 19979 -15979 -9185 19460 28481 19506 14959 8608 -6530 -27520 -24268 -9300 19922 15816 6523 22689 3749 -25310 7112 -6941 -12342 -19551 17424 7201 27017 -30287 -32311 -18999 -23532 15089 -32425 28826 -13557 -26082 27951 -8446 26462 10852 -1991 20516 -8889 -21325 23986 -21596 10714 -5667 366 -9618 -9030 15500 28622 -27351 -22256 3299 5765 12118 31718 18556 9865 15648 -26943 24012 -25447 3617 2308 4132 -10109 20946 -12333 -9017 -2418 95 -6402 2940 13794 -14487 -9212 -27453 7580 -13765 13848 -27535 12486 -3081 12994 -13275 -29931 -3806 4154 -39 -28749 -32727 13288 -28435 -4640 19338 -20251 29477 32543 -12862 -12733 21363 0 0 0 0 1 0 1 0 0 1 0 0.976121327833 1026295334
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
