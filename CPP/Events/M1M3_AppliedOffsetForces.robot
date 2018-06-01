*** Settings ***
Documentation    M1M3_AppliedOffsetForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedOffsetForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 38.2331 0.084606 0.123834 0.090455 0.339519 0.345255 0.57553 0.147852 0.942378 0.192627 0.275531 0.362761 0.204751 0.536793 0.865319 0.748298 0.090231 0.047392 0.059962 0.4717 0.813343 0.371009 0.761925 0.290129 0.465148 0.949961 0.825278 0.462405 0.826583 0.21139 0.360762 0.387893 0.98079 0.230848 0.643099 0.108544 0.144835 0.467403 0.641474 0.412765 0.995945 0.282423 0.677081 0.348155 0.644613 0.59825 0.489239 0.025842 0.653357 0.195988 0.534787 0.460307 0.168998 0.172108 0.318721 0.145477 0.527567 0.325579 0.417222 0.075743 0.80083 0.128883 0.151379 0.452138 0.943971 0.868515 0.676759 0.561526 0.404386 0.315885 0.383684 0.615939 0.549179 0.719947 0.568766 0.288538 0.99063 0.70418 0.881475 0.270814 0.085491 0.506984 0.126181 0.97667 0.163541 0.754176 0.502619 0.148567 0.321598 0.024945 0.025797 0.638492 0.101955 0.982464 0.361627 0.141279 0.548655 0.357408 0.739287 0.850985 0.10721 0.771806 0.772745 0.634915 0.460964 0.488971 0.432167 0.134352 0.548375 0.849506 0.158261 0.019328 0.267982 0.09581 0.253631 0.800616 0.058333 0.798823 0.841404 0.564189 0.897143 0.064713 0.578858 0.380698 0.69201 0.344353 0.641981 0.529934 0.362569 0.497705 0.828794 0.279399 0.851802 0.53598 0.385035 0.94855 0.490599 0.632642 0.783459 0.709951 0.079683 0.513173 0.212145 0.360756 0.147461 0.708289 0.076536 0.346243 0.735888 0.187438 0.963212 0.677765 0.848148 0.558807 0.445969 0.62107 0.111111 0.089375 0.015148 0.205436 0.621699 0.571678 0.771629 0.129837 0.6572 0.536931 0.159197 0.559493 0.707999 0.081411 0.270324 0.972546 0.604898 0.072834 0.579488 0.65414 0.779873 0.14891 0.488647 0.784897 0.764514 0.753733 0.795766 0.71068 0.558547 0.244436 0.333456 0.441192 0.685424 0.471894 0.73655 0.114095 0.790593 0.179138 0.185288 0.041461 0.810551 0.323028 0.897305 0.786067 0.959319 0.869074 0.79882 0.380314 0.054464 0.366895 0.439124 0.684056 0.833006 0.974764 0.718625 0.571701 0.022641 0.549592 0.019088 0.327573 0.457468 0.912431 0.141419 0.866883 0.424941 0.784918 0.295268 0.342583 0.852301 0.883668 0.220251 0.466162 0.88302 0.380882 0.852507 0.302619 0.13039 0.611466 0.75394 0.025821 0.462897 0.010263 0.399981 0.701221 0.727026 0.113535 0.109407 0.996179 0.529898 0.583752 0.413435 0.736861 0.631485 0.418706 0.932365 0.929774 0.697734 0.718027 0.26476 0.03107 0.022178 0.747797 0.977348 0.29488 0.403128 0.068487 0.580519 0.35635 0.809668 0.638197 0.355091 0.831738 0.076493 0.476936 0.180945 0.720939 0.641431 0.140923 0.223707 0.758222 -1591470350
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1591470350
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 38.2331
    Should Contain    ${output}    XForces : 0.084606
    Should Contain    ${output}    YForces : 0.123834
    Should Contain    ${output}    ZForces : 0.090455
    Should Contain    ${output}    Fx : 0.339519
    Should Contain    ${output}    Fy : 0.345255
    Should Contain    ${output}    Fz : 0.57553
    Should Contain    ${output}    Mx : 0.147852
    Should Contain    ${output}    My : 0.942378
    Should Contain    ${output}    Mz : 0.192627
    Should Contain    ${output}    ForceMagnitude : 0.275531
    Should Contain    ${output}    priority : 0.362761
