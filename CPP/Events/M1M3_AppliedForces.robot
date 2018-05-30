*** Settings ***
Documentation    M1M3_AppliedForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 47.2952 0.376873 0.550244 0.283356 0.222641 0.735537 0.044625 0.844733 0.046772 0.438926 0.519718 0.714628 0.406479 0.304577 0.492794 0.629068 0.63902 0.376103 0.14892 0.435318 0.884156 0.54652 0.347761 0.062629 0.082133 0.165006 0.047895 0.480352 0.673168 0.863506 0.578767 0.635065 0.67561 0.623328 0.338545 0.941807 0.599962 0.48897 0.56695 0.995519 0.478816 0.905968 0.472072 0.889359 0.878625 0.519182 0.103488 0.392207 0.540732 0.366766 0.22347 0.223944 0.387331 0.122377 0.095348 0.311085 0.4907 0.004067 0.312132 0.714344 0.20018 0.087455 0.041923 0.222381 0.566356 0.266992 0.816354 0.798737 0.4606 0.672689 0.820379 0.382123 0.007057 0.271237 0.831445 0.536348 0.528151 0.202868 0.217901 0.698511 0.018225 0.557068 0.465247 0.351097 0.967764 0.782009 0.419902 0.700137 0.01244 0.599382 0.480818 0.915248 0.218164 0.635344 0.251914 0.259434 0.883868 0.670415 0.693667 0.95759 0.881555 0.791888 0.175051 0.649493 0.007777 0.821816 0.341852 0.59468 0.683001 0.34918 0.616386 0.508094 0.234798 0.199748 0.641843 0.852814 0.206845 0.926262 0.302451 0.37981 0.967928 0.198428 0.208792 0.074738 0.763668 0.64564 0.330514 0.279217 0.127748 0.909944 0.687975 0.181561 0.039362 0.645622 0.978472 0.889688 0.822973 0.978746 0.87343 0.181717 0.820343 0.093155 0.517697 0.578026 0.879913 0.94388 0.31435 0.348161 0.377617 0.530193 0.684078 0.842042 0.041358 0.225993 0.79705 0.645831 0.040612 0.844892 0.028782 0.648274 0.31403 0.229415 0.309587 0.809297 0.950026 0.295529 0.04644 0.988838 0.009105 0.268683 0.770909 0.069768 0.619139 0.473335 0.141311 0.591952 0.473329 0.820452 0.761651 0.493187 0.156845 0.767432 0.339198 0.615468 0.624635 0.775395 0.905435 0.807535 0.955915 0.576006 0.248312 0.829166 0.339699 0.76824 0.518541 0.029583 0.543023 0.917067 0.824748 0.991412 0.68511 0.812174 0.407382 0.057752 0.914782 0.679913 0.571277 0.913683 0.44219 0.360304 0.872406 0.963424 0.868238 0.189055 0.165303 0.892105 0.992823 0.713798 0.648027 0.099069 0.58882 0.443751 0.665129 0.1209 0.334012 0.423314 0.276806 0.544216 0.241192 0.332495 0.83046 0.484972 0.918887 0.288666 0.196727 0.36892 0.774229 0.161763 0.839399 0.403538 0.830201 0.56625 0.134225 0.578669 0.060769 0.987521 0.063909 0.48762 0.717293 0.531581 0.477189 0.101015 0.057367 0.959097 0.667815 0.181594 0.877649 0.35033 0.138916 0.739193 0.418355 0.364227 0.500352 0.878253 0.421201 0.690367 0.413345 0.760143 0.865555 0.168913 0.725586 0.217579 0.280382 0.235414 0.657091 0.698786 -832196463
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -832196463
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedForces received =     1
    Should Contain    ${output}    Timestamp : 47.2952
    Should Contain    ${output}    XForces : 0.376873
    Should Contain    ${output}    YForces : 0.550244
    Should Contain    ${output}    ZForces : 0.283356
    Should Contain    ${output}    Fx : 0.222641
    Should Contain    ${output}    Fy : 0.735537
    Should Contain    ${output}    Fz : 0.044625
    Should Contain    ${output}    Mx : 0.844733
    Should Contain    ${output}    My : 0.046772
    Should Contain    ${output}    Mz : 0.438926
    Should Contain    ${output}    ForceMagnitude : 0.519718
    Should Contain    ${output}    priority : 0.714628
