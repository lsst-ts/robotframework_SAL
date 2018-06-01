*** Settings ***
Documentation    M1M3_ApplyActiveOpticForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyActiveOpticForces
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.58794 0.304064 0.123207 0.853943 0.162439 0.419635 0.534547 0.059197 0.280812 0.619221 0.561291 0.407872 0.365271 0.169495 0.874939 0.875763 0.356091 0.124089 0.951598 0.129139 0.930289 0.377861 0.817047 0.411993 0.147978 0.39521 0.785714 0.62075 0.684487 0.292384 0.849297 0.657493 0.425305 0.148535 0.05393 0.20272 0.368234 0.864024 0.775181 0.187458 0.082343 0.984829 0.971011 0.197964 0.167585 0.239711 0.872376 0.411972 0.532478 0.193712 0.223591 0.410242 0.893609 0.772072 0.025752 0.733402 0.998749 0.378863 0.736629 0.125795 0.00458 0.453117 0.126955 0.717673 0.647064 0.957231 0.46988 0.930169 0.270639 0.266548 0.199427 0.785641 0.538738 0.913287 0.740166 0.580309 0.876566 0.996728 0.148864 0.518648 0.077255 0.522836 0.354928 0.748133 0.797868 0.582451 0.598307 0.21072 0.572689 0.109548 0.833295 0.108325 0.654196 0.026003 0.491196 0.134672 0.696117 0.240136 0.450796 0.601831 0.817134 0.333312 0.424276 0.401715 0.19387 0.732724 0.104094 0.764066 0.198469 0.034126 0.44579 0.143239 0.244475 0.437099 0.090678 0.902665 0.25876 0.85036 0.466635 0.708769 0.370425 0.024049 0.728645 0.67868 0.782074 0.919702 0.987883 0.438885 0.978858 0.508426 0.189655 0.755875 0.586708 0.462424 0.653634 0.06256 0.166189 0.292812 0.763029 0.757284 0.794804 0.269029 0.1405 0.490195 0.011192 0.930105 0.206178 0.135081 0.917692 0.525739 0.4481 0.840747 0.119308 0.193895 0.569398 0.991909
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.58794 0.304064 0.123207 0.853943 0.162439 0.419635 0.534547 0.059197 0.280812 0.619221 0.561291 0.407872 0.365271 0.169495 0.874939 0.875763 0.356091 0.124089 0.951598 0.129139 0.930289 0.377861 0.817047 0.411993 0.147978 0.39521 0.785714 0.62075 0.684487 0.292384 0.849297 0.657493 0.425305 0.148535 0.05393 0.20272 0.368234 0.864024 0.775181 0.187458 0.082343 0.984829 0.971011 0.197964 0.167585 0.239711 0.872376 0.411972 0.532478 0.193712 0.223591 0.410242 0.893609 0.772072 0.025752 0.733402 0.998749 0.378863 0.736629 0.125795 0.00458 0.453117 0.126955 0.717673 0.647064 0.957231 0.46988 0.930169 0.270639 0.266548 0.199427 0.785641 0.538738 0.913287 0.740166 0.580309 0.876566 0.996728 0.148864 0.518648 0.077255 0.522836 0.354928 0.748133 0.797868 0.582451 0.598307 0.21072 0.572689 0.109548 0.833295 0.108325 0.654196 0.026003 0.491196 0.134672 0.696117 0.240136 0.450796 0.601831 0.817134 0.333312 0.424276 0.401715 0.19387 0.732724 0.104094 0.764066 0.198469 0.034126 0.44579 0.143239 0.244475 0.437099 0.090678 0.902665 0.25876 0.85036 0.466635 0.708769 0.370425 0.024049 0.728645 0.67868 0.782074 0.919702 0.987883 0.438885 0.978858 0.508426 0.189655 0.755875 0.586708 0.462424 0.653634 0.06256 0.166189 0.292812 0.763029 0.757284 0.794804 0.269029 0.1405 0.490195 0.011192 0.930105 0.206178 0.135081 0.917692 0.525739 0.4481 0.840747 0.119308 0.193895 0.569398 0.991909
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 0.58794    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [0.58794, 0.304064, 0.123207, 0.853943, 0.162439, 0.419635, 0.534547, 0.059197, 0.280812, 0.619221, 0.561291, 0.407872, 0.365271, 0.169495, 0.874939, 0.875763, 0.356091, 0.124089, 0.951598, 0.129139, 0.930289, 0.377861, 0.817047, 0.411993, 0.147978, 0.39521, 0.785714, 0.62075, 0.684487, 0.292384, 0.849297, 0.657493, 0.425305, 0.148535, 0.05393, 0.20272, 0.368234, 0.864024, 0.775181, 0.187458, 0.082343, 0.984829, 0.971011, 0.197964, 0.167585, 0.239711, 0.872376, 0.411972, 0.532478, 0.193712, 0.223591, 0.410242, 0.893609, 0.772072, 0.025752, 0.733402, 0.998749, 0.378863, 0.736629, 0.125795, 0.00458, 0.453117, 0.126955, 0.717673, 0.647064, 0.957231, 0.46988, 0.930169, 0.270639, 0.266548, 0.199427, 0.785641, 0.538738, 0.913287, 0.740166, 0.580309, 0.876566, 0.996728, 0.148864, 0.518648, 0.077255, 0.522836, 0.354928, 0.748133, 0.797868, 0.582451, 0.598307, 0.21072, 0.572689, 0.109548, 0.833295, 0.108325, 0.654196, 0.026003, 0.491196, 0.134672, 0.696117, 0.240136, 0.450796, 0.601831, 0.817134, 0.333312, 0.424276, 0.401715, 0.19387, 0.732724, 0.104094, 0.764066, 0.198469, 0.034126, 0.44579, 0.143239, 0.244475, 0.437099, 0.090678, 0.902665, 0.25876, 0.85036, 0.466635, 0.708769, 0.370425, 0.024049, 0.728645, 0.67868, 0.782074, 0.919702, 0.987883, 0.438885, 0.978858, 0.508426, 0.189655, 0.755875, 0.586708, 0.462424, 0.653634, 0.06256, 0.166189, 0.292812, 0.763029, 0.757284, 0.794804, 0.269029, 0.1405, 0.490195, 0.011192, 0.930105, 0.206178, 0.135081, 0.917692, 0.525739, 0.4481, 0.840747, 0.119308, 0.193895, 0.569398, 0.991909]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
