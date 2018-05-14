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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 81.7862 10545 13969 -19491 -7560 -10999 9805 -16581 3619 10747 -241 23103 6406 -11621 3187 20640 16472 3735 30365 25129 2207 -3672 29530 7658 -22505 -18489 20990 22533 25095 10481 -12748 -18070 -28281 26928 30805 -9298 10871 30317 -11435 -9352 8051 -14916 26873 8496 -22166 -28769 6054 -12829 -20246 24122 24710 -10121 1705 29501 -13722 24174 -8127 31559 6183 21516 10522 -11801 20564 -31863 24407 -17504 30802 -5224 31700 -26953 -420 14403 -9378 -8274 -18178 -10299 29631 19672 18935 -9293 5800 18540 -14932 19639 -25814 10385 2510 30705 5415 1744 30620 -19151 -21417 6922 30684 26369 14594 16670 -24372 -6929 18340 -5849 5374 7613 30519 -3650 28941 32385 28467 -6994 25817 -15770 -8976 296 22862 -3862 12269 19448 -2646 -89 7062 -25298 6234 -24100 -1226 3078 14188 28378 -5869 -25373 -9165 -22391 25129 32503 -12341 5516 27246 -13812 -20293 -27203 10664 -17126 -32637 8199 29478 2052 -26989 2764 20764 18854 29391 -10078 -32247 -8221 25410 819 412 1 0 0 1 0 1 0 0 0 1 0 0.934399065074 1948855214
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1948855214
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 81.7862
    Should Contain    ${output}    ILCState : 10545
    Should Contain    ${output}    SlewFlag : 13969
    Should Contain    ${output}    StaticForcesApplied : -19491
    Should Contain    ${output}    ElevationForcesApplied : -7560
    Should Contain    ${output}    AzimuthForcesApplied : -10999
    Should Contain    ${output}    ThermalForcesApplied : 9805
    Should Contain    ${output}    OffsetForcesApplied : -16581
    Should Contain    ${output}    AccelerationForcesApplied : 3619
    Should Contain    ${output}    VelocityForcesApplied : 10747
    Should Contain    ${output}    ActiveOpticForcesApplied : -241
    Should Contain    ${output}    AberrationForcesApplied : 23103
    Should Contain    ${output}    BalanceForcesApplied : 6406
    Should Contain    ${output}    SupportPercentage : -11621
    Should Contain    ${output}    priority : 3187
