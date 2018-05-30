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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 13275 9080 22593 6378 -22831 -4144 14881 -27535 19435 -3903 -18982 -22480 16924 28087 7070 9372 -28523 -26172 20 0.421283 0.803728 0.74928 0.487596 0.925639 0.260254 0.119524 0.325914 0.621596 0.996062 0.993219 0.92525 0.669748 0.737496 0.540529 0.269305 0.851778 0.612161 0.217825 0.976546 0.690488 0.454261 0.082186 0.663825 0.279641 0.735313 0.468718 0.005159 0.057418 0.71812 0.554325 0.653531 0.153457 0.606035 0.941028 0.760608 0.642549 0.803306 0.568129 0.137615 0.797094 0.802002 0.375225 0.44225 0.0715 0.201882 0.549756 0.619673 0.393293 0.447069 0.012375 0.336108 0.602679 0.743785 0.56219 0.044069 0.813087 0.799156 0.979153 0.406597 0.754645 0.138302 0.385222 0.407148 0.272286 0.954108 0.266953 0.421011 0.963737 0.675701 0.886064 0.653008 0.13286 0.104435 0.914135 0.053481 0.323592 0.701908 0.640224 0.168196 0.825587 0.623604 0.519823 0.733722 0.331706 0.437836 0.742374 0.507706 0.540264 0.331138 0.258215 0.720585 0.316449 0.180709 0.114127 0.827919 0.460404 0.880195 0.818031 0.382906 0.889807 0.689501 0.688171 0.316775 0.585004 0.216287 0.49145 0.182992 0.575154 0.735563 0.746943 0.713813 0.23835 0.961826
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 13275 9080 22593 6378 -22831 -4144 14881 -27535 19435 -3903 -18982 -22480 16924 28087 7070 9372 -28523 -26172 20 0.421283 0.803728 0.74928 0.487596 0.925639 0.260254 0.119524 0.325914 0.621596 0.996062 0.993219 0.92525 0.669748 0.737496 0.540529 0.269305 0.851778 0.612161 0.217825 0.976546 0.690488 0.454261 0.082186 0.663825 0.279641 0.735313 0.468718 0.005159 0.057418 0.71812 0.554325 0.653531 0.153457 0.606035 0.941028 0.760608 0.642549 0.803306 0.568129 0.137615 0.797094 0.802002 0.375225 0.44225 0.0715 0.201882 0.549756 0.619673 0.393293 0.447069 0.012375 0.336108 0.602679 0.743785 0.56219 0.044069 0.813087 0.799156 0.979153 0.406597 0.754645 0.138302 0.385222 0.407148 0.272286 0.954108 0.266953 0.421011 0.963737 0.675701 0.886064 0.653008 0.13286 0.104435 0.914135 0.053481 0.323592 0.701908 0.640224 0.168196 0.825587 0.623604 0.519823 0.733722 0.331706 0.437836 0.742374 0.507706 0.540264 0.331138 0.258215 0.720585 0.316449 0.180709 0.114127 0.827919 0.460404 0.880195 0.818031 0.382906 0.889807 0.689501 0.688171 0.316775 0.585004 0.216287 0.49145 0.182992 0.575154 0.735563 0.746943 0.713813 0.23835 0.961826
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    elevIndex : 13275    1
    Should Contain X Times    ${output}    fz1 : 0.421283    1
    Should Contain X Times    ${output}    fz2 : 0.976546    1
    Should Contain X Times    ${output}    fz3 : 0.568129    1
    Should Contain X Times    ${output}    fz4 : 0.799156    1
    Should Contain X Times    ${output}    fz5 : 0.323592    1
    Should Contain X Times    ${output}    fz6 : 0.827919    1
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
    Should Contain X Times    ${output}    elevIndex : 13275    1
    Should Contain X Times    ${output}    fz1 : 0.421283    1
    Should Contain X Times    ${output}    fz2 : 0.976546    1
    Should Contain X Times    ${output}    fz3 : 0.568129    1
    Should Contain X Times    ${output}    fz4 : 0.799156    1
    Should Contain X Times    ${output}    fz5 : 0.323592    1
    Should Contain X Times    ${output}    fz6 : 0.827919    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
