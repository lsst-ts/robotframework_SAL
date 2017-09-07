*** Settings ***
Documentation    Hexapod_configureLimits commander/controller tests.
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
${component}    configureLimits
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1562489457 1577582504 1486253408 617955888 1982618466 -1041726988 1434955186 703653894 -1005540594 -526140010 -1286403742 -1758673504
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1562489457 1577582504 1486253408 617955888 1982618466 -1041726988 1434955186 703653894 -1005540594 -526140010 -1286403742 -1758673504
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : limits    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : -1562489457    1
    Should Contain X Times    ${output}    xmax : 1577582504    1
    Should Contain X Times    ${output}    ymin : 1486253408    1
    Should Contain X Times    ${output}    ymax : 617955888    1
    Should Contain X Times    ${output}    zmin : 1982618466    1
    Should Contain X Times    ${output}    zmax : -1041726988    1
    Should Contain X Times    ${output}    umin : 1434955186    1
    Should Contain X Times    ${output}    umax : 703653894    1
    Should Contain X Times    ${output}    vmin : -1005540594    1
    Should Contain X Times    ${output}    vmax : -526140010    1
    Should Contain X Times    ${output}    wwmin : -1286403742    1
    Should Contain X Times    ${output}    wmax : -1758673504    1
    Should Contain    ${output}    === command configureLimits issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureLimits received =
    Should Contain    ${output}    device : actuators
    Should Contain    ${output}    property : limits
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xmin : -1562489457    1
    Should Contain X Times    ${output}    xmax : 1577582504    1
    Should Contain X Times    ${output}    ymin : 1486253408    1
    Should Contain X Times    ${output}    ymax : 617955888    1
    Should Contain X Times    ${output}    zmin : 1982618466    1
    Should Contain X Times    ${output}    zmax : -1041726988    1
    Should Contain X Times    ${output}    umin : 1434955186    1
    Should Contain X Times    ${output}    umax : 703653894    1
    Should Contain X Times    ${output}    vmin : -1005540594    1
    Should Contain X Times    ${output}    vmax : -526140010    1
    Should Contain X Times    ${output}    wwmin : -1286403742    1
    Should Contain X Times    ${output}    wmax : -1758673504    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
