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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 40.4898 0.402743 0.552596 0.661723 0.119573 0.112575 0.14468 0.031822 0.835074 0.33193 0.415171 0.87815 0.068709 0.121887 0.901205 0.619878 0.132504 0.663856 0.453386 0.370381 0.085492 0.747172 0.849756 0.165677 0.087528 0.882348 0.758768 0.779842 0.848333 0.104995 0.482829 0.501129 0.298134 0.749318 0.751612 0.525583 0.789506 0.151399 0.659049 0.974779 0.101749 0.578525 0.788017 0.684084 0.504547 0.031063 0.631211 0.605595 0.406382 0.949774 0.367984 0.752318 0.764477 0.58302 0.82344 0.214396 0.837906 0.868253 0.263797 0.939825 0.319276 0.550127 0.532779 0.805994 0.354719 0.620337 0.155784 0.207262 0.38494 0.993807 0.310134 0.438875 0.911623 0.837076 0.227035 0.531596 0.809391 0.406855 0.990641 0.359259 0.330661 0.588682 0.826996 0.861044 0.273811 0.494365 0.918783 0.978585 0.105403 0.499517 0.025057 0.471096 0.538777 0.557828 0.576829 0.249838 0.543906 0.134381 0.77772 0.324553 0.400891 0.936943 0.384769 0.528809 0.70957 0.253215 0.782297 0.967287 0.392123 0.768539 0.341127 0.285458 0.084518 0.430671 0.650374 0.306585 0.877635 0.099869 0.798199 0.101877 0.268266 0.954145 0.827076 0.104353 0.033981 0.209143 0.7467 0.16886 0.933238 0.09521 0.509301 0.714929 0.341779 0.561336 0.650137 0.89 0.684506 0.013781 0.75958 0.862191 0.934017 0.827873 0.606494 0.863855 0.260549 0.336822 0.233381 0.220357 0.597415 0.03372 0.376727 0.648958 0.993815 0.482847 0.507775 0.797318 0.66466 0.624208 0.73405 0.009005 -590099650
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -590099650
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 40.4898
    Should Contain    ${output}    ZForces : 0.402743
    Should Contain    ${output}    Fz : 0.552596
    Should Contain    ${output}    Mx : 0.661723
    Should Contain    ${output}    My : 0.119573
    Should Contain    ${output}    priority : 0.112575
