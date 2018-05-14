*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
${component}    RejectedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 37.8678 0.251553603601 0.198528723799 0.844070268188 0.746327198371 0.38016194065 0.949831719529 0.0113407565475 0.117278116188 0.540649754373 0.293912584488 0.300292463163 0.384835745496 0.99392294553 0.623903950407 0.904399676895 0.152215873564 0.375602170875 0.819067396868 0.711371528367 0.871801067533 0.60530163735 0.00735927794807 0.607959528866 0.0790462918952 0.734850271693 0.528488049646 0.696888963083 0.406884931575 0.856032486315 0.467656388064 0.84482848041 0.957520832653 0.894730546134 0.476651108198 0.31579680728 0.460583675331 0.372255729735 0.381110870273 0.820883194144 0.985092062209 0.846756892478 0.802636900033 0.425549238493 0.591670797467 0.260478917291 0.220179024212 0.823907461026 0.426273559687 0.542880472683 0.405523080652 0.694075019727 0.118271900124 0.207726396084 0.583019394168 0.233070402508 0.944247679105 0.73002661624 0.66724861919 0.392742313283 0.755739720065 0.952992210215 0.123752500187 0.221940195036 0.529371349088 0.851068274187 0.254404524132 0.504184483245 0.517382900857 0.0497318905615 0.734328437428 0.658243114357 0.0328064066408 0.875648346327 0.177622884235 0.946658871325 0.590644095976 0.523806161145 0.367645908088 0.47801141416 0.328403703009 0.0712305452105 0.142502036127 0.246888913276 0.554337170599 0.203021805658 0.598781301642 0.928728673563 0.287286009302 0.564763042751 0.359293293555 0.987195536195 0.426374412854 0.602903136946 0.0188528404434 0.299865577389 0.271800465103 0.910637620902 0.508130921017 0.0736596486333 0.665559370521 0.303922443795 0.334889687789 0.924574381534 0.620431938067 0.443727207524 0.480684425134 0.638248151425 0.620209516623 0.481072400214 0.168719517069 0.0482269485901 0.212050549501 0.586234855526 0.634487330433 0.147354509673 0.056238998396 0.632294258365 0.296396790462 0.804641351351 0.924118024199 0.0535409390511 0.124908361876 0.59202992331 0.776763774453 0.0475325979509 0.68597895143 0.597767971481 0.191054021776 0.53079489801 0.458741226413 0.252070591573 0.157169406465 0.92015140354 0.0523876918204 0.414638250747 0.947577902547 0.676051194183 0.605648943426 0.195372273041 0.295542487092 0.514749345838 0.411870269857 0.330583605719 0.967524052866 0.918982436518 0.688031157254 0.343964503674 0.793755487348 0.32959491377 0.41891438614 0.300991516507 0.533732381257 0.02154964234 0.879741915576 0.652024487296 0.213791813112 0.322170815321 0.629717185672 0.497650150727 613359848
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
