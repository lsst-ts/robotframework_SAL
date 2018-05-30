*** Settings ***
Documentation    M1M3_RejectedThermalForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedThermalForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 66.7662 0.777753 0.359891 0.820466 0.7753 0.326402 0.58238 0.647967 0.54398 0.157705 0.272222 0.173617 0.69331 0.598067 0.781912 0.614769 0.98509 0.468558 0.857404 0.487742 0.17951 0.096545 0.330032 0.939645 0.746187 0.919227 0.376331 0.565855 0.692821 0.771056 0.069096 0.213934 0.580344 0.469233 0.414078 0.745097 0.817332 0.907273 0.196327 0.840246 0.845058 0.343009 0.603409 0.600226 0.669983 0.211528 0.997231 0.133165 0.593438 0.187205 0.863955 0.19146 0.800023 0.102685 0.512541 0.63277 0.660163 0.163137 0.185338 0.357303 0.286061 0.431391 0.434926 0.509377 0.132938 0.294992 0.912991 0.693255 0.106431 0.583578 0.524645 0.67743 0.318869 0.581199 0.753861 0.91792 0.65471 0.331618 0.292751 0.583168 0.704764 0.874995 0.875679 0.226253 0.290314 0.429896 0.290732 0.25734 0.264107 0.438915 0.837101 0.407681 0.882436 0.413453 0.12874 0.935796 0.169312 0.087001 0.322511 0.846596 0.633128 0.398987 0.271774 0.190284 0.762767 0.691694 0.209288 0.873855 0.817677 0.767425 0.646168 0.528209 0.036316 0.490537 0.542352 0.782487 0.945919 0.607325 0.665454 0.509185 0.235872 0.014614 0.071612 0.965844 0.540279 0.290386 0.007623 0.070719 0.23782 0.8453 0.147239 0.293371 0.995851 0.381085 0.451854 0.191686 0.114825 0.052504 0.591987 0.151761 0.380415 0.81896 0.583759 0.36678 0.32039 0.67482 0.760308 0.478973 0.302078 0.35312 0.439903 0.7942 0.726945 0.917184 0.532611 0.220457 0.601607 0.009232 0.661866 0.340068 0.102737 0.192038 0.016293 0.806495 0.805152 0.270964 0.458312 0.019433 0.706158 0.722669 0.875547 0.05672 0.808135 0.789093 0.131752 0.27604 0.690009 0.306083 0.284351 0.632175 0.57482 0.470584 0.974901 0.616218 0.274508 0.913077 0.546362 0.485343 0.307252 0.680434 0.824214 0.528805 0.859303 0.347692 0.61573 0.342018 0.881717 0.426781 0.736099 0.789215 0.530184 0.905233 0.107343 0.110271 0.706214 0.164353 0.350084 0.673958 0.043233 0.083733 0.825619 0.752791 0.957633 0.309325 0.020789 0.420643 0.901937 0.439389 0.093441 0.806569 0.24281 0.355524 0.467383 0.627359 0.912493 0.774602 0.445182 0.303797 0.286704 0.967542 0.144797 0.900274 0.958876 0.512311 0.644299 0.884376 0.561252 0.421853 0.619646 0.749837 0.233913 0.600772 0.256109 0.38139 0.569375 0.17729 0.538643 0.732605 0.234152 0.150832 0.159586 0.025644 0.62003 0.613318 0.235455 0.300694 0.992468 0.887504 0.423925 0.614994 0.063454 0.035083 0.531456 0.871449 0.036304 0.913649 0.259339 0.146826 0.319304 0.400948 0.145821 0.680977 0.949164 0.640238 0.165338 0.782328 -31337208
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedThermalForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -31337208
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedThermalForces received =     1
    Should Contain    ${output}    Timestamp : 66.7662
    Should Contain    ${output}    XForces : 0.777753
    Should Contain    ${output}    YForces : 0.359891
    Should Contain    ${output}    ZForces : 0.820466
    Should Contain    ${output}    Fx : 0.7753
    Should Contain    ${output}    Fy : 0.326402
    Should Contain    ${output}    Fz : 0.58238
    Should Contain    ${output}    Mx : 0.647967
    Should Contain    ${output}    My : 0.54398
    Should Contain    ${output}    Mz : 0.157705
    Should Contain    ${output}    ForceMagnitude : 0.272222
    Should Contain    ${output}    priority : 0.173617
