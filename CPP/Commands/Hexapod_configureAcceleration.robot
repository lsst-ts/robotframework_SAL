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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 37.9277 39.1499 10.1295 50.1397 5.8788 97.4516 7.3937 36.4058 90.4748 7.4737 7.2563 49.0605
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 37.9277 39.1499 10.1295 50.1397 5.8788 97.4516 7.3937 36.4058 90.4748 7.4737 7.2563 49.0605
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : acceleration    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 37.9277    1
    Should Contain X Times    ${output}    xmax : 39.1499    1
    Should Contain X Times    ${output}    ymin : 10.1295    1
    Should Contain X Times    ${output}    ymax : 50.1397    1
    Should Contain X Times    ${output}    zmin : 5.8788    1
    Should Contain X Times    ${output}    zmax : 97.4516    1
    Should Contain X Times    ${output}    umin : 7.3937    1
    Should Contain X Times    ${output}    umax : 36.4058    1
    Should Contain X Times    ${output}    vmin : 90.4748    1
    Should Contain X Times    ${output}    vmax : 7.4737    1
    Should Contain X Times    ${output}    wmin : 7.2563    1
    Should Contain X Times    ${output}    wmax : 49.0605    1
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
    Should Contain X Times    ${output}    xmin : 37.9277    1
    Should Contain X Times    ${output}    xmax : 39.1499    1
    Should Contain X Times    ${output}    ymin : 10.1295    1
    Should Contain X Times    ${output}    ymax : 50.1397    1
    Should Contain X Times    ${output}    zmin : 5.8788    1
    Should Contain X Times    ${output}    zmax : 97.4516    1
    Should Contain X Times    ${output}    umin : 7.3937    1
    Should Contain X Times    ${output}    umax : 36.4058    1
    Should Contain X Times    ${output}    vmin : 90.4748    1
    Should Contain X Times    ${output}    vmax : 7.4737    1
    Should Contain X Times    ${output}    wmin : 7.2563    1
    Should Contain X Times    ${output}    wmax : 49.0605    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
