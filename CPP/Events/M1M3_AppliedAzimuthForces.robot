*** Settings ***
Documentation    M1M3_AppliedAzimuthForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAzimuthForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 52.3174 0.679871 0.433411 0.137674 0.021361 0.116853 0.555237 0.591753 0.398061 0.511682 0.419168 0.322552 0.592271 0.66377 0.749874 0.813839 0.343208 0.39913 0.531277 0.18068 0.78397 0.08878 0.670414 0.747599 0.064239 0.333563 0.812919 0.11712 0.758305 0.737847 0.842227 0.867758 0.085207 0.45811 0.557148 0.258185 0.669974 0.269034 0.982995 0.004386 0.198187 0.53044 0.693471 0.613165 0.728021 0.617798 0.990475 0.456606 0.840697 0.35791 0.140464 0.454257 0.907792 0.533163 0.771952 0.687698 0.377973 0.657057 0.461264 0.515037 0.190647 0.308579 0.59065 0.449555 0.25689 0.414495 0.134791 0.180338 0.55678 0.887774 0.830253 0.600966 0.383666 0.741058 0.501101 0.201341 0.398348 0.748063 0.976222 0.049634 0.915994 0.033753 0.202509 0.152022 0.114744 0.802868 0.529803 0.828336 0.242846 0.659462 0.222297 0.229798 0.730696 0.802415 0.517954 0.958334 0.193683 0.584396 0.112511 0.361895 0.387276 0.900828 0.576035 0.621127 0.378301 0.75922 0.897304 0.381189 0.148255 0.237666 0.542325 0.331377 0.335129 0.379879 0.962298 0.915208 0.778209 0.884705 0.815371 0.461073 0.002501 0.125773 0.276326 0.696988 0.701017 0.16261 0.584171 0.604317 0.667437 0.704154 0.153656 0.46781 0.661386 0.40583 0.467488 0.267329 0.634131 0.482096 0.47435 0.244814 0.431836 0.151204 0.141921 0.685341 0.80217 0.627746 0.873249 0.008788 0.661786 0.999033 0.194015 0.768167 0.279971 0.564664 0.287319 0.184208 0.979329 0.123366 0.571325 0.208981 0.090816 0.765749 0.523152 0.374488 0.979408 0.430647 0.161959 0.308633 0.626814 0.987012 0.551675 0.704879 0.191321 0.247632 0.261272 0.39784 0.573539 0.535375 0.197136 0.987562 0.643627 0.337603 0.952384 0.175992 0.625218 0.860784 0.675577 0.78287 0.971885 0.045718 0.044929 0.463502 0.478321 0.083628 0.071073 0.540184 0.539675 0.961996 0.01852 0.864619 0.977818 0.310322 0.164122 0.080994 0.359783 0.944187 0.402271 0.714054 0.483467 0.575018 0.604752 0.785693 0.385548 0.00793 0.939264 0.190177 0.072658 0.254475 0.724207 0.082721 0.656069 0.911716 0.403757 0.338136 0.847636 0.428679 0.888179 0.96115 0.185386 0.284229 0.585489 0.62232 0.590189 0.626724 0.095664 0.194052 0.521033 0.743478 0.611712 0.292023 0.082292 0.261671 0.008288 0.989997 0.032146 0.960777 0.020806 0.508764 0.571379 0.182479 0.49304 0.977305 0.285226 0.874114 0.736212 0.221178 0.144743 0.259745 0.967964 0.505655 0.284981 0.478208 0.889688 0.725003 0.222505 0.795517 0.011588 0.639698 0.781114 0.033791 0.38297 0.131471 0.716684 0.296812 0.387152 0.427433 -877314319
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAzimuthForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -877314319
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAzimuthForces received =     1
    Should Contain    ${output}    Timestamp : 52.3174
    Should Contain    ${output}    XForces : 0.679871
    Should Contain    ${output}    YForces : 0.433411
    Should Contain    ${output}    ZForces : 0.137674
    Should Contain    ${output}    Fx : 0.021361
    Should Contain    ${output}    Fy : 0.116853
    Should Contain    ${output}    Fz : 0.555237
    Should Contain    ${output}    Mx : 0.591753
    Should Contain    ${output}    My : 0.398061
    Should Contain    ${output}    Mz : 0.511682
    Should Contain    ${output}    ForceMagnitude : 0.419168
    Should Contain    ${output}    priority : 0.322552
