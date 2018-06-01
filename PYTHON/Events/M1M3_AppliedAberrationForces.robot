*** Settings ***
Documentation    M1M3_AppliedAberrationForces communications tests.
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
${component}    AppliedAberrationForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 46.4094 0.665364 0.56055 0.951377 0.434659 0.040552 0.328925 0.192176 0.930276 0.614712 0.453795 0.462164 0.83984 0.074122 0.466503 0.998587 0.981087 0.583281 0.982949 0.563923 0.238941 0.863608 0.058188 0.999641 0.56389 0.147364 0.358453 0.343139 0.523565 0.707241 0.355589 0.372621 0.189571 0.806359 0.98153 0.031714 0.252053 0.585806 0.44586 0.727839 0.811258 0.894459 0.021755 0.415534 0.145668 0.955328 0.471096 0.602176 0.267568 0.319933 0.90108 0.309194 0.69298 0.286542 0.553042 0.639741 0.817221 0.549439 0.589567 0.105102 0.475929 0.493093 0.889151 0.158233 0.687818 0.969069 0.809974 0.126866 0.942685 0.000725 0.27711 0.2525 0.75888 0.977681 0.145482 0.73597 0.080261 0.776898 0.330296 0.825192 0.45054 0.04648 0.450258 0.325901 0.250113 0.001628 0.613967 0.536965 0.014172 0.08195 0.952149 0.467074 0.417879 0.360639 0.69326 0.206336 0.408543 0.586987 0.112826 0.279544 0.61452 0.50566 0.920557 0.223131 0.683712 0.111843 0.442361 0.598893 0.626133 0.870928 0.566674 0.946892 0.572818 0.058701 0.74254 0.238822 0.16132 0.973942 0.980048 0.237235 0.019455 0.338891 0.859365 0.763385 0.228662 0.824872 0.834351 0.74983 0.397481 0.492485 0.229605 0.617278 0.561924 0.046864 0.886085 0.189483 0.515979 0.98548 0.801098 0.398476 0.911371 0.942637 0.032016 0.085022 0.524136 0.859446 0.663589 0.183489 0.977399 0.276707 0.489241 0.813257 0.826052 0.156033 0.106726 0.058569 0.337118 0.211252 0.756218 0.740882 -1805854838
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
