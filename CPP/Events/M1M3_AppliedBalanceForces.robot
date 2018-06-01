*** Settings ***
Documentation    M1M3_AppliedBalanceForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedBalanceForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 64.5476 0.592379 0.666378 0.979863 0.030681 0.963602 0.144511 0.454397 0.1464 0.378093 0.292793 0.053935 0.147735 0.234004 0.868776 0.27355 0.50724 0.00941 0.093998 0.7145 0.925627 0.169707 0.126593 0.830664 0.024527 0.901923 0.903384 0.117194 0.602862 0.20851 0.16127 0.176246 0.039363 0.448861 0.61888 0.402174 0.6399 0.852082 0.423374 0.542373 0.172369 0.38187 0.155814 0.376991 0.864845 0.339062 0.844101 0.990563 0.667272 0.389791 0.044406 0.066352 0.812072 0.593523 0.815816 0.204188 0.430985 0.398605 0.107513 0.096974 0.91318 0.631814 0.295539 0.657395 0.736296 0.282257 0.67898 0.960922 0.00433 0.083255 0.198842 0.133145 0.281159 0.853779 0.547597 0.266379 0.027949 0.573071 0.968745 0.95738 0.820834 0.9511 0.523433 0.46229 0.017992 0.204062 0.42159 0.212535 0.701185 0.708933 0.053579 0.923005 0.880427 0.681583 0.546254 0.010597 0.092578 0.166141 0.023484 0.084831 0.45778 0.029081 0.485325 0.913453 0.601735 0.866992 0.668794 0.134945 0.210922 0.470403 0.438849 0.828598 0.874315 0.725438 0.504873 0.170007 0.02731 0.956032 0.845633 0.441788 0.334728 0.645181 0.420612 0.100686 0.200562 0.143493 0.153936 0.710317 0.920754 0.596722 0.932231 0.947351 0.845101 0.112297 0.627825 0.532702 0.120794 0.930191 0.371093 0.143436 0.646565 0.066904 0.036623 0.77722 0.301804 0.270298 0.555593 0.996383 0.335755 0.164784 0.744021 0.16379 0.8952 0.263243 0.194273 0.268536 0.751004 0.659324 0.629146 0.766801 0.647907 0.14992 0.116277 0.370399 0.851943 0.365433 0.116226 0.771107 0.490392 0.406783 0.044398 0.784607 0.86254 0.930055 0.669134 0.184146 0.468603 0.115983 0.569006 0.064392 0.421958 0.442452 0.606354 0.960208 0.185766 0.875559 0.763197 0.134862 0.248927 0.339995 0.484514 0.257368 0.576253 0.116555 0.826784 0.461994 0.042805 0.70316 0.759454 0.982648 0.529827 0.437595 0.896647 0.955386 0.934143 0.4599 0.59853 0.487208 0.197016 0.156545 0.50695 0.74279 0.514703 0.796927 0.646149 0.6842 0.507993 0.675385 0.885664 0.122337 0.643975 0.115579 0.14287 0.146818 0.127914 0.043924 0.869864 0.990179 0.974308 0.135413 0.118384 0.742231 0.642839 0.782283 0.891687 0.496825 0.675707 0.890414 0.50089 0.822487 0.907198 0.830317 0.04071 0.150821 0.416395 0.194365 0.723707 0.470462 0.448648 0.970984 0.882391 0.089217 0.355435 0.719755 0.975025 0.385365 0.9201 0.775739 0.630049 0.591845 0.874796 0.553786 0.68144 0.541059 0.542424 0.711476 0.156253 0.508365 0.93489 0.608621 0.523269 0.51189 0.302978 0.110169 0.175853 0.411038 -577695793
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedBalanceForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -577695793
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedBalanceForces received =     1
    Should Contain    ${output}    Timestamp : 64.5476
    Should Contain    ${output}    XForces : 0.592379
    Should Contain    ${output}    YForces : 0.666378
    Should Contain    ${output}    ZForces : 0.979863
    Should Contain    ${output}    Fx : 0.030681
    Should Contain    ${output}    Fy : 0.963602
    Should Contain    ${output}    Fz : 0.144511
    Should Contain    ${output}    Mx : 0.454397
    Should Contain    ${output}    My : 0.1464
    Should Contain    ${output}    Mz : 0.378093
    Should Contain    ${output}    ForceMagnitude : 0.292793
    Should Contain    ${output}    priority : 0.053935
