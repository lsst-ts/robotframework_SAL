*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 60.3953 0.812897 0.066815 0.565945 0.62167 0.071814 0.927655 0.360457 0.321336 0.893578 0.566597 0.202776 0.0369 0.062461 0.304943 0.205959 0.103687 0.220532 0.204349 0.17034 0.681247 0.176962 0.455476 0.838628 0.09001 0.13269 0.071511 0.574887 0.75984 0.949128 0.538899 0.886837 0.2941 0.566015 0.326802 0.439811 0.433837 0.14667 0.075551 0.633318 0.678177 0.475393 0.589847 0.878099 0.011095 0.740351 0.164751 0.145922 0.030928 0.316905 0.440151 0.65523 0.785246 0.477044 0.812437 0.37824 0.441805 0.76743 0.825055 0.048828 0.217418 0.275195 0.120856 0.783629 0.981261 0.730245 0.971998 0.990037 0.128008 0.868556 0.176886 0.854247 0.726636 0.588608 0.832905 0.076174 0.269407 0.386028 0.922543 0.013763 0.451823 0.097619 0.822819 0.630385 0.474011 0.633491 0.494218 0.974257 0.153098 0.103274 0.577526 0.562123 0.29823 0.730407 0.363973 0.998176 0.146345 0.013768 0.977481 0.958902 0.393124 0.437318 0.011138 0.784627 0.127586 0.721856 0.088332 0.193276 0.690993 0.394675 0.588848 0.679744 0.54209 0.360698 0.464278 0.273632 0.336737 0.959316 0.426668 0.575257 0.612102 0.388822 0.212184 0.567157 0.323301 0.373391 0.777054 0.548609 0.158963 0.83899 0.437066 0.148953 0.05167 0.012514 0.012884 0.860112 0.835997 0.069475 0.066133 0.559994 0.030578 0.574576 0.505732 0.605959 0.629682 0.6332 0.004694 0.491757 0.897378 0.912427 0.087948 0.230253 0.131154 0.631453 0.667684 0.29537 0.375537 0.467092 0.56939 0.350801 1854266841
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1854266841
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 60.3953
    Should Contain    ${output}    ZForces : 0.812897
    Should Contain    ${output}    Fz : 0.066815
    Should Contain    ${output}    Mx : 0.565945
    Should Contain    ${output}    My : 0.62167
    Should Contain    ${output}    priority : 0.071814
