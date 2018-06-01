*** Settings ***
Documentation    M1M3_ForceActuatorState communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 87.1151 30669 263 10136 4003 -15087 -8053 21692 3271 14476 -20161 -23776 30641 3308 21481 -11463 -28453 -31524 -27366 -19772 27290 -27359 -859 -19417 -1598 -5362 11650 -15657 -18377 13598 29031 -9846 11805 10392 16022 -30232 9140 6678 -32617 15658 9833 23581 -2453 30364 -6406 -9692 -1850 679 -24212 -23631 2681 680 13208 14036 -7783 29784 -987 -4108 -14768 15100 27962 28099 -21776 -21407 -7764 -30261 7017 -23749 15870 30004 32583 -25685 19404 17518 -26621 6757 31059 18492 -3750 10586 8013 22948 -28987 -13107 30811 11833 -8791 -24035 -5941 -13616 23857 11820 -867 -2323 30848 -748 29114 -24937 24149 12887 8464 24965 3150 -27264 14969 17271 30260 4665 18599 -29997 18538 -14282 -25813 -3835 -2694 22310 -28924 -19119 -19126 219 4875 -32419 -32283 -16468 24132 14317 -27322 -7634 -28052 29464 -12085 22797 27657 -22407 20136 14049 -900 6875 -19362 -3588 3121 32060 -31492 11072 25475 -12790 -16158 20625 -29156 16550 15680 -20762 32526 -8930 -2038 -3858 19938 0 1 0 1 0 0 1 0 0 1 0 0.868551 -1217376402
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
