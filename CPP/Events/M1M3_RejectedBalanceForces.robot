*** Settings ***
Documentation    M1M3_RejectedBalanceForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedBalanceForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 38.9225 0.722539 0.272054 0.402397 0.370139 0.67792 0.011182 0.849214 0.147628 0.360137 0.472772 0.331695 0.597506 0.918863 0.599412 0.285607 0.666893 0.834742 0.553636 0.951329 0.684028 0.350365 0.113797 0.380484 0.400666 0.889882 0.765343 0.614511 0.756766 0.237204 0.706744 0.165491 0.616999 0.951684 0.705374 0.100713 0.917436 0.551595 0.449417 0.75606 0.909094 0.999112 0.062469 0.299629 0.163866 0.261834 0.641633 0.1836 0.359446 0.429912 0.276344 0.1097 0.921928 0.904264 0.098228 0.329031 0.805372 0.252688 0.956476 0.270543 0.26925 0.986663 0.477324 0.244535 0.100285 0.559516 0.50764 0.684788 0.581192 0.577011 0.058756 0.50611 0.398945 0.191125 0.925831 0.065087 0.23696 0.451452 0.641857 0.669691 0.985235 0.114194 0.014618 0.227353 0.095737 0.690994 0.875873 0.181274 0.136913 0.172685 0.169926 0.907241 0.998755 0.780353 0.770415 0.92885 0.000483 0.37888 0.401325 0.895818 0.68477 0.633996 0.671614 0.043297 0.134488 0.632869 0.26298 0.974914 0.811499 0.642447 0.736742 0.656923 0.084839 0.050283 0.485649 0.52954 0.771035 0.18324 0.401654 0.941317 0.96158 0.710411 0.159206 0.186416 0.794974 0.122728 0.100444 0.802239 0.76427 0.545615 0.520826 0.746796 0.946594 0.983733 0.097308 0.729144 0.537111 0.677675 0.90347 0.900356 0.674709 0.334308 0.989447 0.122886 0.697409 0.766892 0.653049 0.45719 0.51372 0.341672 0.598656 0.119074 0.449942 0.638708 0.222841 0.323718 0.275936 0.305718 0.302914 0.893014 0.31142 0.918217 0.878218 0.197133 0.571571 0.4428 0.776637 0.860049 0.334769 0.289236 0.216091 0.768149 0.216972 0.801317 0.657532 0.100786 0.097945 0.959391 0.09031 0.90938 0.598752 0.496994 0.726081 0.836678 0.23743 0.764581 0.664799 0.224263 0.884983 0.854969 0.685027 0.560003 0.486246 0.950007 0.441264 0.392145 0.267093 0.692375 0.095173 0.712468 0.614785 0.481114 0.711766 0.569566 0.715963 0.20008 0.939323 0.005929 0.843481 0.72758 0.957372 0.24042 0.834891 0.263132 0.794375 0.221606 0.552834 0.269535 0.694962 0.59806 0.015238 0.98884 0.744124 0.077697 0.808536 0.82333 0.969966 0.884275 0.675394 0.66102 0.921029 0.520089 0.870555 0.100269 0.324558 0.683167 0.66736 0.722587 0.678664 0.21573 0.562053 0.686527 0.84683 0.069284 0.34949 0.027151 0.308397 0.705885 0.925861 0.306505 0.09111 0.770662 0.850823 0.985847 0.79072 0.268879 0.30203 0.513732 0.624087 0.747843 0.238525 0.793758 0.005033 0.914219 0.042631 0.779973 0.189511 0.099277 0.863674 0.967048 0.318749 0.339466 0.156358 0.848586 0.061684 0.957975 -24956546
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedBalanceForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -24956546
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedBalanceForces received =     1
    Should Contain    ${output}    Timestamp : 38.9225
    Should Contain    ${output}    XForces : 0.722539
    Should Contain    ${output}    YForces : 0.272054
    Should Contain    ${output}    ZForces : 0.402397
    Should Contain    ${output}    Fx : 0.370139
    Should Contain    ${output}    Fy : 0.67792
    Should Contain    ${output}    Fz : 0.011182
    Should Contain    ${output}    Mx : 0.849214
    Should Contain    ${output}    My : 0.147628
    Should Contain    ${output}    Mz : 0.360137
    Should Contain    ${output}    ForceMagnitude : 0.472772
    Should Contain    ${output}    priority : 0.331695
