*** Settings ***
Documentation    M1M3_AppliedStaticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedStaticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 55.136 0.915379 0.512323 0.741455 0.911966 0.982579 0.904276 0.391669 0.355087 0.236236 0.90015 0.295206 0.343085 0.515217 0.655966 0.734728 0.166673 0.321655 0.934895 0.811646 0.847952 0.522887 0.734908 0.078252 0.516071 0.783873 0.126162 0.828706 0.33669 0.963152 0.558379 0.388501 0.867689 0.266167 0.291602 0.100954 0.440993 0.357243 0.978062 0.18097 0.104739 0.301295 0.187043 0.157213 0.500253 0.637608 0.579733 0.108593 0.617937 0.050471 0.952547 0.608821 0.114721 0.452842 0.443743 0.281119 0.493165 0.701345 0.367564 0.317196 0.717067 0.720336 0.872538 0.595889 0.590386 0.763772 0.810932 0.144168 0.19942 0.657468 0.499525 0.908858 0.4859 0.425117 0.709382 0.060874 0.64204 0.195125 0.244167 0.130997 0.880107 0.939032 0.476519 0.379469 0.016757 0.125565 0.971162 0.422898 0.745156 0.466802 0.289773 0.185126 0.996526 0.815241 0.309031 0.407573 0.110767 0.152019 0.476067 0.008436 0.899698 0.01301 0.800066 0.060672 0.391203 0.065417 0.481378 0.342462 0.143978 0.302296 0.3661 0.183085 0.732807 0.248357 0.367864 0.752357 0.216267 0.550388 0.501862 0.520515 0.11567 0.340124 0.378455 0.604746 0.275904 0.39718 0.720427 0.450873 0.976798 0.137422 0.798129 0.719894 0.024926 0.827847 0.373783 0.307117 0.127323 0.825151 0.53837 0.998668 0.315938 0.271418 0.301624 0.015744 0.232371 0.720441 0.264993 0.165551 0.846424 0.568404 0.131823 0.015328 0.01237 0.742914 0.59271 0.371005 0.177163 0.962966 0.909771 0.887705 0.096586 0.079254 0.819838 0.296371 0.416964 0.455685 0.835132 0.932195 0.989984 0.586241 0.988545 0.10462 0.641429 0.252468 0.307292 0.13813 0.404164 0.94093 0.095422 0.341383 0.442474 0.07701 0.978704 0.660692 0.091992 0.564985 0.334065 0.200001 0.166241 0.906368 0.67362 0.838241 0.515695 0.5313 0.402378 0.46161 0.239934 0.613637 0.629914 0.243796 0.135025 0.826108 0.32017 0.22345 0.834029 0.682686 0.341782 0.434916 0.406131 0.983056 0.855981 0.819438 0.097635 0.825194 0.563836 0.81762 0.050388 0.621647 0.512948 0.716096 0.251614 0.808524 0.177468 0.4982 0.853933 0.267912 0.976844 0.932548 0.972731 0.23752 0.015182 0.210826 0.844175 0.099665 0.292848 0.352762 0.130133 0.618534 0.174953 0.572481 0.400891 0.591927 0.036807 0.990273 0.135597 0.510525 0.075765 0.724495 0.250348 0.273597 0.737735 0.892911 0.405593 0.095358 0.091087 0.302904 0.875808 0.86759 0.351359 0.99697 0.757601 0.455197 0.972528 0.496688 0.849455 0.428099 0.49874 0.638811 0.203044 0.830582 0.36175 0.687424 0.80778 0.867771 0.745894 0.799406 -979459980
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedStaticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -979459980
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedStaticForces received =     1
    Should Contain    ${output}    Timestamp : 55.136
    Should Contain    ${output}    XForces : 0.915379
    Should Contain    ${output}    YForces : 0.512323
    Should Contain    ${output}    ZForces : 0.741455
    Should Contain    ${output}    Fx : 0.911966
    Should Contain    ${output}    Fy : 0.982579
    Should Contain    ${output}    Fz : 0.904276
    Should Contain    ${output}    Mx : 0.391669
    Should Contain    ${output}    My : 0.355087
    Should Contain    ${output}    Mz : 0.236236
    Should Contain    ${output}    ForceMagnitude : 0.90015
    Should Contain    ${output}    priority : 0.295206
