*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT communications tests.
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
${component}    configureTemperatureRawLUT
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -8328 24075 -16199 -15503 -21419 8963 -22566 -16556 31864 0.315409 0.393259 0.372944 0.767335 0.619003 0.794114 0.123868 0.436752 0.348761 0.275476 0.375248 0.525941 0.268949 0.19406 0.744897 0.959292 0.892193 0.267929 0.048838 0.137017 0.7282 0.987294 0.252549 0.011913 0.653811 0.808454 0.951941 0.469097 0.468214 0.589254 0.387481 0.818307 0.670681 0.253181 0.986524 0.448086 0.107348 0.082473 0.630192 0.380363 0.379568 0.568709 0.050331 0.726662 0.035857 0.084041 0.099741 0.489329 0.905097 0.161174 0.394074 0.176289 0.641669 0.572929
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -8328 24075 -16199 -15503 -21419 8963 -22566 -16556 31864 0.315409 0.393259 0.372944 0.767335 0.619003 0.794114 0.123868 0.436752 0.348761 0.275476 0.375248 0.525941 0.268949 0.19406 0.744897 0.959292 0.892193 0.267929 0.048838 0.137017 0.7282 0.987294 0.252549 0.011913 0.653811 0.808454 0.951941 0.469097 0.468214 0.589254 0.387481 0.818307 0.670681 0.253181 0.986524 0.448086 0.107348 0.082473 0.630192 0.380363 0.379568 0.568709 0.050331 0.726662 0.035857 0.084041 0.099741 0.489329 0.905097 0.161174 0.394074 0.176289 0.641669 0.572929
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    tempIndex : -8328    1
    Should Contain X Times    ${output}    rx : 0.315409    1
    Should Contain X Times    ${output}    ry : 0.275476    1
    Should Contain X Times    ${output}    rz : 0.048838    1
    Should Contain X Times    ${output}    tx : 0.469097    1
    Should Contain X Times    ${output}    ty : 0.107348    1
    Should Contain X Times    ${output}    tz : 0.084041    1
    Should Contain    ${output}    === command configureTemperatureRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureTemperatureRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    tempIndex : -8328    1
    Should Contain X Times    ${output}    rx : 0.315409    1
    Should Contain X Times    ${output}    ry : 0.275476    1
    Should Contain X Times    ${output}    rz : 0.048838    1
    Should Contain X Times    ${output}    tx : 0.469097    1
    Should Contain X Times    ${output}    ty : 0.107348    1
    Should Contain X Times    ${output}    tz : 0.084041    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
