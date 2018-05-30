*** Settings ***
Documentation    M1M3_RejectedElevationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedElevationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 78.6312 0.490529 0.052544 0.755946 0.65966 0.255419 0.18587 0.550132 0.622196 0.691884 0.428297 0.240441 0.704302 0.212888 0.933198 0.207343 0.179629 0.088884 0.314902 0.202989 0.38411 0.173392 0.70351 0.867453 0.244207 0.634431 0.798581 0.917811 0.269831 0.511759 0.822417 0.953806 0.347626 0.669571 0.10504 0.450986 0.106246 0.459729 0.854058 0.925413 0.405982 0.712617 0.856699 0.835564 0.215403 0.305432 0.353811 0.949258 0.288038 0.554527 0.829342 0.984649 0.539501 0.809585 0.782212 0.874196 0.503765 0.627808 0.750541 0.578596 0.955182 0.661049 0.72742 0.236924 0.702509 0.42881 0.120836 0.7303 0.652212 0.829448 0.734199 0.577647 0.362717 0.743465 0.923546 0.548263 0.236033 0.848002 0.99207 0.061769 0.22966 0.042172 0.059357 0.286065 0.435982 0.633594 0.865567 0.040642 0.105971 0.615142 0.847379 0.068529 0.067524 0.667527 0.249529 0.44267 0.656892 0.458157 0.780111 0.98832 0.145812 0.192858 0.236257 0.641875 0.039134 0.790159 0.581644 0.649038 0.593761 0.476253 0.615334 0.61238 0.94198 0.098185 0.935157 0.024458 0.63032 0.491622 0.499956 0.385858 0.8664 0.205162 0.815957 0.793148 0.26444 0.463448 0.863407 0.166528 0.763774 0.307427 0.923286 0.47672 0.640398 0.029386 0.798115 0.672484 0.037493 0.29747 0.136553 0.028877 0.599856 0.429966 0.753035 0.150002 0.424757 0.742772 0.0784 0.529068 0.728921 0.719117 0.126588 0.149574 0.681894 0.802032 0.201323 0.930871 0.905964 0.37149 0.576008 0.514387 0.313923 0.067464 0.854756 0.017317 0.638083 0.326166 0.714715 0.685864 0.21926 0.105833 0.579526 0.24612 0.932325 0.89573 0.422662 0.917336 0.097694 0.362368 0.074614 0.123398 0.402118 0.913578 0.34993 0.507232 0.19723 0.777166 0.097245 0.684788 0.629689 0.044132 0.608086 0.64366 0.058894 0.71787 0.525951 0.75798 0.494075 0.086394 0.034934 0.438959 0.723409 0.004035 0.849924 0.440449 0.454409 0.110348 0.985032 0.487776 0.888608 0.398716 0.89584 0.59409 0.893891 0.497928 0.185632 0.702464 0.5904 0.250661 0.457717 0.422614 0.178163 0.081525 0.841421 0.03883 0.944863 0.839919 0.396705 0.801019 0.863816 0.513664 0.411124 0.804094 0.481264 0.675919 0.523836 0.517733 0.093976 0.639826 0.25199 0.317191 0.939388 0.237537 0.036235 0.794391 0.552663 0.61076 0.25156 0.759977 0.835159 0.668168 0.582809 0.727712 0.325549 0.161551 0.117951 0.181046 0.840041 0.130839 0.367462 0.38184 0.627323 0.186537 0.626998 0.055315 0.722316 0.466523 0.414524 0.368204 0.152773 0.977766 0.945918 0.819343 0.347517 0.755309 0.847388 0.873184 1428515435
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedElevationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1428515435
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedElevationForces received =     1
    Should Contain    ${output}    Timestamp : 78.6312
    Should Contain    ${output}    XForces : 0.490529
    Should Contain    ${output}    YForces : 0.052544
    Should Contain    ${output}    ZForces : 0.755946
    Should Contain    ${output}    Fx : 0.65966
    Should Contain    ${output}    Fy : 0.255419
    Should Contain    ${output}    Fz : 0.18587
    Should Contain    ${output}    Mx : 0.550132
    Should Contain    ${output}    My : 0.622196
    Should Contain    ${output}    Mz : 0.691884
    Should Contain    ${output}    ForceMagnitude : 0.428297
    Should Contain    ${output}    priority : 0.240441
