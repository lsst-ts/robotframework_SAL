*** Settings ***
Documentation    M1M3_RejectedAccelerationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAccelerationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 63.1625 0.917457 0.264115 0.946237 0.008294 0.60937 0.494382 0.742202 0.903692 0.572034 0.942293 0.989091 0.544672 0.676639 0.825505 0.950644 0.388954 0.841648 0.750299 0.431362 0.524868 0.364338 0.891743 0.551881 0.32223 0.466971 0.135215 0.432465 0.584347 0.628275 0.473467 0.471094 0.594784 0.870066 0.096902 0.511209 0.536547 0.685895 0.774604 0.193442 0.081143 0.50623 0.540771 0.816927 0.781764 0.24098 0.517787 0.615308 0.502134 0.680874 0.248563 0.502836 0.644165 0.66559 0.48927 0.466942 0.036317 0.688385 0.258858 0.997821 0.826718 0.214082 0.333853 0.740981 0.684314 0.35612 0.046357 0.032431 0.289005 0.360082 0.852611 0.692132 0.086469 0.203796 0.258527 0.313586 0.301453 0.797045 0.200727 0.329766 0.318837 0.080336 0.945359 0.691743 0.881978 0.74262 0.451435 0.148038 0.693331 0.568669 0.707776 0.604746 0.726032 0.78124 0.687673 0.965767 0.750637 0.040484 0.636623 0.708488 0.525519 0.257491 0.36729 0.30568 0.969866 0.759311 0.073034 0.300556 0.132666 0.583498 0.840209 0.056814 0.971693 0.498753 0.410258 0.591895 0.870442 0.820012 0.045184 0.092303 0.174099 0.388585 0.711516 0.801161 0.277871 0.105624 0.420683 0.425503 0.520443 0.568539 0.824311 0.885042 0.073904 0.489126 0.009926 0.724627 0.955813 0.446309 0.507178 0.186359 0.433206 0.826255 0.416262 0.773254 0.053976 0.326645 0.572149 0.721879 0.82351 0.034516 0.043303 0.146028 0.657756 0.134907 0.73715 0.231066 0.966813 0.151862 0.022303 0.746126 0.572743 0.391187 0.225033 0.949362 0.077027 0.199991 0.210456 0.114618 0.406189 0.297706 0.987802 0.559692 0.385386 0.493188 0.95472 0.782358 0.107337 0.585475 0.277392 0.272396 0.873162 0.993246 0.980939 0.021283 0.771481 0.936675 0.717009 0.661223 0.898131 0.661661 0.43516 0.133558 0.043945 0.868731 0.54923 0.88293 0.205706 0.732907 0.041043 0.92068 0.852662 0.957357 0.536019 0.611724 0.54575 0.921079 0.325913 0.637529 0.076253 0.783048 0.733852 0.31328 0.418884 0.363369 0.429023 0.761801 0.564201 0.303665 0.338329 0.514256 0.042476 0.980127 0.407469 0.18521 0.084075 0.639917 0.081702 0.313753 0.527984 0.679837 0.64172 0.334769 0.555611 0.146674 0.961062 0.207975 0.027405 0.38533 0.378429 0.178799 0.918537 0.294306 0.751405 0.477529 0.912452 0.370785 0.326887 0.285377 0.60128 0.493154 0.189154 0.698508 0.741399 0.653935 0.024888 0.765471 0.411505 0.982816 0.753212 0.526282 0.5493 0.065925 0.43767 0.392969 0.698895 0.395706 0.661623 0.196586 0.385382 0.24593 0.500345 0.858956 0.944559 0.271057 0.251138 0.777105 -713347506
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAccelerationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -713347506
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAccelerationForces received =     1
    Should Contain    ${output}    Timestamp : 63.1625
    Should Contain    ${output}    XForces : 0.917457
    Should Contain    ${output}    YForces : 0.264115
    Should Contain    ${output}    ZForces : 0.946237
    Should Contain    ${output}    Fx : 0.008294
    Should Contain    ${output}    Fy : 0.60937
    Should Contain    ${output}    Fz : 0.494382
    Should Contain    ${output}    Mx : 0.742202
    Should Contain    ${output}    My : 0.903692
    Should Contain    ${output}    Mz : 0.572034
    Should Contain    ${output}    ForceMagnitude : 0.942293
    Should Contain    ${output}    priority : 0.989091
