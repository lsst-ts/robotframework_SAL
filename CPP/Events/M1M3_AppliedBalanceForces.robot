*** Settings ***
Documentation    M1M3_AppliedBalanceForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedBalanceForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 25.583 0.389478 0.37755 0.87224 0.855014 0.131319 0.539175 0.800103 0.721732 0.101775 0.782711 0.8121 0.880087 0.644889 0.502259 0.691556 0.920923 0.428967 0.040495 0.036439 0.347673 0.062503 0.769259 0.850918 0.221733 0.12627 0.867987 0.196302 0.989904 0.726674 0.49712 0.558963 0.770716 0.337892 0.768473 0.626452 0.659631 0.899949 0.697483 0.28793 0.121237 0.66125 0.838133 0.227473 0.196664 0.805368 0.246782 0.318012 0.039439 0.186854 0.976774 0.768229 0.097267 0.850373 0.263731 0.559588 0.460769 0.233885 0.342321 0.418118 0.938125 0.308187 0.251829 0.126998 0.098406 0.161457 0.190936 0.99444 0.987015 0.534363 0.578036 0.919229 0.490938 0.041806 0.076129 0.592321 0.379031 0.1299 0.202882 0.399897 0.342635 0.229052 0.306767 0.055209 0.182958 0.935996 0.768058 0.100295 0.223352 0.812338 0.638909 0.768057 0.311656 0.070361 0.476429 0.625087 0.975611 0.22516 0.178365 0.880663 0.088718 0.489162 0.985007 0.880897 0.525068 0.394182 0.533623 0.633228 0.849619 0.641375 0.46153 0.791426 0.134541 0.300562 0.185172 0.567076 0.787951 0.391627 0.378148 0.600604 0.145515 0.026416 0.464809 0.339613 0.504343 0.961951 0.916669 0.385124 0.236504 0.202646 0.689808 0.866875 0.264938 0.31432 0.562108 0.753086 0.423601 0.497337 0.769414 0.441535 0.075996 0.924357 0.982366 0.62674 0.031852 0.376125 0.457015 0.267115 0.529215 0.606918 0.144085 0.995976 0.983176 0.065815 0.942667 0.855644 0.58783 0.598363 0.818217 0.168497 0.30903 0.761076 0.289917 0.947924 0.383496 0.656151 0.032127 0.788655 0.089776 0.948726 0.554612 0.934918 0.576542 0.648883 0.365394 0.695945 0.274943 0.629213 0.649789 0.328241 0.192027 0.256298 0.497025 0.802719 0.753659 0.198459 0.225815 0.819724 0.729388 0.769037 0.078385 0.543176 0.387319 0.579178 0.340806 0.929283 0.513269 0.214921 0.916869 0.619805 0.039601 0.733901 0.181462 0.065001 0.590537 0.448316 0.573077 0.695851 0.943959 0.361019 0.941693 0.155909 0.688607 0.076717 0.436553 0.540504 0.915759 0.493772 0.516376 0.333176 0.812281 0.715577 0.096656 0.527824 0.752748 0.475565 0.194632 0.134822 0.579978 0.006607 0.047194 0.073755 0.379641 0.818957 0.228057 0.642999 0.4224 0.018231 0.499232 0.189958 0.365712 0.651366 0.680774 0.775238 0.825617 0.351882 0.534975 0.593855 0.382046 0.074907 0.872423 0.157929 0.542538 0.362643 0.305654 0.348504 0.283901 0.659643 0.279268 0.242267 0.989628 0.6589 0.677699 0.78951 0.172382 0.647376 0.917495 0.491754 0.269272 0.088952 0.597706 0.387829 0.703481 0.817712 0.51238 0.753537 -744584488
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedBalanceForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -744584488
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedBalanceForces received =     1
    Should Contain    ${output}    Timestamp : 25.583
    Should Contain    ${output}    XForces : 0.389478
    Should Contain    ${output}    YForces : 0.37755
    Should Contain    ${output}    ZForces : 0.87224
    Should Contain    ${output}    Fx : 0.855014
    Should Contain    ${output}    Fy : 0.131319
    Should Contain    ${output}    Fz : 0.539175
    Should Contain    ${output}    Mx : 0.800103
    Should Contain    ${output}    My : 0.721732
    Should Contain    ${output}    Mz : 0.101775
    Should Contain    ${output}    ForceMagnitude : 0.782711
    Should Contain    ${output}    priority : 0.8121
