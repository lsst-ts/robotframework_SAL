*** Settings ***
Documentation    M1M3_RejectedAzimuthForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAzimuthForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 24.2773 0.440783 0.683476 0.330596 0.490873 0.146294 0.012568 0.642565 0.727925 0.313147 0.715295 0.743066 0.548383 0.338113 0.015254 0.936455 0.047144 0.149898 0.847428 0.233517 0.109366 0.91781 0.183051 0.267969 0.265583 0.705468 0.41047 0.186125 0.969959 0.616269 0.567363 0.346794 0.021869 0.131535 0.283682 0.982837 0.764211 0.657685 0.863634 0.082589 0.768467 0.947024 0.139878 0.944801 0.91593 0.974991 0.424875 0.001407 0.761705 0.175307 0.540705 0.20504 0.590696 0.132899 0.629556 0.200862 0.992237 0.540406 0.329003 0.188162 0.677044 0.113396 0.366525 0.33432 0.950445 0.695635 0.058106 0.081918 0.218396 0.689473 0.370452 0.208318 0.524452 0.182914 0.363625 0.932887 0.865958 0.877327 0.561372 0.21203 0.787608 0.180382 0.935983 0.842116 0.768265 0.87123 0.365583 0.530438 0.710064 0.088949 0.85731 0.003099 0.688241 0.264286 0.840906 0.527221 0.908431 0.114236 0.159049 0.48947 0.892404 0.54339 0.851773 0.075814 0.274284 0.764415 0.186475 0.429085 0.608159 0.135582 0.102487 0.337733 0.896267 0.101295 0.838877 0.77835 0.823118 0.377595 0.954275 0.589302 0.462151 0.10259 0.804997 0.130323 0.447288 0.808558 0.482337 0.880631 0.617485 0.449138 0.445684 0.863309 0.113022 0.757764 0.49717 0.021796 0.78103 0.207836 0.238898 0.258143 0.754117 0.655018 0.10409 0.080053 0.51574 0.162078 0.714487 0.6957 0.041503 0.165705 0.122129 0.638274 0.762542 0.805045 0.230696 0.331603 0.759874 0.544245 0.930484 0.274083 0.422503 0.100077 0.883141 0.669225 0.913936 0.114158 0.849368 0.097123 0.683725 0.433783 0.712522 0.7549 0.567154 0.32061 0.013834 0.550938 0.580458 0.788463 0.700605 0.520311 0.630571 0.878942 0.654923 0.15273 0.534506 0.756833 0.276938 0.979558 0.113144 0.767548 0.429486 0.837752 0.07468 0.344861 0.548741 0.839387 0.746583 0.335917 0.877709 0.687644 0.56864 0.465654 0.037276 0.608203 0.557391 0.641033 0.673438 0.567193 0.814894 0.343392 0.922985 0.684197 0.807161 0.383103 0.862849 0.956543 0.277908 0.450109 0.546424 0.235327 0.035753 0.247042 0.08101 0.372598 0.585243 0.574992 0.862327 0.842759 0.549015 0.785781 0.299954 0.186673 0.97551 0.416822 0.457101 0.230239 0.814626 0.412216 0.749032 0.94862 0.9218 0.765433 0.570831 0.092466 0.239724 0.521717 0.455264 0.518048 0.493369 0.540182 0.024084 0.115125 0.10522 0.246569 0.073083 0.467349 0.623977 0.328854 0.64711 0.616435 0.245908 0.948408 0.354843 0.003896 0.081247 0.434905 0.266305 0.206876 0.256498 0.272656 0.236364 0.216258 0.35989 0.273958 0.883383 0.49615 478805077
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAzimuthForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 478805077
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAzimuthForces received =     1
    Should Contain    ${output}    Timestamp : 24.2773
    Should Contain    ${output}    XForces : 0.440783
    Should Contain    ${output}    YForces : 0.683476
    Should Contain    ${output}    ZForces : 0.330596
    Should Contain    ${output}    Fx : 0.490873
    Should Contain    ${output}    Fy : 0.146294
    Should Contain    ${output}    Fz : 0.012568
    Should Contain    ${output}    Mx : 0.642565
    Should Contain    ${output}    My : 0.727925
    Should Contain    ${output}    Mz : 0.313147
    Should Contain    ${output}    ForceMagnitude : 0.715295
    Should Contain    ${output}    priority : 0.743066
