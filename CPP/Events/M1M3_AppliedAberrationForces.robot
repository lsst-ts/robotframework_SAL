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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 70.1098 0.25973 0.112253 0.558851 0.898187 0.558285 0.122723 0.385851 0.686058 0.120923 0.491466 0.422897 0.665202 0.519533 0.254697 0.299248 0.779585 0.046248 0.069266 0.637685 0.15536 0.732424 0.202678 0.893415 0.083006 0.226567 0.517312 0.750673 0.816435 0.348883 0.657113 0.781182 0.364346 0.977274 0.921992 0.110868 0.159511 0.05887 0.357718 0.903608 0.928809 0.508723 0.846394 0.033399 0.139358 0.41343 0.222156 0.602535 0.869361 0.135024 0.927962 0.132908 0.255724 0.028019 0.68228 0.906238 0.949989 0.710846 0.410862 0.139955 0.46735 0.612984 0.653868 0.770758 0.809918 0.285251 0.450063 0.080625 0.509582 0.847401 0.413412 0.59911 0.90769 0.348015 0.959809 0.801239 0.32316 0.28748 0.055273 0.036381 0.052583 0.233104 0.272666 0.576192 0.924411 0.173315 0.408815 0.805935 0.702173 0.87196 0.02408 0.110659 0.067672 0.765427 0.404906 0.029738 0.398102 0.169474 0.857027 0.313711 0.259992 0.080189 0.277327 0.411219 0.609698 0.911706 0.291908 0.311435 0.312292 0.132854 0.803423 0.003231 0.414919 0.218585 0.133136 0.2699 0.149376 0.236207 0.211547 0.590567 0.710077 0.483024 0.943005 0.223519 0.788016 0.503765 0.400963 0.564048 0.862131 0.579558 0.338734 0.928097 0.064428 0.768783 0.808243 0.79355 0.861274 0.66377 0.247097 0.946465 0.071435 0.743308 0.583192 0.848314 0.902507 0.056721 0.340402 0.569184 0.556284 0.735214 0.612481 0.689235 0.372836 0.827704 0.732999 0.674763 0.751569 0.973232 0.575529 0.895874 -95625753
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -95625753
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 70.1098
    Should Contain    ${output}    ZForces : 0.25973
    Should Contain    ${output}    Fz : 0.112253
    Should Contain    ${output}    Mx : 0.558851
    Should Contain    ${output}    My : 0.898187
    Should Contain    ${output}    priority : 0.558285
