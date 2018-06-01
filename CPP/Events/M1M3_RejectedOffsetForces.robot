*** Settings ***
Documentation    M1M3_RejectedOffsetForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedOffsetForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 59.0458 0.307878 0.330029 0.050105 0.313556 0.994856 0.466683 0.394746 0.221115 0.085273 0.117875 0.472143 0.715787 0.49508 0.139705 0.628423 0.66648 0.790816 0.172769 0.324023 0.631699 0.004171 0.100635 0.192098 0.038406 0.078412 0.925312 0.594725 0.003899 0.245034 0.485418 0.894752 0.240205 0.656921 0.059938 0.094218 0.827183 0.937905 0.612969 0.24698 0.989399 0.259053 0.447966 0.649937 0.266546 0.778884 0.677254 0.608168 0.233806 0.394306 0.841343 0.520422 0.442058 0.330628 0.79566 0.307116 0.073149 0.178649 0.535152 0.19759 0.061965 0.196038 0.089325 0.383368 0.653405 0.81388 0.795513 0.015023 0.769951 0.187285 0.555778 0.274449 0.92478 0.590928 0.57037 0.4415 0.047966 0.688287 0.124041 0.879299 0.13065 0.933467 0.937608 0.574922 0.856001 0.108574 0.821805 0.908413 0.958718 0.01428 0.427254 0.60599 0.554963 0.126285 0.587879 0.69178 0.717205 0.469141 0.407471 0.015836 0.833117 0.211695 0.401457 0.323987 0.296045 0.742314 0.668445 0.403193 0.12416 0.492675 0.794396 0.168865 0.32742 0.956252 0.21796 0.540639 0.600854 0.20424 0.078882 0.435641 0.299545 0.422879 0.342523 0.007362 0.665864 0.989546 0.517059 0.078615 0.28458 0.976581 0.136582 0.139629 0.385174 0.472315 0.631573 0.778421 0.058405 0.56088 0.499195 0.242141 0.01651 0.624637 0.243686 0.155359 0.782156 0.684832 0.625205 0.055237 0.97993 0.868956 0.357117 0.236705 0.678293 0.419353 0.366823 0.965697 0.675165 0.174765 0.38642 0.086797 0.551562 0.67723 0.338997 0.877996 0.824721 0.420022 0.043452 0.049325 0.635235 0.591117 0.487704 0.257498 0.164724 0.373305 0.868522 0.582071 0.181763 0.601778 0.629352 0.653041 0.869466 0.351798 0.087503 0.888734 0.882269 0.868012 0.389325 0.766729 0.139501 0.682243 0.925534 0.210229 0.936067 0.634899 0.726922 0.263446 0.934536 0.309056 0.102978 0.717724 0.093916 0.620478 0.07865 0.144442 0.658251 0.163014 0.777774 0.565557 0.117513 0.314635 0.962885 0.338336 0.69312 0.268237 0.850595 0.279181 0.571171 0.553286 0.330213 0.991228 0.760989 0.711541 0.365001 0.544768 0.181455 0.879101 0.425311 0.733402 0.238899 0.238581 0.882037 0.700268 0.729586 0.929048 0.713678 0.646879 0.114231 0.160141 0.192056 0.376809 0.949507 0.897633 0.557067 0.602949 0.427879 0.851104 0.45013 0.286821 0.416587 0.874023 0.965112 0.572375 0.63291 0.346668 0.265027 0.960039 0.467129 0.670637 0.979529 0.802184 0.623138 0.882759 0.621314 0.395335 0.879336 0.213391 0.574451 0.278741 0.75419 0.682485 0.411614 0.911791 0.457057 0.64929 0.660897 0.890847 917275204
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 917275204
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 59.0458
    Should Contain    ${output}    XForces : 0.307878
    Should Contain    ${output}    YForces : 0.330029
    Should Contain    ${output}    ZForces : 0.050105
    Should Contain    ${output}    Fx : 0.313556
    Should Contain    ${output}    Fy : 0.994856
    Should Contain    ${output}    Fz : 0.466683
    Should Contain    ${output}    Mx : 0.394746
    Should Contain    ${output}    My : 0.221115
    Should Contain    ${output}    Mz : 0.085273
    Should Contain    ${output}    ForceMagnitude : 0.117875
    Should Contain    ${output}    priority : 0.472143
