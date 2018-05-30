*** Settings ***
Documentation    M1M3_AppliedAccelerationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAccelerationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 72.6613 0.382886 0.159567 0.109724 0.047484 0.836811 0.560021 0.611097 0.09859 0.708651 0.390339 0.065269 0.130011 0.540899 0.207934 0.545742 0.32868 0.217665 0.657442 0.019502 0.858806 0.812411 0.01231 0.876273 0.022268 0.331561 0.416147 0.235007 0.715642 0.416273 0.81359 0.251842 0.389285 0.774673 0.963698 0.706353 0.929441 0.321691 0.999096 0.618741 0.370728 0.704511 0.384753 0.433254 0.082 0.716857 0.873021 0.617211 0.511071 0.957904 0.246438 0.125051 0.205343 0.133118 0.096398 0.20608 0.305122 0.476308 0.783196 0.529754 0.163525 0.321059 0.056718 0.241642 0.177809 0.31126 0.265247 0.096587 0.523205 0.152498 0.205514 0.793441 0.589873 0.219032 0.40397 0.449719 0.681235 0.000687 0.777689 0.749598 0.692264 0.507051 0.757746 0.493367 0.135775 0.344161 0.141829 0.454835 0.128375 0.152967 0.898618 0.924797 0.0356 0.513291 0.297605 0.417159 0.680826 0.780802 0.680622 0.264691 0.454766 0.538115 0.992762 0.523132 0.273296 0.895205 0.992241 0.772481 0.557968 0.30539 0.355678 0.06783 0.203597 0.984448 0.680179 0.198771 0.557719 0.901993 0.155751 0.933599 0.728796 0.850544 0.104062 0.503817 0.477501 0.950071 0.925219 0.638011 0.317347 0.63938 0.24816 0.710675 0.266493 0.805724 0.905581 0.721743 0.066452 0.398104 0.358776 0.724578 0.491077 0.387608 0.785286 0.105177 0.426074 0.941696 0.473338 0.82857 0.213694 0.147183 0.663311 0.422839 0.13318 0.179661 0.430051 0.569357 0.675723 0.600561 0.04841 0.284931 0.734876 0.24301 0.956592 0.533159 0.035398 0.563813 0.259417 0.134112 0.768437 0.464281 0.315844 0.578765 0.983659 0.560039 0.664764 0.698085 0.056637 0.345724 0.857843 0.083367 0.668428 0.200526 0.013347 0.115194 0.926014 0.71983 0.311158 0.339481 0.658104 0.107354 0.190272 0.776357 0.445499 0.434325 0.867241 0.971876 0.700694 0.772457 0.882165 0.994821 0.341777 0.31564 0.53822 0.284347 0.400526 0.311954 0.80832 0.894856 0.36247 0.410315 0.041315 0.885162 0.173029 0.210327 0.086111 0.63166 0.012171 0.259182 0.691356 0.750295 0.01488 0.116159 0.09304 0.943166 0.645091 0.940361 0.51487 0.882431 0.855168 0.86559 0.744225 0.331672 0.907293 0.278291 0.238447 0.37246 0.920528 0.686418 0.657973 0.210815 0.529565 0.763835 0.531394 0.885504 0.589541 0.34016 0.887667 0.665381 0.643052 0.641729 0.20477 0.95959 0.709137 0.821281 0.389766 0.501356 0.666003 0.199961 0.05538 0.548166 0.594656 0.938016 0.517088 0.29907 0.205463 0.976879 0.156988 0.398525 0.828257 0.821764 0.05201 0.967767 0.432557 0.75852 0.458908 0.064305 272994502
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAccelerationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 272994502
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAccelerationForces received =     1
    Should Contain    ${output}    Timestamp : 72.6613
    Should Contain    ${output}    XForces : 0.382886
    Should Contain    ${output}    YForces : 0.159567
    Should Contain    ${output}    ZForces : 0.109724
    Should Contain    ${output}    Fx : 0.047484
    Should Contain    ${output}    Fy : 0.836811
    Should Contain    ${output}    Fz : 0.560021
    Should Contain    ${output}    Mx : 0.611097
    Should Contain    ${output}    My : 0.09859
    Should Contain    ${output}    Mz : 0.708651
    Should Contain    ${output}    ForceMagnitude : 0.390339
    Should Contain    ${output}    priority : 0.065269
