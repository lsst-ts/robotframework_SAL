*** Settings ***
Documentation    M1M3_RejectedBalanceForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedBalanceForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 91.6593 0.396019 0.764238 0.704675 0.446552 0.974117 0.853575 0.203772 0.810061 0.726131 0.230336 0.116045 0.56901 0.700557 0.223043 0.511101 0.807076 0.497524 0.48422 0.357298 0.739912 0.813229 0.673923 0.881236 0.546117 0.914704 0.686456 0.589352 0.483178 0.018776 0.166594 0.924685 0.423253 0.424129 0.861888 0.306807 0.064042 0.681376 0.949269 0.053716 0.993689 0.035297 0.807594 0.903754 0.621009 0.375588 0.215205 0.802743 0.476102 0.463894 0.401279 0.271828 0.503039 0.966231 0.014172 0.324436 0.412196 0.034399 0.228636 0.373721 0.819928 0.375826 0.463427 0.920492 0.531489 0.388994 0.339634 0.38038 0.425423 0.983836 0.743559 0.560311 0.783386 0.865855 0.166476 0.17925 0.212004 0.369495 0.959163 0.649169 0.218912 0.126812 0.712718 0.073065 0.210532 0.929529 0.052971 0.537298 0.76582 0.007072 0.502623 0.996253 0.6151 0.185595 0.119373 0.609912 0.166939 0.754092 0.817621 0.432558 0.501988 0.530993 0.61184 0.391593 0.787781 0.983906 0.654311 0.333982 0.058142 0.283021 0.589659 0.884842 0.900328 0.914436 0.312143 0.621178 0.278819 0.81689 0.385874 0.122989 0.43097 0.842182 0.655426 0.105575 0.508695 0.848693 0.428068 0.633632 0.018056 0.820351 0.341225 0.788695 0.4271 0.301707 0.412565 0.388021 0.702933 0.427832 0.166474 0.809539 0.734314 0.975792 0.632945 0.931435 0.150332 0.075234 0.891074 0.328406 0.101733 0.825965 0.217368 0.603992 0.403446 0.090965 0.005688 0.795292 0.782385 0.36018 0.499499 0.079052 0.836145 0.625 0.380844 0.910994 0.190218 0.998205 0.484876 0.583088 0.256509 0.587763 0.540502 0.082125 0.239198 0.920742 0.515495 0.706205 0.686972 0.089118 0.626784 0.94455 0.495079 0.660803 0.977991 0.685801 0.644361 0.748695 0.911749 0.142311 0.605383 0.0844 0.363858 0.282698 0.85842 0.661926 0.317711 0.411894 0.021105 0.569834 0.453781 0.428489 0.336425 0.450131 0.099608 0.747745 0.782806 0.230739 0.991889 0.255711 0.741687 0.926543 0.354617 0.355934 0.422533 0.370557 0.906139 0.28064 0.158228 0.441408 0.935038 0.988173 0.439272 0.49441 0.997443 0.436802 0.101987 0.695585 0.507023 0.878375 0.066142 0.48778 0.405986 0.892202 0.268153 0.433215 0.641059 0.082967 0.95283 0.873319 0.589924 0.64017 0.596578 0.409425 0.659367 0.701886 0.39597 0.315617 0.30938 0.691247 0.974874 0.520769 0.427739 0.367868 0.855166 0.822519 0.617063 0.264105 0.145137 0.779736 0.480525 0.101383 0.870955 0.765773 0.703698 0.674628 0.169117 0.601982 0.851902 0.920054 0.436929 0.558582 0.599428 0.098992 0.959092 0.991666 0.67156 0.731812 1576828898
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedBalanceForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1576828898
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedBalanceForces received =     1
    Should Contain    ${output}    Timestamp : 91.6593
    Should Contain    ${output}    XForces : 0.396019
    Should Contain    ${output}    YForces : 0.764238
    Should Contain    ${output}    ZForces : 0.704675
    Should Contain    ${output}    Fx : 0.446552
    Should Contain    ${output}    Fy : 0.974117
    Should Contain    ${output}    Fz : 0.853575
    Should Contain    ${output}    Mx : 0.203772
    Should Contain    ${output}    My : 0.810061
    Should Contain    ${output}    Mz : 0.726131
    Should Contain    ${output}    ForceMagnitude : 0.230336
    Should Contain    ${output}    priority : 0.116045
