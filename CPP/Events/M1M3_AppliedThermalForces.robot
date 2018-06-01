*** Settings ***
Documentation    M1M3_AppliedThermalForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedThermalForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 11.2375 0.907728 0.915295 0.379306 0.951508 0.203481 0.997798 0.593515 0.693245 0.412863 0.613552 0.274171 0.427244 0.823728 0.636274 0.963313 0.76537 0.987232 0.082265 0.705779 0.304945 0.592604 0.955035 0.302103 0.075178 0.769133 0.096456 0.13073 0.130292 0.851081 0.543811 0.20271 0.311689 0.205534 0.501459 0.184298 0.740319 0.229541 0.372812 0.810583 0.765254 0.239281 0.34611 0.28562 0.730359 0.226914 0.430719 0.00691 0.120738 0.601831 0.209876 0.351813 0.397268 0.983562 0.382719 0.584222 0.106826 0.178561 0.079754 0.40013 0.196558 0.352809 0.693283 0.841544 0.668737 0.461253 0.33998 0.901303 0.375214 0.037437 0.538199 0.354522 0.740288 0.730666 0.428194 0.805396 0.384641 0.282756 0.554985 0.534006 0.57149 0.330566 0.054065 0.19295 0.360299 0.697681 0.481074 0.067783 0.999087 0.461538 0.783548 0.24704 0.508975 0.454768 0.230714 0.315946 0.846899 0.869291 0.624325 0.393644 0.136018 0.936528 0.411446 0.403729 0.171583 0.750083 0.771644 0.518022 0.049361 0.640633 0.948341 0.210036 0.461769 0.424774 0.902787 0.929198 0.301403 0.745825 0.715461 0.123712 0.875249 0.265152 0.519438 0.898606 0.894663 0.470464 0.345033 0.724016 0.952311 0.779021 0.082208 0.584754 0.388928 0.545806 0.132105 0.924313 0.474447 0.818922 0.780432 0.526174 0.996872 0.132432 0.804344 0.050449 0.860221 0.886379 0.715487 0.510637 0.540282 0.860469 0.276691 0.211594 0.709686 0.495506 0.747077 0.912706 0.19992 0.384133 0.81062 0.387009 0.523817 0.958395 0.605418 0.973891 0.305885 0.628835 0.905391 0.891593 0.204023 0.223885 0.498351 0.209516 0.814241 0.084068 0.881738 0.256973 0.532416 0.921741 0.632545 0.716154 0.664283 0.985782 0.259959 0.473551 0.132347 0.776305 0.8361 0.579059 0.243435 0.691354 0.883378 0.695436 0.047496 0.771352 0.324453 0.019588 0.664637 0.945012 0.781675 0.698936 0.873226 0.350791 0.359953 0.255431 0.688529 0.098965 0.296805 0.900455 0.245573 0.859082 0.993686 0.608882 0.973726 0.666612 0.288396 0.16469 0.408666 0.909772 0.883016 0.056407 0.35542 0.453023 0.661265 0.490362 0.821055 0.96524 0.259021 0.770222 0.653567 0.066552 0.408662 0.476692 0.645435 0.41059 0.881075 0.80031 0.924421 0.316044 0.032254 0.882219 0.534233 0.181514 0.37138 0.363043 0.337973 0.025429 0.523835 0.929264 0.589856 0.765038 0.12818 0.063226 0.697102 0.025089 0.541486 0.690291 0.004305 0.890705 0.402089 0.629801 0.620403 0.663296 0.766365 0.185461 0.311187 0.010747 0.015915 0.086951 0.511448 0.287771 0.690528 0.336509 0.377727 0.83174 0.284539 0.198456 -313601370
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedThermalForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -313601370
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedThermalForces received =     1
    Should Contain    ${output}    Timestamp : 11.2375
    Should Contain    ${output}    XForces : 0.907728
    Should Contain    ${output}    YForces : 0.915295
    Should Contain    ${output}    ZForces : 0.379306
    Should Contain    ${output}    Fx : 0.951508
    Should Contain    ${output}    Fy : 0.203481
    Should Contain    ${output}    Fz : 0.997798
    Should Contain    ${output}    Mx : 0.593515
    Should Contain    ${output}    My : 0.693245
    Should Contain    ${output}    Mz : 0.412863
    Should Contain    ${output}    ForceMagnitude : 0.613552
    Should Contain    ${output}    priority : 0.274171
