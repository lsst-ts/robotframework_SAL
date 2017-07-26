*** Settings ***
Documentation    Hexapod_configureAcceleration commander/controller tests.
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
${component}    configureAcceleration
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 62.4864 21.1118 95.7849 46.522 70.1821 3.8626 83.8219 96.8138 60.2951 71.672 64.3988 25.7438
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 62.4864 21.1118 95.7849 46.522 70.1821 3.8626 83.8219 96.8138 60.2951 71.672 64.3988 25.7438
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 62.4864    1
    Should Contain X Times    ${output}    xmax : 21.1118    1
    Should Contain X Times    ${output}    ymin : 95.7849    1
    Should Contain X Times    ${output}    ymax : 46.522    1
    Should Contain X Times    ${output}    zmin : 70.1821    1
    Should Contain X Times    ${output}    zmax : 3.8626    1
    Should Contain X Times    ${output}    umin : 83.8219    1
    Should Contain X Times    ${output}    umax : 96.8138    1
    Should Contain X Times    ${output}    vmin : 60.2951    1
    Should Contain X Times    ${output}    vmax : 71.672    1
    Should Contain X Times    ${output}    wmin : 64.3988    1
    Should Contain X Times    ${output}    wmax : 25.7438    1
    Should Contain    ${output}    === command configureAcceleration issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureAcceleration received =
    Should Contain    ${output}    device : drive
    Should Contain    ${output}    property : acceleration
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : 62.4864    1
    Should Contain X Times    ${output}    xmax : 21.1118    1
    Should Contain X Times    ${output}    ymin : 95.7849    1
    Should Contain X Times    ${output}    ymax : 46.522    1
    Should Contain X Times    ${output}    zmin : 70.1821    1
    Should Contain X Times    ${output}    zmax : 3.8626    1
    Should Contain X Times    ${output}    umin : 83.8219    1
    Should Contain X Times    ${output}    umax : 96.8138    1
    Should Contain X Times    ${output}    vmin : 60.2951    1
    Should Contain X Times    ${output}    vmax : 71.672    1
    Should Contain X Times    ${output}    wmin : 64.3988    1
    Should Contain X Times    ${output}    wmax : 25.7438    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
