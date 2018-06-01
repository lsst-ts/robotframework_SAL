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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 66.8903 0.632343 0.792899 0.808967 0.772862 0.806539 0.200764 0.068434 0.301698 0.074415 0.590965 0.812189 0.644264 0.827865 0.641007 0.613948 0.959712 0.775853 0.437302 0.411537 0.187905 0.111722 0.918491 0.295701 0.518218 0.209697 0.959262 0.628084 0.28183 0.916611 0.551886 0.872723 0.564481 0.44921 0.07209 0.481647 0.26542 0.205589 0.589026 0.57933 0.574534 0.599437 0.945177 0.701314 0.32438 0.078351 0.892726 0.177179 0.599456 0.121034 0.908118 0.936938 0.547263 0.313182 0.63835 0.474303 0.094772 0.765755 0.999848 0.078091 0.492207 0.479245 0.648036 0.194317 0.540429 0.920404 0.694642 0.361316 0.160237 0.915847 0.463141 0.498761 0.854682 0.827675 0.34443 0.368202 0.455041 0.611434 0.197103 0.919531 0.869585 0.650788 0.683044 0.189704 0.909305 0.312561 0.540706 0.326499 0.276205 0.086801 0.239375 0.795088 0.039748 0.219946 0.759898 0.957817 0.501593 0.849884 0.513308 0.631364 0.599 0.675157 0.668356 0.45691 0.346038 0.655508 0.277467 0.234402 0.732365 0.996933 0.308304 0.463826 0.587129 0.291961 0.400013 0.259308 0.416893 0.158301 0.790858 0.0164 0.201792 0.64101 0.321391 0.782258 0.949435 0.668318 0.577427 0.901061 0.616475 0.8994 0.459559 0.226899 0.278375 0.068056 0.683132 0.745376 0.922893 0.266497 0.411919 0.195726 0.315867 0.963912 0.751543 0.711028 0.043254 0.299441 0.093458 0.59599 0.170813 0.28961 0.856707 0.176469 0.166068 0.746661 0.651659 0.478292 0.227892 0.161125 0.105052 0.648171 0.883409 0.085244 0.16013 0.154873 0.66022 0.088612 0.082993 0.404726 0.676281 0.960886 0.898018 0.410475 0.292097 0.3382 0.081326 0.613733 0.603596 0.106361 0.627933 0.016957 0.775709 0.860821 0.603236 0.779513 0.009523 0.825777 0.638589 0.364646 0.513549 0.448788 0.381832 0.419475 0.01568 0.076432 0.000977 0.498682 0.583897 0.770242 0.310257 0.737629 0.4649 0.948185 0.765111 0.491084 0.462931 0.989882 0.60613 0.114808 0.833193 0.211354 0.112012 0.188928 0.404626 0.203545 0.858152 0.39723 0.461076 0.756163 0.086108 0.980425 0.165798 0.175071 0.41364 0.758853 0.682896 0.120678 0.991001 0.403358 0.121015 0.966949 0.020161 0.843811 0.802178 0.830693 0.867702 0.544539 0.931264 0.243705 0.335118 0.318572 0.561328 0.891528 0.658082 0.858443 0.63011 0.714415 0.302864 0.329819 0.297461 0.212914 0.257979 0.467683 0.734794 0.897339 0.522988 0.362673 0.912436 0.71114 0.861709 0.472154 0.90423 0.682449 0.602747 0.934945 0.522121 0.0222 0.950423 0.75123 0.073714 0.680506 0.026916 0.610203 0.980067 0.335553 0.090524 0.730184 -1618833904
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedElevationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1618833904
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedElevationForces received =     1
    Should Contain    ${output}    Timestamp : 66.8903
    Should Contain    ${output}    XForces : 0.632343
    Should Contain    ${output}    YForces : 0.792899
    Should Contain    ${output}    ZForces : 0.808967
    Should Contain    ${output}    Fx : 0.772862
    Should Contain    ${output}    Fy : 0.806539
    Should Contain    ${output}    Fz : 0.200764
    Should Contain    ${output}    Mx : 0.068434
    Should Contain    ${output}    My : 0.301698
    Should Contain    ${output}    Mz : 0.074415
    Should Contain    ${output}    ForceMagnitude : 0.590965
    Should Contain    ${output}    priority : 0.812189
