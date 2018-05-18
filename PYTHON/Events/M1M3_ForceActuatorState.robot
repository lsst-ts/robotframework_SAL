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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 26.4771 29195 11532 23699 20174 29611 -26106 -31436 -32315 -28850 -15883 17579 -31673 -6146 10001 25905 28226 14955 31060 -5956 -1259 2533 -13096 -25578 -11269 -14912 -18109 29501 10907 19601 1831 -29106 12303 -15593 7290 -350 14718 -26207 -27386 -26118 -19371 18953 20258 -841 -22691 6304 -18945 -7147 -11117 -4821 -13237 -22615 -121 7372 -13968 -24796 24812 14766 22551 7746 -11385 17861 -1601 -5463 -25039 -2954 -23921 -32610 13809 21307 13588 20763 18378 -26084 -4878 -6112 18306 -11169 -28674 -21844 2336 8733 -28674 -20121 662 19488 -8786 11036 17990 14313 -5979 14234 5150 -17162 24099 25727 14950 23264 -419 -25059 -7020 -20514 -31624 27941 -1769 28022 14036 10856 30036 -29046 25465 -4884 23859 -8771 -13473 -25105 -14865 31153 14365 16346 -3275 2634 -18492 -5536 -18055 -2603 -29042 -18513 -28968 -2427 -13399 11797 21255 21528 12810 6602 30370 29569 -17606 -18450 21151 -19410 6029 13833 18217 12409 24884 -22394 -27284 -1561 -8593 7844 -30442 -29245 5213 -13534 -18449 1 1 1 0 1 1 0 0 1 1 1 0.727178704135 1510175294
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
