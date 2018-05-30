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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 94.3827 21360 28907 18023 159 -22445 -28455 23459 -1545 7407 31623 -32722 26722 -21855 16853 24067 13338 3838 -31114 18869 6265 22884 32703 14828 7695 29475 -20161 -11385 -14521 -6982 -13371 -22823 -21868 -30302 25697 5110 18569 -30472 -2110 3222 -25300 13113 31117 22855 -29625 19525 -13537 23717 -21498 -23785 11703 14170 -9429 -10245 -31826 -30326 10729 -16333 -30459 4129 723 -20643 -8442 -23599 -272 32014 11430 5958 10568 -4458 15083 5625 -22889 -29344 -9889 -3299 -16998 -1420 20695 22672 -11902 7070 -1305 8850 -28865 -1767 -10641 2776 -20719 21150 -27159 -11845 12453 -19023 23660 -16191 -14442 -15628 20642 -21843 3948 -26269 -11080 -11877 -9751 -31925 -21537 11468 9573 10196 6475 21153 -7520 -32734 12869 9410 -25478 29295 11177 -14488 -5575 -29942 -27276 25851 -8664 23594 1947 -30486 27336 3823 -27861 -2865 -15470 13308 -134 32210 -17196 -24059 27021 -19323 7618 -21958 -30698 14720 -21269 -6499 15197 32145 4934 -1220 21264 -9076 15621 31013 -6782 -2804 -1915 0 1 1 0 1 1 1 0 0 0 0 0.692110855958 207975710
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 82.9765 22331 -1092 2232 -9794 28420 32596 5882 -14733 9026 8030 6324 -3077 6334 14744 -24925 -12116 -20553 10519 25718 181 -28627 26579 -18812 -17546 -6308 16181 -21202 -4500 27432 21580 3563 -16735 18446 14682 22056 -13135 14792 19358 15429 32412 -2909 32385 -10480 -18064 -23555 816 -22141 23733 9612 -12495 25734 -28001 -20172 -11719 20206 -6502 -3498 -18902 -4498 -27011 32634 -2993 22881 -23418 -28829 -29902 6632 -326 25969 -18477 24045 14601 -4793 -12366 6030 30141 13769 -4193 25866 3214 11705 -32384 -21763 18881 -9386 -22356 31036 -7927 -31655 -19950 8152 14647 1128 30538 -32753 -28203 -5365 25218 -7701 -1915 10364 25758 -17152 -13928 -12677 16709 -32061 25923 7265 10387 20384 29886 29368 9929 -31472 -15527 -31795 -20905 -19643 -31672 -22134 -2773 -8828 6619 32289 28451 2778 -4004 14038 -8737 -31458 17583 11907 20986 13444 -8757 -2250 12540 -13917 -29202 -12303 -11149 8446 -20344 29044 16939 24969 32034 -12257 -20770 17471 -32525 30780 30627 11277 21967 1 0 0 0 1 0 0 1 1 1 0 0.599978 43718524
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
