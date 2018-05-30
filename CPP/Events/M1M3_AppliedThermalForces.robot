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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 75.7562 0.134382 0.009768 0.838531 0.397698 0.496031 0.763934 0.91427 0.064793 0.482841 0.315698 0.481344 0.148938 0.337905 0.213408 0.255797 0.501924 0.728227 0.632846 0.14973 0.818212 0.037992 0.797654 0.783123 0.704397 0.980733 0.384984 0.710322 0.107707 0.207632 0.788864 0.431585 0.644845 0.878423 0.42446 0.428251 0.733084 0.832498 0.719647 0.261037 0.326364 0.342946 0.935221 0.933187 0.832345 0.173469 0.010102 0.218802 0.9913 0.757764 0.327747 0.674502 0.520926 0.208861 0.696736 0.419856 0.398038 0.2184 0.734546 0.700993 0.618508 0.387731 0.219278 0.441306 0.925348 0.087434 0.546478 0.947367 0.639438 0.881518 0.82751 0.074548 0.880773 0.626773 0.536675 0.38831 0.851546 0.026622 0.320234 0.988526 0.089957 0.153069 0.849557 0.938023 0.601174 0.872058 0.82794 0.671964 0.548303 0.322658 0.052588 0.931263 0.097969 0.206936 0.543958 0.544604 0.92119 0.979187 0.290403 0.935027 0.562292 0.224487 0.266186 0.322777 0.608107 0.183809 0.217281 0.990943 0.879588 0.3453 0.491792 0.647787 0.934766 0.232536 0.955699 0.247911 0.697279 0.327077 0.019585 0.093088 0.218467 0.676732 0.733871 0.932334 0.572502 0.898712 0.142766 0.233981 0.440445 0.701436 0.377908 0.157411 0.222442 0.130243 0.078181 0.177749 0.650739 0.71647 0.928606 0.266365 0.197326 0.835578 0.389548 0.842926 0.160506 0.057279 0.463031 0.774061 0.287891 0.637816 0.295447 0.005444 0.141045 0.440994 0.123474 0.894233 0.818088 0.892381 0.095453 0.103586 0.857901 0.364766 0.344873 0.982539 0.646562 0.186297 0.811757 0.892921 0.93429 0.584431 0.621192 0.542086 0.079401 0.460569 0.028293 0.68783 0.726693 0.644916 0.703393 0.58728 0.478053 0.839485 0.461181 0.773595 0.926808 0.811865 0.394003 0.508956 0.813048 0.068636 0.658502 0.652419 0.020979 0.203463 0.054456 0.196509 0.373621 0.093908 0.604787 0.280475 0.920654 0.392183 0.422839 0.988773 0.094476 0.559509 0.638535 0.901843 0.922743 0.361545 0.57491 0.398356 0.938238 0.644302 0.189997 0.680763 0.928809 0.850139 0.024215 0.989203 0.594 0.325846 0.975184 0.658485 0.982663 0.948264 0.662613 0.924616 0.210483 0.403967 0.52906 0.018502 0.1322 0.996709 0.945059 0.478934 0.839979 0.08145 0.085592 0.729763 0.963873 0.598865 0.793413 0.634703 0.742312 0.924563 0.819077 0.709857 0.655809 0.661831 0.353594 0.791134 0.427094 0.28942 0.110783 0.809266 0.466209 0.594248 0.014286 0.876731 0.393924 0.633971 0.536144 0.522754 0.00072 0.717209 0.469073 0.707321 0.566807 0.598436 0.277558 0.652143 0.5559 0.721615 0.836842 0.965218 2003086901
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedThermalForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2003086901
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedThermalForces received =     1
    Should Contain    ${output}    Timestamp : 75.7562
    Should Contain    ${output}    XForces : 0.134382
    Should Contain    ${output}    YForces : 0.009768
    Should Contain    ${output}    ZForces : 0.838531
    Should Contain    ${output}    Fx : 0.397698
    Should Contain    ${output}    Fy : 0.496031
    Should Contain    ${output}    Fz : 0.763934
    Should Contain    ${output}    Mx : 0.91427
    Should Contain    ${output}    My : 0.064793
    Should Contain    ${output}    Mz : 0.482841
    Should Contain    ${output}    ForceMagnitude : 0.315698
    Should Contain    ${output}    priority : 0.481344
