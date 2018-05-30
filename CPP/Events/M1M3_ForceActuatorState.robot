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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 87.7457 -8782 -29492 12894 -3125 -12282 -30241 -20511 -32646 1412 5467 24179 -7830 -3245 28280 -22647 -2434 -23619 22020 20941 -1817 9737 9117 -23071 -7955 -31520 -17408 29687 20893 -32417 -26363 29884 14922 17830 19572 -10499 -28559 157 -18254 -23048 24770 -5572 -9078 13256 -27725 -4176 12270 13403 -21724 -2263 28132 -29614 -31114 1240 -12372 20203 -6031 12069 -24221 1920 -26613 -8180 -27682 -25792 18162 11063 2626 2622 16945 -28839 7776 9738 11938 12679 -2317 19920 -21595 -1410 -7022 -25035 -325 -2551 168 5157 17395 -6074 -20011 -12737 -28967 28403 -29612 -24978 4439 -9901 -3528 -2095 22009 -25676 27957 19024 -31692 27842 4718 -4451 27022 15287 23131 10776 -29037 -28789 19771 -6852 -14179 28469 -14053 15066 -22590 -27415 23783 17453 9331 -15144 -23342 -8936 3918 -10613 -20853 -24200 26160 -4879 -15453 -24171 28972 30308 -19314 -11695 -24348 30026 -29299 31561 11608 8806 23067 18830 6364 -30228 1212 30370 -28026 4831 -17763 -14737 19968 21312 -10481 25989 25346 1 1 0 1 1 0 0 1 0 0 0 0.508937 -1823714600
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1823714600
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 87.7457
    Should Contain    ${output}    ILCState : -8782
    Should Contain    ${output}    SlewFlag : -29492
    Should Contain    ${output}    StaticForcesApplied : 12894
    Should Contain    ${output}    ElevationForcesApplied : -3125
    Should Contain    ${output}    AzimuthForcesApplied : -12282
    Should Contain    ${output}    ThermalForcesApplied : -30241
    Should Contain    ${output}    OffsetForcesApplied : -20511
    Should Contain    ${output}    AccelerationForcesApplied : -32646
    Should Contain    ${output}    VelocityForcesApplied : 1412
    Should Contain    ${output}    ActiveOpticForcesApplied : 5467
    Should Contain    ${output}    AberrationForcesApplied : 24179
    Should Contain    ${output}    BalanceForcesApplied : -7830
    Should Contain    ${output}    SupportPercentage : -3245
    Should Contain    ${output}    priority : 28280
