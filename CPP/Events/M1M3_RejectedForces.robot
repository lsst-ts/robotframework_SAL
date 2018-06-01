*** Settings ***
Documentation    M1M3_RejectedForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 36.3702 0.904349 0.948447 0.469018 0.073352 0.564935 0.170312 0.784246 0.883269 0.86887 0.72153 0.843785 0.498887 0.940774 0.855304 0.839178 0.282343 0.033348 0.449377 0.339336 0.839354 0.870814 0.844406 0.356337 0.862765 0.02867 0.436404 0.839559 0.737846 0.996755 0.0009 0.277277 0.945736 0.206224 0.802676 0.915891 0.580065 0.372619 0.900234 0.792117 0.127512 0.942215 0.477588 0.470209 0.119446 0.82674 0.20591 0.867566 0.991077 0.12716 0.146996 0.752936 0.526549 0.009946 0.664889 0.994916 0.983383 0.738658 0.243661 0.24548 0.269186 0.279509 0.714185 0.816912 0.521846 0.336647 0.198065 0.661179 0.256935 0.890643 0.886195 0.570553 0.549359 0.315184 0.738753 0.501672 0.785928 0.740935 0.406602 0.814226 0.302776 0.524173 0.154845 0.088632 0.499132 0.558543 0.926775 0.382717 0.269536 0.579087 0.67078 0.840232 0.689819 0.656548 0.583033 0.128199 0.841022 0.390011 0.863065 0.520798 0.816341 0.099554 0.898014 0.21711 0.440819 0.726735 0.343173 0.433522 0.832445 0.001267 0.762491 0.751704 0.627327 0.535178 0.658131 0.353243 0.068485 0.021441 0.286034 0.445472 0.384957 0.031615 0.538037 0.561035 0.236457 0.888654 0.916702 0.151001 0.117198 0.016339 0.856626 0.643619 0.417129 0.411349 0.55973 0.080911 0.417565 0.302087 0.394572 0.23489 0.867027 0.051365 0.246523 0.40669 0.755563 0.17914 0.73348 0.710989 0.208605 0.687311 0.105936 0.959262 0.086875 0.343545 0.929177 0.014143 0.860826 0.329561 0.209725 0.516227 0.960039 0.23858 0.446003 0.369335 0.064917 0.628834 0.36307 0.171142 0.369013 0.612097 0.037564 0.808979 0.017442 0.36055 0.500576 0.8105 0.870902 0.833014 0.67324 0.744911 0.486943 0.062495 0.419066 0.583603 0.751721 0.277708 0.178351 0.841953 0.431666 0.107859 0.411638 0.925966 0.395119 0.191942 0.755291 0.555174 0.279054 0.877124 0.389676 0.776198 0.765043 0.096963 0.169283 0.073949 0.118396 0.230663 0.10351 0.243891 0.33942 0.986146 0.582485 0.97121 0.425298 0.416703 0.914164 0.033625 0.985705 0.274982 0.507103 0.711203 0.394454 0.860184 0.382635 0.10735 0.169116 0.932196 0.536331 0.700243 0.891428 0.177191 0.670281 0.366532 0.90978 0.2917 0.864168 0.303392 0.656622 0.673368 0.05923 0.764325 0.536847 0.209867 0.391556 0.477204 0.146806 0.502541 0.002635 0.530353 0.310205 0.459615 0.398384 0.145275 0.320723 0.965704 0.355379 0.888361 0.169586 0.879488 0.891891 0.548052 0.473744 0.365701 0.235291 0.088456 0.469821 0.081959 0.544835 0.863237 0.242694 0.43852 0.191743 0.790568 0.623273 0.569483 0.489854 0.639802 -661785596
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -661785596
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedForces received =     1
    Should Contain    ${output}    Timestamp : 36.3702
    Should Contain    ${output}    XForces : 0.904349
    Should Contain    ${output}    YForces : 0.948447
    Should Contain    ${output}    ZForces : 0.469018
    Should Contain    ${output}    Fx : 0.073352
    Should Contain    ${output}    Fy : 0.564935
    Should Contain    ${output}    Fz : 0.170312
    Should Contain    ${output}    Mx : 0.784246
    Should Contain    ${output}    My : 0.883269
    Should Contain    ${output}    Mz : 0.86887
    Should Contain    ${output}    ForceMagnitude : 0.72153
    Should Contain    ${output}    priority : 0.843785
