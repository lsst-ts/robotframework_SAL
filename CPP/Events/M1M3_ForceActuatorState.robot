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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 83.965 -20604 -22343 29324 1980 3202 22884 -11417 17134 23226 -15354 -28092 -7136 18768 28119 16990 -17210 -6067 113 2044 27094 30372 20620 -227 7606 -8816 -4940 21545 -24757 15978 -14900 -31339 9228 15864 -12550 -22563 1280 4209 7254 -31747 27730 21741 27728 28001 -4939 -19923 17998 -14737 28521 4755 19780 -6689 27240 -28490 -2389 -21732 8511 -14191 2049 21105 11943 -24370 -2929 -7019 11741 -400 -17785 -29539 3302 30871 5315 -10986 3558 -30511 1601 12952 -25905 -26324 -1278 -7669 -32134 15762 31016 -677 13375 -29234 11963 29956 5936 32687 -13550 17644 -17103 18331 -19946 3148 26991 24028 18615 -4203 18341 18586 -19556 -22502 -10428 -24904 -27406 -21554 -7637 24768 -8791 -7886 -27300 -7571 -26390 -11983 -2840 1732 10704 12545 4983 -25638 -7603 26178 2508 -16562 970 11492 -25544 -21845 18324 -1379 18870 -21603 -5146 -23949 -21293 7702 -15347 21886 18224 5746 4667 -32159 -7249 -15187 -2545 20560 -27407 -18248 -20048 474 2783 -10382 -27652 24261 -12366 1 1 1 1 0 1 0 1 1 1 1 0.906177680394 -451046295
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -451046295
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 83.965
    Should Contain    ${output}    ILCState : -20604
    Should Contain    ${output}    SlewFlag : -22343
    Should Contain    ${output}    StaticForcesApplied : 29324
    Should Contain    ${output}    ElevationForcesApplied : 1980
    Should Contain    ${output}    AzimuthForcesApplied : 3202
    Should Contain    ${output}    ThermalForcesApplied : 22884
    Should Contain    ${output}    OffsetForcesApplied : -11417
    Should Contain    ${output}    AccelerationForcesApplied : 17134
    Should Contain    ${output}    VelocityForcesApplied : 23226
    Should Contain    ${output}    ActiveOpticForcesApplied : -15354
    Should Contain    ${output}    AberrationForcesApplied : -28092
    Should Contain    ${output}    BalanceForcesApplied : -7136
    Should Contain    ${output}    SupportPercentage : 18768
    Should Contain    ${output}    priority : 28119
