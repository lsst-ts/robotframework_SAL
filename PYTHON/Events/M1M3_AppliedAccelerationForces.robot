*** Settings ***
Documentation    M1M3_AppliedAccelerationForces communications tests.
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
${component}    AppliedAccelerationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 9.4574 0.575513 0.832749 0.296121 0.312342 0.919765 0.56569 0.661685 0.799146 0.29443 0.631069 0.739332 0.616784 0.840126 0.625913 0.856164 0.2287 0.198262 0.356941 0.718297 0.656561 0.963029 0.955575 0.258631 0.018451 0.735092 0.443854 0.616869 0.170789 0.940306 0.2446 0.575473 0.931123 0.776045 0.359621 0.480501 0.048325 0.643197 0.589033 0.125631 0.716294 0.763812 0.010954 0.93425 0.998345 0.002982 0.467618 0.745551 0.038439 0.231241 0.648222 0.078838 0.574158 0.594725 0.856589 0.660317 0.575836 0.072351 0.378856 0.52993 0.502093 0.445691 0.356371 0.209048 0.948725 0.785407 0.901186 0.072648 0.985075 0.024084 0.309311 0.040266 0.425645 0.046022 0.826244 0.182254 0.814689 0.883991 0.674385 0.527388 0.499664 0.528874 0.100278 0.671901 0.575376 0.069686 0.297399 0.371681 0.731739 0.729072 0.80111 0.376363 0.027659 0.00491 0.98042 0.08332 0.100658 0.193358 0.851957 0.451553 0.035105 0.611686 0.301193 0.694443 0.933524 0.411502 0.649852 0.945293 0.977743 0.041862 0.205057 0.983821 0.924071 0.443916 0.402422 0.67736 0.444564 0.843538 0.926591 0.682582 0.458429 0.335117 0.89797 0.428338 0.873885 0.974928 0.915986 0.71509 0.211805 0.714912 0.184351 0.186546 0.158436 0.724758 0.257885 0.819823 0.088902 0.287318 0.157944 0.131121 0.952156 0.602053 0.87247 0.194796 0.539597 0.48081 0.134168 0.687858 0.578146 0.465138 0.728268 0.261797 0.442357 0.941355 0.416616 0.925724 0.085043 0.206534 0.709605 0.617616 0.894089 0.869114 0.155133 0.966454 0.281965 0.930262 0.058751 0.374667 0.770739 0.725079 0.264798 0.914051 0.845548 0.452009 0.872112 0.690918 0.901718 0.025343 0.876157 0.192123 0.003468 0.651177 0.007623 0.302672 0.593697 0.54419 0.558687 0.101749 0.789333 0.531374 0.244031 0.866258 0.185271 0.608523 0.792866 0.062842 0.447578 0.412458 0.221058 0.053409 0.59645 0.134227 0.604628 0.823693 0.224756 0.162292 0.309347 0.173377 0.636293 0.828468 0.415026 0.799625 0.141477 0.513125 0.801398 0.329976 0.782134 0.923891 0.462749 0.689613 0.03028 0.104953 0.359703 0.333196 0.786859 0.724451 0.972811 0.227713 0.944438 0.01827 0.933441 0.187275 0.992124 0.594982 0.751151 0.800464 0.895483 0.05283 0.139575 0.005932 0.286422 0.687527 0.368736 0.804941 0.596042 0.543019 0.175788 0.681302 0.289189 0.909003 0.880721 0.744798 0.41952 0.306882 0.064604 0.563695 0.822009 0.401612 0.721256 0.241548 0.287591 0.348974 0.389488 0.832571 0.525577 0.488474 0.275862 0.963911 0.751085 0.767336 0.168259 0.173476 0.315827 0.723951 0.790189 0.097497 -2040517463
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
