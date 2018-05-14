*** Settings ***
Documentation    M1M3_ForceActuatorState sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceActuatorState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 77.6275 26727 8147 31951 -13589 13655 -1787 24583 -30805 -22741 -14395 17636 -18764 -3432 -2211 12977 -9388 -23689 -21690 13933 -7967 -29477 24736 -12448 9829 -24026 6602 19031 -1117 -2979 26789 6529 -17554 -595 1013 1576 18987 13330 27272 -14724 16926 27862 32402 -30499 -22220 9490 -235 10640 28299 -20577 -22792 12182 30046 -29156 -5993 -22872 15130 -11591 16207 -29781 6216 -1303 -25517 -8434 6614 -29565 19340 -909 15415 24565 11903 -16968 -6381 6655 -26922 -22244 16866 9757 28678 -28963 1625 -26816 -1616 -16615 29184 -22640 -15414 -16014 -17358 2501 -17412 17650 23962 31491 -14393 899 -10356 -11458 -770 -29920 29386 -19605 -3096 14149 -21601 -1087 -19445 -15062 30408 -5570 -4134 30614 -16614 5745 -7410 -13191 -2982 29946 13085 -12081 14456 -30453 19653 -13425 -7020 26809 26305 -7437 22044 -13774 -10146 28303 -31900 28602 -13682 -5148 -20832 15732 -31395 -5643 -28301 21322 -7002 -30743 2776 -26676 9030 30031 -24770 31914 -30862 -23290 -4855 -23302 14294 1593 7204 1 1 1 1 1 1 1 1 0 1 0 0.340355596803 -1202395058
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1202395058
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 77.6275
    Should Contain    ${output}    ILCState : 26727
    Should Contain    ${output}    SlewFlag : 8147
    Should Contain    ${output}    StaticForcesApplied : 31951
    Should Contain    ${output}    ElevationForcesApplied : -13589
    Should Contain    ${output}    AzimuthForcesApplied : 13655
    Should Contain    ${output}    ThermalForcesApplied : -1787
    Should Contain    ${output}    OffsetForcesApplied : 24583
    Should Contain    ${output}    AccelerationForcesApplied : -30805
    Should Contain    ${output}    VelocityForcesApplied : -22741
    Should Contain    ${output}    ActiveOpticForcesApplied : -14395
    Should Contain    ${output}    AberrationForcesApplied : 17636
    Should Contain    ${output}    BalanceForcesApplied : -18764
    Should Contain    ${output}    SupportPercentage : -3432
    Should Contain    ${output}    priority : -2211
