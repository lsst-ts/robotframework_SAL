*** Settings ***
Documentation    M1M3_AppliedAberrationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 32.6471 0.265006 0.683262 0.787581 0.325145 0.636971 0.652229 0.148292 0.279175 0.567692 0.485056 0.121583 0.564239 0.36801 0.04258 0.541749 0.700083 0.574027 0.187473 0.410084 0.980463 0.66595 0.428508 0.337496 0.252964 0.511255 0.846239 0.072988 0.245549 0.373901 0.546945 0.781511 0.033722 0.378634 0.429354 0.521256 0.779951 0.602413 0.441054 0.325607 0.669566 0.776301 0.082123 0.98524 0.122752 0.215838 0.750217 0.468674 0.356296 0.710132 0.214117 0.81689 0.874119 0.368557 0.389136 0.489123 0.255698 0.509183 0.864239 0.776499 0.751543 0.465571 0.115698 0.98997 0.866398 0.393821 0.635521 0.728981 0.725324 0.639948 0.439631 0.063558 0.239174 0.987804 0.253248 0.877521 0.891581 0.352067 0.85286 0.104394 0.412324 0.096105 0.722204 0.307453 0.64703 0.069249 0.999688 0.760901 0.565487 0.393194 0.591886 0.574269 0.942126 0.138572 0.337918 0.925338 0.279008 0.237585 0.883322 0.754131 0.248061 0.939791 0.521933 0.594213 0.250258 0.36931 0.902529 0.582117 0.613733 0.06552 0.730526 0.730724 0.898072 0.750521 0.711161 0.627399 0.937481 0.931556 0.087088 0.827321 0.204642 0.898783 0.959658 0.95683 0.02298 0.605478 0.333329 0.280348 0.560799 0.629302 0.586038 0.401306 0.7675 0.498272 0.535009 0.595485 0.42448 0.523556 0.538422 0.442264 0.212394 0.319244 0.25469 0.513833 0.457043 0.562844 0.97846 0.468314 0.242944 0.248086 0.309011 0.612765 0.42395 0.489921 0.766355 0.634882 0.560712 0.344633 0.708934 0.205844 718513436
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 718513436
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 32.6471
    Should Contain    ${output}    ZForces : 0.265006
    Should Contain    ${output}    Fz : 0.683262
    Should Contain    ${output}    Mx : 0.787581
    Should Contain    ${output}    My : 0.325145
    Should Contain    ${output}    priority : 0.636971
