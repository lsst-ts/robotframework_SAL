*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
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
${component}    configureVelocity
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 52.8771 5.47 41.9245 62.8365 71.8046 94.5358 60.4674 67.8659 30.486 32.8991 26.4904 91.4433
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 52.8771 5.47 41.9245 62.8365 71.8046 94.5358 60.4674 67.8659 30.486 32.8991 26.4904 91.4433
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : drive    1
    Should Contain X Times    ${output}    property : velocity    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : 52.8771    1
    Should Contain X Times    ${output}    xmax : 5.47    1
    Should Contain X Times    ${output}    ymin : 41.9245    1
    Should Contain X Times    ${output}    ymax : 62.8365    1
    Should Contain X Times    ${output}    zmin : 71.8046    1
    Should Contain X Times    ${output}    zmax : 94.5358    1
    Should Contain X Times    ${output}    umin : 60.4674    1
    Should Contain X Times    ${output}    umax : 67.8659    1
    Should Contain X Times    ${output}    vmin : 30.486    1
    Should Contain X Times    ${output}    vmax : 32.8991    1
    Should Contain X Times    ${output}    wmin : 26.4904    1
    Should Contain X Times    ${output}    wmax : 91.4433    1
    Should Contain    ${output}    === command configureVelocity issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureVelocity received =
    Should Contain    ${output}    device : drive
    Should Contain    ${output}    property : velocity
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : 52.8771    1
    Should Contain X Times    ${output}    xmax : 5.47    1
    Should Contain X Times    ${output}    ymin : 41.9245    1
    Should Contain X Times    ${output}    ymax : 62.8365    1
    Should Contain X Times    ${output}    zmin : 71.8046    1
    Should Contain X Times    ${output}    zmax : 94.5358    1
    Should Contain X Times    ${output}    umin : 60.4674    1
    Should Contain X Times    ${output}    umax : 67.8659    1
    Should Contain X Times    ${output}    vmin : 30.486    1
    Should Contain X Times    ${output}    vmax : 32.8991    1
    Should Contain X Times    ${output}    wmin : 26.4904    1
    Should Contain X Times    ${output}    wmax : 91.4433    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
