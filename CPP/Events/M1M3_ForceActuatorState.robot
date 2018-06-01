*** Settings ***
Documentation    M1M3_ForceActuatorState communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 6.4898 -11332 -14453 -29648 2443 6488 -27643 29370 24988 -312 21488 32141 -25879 29583 29234 -26935 -17909 -32084 -8274 8210 -454 -9989 20272 -1717 -29848 -26581 32586 13526 -21800 10944 8568 -2012 -27794 32511 -32281 5059 1863 -17402 -18410 -28801 14678 -29245 31738 -31988 7954 7864 3235 29492 -17743 -789 -9487 -27743 -22068 28473 -25700 -26173 20742 -17549 -10887 10323 -23238 -21939 27571 19694 -11626 -17145 -20881 -25904 -27877 5526 -10288 -10110 19408 -22824 1018 6216 19444 -22018 21925 2479 11957 23416 29597 22605 -22044 13559 -17418 -284 15723 5500 21178 -16984 975 -12931 -7028 -20947 -3157 4604 18314 -22509 21364 32294 19969 19828 5830 -781 -27038 28389 -18994 -7645 30354 -10524 1481 -23556 19450 1202 19600 -15943 1985 -29900 -20209 -28174 29304 16705 -14885 26600 27520 13643 31336 -25447 -17170 -2518 -17808 4298 5750 -28658 32307 -7232 -26348 -31538 3616 4404 -8257 24483 -19805 11432 -20751 1462 10010 23712 28281 5993 -29 -4483 32630 9038 -2885 1 0 1 0 1 0 1 1 1 0 0 0.533939 153153135
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 153153135
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 6.4898
    Should Contain    ${output}    ILCState : -11332
    Should Contain    ${output}    SlewFlag : -14453
    Should Contain    ${output}    StaticForcesApplied : -29648
    Should Contain    ${output}    ElevationForcesApplied : 2443
    Should Contain    ${output}    AzimuthForcesApplied : 6488
    Should Contain    ${output}    ThermalForcesApplied : -27643
    Should Contain    ${output}    OffsetForcesApplied : 29370
    Should Contain    ${output}    AccelerationForcesApplied : 24988
    Should Contain    ${output}    VelocityForcesApplied : -312
    Should Contain    ${output}    ActiveOpticForcesApplied : 21488
    Should Contain    ${output}    AberrationForcesApplied : 32141
    Should Contain    ${output}    BalanceForcesApplied : -25879
    Should Contain    ${output}    SupportPercentage : 29583
    Should Contain    ${output}    priority : 29234
