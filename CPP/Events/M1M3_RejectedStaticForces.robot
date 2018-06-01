*** Settings ***
Documentation    M1M3_RejectedStaticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedStaticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 77.5976 0.040193 0.505922 0.666951 0.903343 0.818936 0.524708 0.422391 0.471193 0.976839 0.188189 0.295336 0.009479 0.359413 0.850563 0.697534 0.417281 0.822739 0.098861 0.865917 0.205708 0.163699 0.931948 0.501573 0.254996 0.555164 0.843383 0.961669 0.777947 0.23681 0.322647 0.306104 0.661713 0.487831 0.208285 0.899762 0.323192 0.227518 0.39455 0.765982 0.10736 0.72223 0.078623 0.470362 0.322117 0.193209 0.749866 0.488911 0.613899 0.285039 0.125963 0.088975 0.629367 0.097384 0.958716 0.07027 0.315974 0.228124 0.848969 0.877883 0.818069 0.850248 0.923494 0.993256 0.323802 0.673957 0.129247 0.668928 0.673627 0.670417 0.370426 0.938045 0.717319 0.671819 0.663247 0.162763 0.633841 0.36259 0.819891 0.871389 0.62927 0.205784 0.795637 0.543868 0.921453 0.488276 0.276055 0.946771 0.16713 0.315217 0.968495 0.2242 0.403309 0.073633 0.407451 0.549645 0.775151 0.500854 0.254875 0.731611 0.995091 0.070933 0.986549 0.02345 0.005052 0.076276 0.322288 0.60093 0.272404 0.646052 0.647602 0.253469 0.332823 0.906279 0.874085 0.55238 0.198554 0.226136 0.947969 0.579281 0.033841 0.507612 0.978242 0.966832 0.819645 0.038193 0.300003 0.130367 0.984979 0.198857 0.621781 0.89029 0.320721 0.781451 0.670608 0.594499 0.890658 0.29565 0.329426 0.105992 0.838803 0.470779 0.688917 0.278787 0.375031 0.423691 0.096835 0.611742 0.711679 0.441406 0.466391 0.323982 0.961877 0.248481 0.366197 0.866082 0.543201 0.848656 0.315213 0.125567 0.224262 0.385739 0.412661 0.169848 0.234774 0.156004 0.144445 0.90529 0.456272 0.402808 0.361954 0.425258 0.264301 0.254265 0.471925 0.259676 0.982671 0.368747 0.014548 0.986534 0.127529 0.44383 0.249623 0.961141 0.685695 0.640286 0.316779 0.501167 0.279509 0.585638 0.319226 0.71854 0.465245 0.679337 0.986285 0.705097 0.036112 0.656479 0.680427 0.590118 0.801337 0.604475 0.560497 0.463408 0.917915 0.452813 0.612339 0.164918 0.936341 0.583734 0.678538 0.898656 0.855346 0.737057 0.688187 0.085651 0.242644 0.127052 0.07026 0.552469 0.917684 0.288786 0.193293 0.059551 0.826352 0.811592 0.095392 0.66026 0.707791 0.261317 0.090342 0.998442 0.378101 0.932152 0.063105 0.916373 0.69919 0.048863 0.063469 0.219698 0.470905 0.104445 0.943134 0.563068 0.812447 0.943109 0.966782 0.604456 0.877852 0.928615 0.232475 0.726919 0.022289 0.929437 0.826684 0.55009 0.941147 0.02812 0.680494 0.274319 0.902394 0.09541 0.630177 0.952087 0.827224 0.758638 0.718327 0.822122 0.580113 0.22035 0.232204 0.781572 0.333742 0.587248 0.169469 0.810226 1388762540
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedStaticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1388762540
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedStaticForces received =     1
    Should Contain    ${output}    Timestamp : 77.5976
    Should Contain    ${output}    XForces : 0.040193
    Should Contain    ${output}    YForces : 0.505922
    Should Contain    ${output}    ZForces : 0.666951
    Should Contain    ${output}    Fx : 0.903343
    Should Contain    ${output}    Fy : 0.818936
    Should Contain    ${output}    Fz : 0.524708
    Should Contain    ${output}    Mx : 0.422391
    Should Contain    ${output}    My : 0.471193
    Should Contain    ${output}    Mz : 0.976839
    Should Contain    ${output}    ForceMagnitude : 0.188189
    Should Contain    ${output}    priority : 0.295336
