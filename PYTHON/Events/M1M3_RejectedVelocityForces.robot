*** Settings ***
Documentation    M1M3_RejectedVelocityForces communications tests.
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
${component}    RejectedVelocityForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 5.6093 0.042341 0.895083 0.105781 0.740195 0.994563 0.649229 0.421243 0.435815 0.878306 0.32016 0.538629 0.759655 0.728747 0.066765 0.843406 0.587081 0.095935 0.82148 0.113204 0.543846 0.047887 0.823417 0.830771 0.284842 0.827237 0.198021 0.429485 0.397248 0.836769 0.985612 0.047664 0.021075 0.593377 0.627188 0.569863 0.688247 0.113002 0.267474 0.027658 0.15925 0.747734 0.382417 0.365584 0.314745 0.670568 0.880183 0.851185 0.680726 0.907039 0.0488 0.440383 0.653146 0.859374 0.038685 0.712208 0.392601 0.014181 0.630108 0.38877 0.838613 0.839369 0.106786 0.051699 0.544391 0.170775 0.875487 0.380561 0.00024 0.98728 0.695091 0.219722 0.326829 0.284655 0.895076 0.15234 0.036661 0.356072 0.261288 0.366749 0.766853 0.330628 0.145321 0.966615 0.337003 0.821414 0.052819 0.430882 0.487123 0.616602 0.885016 0.161656 0.498454 0.917498 0.51466 0.96517 0.43995 0.67854 0.37719 0.838126 0.526309 0.315319 0.03881 0.829151 0.014276 0.992966 0.691293 0.470787 0.561849 0.82087 0.512117 0.592373 0.464981 0.580364 0.902563 0.55037 0.063184 0.530935 0.882948 0.403026 0.239511 0.941519 0.710414 0.827053 0.706148 0.084281 0.888242 0.244967 0.693189 0.311568 0.570545 0.466825 0.587813 0.536609 0.402836 0.684782 0.942724 0.532237 0.577856 0.300053 0.739386 0.800984 0.47626 0.555523 0.205969 0.487744 0.063678 0.441924 0.936198 0.639727 0.784516 0.830167 0.11149 0.135176 0.070785 0.167563 0.995286 0.444486 0.509747 0.277198 0.193103 0.745412 0.881839 0.593835 0.05537 0.490802 0.08368 0.317762 0.163129 0.727539 0.593033 0.177158 0.873868 0.214134 0.728723 0.895876 0.921468 0.639058 0.996271 0.062343 0.758695 0.158422 0.807624 0.074243 0.195716 0.085478 0.330648 0.046836 0.697942 0.768062 0.386103 0.344358 0.385111 0.289649 0.561266 0.961673 0.87664 0.01168 0.733646 0.178178 0.915386 0.563953 0.063695 0.050255 0.555388 0.347508 0.336975 0.395979 0.625752 0.204484 0.86405 0.218832 0.316703 0.546784 0.678533 0.504936 0.804504 0.188919 0.393909 0.602412 0.566087 0.834837 0.49677 0.083507 0.478833 0.130543 0.429616 0.076824 0.23178 0.840339 0.051038 0.564015 0.120831 0.827656 0.982147 0.514335 0.274545 0.237791 0.165878 0.656431 0.523295 0.728628 0.355566 0.1663 0.983999 0.694321 0.349632 0.769993 0.024358 0.305439 0.083103 0.337837 0.99358 0.909804 0.349755 0.401657 0.647066 0.319447 0.375218 0.858772 0.496552 0.957357 0.537431 0.23509 0.013569 0.203366 0.370456 0.225948 0.291641 0.812142 0.888747 0.892395 0.99888 0.213677 0.906558 0.205336 -756723123
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
