*** Settings ***
Documentation    M1M3_RejectedAberrationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 78.3452 0.042955 0.807406 0.177905 0.362982 0.571549 0.451402 0.701051 0.498637 0.559377 0.945572 0.396353 0.672288 0.854961 0.556504 0.227535 0.876548 0.015609 0.053024 0.518798 0.921432 0.519371 0.30634 0.687136 0.46937 0.002439 0.337791 0.775154 0.416338 0.433863 0.367347 0.589583 0.006863 0.700286 0.485103 0.984682 0.12425 0.537465 0.271204 0.184887 0.87534 0.778823 0.504439 0.669021 0.723269 0.080598 0.574258 0.770417 0.817569 0.309536 0.562498 0.561291 0.747672 0.115386 0.772067 0.565849 0.111379 0.403128 0.869744 0.77897 0.365002 0.141547 0.058237 0.684361 0.150665 0.546225 0.507424 0.586212 0.09299 0.793605 0.017743 0.852794 0.064031 0.201258 0.243155 0.315787 0.666652 0.381802 0.600405 0.350599 0.152675 0.412496 0.807289 0.608736 0.15077 0.138177 0.518942 0.452201 0.514732 0.57804 0.740311 0.708781 0.226307 0.594861 0.85222 0.965287 0.957096 0.028313 0.546841 0.155437 0.158595 0.13147 0.095803 0.479655 0.425051 0.011959 0.060146 0.96841 0.13777 0.410932 0.833223 0.71539 0.986955 0.433935 0.164133 0.153344 0.865012 0.777427 0.307843 0.166045 0.335207 0.627979 0.918307 0.153605 0.819516 0.055596 0.877137 0.035702 0.64187 0.578721 0.090508 0.571227 0.896902 0.471861 0.091016 0.797288 0.112268 0.212148 0.935516 0.859495 0.911042 0.732995 0.86147 0.080446 0.18857 0.507206 0.906283 0.562388 0.169025 0.419579 0.061944 0.046374 0.765937 0.641528 0.009092 0.756987 0.804898 0.010494 0.468831 0.507186 346014923
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 346014923
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 78.3452
    Should Contain    ${output}    ZForces : 0.042955
    Should Contain    ${output}    Fz : 0.807406
    Should Contain    ${output}    Mx : 0.177905
    Should Contain    ${output}    My : 0.362982
    Should Contain    ${output}    priority : 0.571549
