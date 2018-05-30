*** Settings ***
Documentation    M1M3_AppliedVelocityForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedVelocityForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 17.2357 0.179245 0.483793 0.049266 0.818051 0.027225 0.915876 0.684123 0.170732 0.800367 0.088731 0.451661 0.882555 0.894469 0.450205 0.024467 0.038144 0.710297 0.373294 0.839381 0.990579 0.347558 0.571684 0.248293 0.561701 0.331723 0.128532 0.022111 0.32058 0.762408 0.442051 0.024919 0.167666 0.046501 0.500893 0.942448 0.94158 0.529331 0.880291 0.449518 0.966931 0.310947 0.665679 0.171247 0.313665 0.766168 0.167649 0.844886 0.928008 0.661493 0.764254 0.575878 0.177637 0.956806 0.540046 0.803625 0.805257 0.568143 0.06881 0.331516 0.317469 0.936699 0.308002 0.790793 0.885536 0.229443 0.017376 0.533051 0.64447 0.515237 0.245187 0.969605 0.410377 0.247625 0.603179 0.048645 0.089818 0.451564 0.205897 0.581983 0.431724 0.639617 0.621599 0.548727 0.760246 0.255657 0.531812 0.688026 0.408901 0.851052 0.718516 0.011331 0.620371 0.653791 0.33969 0.272375 0.855747 0.56917 0.128049 0.329966 0.017937 0.804541 0.144672 0.285137 0.642015 0.506564 0.721913 0.906725 0.844835 0.16639 0.397553 0.048278 0.578424 0.043385 0.820345 0.523811 0.817205 0.249552 0.196064 0.408765 0.778067 0.499811 0.375789 0.220473 0.944362 0.962885 0.821799 0.943152 0.596519 0.730659 0.009071 0.260456 0.270696 0.499714 0.361506 0.002137 0.379997 0.953369 0.387124 0.92701 0.057949 0.836669 0.865832 0.511685 0.514304 0.181761 0.113276 0.957722 0.784137 0.402015 0.626891 0.029218 0.367846 0.448104 0.250566 0.26137 0.04891 0.095067 0.223652 0.178896 0.411615 0.145021 0.942885 0.00861 0.003519 0.158002 0.54114 0.273649 0.657445 0.512062 0.187722 0.524662 0.871386 0.458935 0.270999 0.167394 0.139343 0.88508 0.224092 0.477533 0.561794 0.209526 0.777746 0.497126 0.845389 0.147505 0.504153 0.798639 0.167711 0.560829 0.090252 0.08128 0.406963 0.188364 0.641814 0.731172 0.785477 0.492725 0.19084 0.482194 0.856206 0.642828 0.650091 0.133997 0.541629 0.951688 0.609487 0.057076 0.134893 0.262581 0.722767 0.895566 0.35761 0.898822 0.704182 0.506843 0.972486 0.861195 0.553321 0.556328 0.079813 0.618799 0.955894 0.448636 0.959348 0.077853 0.687793 0.315184 0.472665 0.81468 0.796108 0.213389 0.731612 0.796531 0.731044 0.463093 0.137138 0.566661 0.32149 0.543244 0.789069 0.713763 0.476225 0.332705 0.020206 0.892322 0.059203 0.127763 0.148133 0.266941 0.389785 0.984976 0.725809 0.497156 0.110872 0.015405 0.270566 0.109014 0.955202 0.495388 0.220437 0.770128 0.863161 0.663293 0.599203 0.573079 0.916114 0.656154 0.410553 0.291157 0.766063 0.769764 0.404448 0.590838 0.615691 0.226732 -1918530271
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedVelocityForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1918530271
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedVelocityForces received =     1
    Should Contain    ${output}    Timestamp : 17.2357
    Should Contain    ${output}    XForces : 0.179245
    Should Contain    ${output}    YForces : 0.483793
    Should Contain    ${output}    ZForces : 0.049266
    Should Contain    ${output}    Fx : 0.818051
    Should Contain    ${output}    Fy : 0.027225
    Should Contain    ${output}    Fz : 0.915876
    Should Contain    ${output}    Mx : 0.684123
    Should Contain    ${output}    My : 0.170732
    Should Contain    ${output}    Mz : 0.800367
    Should Contain    ${output}    ForceMagnitude : 0.088731
    Should Contain    ${output}    priority : 0.451661
