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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 10.8093 -8258 -5923 -11876 -10346 -1570 -18906 17436 -18719 -8388 -9066 -13531 1847 -5373 19766 27863 -28605 -5453 -10575 -13667 10038 6479 14267 22209 14845 8443 -11145 -11325 14779 11764 18049 -19299 29870 -30194 -32 27399 -29536 19369 -14211 11207 -16784 1471 -17373 4510 -12256 -3676 2590 11161 32035 21874 18051 13720 12549 -21663 1241 -30201 -28222 23702 -27889 13143 3699 11701 -3911 -10822 1705 -12555 24788 -25289 30020 3481 26500 -21851 28412 -23128 7114 13134 22111 -10625 -5584 5066 -17599 24939 -25074 10662 -10177 -28220 -5144 -22884 5586 22237 -10648 27514 -5805 7211 31879 -7793 985 32463 -13802 17739 -3757 -9356 -14376 -32736 9270 19943 28768 -6082 951 -6115 19610 -27992 -10692 11351 -23858 -13289 -1203 11000 15393 18300 -2138 13526 19341 5485 -3410 -9944 4623 10177 -20075 2125 30805 395 -29586 25620 6353 17953 10538 7863 -14058 -22454 -19812 7056 -25400 11596 -7856 32595 -9972 -23090 26208 13656 -7637 -31798 -4177 7766 -30229 15204 -20424 0 1 0 1 0 1 0 0 0 1 0 0.0529302367212 92894837
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
