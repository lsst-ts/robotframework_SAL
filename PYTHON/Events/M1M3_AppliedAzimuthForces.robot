*** Settings ***
Documentation    M1M3_AppliedAzimuthForces communications tests.
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
${component}    AppliedAzimuthForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 29.3512 0.15457 0.651418 0.330777 0.270299 0.528444 0.74969 0.433885 0.919689 0.904913 0.068391 0.527297 0.79242 0.67341 0.521131 0.888236 0.8679 0.170137 0.894809 0.106643 0.777276 0.769568 0.459585 0.745278 0.522167 0.965015 0.426938 0.512254 0.930076 0.059474 0.451984 0.058215 0.876781 0.572351 0.904455 0.67701 0.647177 0.96205 0.063261 0.051384 0.614802 0.9438 0.761597 0.587788 0.237936 0.467114 0.280169 0.627844 0.752922 0.95568 0.624715 0.373907 0.2974 0.2275 0.354346 0.395145 0.448416 0.155824 0.938613 0.235757 0.592669 0.71434 0.717823 0.866458 0.643244 0.482124 0.010174 0.443031 0.5843 0.466395 0.74322 0.671756 0.141698 0.933998 0.444275 0.908953 0.107145 0.611404 0.688335 0.142873 0.311643 0.839432 0.841351 0.48594 0.398817 0.366339 0.203136 0.871424 0.157696 0.106382 0.202541 0.217578 0.700759 0.428583 0.017628 0.486308 0.860527 0.231565 0.977049 0.116159 0.737429 0.087627 0.882416 0.963919 0.659652 0.756388 0.055023 0.099013 0.249368 0.40217 0.301585 0.219989 0.6476 0.795929 0.518964 0.281521 0.361098 0.302669 0.954053 0.54613 0.912379 0.485825 0.695097 0.527042 0.92847 0.690369 0.624421 0.345628 0.096899 0.370191 0.548736 0.716002 0.678275 0.908704 0.745746 0.226833 0.495691 0.365887 0.848089 0.13883 0.105066 0.745663 0.718357 0.144165 0.950987 0.927521 0.310437 0.488906 0.899574 0.290639 0.871746 0.042761 0.38881 0.631056 0.054616 0.244353 0.523516 0.147772 0.143154 0.449877 0.814956 0.693733 0.061367 0.466412 0.926456 0.094631 0.558127 0.59363 0.109617 0.225912 0.294079 0.543698 0.958425 0.105779 0.612656 0.670742 0.242217 0.82497 0.912412 0.481547 0.046538 0.449237 0.350646 0.112099 0.195071 0.980739 0.449596 0.46078 0.772589 0.491582 0.50908 0.221646 0.736206 0.522767 0.033311 0.959759 0.741803 0.486151 0.113796 0.312337 0.499528 0.229629 0.77283 0.221346 0.476271 0.053464 0.008953 0.955145 0.250602 0.106235 0.483765 0.846912 0.910169 0.551563 0.001174 0.512288 0.281241 0.795593 0.815512 0.896333 0.467502 0.188535 0.626739 0.483075 0.028239 0.081667 0.515268 0.80864 0.977107 0.198575 0.26589 0.669592 0.948477 0.977446 0.552167 0.971286 0.70819 0.512144 0.204317 0.536894 0.936574 0.407973 0.086898 0.429285 0.221373 0.429493 0.633849 0.738336 0.682467 0.162142 0.953566 0.22653 0.159565 0.718546 0.060546 0.235022 0.992338 0.751288 0.793908 0.778306 0.673882 0.294307 0.294846 0.222121 0.583664 0.013047 0.535354 0.588624 0.469463 0.83573 0.633309 0.247163 0.064962 0.926562 0.802438 0.428693 -1099056331
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
