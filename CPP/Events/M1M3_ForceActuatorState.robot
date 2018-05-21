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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 52.8877 3993 -13806 4234 -28 31132 17533 1183 -12472 30975 -8139 -10373 -18916 26199 -19163 22804 27108 12106 23943 15725 32390 21818 13502 13342 -21078 -25051 26716 -5035 -8035 -13828 27261 -10690 -30793 31515 -8065 27102 30936 -9882 -16113 -19598 31581 -30611 -7784 -25991 15625 18044 20900 -21357 -19103 -5455 -6060 6667 -12862 26083 -12229 10479 13081 -13653 20622 23878 26675 -22943 29900 22977 22172 3972 25061 22145 11163 22287 16295 -17737 -5531 -31094 -5621 17466 705 -23774 -13067 -8886 664 -12348 -5764 -23700 9933 -32729 -29442 8353 10500 -4310 -15229 -23419 -12597 -6533 -8049 21189 26290 -13263 -12735 -10075 11323 29400 1990 16666 -28477 1958 -21496 30341 -28614 -15179 -1431 27080 9154 -599 28017 26044 12930 12301 8213 22138 -25123 -3273 31474 6104 -5142 27094 10023 1352 14612 -25619 -9557 -15680 27429 -13151 -28467 -109 -13897 27392 -24447 -2894 30380 -7057 -32033 -17239 -3429 6732 -20350 22028 22263 32115 -15649 16003 -18891 -23687 1347 21966 28538 0 1 1 0 0 1 1 0 0 0 1 0.747180607251 1451200146
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ForceActuatorState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1451200146
    Log    ${output}
    Should Contain X Times    ${output}    === Event ForceActuatorState received =     1
    Should Contain    ${output}    Timestamp : 52.8877
    Should Contain    ${output}    ILCState : 3993
    Should Contain    ${output}    SlewFlag : -13806
    Should Contain    ${output}    StaticForcesApplied : 4234
    Should Contain    ${output}    ElevationForcesApplied : -28
    Should Contain    ${output}    AzimuthForcesApplied : 31132
    Should Contain    ${output}    ThermalForcesApplied : 17533
    Should Contain    ${output}    OffsetForcesApplied : 1183
    Should Contain    ${output}    AccelerationForcesApplied : -12472
    Should Contain    ${output}    VelocityForcesApplied : 30975
    Should Contain    ${output}    ActiveOpticForcesApplied : -8139
    Should Contain    ${output}    AberrationForcesApplied : -10373
    Should Contain    ${output}    BalanceForcesApplied : -18916
    Should Contain    ${output}    SupportPercentage : 26199
    Should Contain    ${output}    priority : -19163
