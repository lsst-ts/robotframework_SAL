*** Settings ***
Documentation    M1M3_AppliedOffsetForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedOffsetForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 79.4605 0.995201 0.342953 0.358147 0.875526 0.084891 0.266055 0.716335 0.871461 0.676892 0.309591 0.046195 0.152994 0.185111 0.540036 0.337713 0.204889 0.372498 0.35556 0.060367 0.555742 0.5777 0.11318 0.139619 0.901195 0.243303 0.922472 0.663431 0.9343 0.367279 0.861814 0.94377 0.860185 0.476085 0.237527 0.945531 0.223867 0.725026 0.47839 0.807409 0.048044 0.224892 0.826962 0.003033 0.755466 0.413146 0.909713 0.557186 0.657288 0.087043 0.064042 0.328782 0.337218 0.638751 0.132686 0.22232 0.380064 0.817685 0.673095 0.762193 0.429743 0.715561 0.627268 0.640906 0.724796 0.429041 0.975061 0.807697 0.913444 0.38359 0.380912 0.185435 0.748063 0.788145 0.527755 0.139427 0.841343 0.384775 0.549332 0.257478 0.05736 0.405973 0.968646 0.418998 0.688951 0.056275 0.155982 0.287826 0.249487 0.066872 0.402449 0.13279 0.338799 0.08622 0.870822 0.293601 0.042607 0.081965 0.570692 0.347806 0.708517 0.669978 0.052613 0.558438 0.256386 0.49783 0.475179 0.653201 0.896786 0.640226 0.875919 0.53245 0.419362 0.262098 0.825497 0.020046 0.904208 0.110555 0.216508 0.303054 0.901128 0.108918 0.387047 0.253342 0.391658 0.385456 0.890411 0.825228 0.12018 0.686842 0.087494 0.170799 0.615119 0.327503 0.550184 0.756193 0.09821 0.178725 0.9742 0.405879 0.034945 0.844744 0.4214 0.034092 0.089811 0.561775 0.980203 0.2812 0.81075 0.463323 0.687322 0.055613 0.294165 0.766813 0.435121 0.636838 0.604656 0.525102 0.624267 0.228897 0.611832 0.572874 0.64799 0.353059 0.356786 0.835287 0.002971 0.71527 0.629684 0.427897 0.701066 0.484812 0.957719 0.514457 0.418178 0.018182 0.778951 0.27542 0.852887 0.257446 0.069345 0.507155 0.381538 0.411176 0.713478 0.611827 0.528363 0.429032 0.896867 0.641659 0.312303 0.114298 0.4859 0.69323 0.706861 0.890625 0.248747 0.883286 0.405902 0.275434 0.985983 0.050329 0.29036 0.480781 0.034499 0.389631 0.47262 0.800418 0.274944 0.386739 0.070313 0.903001 0.464887 0.073548 0.952584 0.499656 0.43483 0.714664 0.410585 0.63228 0.370636 0.958232 0.097546 0.347864 0.288614 0.594311 0.021366 0.325553 0.613516 0.23608 0.447809 0.061119 0.567426 0.28826 0.642165 0.525463 0.296754 0.956939 0.178374 0.811671 0.411313 0.260731 0.046217 0.214666 0.452526 0.07968 0.820895 0.467349 0.420228 0.099646 0.029603 0.601044 0.962781 0.696447 0.83823 0.337459 0.027222 0.12272 0.742113 0.785335 0.992936 0.703344 0.022329 0.948811 0.917873 0.903652 0.988083 0.833935 0.82087 0.944206 0.102645 0.792781 0.5866 0.916685 0.466391 0.016922 1757057305
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1757057305
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 79.4605
    Should Contain    ${output}    XForces : 0.995201
    Should Contain    ${output}    YForces : 0.342953
    Should Contain    ${output}    ZForces : 0.358147
    Should Contain    ${output}    Fx : 0.875526
    Should Contain    ${output}    Fy : 0.084891
    Should Contain    ${output}    Fz : 0.266055
    Should Contain    ${output}    Mx : 0.716335
    Should Contain    ${output}    My : 0.871461
    Should Contain    ${output}    Mz : 0.676892
    Should Contain    ${output}    ForceMagnitude : 0.309591
    Should Contain    ${output}    priority : 0.046195
