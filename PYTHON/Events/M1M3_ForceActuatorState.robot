*** Settings ***
Documentation    M1M3_ForceActuatorState sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 37.5366 19193 -9986 -21054 12091 -23513 -32743 -28109 20825 29794 -16400 32163 -24798 16931 -16174 3124 19161 20110 11750 6668 -10996 23828 30334 12947 7225 -4937 19563 28103 -599 13703 -22670 19600 -21285 -13757 1819 21218 -8079 19908 -6676 -31478 14011 -14533 -13397 10812 -28557 -29469 818 3159 7190 21503 29848 -6851 14188 22888 -3967 -12690 16207 12023 -11772 -811 -20274 -30805 -13902 -12567 17241 10046 -24528 -23355 -23063 -32305 -29418 -23961 5822 23747 27941 -3080 1186 -21921 -21553 -25755 31316 18115 -18395 -21360 12960 -30044 3721 -4567 31303 3507 -27106 -14207 -12280 5068 -4490 -8592 5912 -27501 -6464 25709 -14355 19929 -4698 17877 14640 18002 12615 -30228 11330 -2199 -23278 28621 31502 -7428 29488 14880 -12838 -25432 -6029 -4821 -14881 14190 -31966 20068 -18495 4143 -8430 -31406 26325 4160 -30259 9205 17013 -27793 -783 28024 30160 -21350 20927 11758 26858 -16083 -24973 32373 18672 18109 -7947 9199 25187 6672 7837 13065 27745 21776 -7221 15615 -997 0 1 1 1 1 0 0 1 1 1 1 0.465690491209 -1146358367
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
