*** Settings ***
Documentation    M1M3_RejectedAccelerationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAccelerationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 62.9121 0.402627 0.554427 0.673351 0.207019 0.17512 0.7378 0.416718 0.965877 0.384737 0.88347 0.490347 0.970239 0.405982 0.555954 0.741391 0.623959 0.893795 0.479921 0.630011 0.98147 0.80062 0.642927 0.4386 0.56357 0.588685 0.798757 0.244257 0.083003 0.96411 0.783463 0.235351 0.928793 0.286039 0.728464 0.282045 0.351481 0.105773 0.354942 0.676265 0.676775 0.173274 0.375288 0.64161 0.365307 0.847204 0.130105 0.354559 0.516699 0.031113 0.514943 0.342588 0.586564 0.324432 0.707724 0.586532 0.676211 0.623656 0.393302 0.555927 0.476651 0.321844 0.427062 0.505153 0.010657 0.754992 0.318389 0.525793 0.201077 0.994331 0.976257 0.23822 0.23495 0.89562 0.83232 0.134239 0.411071 0.715871 0.042055 0.794087 0.656775 0.573126 0.030578 0.914192 0.012007 0.234093 0.453218 0.204661 0.006272 0.781606 0.565536 0.889146 0.18401 0.698336 0.738309 0.095176 0.512901 0.930757 0.017008 0.103152 0.110862 0.925301 0.10633 0.513994 0.155143 0.190265 0.254213 0.77711 0.195033 0.442313 0.143904 0.659488 0.792535 0.452615 0.808274 0.51683 0.620619 0.030911 0.30203 0.059614 0.379121 0.247633 0.318122 0.419479 0.602653 0.428133 0.575346 0.912042 0.444528 0.429563 0.28872 0.729147 0.039868 0.35623 0.868844 0.979801 0.614578 0.921841 0.605248 0.901295 0.253121 0.737082 0.039305 0.382089 0.749556 0.132051 0.563184 0.666276 0.408032 0.709167 0.90527 0.262226 0.46043 0.345464 0.623498 0.765085 0.043923 0.110513 0.783274 0.585415 0.250187 0.635672 0.973982 0.624113 0.674167 0.281317 0.56206 0.585905 0.76464 0.904312 0.60555 0.642846 0.092298 0.452707 0.060772 0.588085 0.236794 0.498653 0.545206 0.632431 0.599032 0.448535 0.302679 0.010014 0.673767 0.466769 0.248021 0.311096 0.41757 0.922227 0.7494 0.090534 0.961272 0.003291 0.917407 0.207671 0.860333 0.833636 0.401535 0.69758 0.138697 0.296233 0.32459 0.667843 0.073325 0.580409 0.434144 0.073159 0.19065 0.069101 0.236294 0.067754 0.129934 0.259822 0.018979 0.627733 0.812313 0.847801 0.267767 0.01333 0.072089 0.422549 0.566464 0.453244 0.433805 0.113322 0.267449 0.172269 0.659208 0.367494 0.624963 0.986854 0.19347 0.31491 0.992646 0.441765 0.544781 0.169377 0.299471 0.314274 0.484236 0.965065 0.865995 0.041414 0.407411 0.63852 0.017677 0.778612 0.242709 0.178147 0.508505 0.605561 0.62126 0.616526 0.957989 0.415294 0.041654 0.484842 0.746256 0.608484 0.24297 0.656768 0.626173 0.521156 0.084651 0.107891 0.177717 0.408307 0.886442 0.206868 0.63894 0.294298 0.64668 0.696918 0.046386 0.270061 453364703
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAccelerationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 453364703
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAccelerationForces received =     1
    Should Contain    ${output}    Timestamp : 62.9121
    Should Contain    ${output}    XForces : 0.402627
    Should Contain    ${output}    YForces : 0.554427
    Should Contain    ${output}    ZForces : 0.673351
    Should Contain    ${output}    Fx : 0.207019
    Should Contain    ${output}    Fy : 0.17512
    Should Contain    ${output}    Fz : 0.7378
    Should Contain    ${output}    Mx : 0.416718
    Should Contain    ${output}    My : 0.965877
    Should Contain    ${output}    Mz : 0.384737
    Should Contain    ${output}    ForceMagnitude : 0.88347
    Should Contain    ${output}    priority : 0.490347
