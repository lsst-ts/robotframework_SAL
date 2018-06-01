*** Settings ***
Documentation    Hexapod_configureElevationRawLUT communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureElevationRawLUT
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -28521 10078 9272 -4618 -13643 7739 -23090 -142 4866 -16043 3518 -25403 -30208 7635 -25760 31965 1496 13674 -18723 0.865676 0.412096 0.38581 0.676298 0.718232 0.217151 0.610304 0.167683 0.803763 0.318407 0.998746 0.038844 0.922303 0.504674 0.432448 0.774366 0.141815 0.979183 0.581517 0.470558 0.745345 0.152387 0.936882 0.12555 0.167468 0.239341 0.673654 0.107213 0.40294 0.029533 0.360281 0.942497 0.780544 0.096063 0.119515 0.338111 0.472215 0.955888 0.205093 0.326461 0.951488 0.447945 0.938384 0.835689 0.501722 0.439247 0.169676 0.982501 0.768264 0.670856 0.745864 0.208651 0.949371 0.606419 0.861443 0.726527 0.428449 0.10456 0.175908 0.83247 0.726015 0.704439 0.151338 0.062264 0.465588 0.131607 0.992782 0.630999 0.079394 0.82227 0.929013 0.133888 0.914967 0.623891 0.610453 0.418443 0.92551 0.580039 0.623523 0.196532 0.584623 0.918239 0.938425 0.696438 0.641423 0.98937 0.884684 0.95578 0.256225 0.147847 0.054764 0.72849 0.690427 0.895749 0.043061 0.906101 0.859089 0.749376 0.287413 0.083456 0.482376 0.294818 0.843243 0.739531 0.866622 0.94141 0.192233 0.466333 0.401814 0.367504 0.011124 0.77572 0.318624 0.569093
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -28521 10078 9272 -4618 -13643 7739 -23090 -142 4866 -16043 3518 -25403 -30208 7635 -25760 31965 1496 13674 -18723 0.865676 0.412096 0.38581 0.676298 0.718232 0.217151 0.610304 0.167683 0.803763 0.318407 0.998746 0.038844 0.922303 0.504674 0.432448 0.774366 0.141815 0.979183 0.581517 0.470558 0.745345 0.152387 0.936882 0.12555 0.167468 0.239341 0.673654 0.107213 0.40294 0.029533 0.360281 0.942497 0.780544 0.096063 0.119515 0.338111 0.472215 0.955888 0.205093 0.326461 0.951488 0.447945 0.938384 0.835689 0.501722 0.439247 0.169676 0.982501 0.768264 0.670856 0.745864 0.208651 0.949371 0.606419 0.861443 0.726527 0.428449 0.10456 0.175908 0.83247 0.726015 0.704439 0.151338 0.062264 0.465588 0.131607 0.992782 0.630999 0.079394 0.82227 0.929013 0.133888 0.914967 0.623891 0.610453 0.418443 0.92551 0.580039 0.623523 0.196532 0.584623 0.918239 0.938425 0.696438 0.641423 0.98937 0.884684 0.95578 0.256225 0.147847 0.054764 0.72849 0.690427 0.895749 0.043061 0.906101 0.859089 0.749376 0.287413 0.083456 0.482376 0.294818 0.843243 0.739531 0.866622 0.94141 0.192233 0.466333 0.401814 0.367504 0.011124 0.77572 0.318624 0.569093
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    elevIndex : -28521    1
    Should Contain X Times    ${output}    fz1 : 0.865676    1
    Should Contain X Times    ${output}    fz2 : 0.470558    1
    Should Contain X Times    ${output}    fz3 : 0.205093    1
    Should Contain X Times    ${output}    fz4 : 0.10456    1
    Should Contain X Times    ${output}    fz5 : 0.92551    1
    Should Contain X Times    ${output}    fz6 : 0.906101    1
    Should Contain    ${output}    === command configureElevationRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureElevationRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    elevIndex : -28521    1
    Should Contain X Times    ${output}    fz1 : 0.865676    1
    Should Contain X Times    ${output}    fz2 : 0.470558    1
    Should Contain X Times    ${output}    fz3 : 0.205093    1
    Should Contain X Times    ${output}    fz4 : 0.10456    1
    Should Contain X Times    ${output}    fz5 : 0.92551    1
    Should Contain X Times    ${output}    fz6 : 0.906101    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
