*** Settings ***
Documentation    M1M3_AppliedStaticForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedStaticForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 64.492 0.797808 0.771763 0.809117 0.452446 0.118857 0.597946 0.746773 0.413638 0.892801 0.003426 0.932677 0.530153 0.770368 0.659295 0.374275 0.706225 0.605806 0.260801 0.847949 0.456768 0.065485 0.814045 0.53675 0.766646 0.61258 0.635814 0.714413 0.124673 0.92008 0.409611 0.244977 0.742699 0.532522 0.886782 0.954123 0.993921 0.085629 0.473989 0.577196 0.698997 0.676562 0.302274 0.955183 0.119828 0.857425 0.444423 0.683272 0.334212 0.544734 0.638063 0.859826 0.717119 0.404952 0.672086 0.859302 0.225161 0.502365 0.464066 0.117426 0.893792 0.044301 0.090142 0.556728 0.525444 0.539886 0.560597 0.47957 0.999398 0.598613 0.290757 0.96462 0.991649 0.847729 0.085681 0.825445 0.891611 0.223683 0.407193 0.753307 0.732208 0.005862 0.01491 0.840891 0.613104 0.028793 0.487137 0.459203 0.104828 0.547083 0.880412 0.031926 0.94997 0.199533 0.93289 0.904113 0.046244 0.624575 0.023053 0.131718 0.504757 0.903375 0.711696 0.892131 0.29235 0.015225 0.019121 0.053582 0.017314 0.268079 0.384145 0.635023 0.073657 0.214263 0.564529 0.222296 0.92435 0.289654 0.33996 0.960466 0.443746 0.409986 0.461656 0.664904 0.761888 0.160329 0.877257 0.338741 0.710335 0.926392 0.043515 0.935465 0.797582 0.832944 0.915407 0.877441 0.988044 0.419389 0.493079 0.360703 0.496686 0.218146 0.942399 0.949439 0.088502 0.441697 0.070299 0.306969 0.876418 0.410549 0.602237 0.001593 0.224514 0.268512 0.932085 0.687026 0.055153 0.757502 0.13745 0.633487 0.660954 0.919677 0.59584 0.224937 0.90861 0.243475 0.839359 0.673664 0.04428 0.834265 0.801185 0.679654 0.917293 0.889021 0.294307 0.731526 0.464803 0.513242 0.453321 0.062288 0.49367 0.984207 0.335278 0.48408 0.537122 0.223008 0.94869 0.869169 0.783808 0.855681 0.570318 0.000655 0.790744 0.199445 0.003883 0.031949 0.103257 0.326351 0.405513 0.756091 0.541639 0.826325 0.295354 0.459688 0.00755 0.684802 0.424528 0.046915 0.216023 0.940943 0.129409 0.671414 0.012445 0.659748 0.957767 0.30546 0.585141 0.524076 0.147287 0.065036 0.435417 0.289672 0.425755 0.547333 0.076883 0.444228 0.614175 0.712016 0.420961 0.510449 0.93091 0.3611 0.197852 0.515112 0.854472 0.987968 0.08289 0.644725 0.434259 0.307516 0.389094 0.101908 0.180984 0.885788 0.008569 0.518398 0.553323 0.139448 0.169826 0.032092 0.6238 0.380583 0.760078 0.808274 0.74743 0.829397 0.798623 0.024426 0.734703 0.623595 0.905782 0.948698 0.957454 0.133752 0.115838 0.068602 0.018375 0.346629 0.865779 0.315626 0.270889 0.964756 0.336104 0.278458 0.093832 0.199489 -1820712347
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
