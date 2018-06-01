*** Settings ***
Documentation    M1M3_AppliedAccelerationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAccelerationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 25.4591 0.3858 0.421584 0.152607 0.867345 0.428398 0.079396 0.130756 0.073737 0.488392 0.246953 0.780187 0.568801 0.893163 0.7653 0.707151 0.183735 0.720608 0.10287 0.494284 0.755397 0.832902 0.425883 0.553288 0.547056 0.397334 0.031471 0.722962 0.851658 0.448922 0.849002 0.538185 0.903899 0.583765 0.913976 0.188439 0.97787 0.259733 0.586972 0.556153 0.461741 0.260413 0.132279 0.83619 0.337916 0.475844 0.08313 0.733955 0.720887 0.031656 0.091326 0.596195 0.191465 0.779135 0.345831 0.974203 0.246762 0.67207 0.563783 0.117835 0.362763 0.154751 0.053886 0.715543 0.913183 0.583433 0.216656 0.191398 0.345791 0.224823 0.70064 0.339473 0.256626 0.680484 0.856527 0.967782 0.450776 0.615169 0.289719 0.254714 0.751243 0.902881 0.780652 0.824894 0.731763 0.861935 0.390625 0.708523 0.952376 0.870685 0.885046 0.24354 0.954858 0.729716 0.993634 0.449608 0.562677 0.958453 0.827751 0.069124 0.930123 0.688583 0.438855 0.563817 0.480409 0.206925 0.308571 0.035671 0.396637 0.025874 0.376491 0.229956 0.937971 0.609948 0.994697 0.474497 0.353269 0.92734 0.899132 0.386248 0.131708 0.07983 0.339463 0.794268 0.469541 0.503025 0.955793 0.867901 0.139154 0.665993 0.235132 0.11785 0.343204 0.791883 0.082695 0.013737 0.610167 0.873466 0.200001 0.303997 0.196007 0.863844 0.684103 0.664318 0.566886 0.896643 0.500174 0.428005 0.301122 0.843071 0.820417 0.113656 0.165542 0.04717 0.199841 0.259333 0.923338 0.074651 0.151493 0.035001 0.372945 0.316616 0.153614 0.569275 0.618447 0.038552 0.2827 0.592166 0.793523 0.760598 0.672214 0.385562 0.908695 0.572236 0.897781 0.173885 0.635678 0.211287 0.607788 0.805265 0.577767 0.056743 0.216163 0.195717 0.449283 0.118772 0.496842 0.657175 0.790271 0.446235 0.370215 0.613807 0.26736 0.314769 0.136276 0.224453 0.708328 0.485634 0.839379 0.605506 0.503715 0.605901 0.795519 0.579634 0.263669 0.124634 0.297463 0.336958 0.699961 0.700929 0.781835 0.05922 0.790457 0.48789 0.692456 0.538803 0.534274 0.819275 0.891173 0.256848 0.040176 0.074838 0.856694 0.995628 0.368087 0.173524 0.335501 0.307328 0.911693 0.003751 0.881258 0.120372 0.420131 0.548314 0.799422 0.213402 0.798789 0.093817 0.396829 0.763096 0.364749 0.550133 0.385884 0.20154 0.337797 0.188858 0.358794 0.218538 0.064004 0.505452 0.41376 0.061037 0.397941 0.904548 0.400519 0.30469 0.881025 0.852405 0.069897 0.805339 0.737217 0.705901 0.942646 0.211517 0.388073 0.304791 0.625683 0.643746 0.797238 0.33837 0.129234 0.611134 0.753203 0.299027 0.72945 0.488884 402303848
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAccelerationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 402303848
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAccelerationForces received =     1
    Should Contain    ${output}    Timestamp : 25.4591
    Should Contain    ${output}    XForces : 0.3858
    Should Contain    ${output}    YForces : 0.421584
    Should Contain    ${output}    ZForces : 0.152607
    Should Contain    ${output}    Fx : 0.867345
    Should Contain    ${output}    Fy : 0.428398
    Should Contain    ${output}    Fz : 0.079396
    Should Contain    ${output}    Mx : 0.130756
    Should Contain    ${output}    My : 0.073737
    Should Contain    ${output}    Mz : 0.488392
    Should Contain    ${output}    ForceMagnitude : 0.246953
    Should Contain    ${output}    priority : 0.780187
