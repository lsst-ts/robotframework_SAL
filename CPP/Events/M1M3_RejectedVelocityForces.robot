*** Settings ***
Documentation    M1M3_RejectedVelocityForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedVelocityForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 88.8741 0.747929 0.865836 0.301951 0.614479 0.503177 0.659574 0.983775 0.229864 0.754512 0.082577 0.264968 0.364499 0.354538 0.852357 0.946475 0.053411 0.332341 0.529905 0.307098 0.406085 0.64006 0.600256 0.872562 0.989757 0.464322 0.274776 0.850636 0.572984 0.607254 0.498312 0.648692 0.331219 0.261321 0.813039 0.288378 0.236113 0.943424 0.616532 0.515766 0.187928 0.916443 0.966254 0.689346 0.981923 0.976222 0.405578 0.682623 0.527485 0.994067 0.899004 0.029367 0.539435 0.980285 0.954088 0.815469 0.689361 0.330165 0.822822 0.786654 0.158749 0.963162 0.763476 0.688634 0.682988 0.095016 0.328316 0.272604 0.919156 0.26948 0.100452 0.623633 0.862081 0.024848 0.848437 0.497017 0.022685 0.2313 0.832554 0.748829 0.174645 0.629018 0.375018 0.130257 0.181901 0.188652 0.050325 0.946183 0.070356 0.061938 0.803964 0.000132 0.389924 0.849189 0.571717 0.292673 0.522171 0.941583 0.980816 0.937376 0.897329 0.513559 0.191241 0.347673 0.344598 0.616309 0.723406 0.481275 0.160475 0.770951 0.666888 0.350685 0.79795 0.037147 0.167423 0.644726 0.864213 0.528796 0.058678 0.054516 0.515572 0.850536 0.43806 0.709331 0.214379 0.80179 0.63704 0.588692 0.750424 0.281079 0.781803 0.793532 0.743494 0.743979 0.421865 0.751704 0.300342 0.032709 0.410125 0.674042 0.173465 0.951309 0.662334 0.461745 0.800613 0.659827 0.946151 0.18289 0.236264 0.70604 0.12006 0.98829 0.649944 0.370838 0.167901 0.3513 0.871024 0.413476 0.346667 0.071872 0.793365 0.509048 0.194151 0.401952 0.535372 0.606454 0.700722 0.091505 0.898287 0.074239 0.872539 0.069945 0.938588 0.610102 0.729481 0.375942 0.608354 0.888322 0.147327 0.193102 0.349988 0.980336 0.906002 0.339089 0.868203 0.603619 0.045978 0.894934 0.726709 0.038485 0.077956 0.967665 0.788272 0.838773 0.641838 0.261733 0.598356 0.17258 0.714481 0.073286 0.508778 0.136128 0.689063 0.804461 0.879839 0.829741 0.548147 0.289421 0.158477 0.301504 0.530509 0.210898 0.612295 0.641837 0.802759 0.78087 0.406008 0.668297 0.800537 0.894418 0.447594 0.260322 0.127861 0.10657 0.086053 0.54336 0.196128 0.108668 0.791298 0.168375 0.833323 0.757397 0.699016 0.187099 0.888565 0.558655 0.361626 0.208168 0.518564 0.397531 0.680998 0.73671 0.852063 0.356001 0.051007 0.444183 0.127433 0.736693 0.358056 0.223029 0.067366 0.478518 0.223422 0.616304 0.626474 0.465733 0.780226 0.966386 0.865694 0.535872 0.084382 0.175657 0.565656 0.643683 0.346067 0.367454 0.446409 0.248138 0.094569 0.655055 0.278827 0.645901 0.087319 0.671438 0.32244 0.646733 -2046988309
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedVelocityForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2046988309
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedVelocityForces received =     1
    Should Contain    ${output}    Timestamp : 88.8741
    Should Contain    ${output}    XForces : 0.747929
    Should Contain    ${output}    YForces : 0.865836
    Should Contain    ${output}    ZForces : 0.301951
    Should Contain    ${output}    Fx : 0.614479
    Should Contain    ${output}    Fy : 0.503177
    Should Contain    ${output}    Fz : 0.659574
    Should Contain    ${output}    Mx : 0.983775
    Should Contain    ${output}    My : 0.229864
    Should Contain    ${output}    Mz : 0.754512
    Should Contain    ${output}    ForceMagnitude : 0.082577
    Should Contain    ${output}    priority : 0.264968
