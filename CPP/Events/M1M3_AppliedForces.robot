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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 13.4852 0.802947 0.541397 0.282645 0.096818 0.313957 0.352535 0.090847 0.166551 0.485013 0.598935 0.829423 0.713624 0.405557 0.0079 0.908625 0.628488 0.929988 0.849761 0.320129 0.682264 0.483741 0.233789 0.834848 0.01226 0.870637 0.368724 0.619789 0.622831 0.307279 0.664811 0.066184 0.16169 0.965322 0.598856 0.808643 0.349211 0.332943 0.786263 0.898189 0.348824 0.426282 0.011916 0.814452 0.889707 0.670138 0.232478 0.087623 0.461478 0.594488 0.928525 0.597868 0.915381 0.987687 0.454468 0.463715 0.898995 0.165634 0.289824 0.137661 0.46197 0.964912 0.290043 0.667169 0.546776 0.79 0.443128 0.063401 0.249622 0.031466 0.194913 0.55804 0.442837 0.030226 0.856206 0.253433 0.354273 0.040503 0.138884 0.238857 0.667313 0.505684 0.096176 0.631785 0.177841 0.69365 0.304057 0.930663 0.14943 0.692687 0.371383 0.279915 0.764835 0.739354 0.459562 0.016645 0.135551 0.319967 0.340237 0.141538 0.550212 0.896966 0.719425 0.249332 0.608754 0.698629 0.619217 0.310738 0.938152 0.911492 0.159865 0.50775 0.058584 0.423253 0.840541 0.066731 0.255248 0.82768 0.630573 0.756081 0.23309 0.351161 0.447354 0.512624 0.848003 0.822095 0.176289 0.807118 0.817014 0.085953 0.848727 0.522247 0.441835 0.109728 0.080684 0.110917 0.749001 0.764657 0.376242 0.57519 0.633538 0.563507 0.083505 0.709809 0.628819 0.889219 0.292351 0.330604 0.545784 0.366495 0.849387 0.822596 0.599808 0.387125 0.857334 0.467393 0.669623 0.626403 0.438764 0.818569 0.175848 0.450279 0.903988 0.937749 0.691632 0.305841 0.848906 0.613391 0.593148 0.635186 0.943076 0.608954 0.04628 0.90115 0.368894 0.533473 0.864005 0.349131 0.022898 0.698149 0.354583 0.575688 0.943663 0.805382 0.122467 0.833201 0.950719 0.652079 0.96577 0.276481 0.663388 0.334827 0.079912 0.145601 0.898938 0.802588 0.134699 0.247656 0.746333 0.607965 0.709537 0.198291 0.324535 0.671163 0.175074 0.216657 0.037625 0.85631 0.72447 0.227222 0.899961 0.384786 0.732888 0.576293 0.653406 0.973837 0.878846 0.679829 0.659401 0.183398 0.653129 0.409357 0.48244 0.011359 0.437304 0.763345 0.839908 0.596402 0.795239 0.791383 0.375639 0.219299 0.256623 0.121507 0.981828 0.269346 0.369058 0.229789 0.020755 0.064343 0.532876 0.399481 0.223473 0.767258 0.631576 0.766541 0.282377 0.350326 0.081344 0.819676 0.387598 0.735444 0.913269 0.160587 0.110017 0.171261 0.056283 0.53839 0.830213 0.7784 0.391001 0.404477 0.39077 0.705719 0.475397 0.12874 0.227294 0.515249 0.121807 0.767097 0.971725 0.889761 0.693136 0.883936 0.194877 0.265255 227360610
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 227360610
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedForces received =     1
    Should Contain    ${output}    Timestamp : 13.4852
    Should Contain    ${output}    XForces : 0.802947
    Should Contain    ${output}    YForces : 0.541397
    Should Contain    ${output}    ZForces : 0.282645
    Should Contain    ${output}    Fx : 0.096818
    Should Contain    ${output}    Fy : 0.313957
    Should Contain    ${output}    Fz : 0.352535
    Should Contain    ${output}    Mx : 0.090847
    Should Contain    ${output}    My : 0.166551
    Should Contain    ${output}    Mz : 0.485013
    Should Contain    ${output}    ForceMagnitude : 0.598935
    Should Contain    ${output}    priority : 0.829423
