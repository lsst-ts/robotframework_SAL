*** Settings ***
Documentation    M1M3_AppliedAzimuthForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAzimuthForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 72.6572 0.850584 0.762948 0.063805 0.473264 0.598498 0.53535 0.469237 0.869599 0.945109 0.118539 0.95925 0.21242 0.202842 0.315239 0.518884 0.919247 0.650146 0.547912 0.553983 0.805621 0.996531 0.537993 0.726851 0.737619 0.81563 0.649819 0.174862 0.456745 0.205005 0.22982 0.080183 0.300179 0.233501 0.976651 0.884865 0.38838 0.692063 0.962057 0.266859 0.344946 0.192334 0.892369 0.783686 0.143704 0.047065 0.111095 0.453763 0.265435 0.926369 0.065099 0.509695 0.830887 0.970828 0.185354 0.583327 0.551613 0.734417 0.768359 0.60598 0.595913 0.220415 0.929181 0.116396 0.395482 0.970197 0.494818 0.033711 0.860674 0.616712 0.059251 0.446551 0.694869 0.533198 0.04809 0.611183 0.954446 0.147223 0.536458 0.090932 0.751422 0.27045 0.820603 0.764491 0.075344 0.664387 0.087867 0.749974 0.700516 0.922484 0.40409 0.73442 0.271052 0.433359 0.472468 0.14602 0.006024 0.51422 0.788951 0.145915 0.218122 0.765757 0.199306 0.709921 0.786464 0.293187 0.318575 0.525249 0.683597 0.098628 0.150212 0.50903 0.628807 0.520837 0.186431 0.903105 0.045726 0.19151 0.294801 0.914547 0.817199 0.283109 0.234448 0.786076 0.897792 0.140051 0.346431 0.045602 0.110932 0.859285 0.107372 0.382743 0.664014 0.051336 0.765578 0.864624 0.351528 0.175073 0.023934 0.745253 0.826247 0.054203 0.021672 0.391563 0.504917 0.074331 0.299409 0.553047 0.631385 0.588042 0.058274 0.047514 0.052953 0.954046 0.045242 0.374792 0.795929 0.616471 0.347803 0.014673 0.273998 0.516023 0.531915 0.555705 0.943996 0.294694 0.327249 0.679577 0.984625 0.788967 0.978806 0.401791 0.173975 0.779069 0.630054 0.386019 0.879448 0.644089 0.369702 0.824616 0.954553 0.571893 0.950409 0.130178 0.966928 0.663787 0.004112 0.638847 0.193947 0.249964 0.451188 0.523625 0.320574 0.210819 0.276404 0.656601 0.211541 0.217282 0.7374 0.153343 0.811209 0.162242 0.72772 0.048803 0.066068 0.822099 0.704386 0.372547 0.083013 0.938025 0.667718 0.41182 0.495201 0.920676 0.284547 0.923795 0.861274 0.907118 0.382752 0.403264 0.536878 0.057978 0.932443 0.511426 0.72622 0.654482 0.036074 0.222005 0.479615 0.302175 0.275959 0.255102 0.027367 0.885402 0.981115 0.468253 0.002656 0.76894 0.715334 0.398243 0.380481 0.782637 0.573457 0.365634 0.764748 0.379874 0.585913 0.197994 0.604316 0.789801 0.840836 0.942671 0.160042 0.203154 0.645077 0.954323 0.055787 0.403841 0.761024 0.006399 0.655812 0.069301 0.910721 0.402507 0.148224 0.384984 0.630945 0.981929 0.195476 0.133313 0.981804 0.343363 0.93062 0.692917 0.776281 0.233805 -1475796784
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAzimuthForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1475796784
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAzimuthForces received =     1
    Should Contain    ${output}    Timestamp : 72.6572
    Should Contain    ${output}    XForces : 0.850584
    Should Contain    ${output}    YForces : 0.762948
    Should Contain    ${output}    ZForces : 0.063805
    Should Contain    ${output}    Fx : 0.473264
    Should Contain    ${output}    Fy : 0.598498
    Should Contain    ${output}    Fz : 0.53535
    Should Contain    ${output}    Mx : 0.469237
    Should Contain    ${output}    My : 0.869599
    Should Contain    ${output}    Mz : 0.945109
    Should Contain    ${output}    ForceMagnitude : 0.118539
    Should Contain    ${output}    priority : 0.95925
