*** Settings ***
Documentation    M1M3_AppliedElevationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedElevationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 46.7877 0.840813 0.831169 0.749662 0.874148 0.655543 0.615255 0.404018 0.234364 0.192627 0.510098 0.18287 0.539205 0.867813 0.737868 0.930743 0.284655 0.442362 0.070367 0.317641 0.965051 0.922025 0.72819 0.534164 0.008421 0.544911 0.239985 0.493407 0.630178 0.568057 0.428802 0.448031 0.594639 0.495811 0.644485 0.356078 0.415521 0.052948 0.761262 0.334026 0.847482 0.258089 0.786126 0.18491 0.329021 0.75275 0.449914 0.887491 0.28797 0.21467 0.201249 0.396623 0.82084 0.524111 0.214125 0.63338 0.757604 0.428606 0.366845 0.014749 0.88987 0.089703 0.310614 0.377367 0.457201 0.164926 0.222042 0.899606 0.008484 0.010368 0.102675 0.402299 0.48811 0.839165 0.432574 0.222426 0.798157 0.047025 0.073572 0.150716 0.583365 0.489749 0.424039 0.782313 0.564924 0.957646 0.197657 0.880221 0.401526 0.403478 0.826532 0.200456 0.66127 0.603489 0.713826 0.701204 0.248595 0.880613 0.487558 0.430841 0.50433 0.126757 0.786067 0.62317 0.05154 0.267376 0.534511 0.925331 0.202875 0.167562 0.559976 0.400538 0.120323 0.12013 0.013051 0.554286 0.515951 0.980558 0.737824 0.78626 0.748887 0.816624 0.241965 0.830209 0.728184 0.14876 0.061738 0.775001 0.850948 0.084735 0.954362 0.511708 0.97632 0.005365 0.483717 0.743134 0.81528 0.402322 0.656531 0.316739 0.334694 0.080425 0.724266 0.145949 0.21236 0.282883 0.431329 0.99132 0.310563 0.693119 0.75521 0.888648 0.885382 0.655995 0.514909 0.692698 0.186202 0.165914 0.931718 0.648688 0.232374 0.488125 0.213564 0.828708 0.705411 0.691544 0.368262 0.254602 0.690934 0.637944 0.594266 0.429296 0.195403 0.047839 0.900569 0.58149 0.385453 0.830912 0.384004 0.462615 0.577575 0.888733 0.137714 0.261446 0.040328 0.946857 0.497529 0.911028 0.916855 0.902423 0.716743 0.898835 0.489279 0.422693 0.530295 0.452988 0.589285 0.203439 0.168943 0.38761 0.65683 0.68441 0.841161 0.140687 0.723997 0.668662 0.005628 0.343726 0.255755 0.505584 0.083243 0.253147 0.284758 0.00148 0.37336 0.763739 0.112607 0.920337 0.936378 0.776594 0.959079 0.20243 0.448285 0.115563 0.869777 0.885536 0.434391 0.804003 0.097978 0.852939 0.564172 0.133427 0.218179 0.021143 0.087875 0.376244 0.145108 0.179987 0.462078 0.733589 0.138048 0.029853 0.524725 0.887653 0.011775 0.967152 0.642326 0.739048 0.919881 0.089232 0.878267 0.262169 0.14493 0.70633 0.204255 0.397047 0.396439 0.539131 0.84472 0.742162 0.816927 0.178381 0.5827 0.326393 0.435291 0.959694 0.497016 0.94989 0.940838 0.877388 0.443154 0.003675 0.964498 0.68729 0.597878 0.356326 994024809
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedElevationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 994024809
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedElevationForces received =     1
    Should Contain    ${output}    Timestamp : 46.7877
    Should Contain    ${output}    XForces : 0.840813
    Should Contain    ${output}    YForces : 0.831169
    Should Contain    ${output}    ZForces : 0.749662
    Should Contain    ${output}    Fx : 0.874148
    Should Contain    ${output}    Fy : 0.655543
    Should Contain    ${output}    Fz : 0.615255
    Should Contain    ${output}    Mx : 0.404018
    Should Contain    ${output}    My : 0.234364
    Should Contain    ${output}    Mz : 0.192627
    Should Contain    ${output}    ForceMagnitude : 0.510098
    Should Contain    ${output}    priority : 0.18287
