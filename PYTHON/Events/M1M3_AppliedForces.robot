*** Settings ***
Documentation    M1M3_AppliedForces communications tests.
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
${component}    AppliedForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 56.7765 0.406498 0.988889 0.785079 0.568697 0.301774 0.903236 0.889573 0.895137 0.788074 0.65491 0.315182 0.860274 0.781021 0.322446 0.143494 0.040129 0.98338 0.358491 0.140555 0.192538 0.535535 0.021198 0.511911 0.041698 0.079655 0.207389 0.24373 0.189018 0.708199 0.755724 0.386225 0.600393 0.687576 0.581593 0.647873 0.352799 0.330646 0.236637 0.792529 0.923086 0.118955 0.398029 0.635749 0.30961 0.292682 0.034352 0.501629 0.07093 0.424153 0.623554 0.906566 0.084475 0.876039 0.286703 0.128014 0.899468 0.065543 0.465874 0.305345 0.150375 0.818387 0.579903 0.420487 0.758813 0.04118 0.09459 0.947377 0.081535 0.823913 0.278782 0.316958 0.453554 0.081268 0.649006 0.592171 0.352244 0.334215 0.820099 0.905318 0.08402 0.943955 0.205595 0.470931 0.660668 0.874782 0.871528 0.053793 0.131844 0.260186 0.998101 0.228663 0.06157 0.149812 0.242143 0.715545 0.287694 0.801654 0.938396 0.816856 0.71739 0.087674 0.341868 0.738447 0.221025 0.750067 0.702895 0.418811 0.705012 0.748195 0.939917 0.453653 0.773664 0.480405 0.902223 0.220849 0.553921 0.408312 0.359529 0.810745 0.251866 0.327504 0.336562 0.212242 0.339662 0.742885 0.550897 0.782968 0.090454 0.550182 0.4618 0.512933 0.406477 0.36099 0.765986 0.112881 0.856996 0.308404 0.024197 0.819027 0.551369 0.272799 0.4647 0.669571 0.523811 0.588675 0.399463 0.892373 0.545443 0.01899 0.256928 0.041776 0.94439 0.718991 0.372467 0.727637 0.807882 0.647369 0.494735 0.202635 0.428855 0.622829 0.077822 0.006644 0.983659 0.457487 0.718898 0.36183 0.635512 0.075805 0.487381 0.722297 0.687828 0.780689 0.200086 0.976454 0.100719 0.673569 0.090462 0.238745 0.35382 0.622789 0.178627 0.308343 0.656134 0.470069 0.453747 0.688067 0.636919 0.705558 0.772678 0.441154 0.55689 0.162515 0.563028 0.907173 0.477453 0.155326 0.299603 0.490893 0.957903 0.35286 0.003562 0.852632 0.236297 0.539553 0.142348 0.949202 0.512877 0.878542 0.178619 0.381698 0.365803 0.531933 0.127454 0.700005 0.179939 0.178535 0.245947 0.221548 0.868532 0.227645 0.331368 0.885105 0.461612 0.296001 0.522337 0.357392 0.361209 0.076746 0.896559 0.642766 0.540396 0.87803 0.90303 0.640162 0.367269 0.698617 0.983159 0.644777 0.964158 0.277982 0.571339 0.183465 0.288619 0.114813 0.479544 0.121929 0.458712 0.968734 0.515408 0.179822 0.325816 0.662068 0.177467 0.375199 0.314018 0.448035 0.635797 0.052352 0.161151 0.952034 0.890719 0.108516 0.528056 0.101688 0.774111 0.632067 0.293762 0.356393 0.938759 0.160031 0.791724 0.306701 0.23527 0.3246 1083939257
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
