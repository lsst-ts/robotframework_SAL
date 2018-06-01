*** Settings ***
Documentation    M1M3_AppliedElevationForces communications tests.
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
${component}    AppliedElevationForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 38.5485 0.887986 0.040217 0.74466 0.129638 0.846921 0.47089 0.653786 0.048356 0.111341 0.946315 0.12691 0.254535 0.920817 0.594704 0.368528 0.76092 0.609392 0.378182 0.486233 0.708748 0.0171 0.753354 0.992659 0.078818 0.620116 0.448844 0.838211 0.935956 0.50052 0.084086 0.20228 0.893118 0.241268 0.741151 0.15879 0.877869 0.586014 0.230327 0.91457 0.421518 0.351803 0.693225 0.253342 0.276844 0.206413 0.955461 0.10934 0.748099 0.911764 0.276236 0.720992 0.479639 0.612297 0.688146 0.223191 0.525912 0.350029 0.657716 0.221657 0.80831 0.480931 0.355643 0.338633 0.715354 0.968994 0.183864 0.647571 0.17033 0.744493 0.027255 0.470614 0.029324 0.246032 0.011275 0.568641 0.352179 0.582402 0.981557 0.521039 0.792055 0.864841 0.375005 0.873236 0.015674 0.400338 0.228296 0.94926 0.988902 0.090299 0.29027 0.032523 0.007862 0.305067 0.708543 0.511489 0.00414 0.539468 0.487361 0.776929 0.832538 0.32564 0.155758 0.764529 0.448981 0.573129 0.818564 0.031474 0.575317 0.889932 0.388438 0.644296 0.432796 0.454073 0.935082 0.411473 0.180442 0.515381 0.49034 0.507364 0.913749 0.8448 0.416004 0.975753 0.986836 0.983864 0.868027 0.365224 0.470573 0.749937 0.089833 0.832994 0.632087 0.756651 0.978298 0.649673 0.294097 0.476641 0.273586 0.396017 0.874207 0.15466 0.436708 0.928382 0.335757 0.120009 0.081034 0.711377 0.00125 0.427354 0.398721 0.998171 0.749704 0.552459 0.743435 0.152151 0.9539 0.281054 0.681877 0.809068 0.401636 0.106115 0.522212 0.798499 0.86565 0.733835 0.956456 0.301129 0.934426 0.175313 0.426247 0.25194 0.384275 0.955385 0.97128 0.098696 0.700841 0.410019 0.879267 0.343887 0.844827 0.430756 0.813801 0.220849 0.038297 0.890995 0.369972 0.785985 0.035461 0.39433 0.85711 0.910521 0.306893 0.878136 0.992458 0.176225 0.446679 0.76287 0.422086 0.474742 0.311476 0.392087 0.460859 0.580532 0.327851 0.325084 0.324429 0.874541 0.725179 0.955876 0.907265 0.772181 0.831805 0.002272 0.390511 0.837871 0.171 0.852182 0.490001 0.100717 0.244597 0.404369 0.463352 0.685678 0.592012 0.361471 0.283119 0.922488 0.431974 0.132715 0.843409 0.413385 0.766028 0.120975 0.341872 0.590353 0.408375 0.083852 0.661276 0.814207 0.573703 0.670861 0.201885 0.198411 0.236885 0.981523 0.054398 0.661002 0.713247 0.35392 0.142825 0.757681 0.117681 0.40023 0.146767 0.910958 0.337949 0.129387 0.902119 0.599143 0.459534 0.556926 0.001817 0.223723 0.831369 0.384373 0.696252 0.345225 0.757801 0.161381 0.751978 0.591936 0.490811 0.090434 0.999846 0.663812 -1532094061
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
