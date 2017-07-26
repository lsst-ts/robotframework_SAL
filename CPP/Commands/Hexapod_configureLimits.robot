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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1275322379 -1439809071 -430421510 707797582 -121514741 -1023696242 36770728 738002543 -674304498 -1586495876 -1490603558 -1553643036
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1275322379 -1439809071 -430421510 707797582 -121514741 -1023696242 36770728 738002543 -674304498 -1586495876 -1490603558 -1553643036
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : actuators    1
    Should Contain X Times    ${output}    property : limits    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xmin : -1275322379    1
    Should Contain X Times    ${output}    xmax : -1439809071    1
    Should Contain X Times    ${output}    ymin : -430421510    1
    Should Contain X Times    ${output}    ymax : 707797582    1
    Should Contain X Times    ${output}    zmin : -121514741    1
    Should Contain X Times    ${output}    zmax : -1023696242    1
    Should Contain X Times    ${output}    umin : 36770728    1
    Should Contain X Times    ${output}    umax : 738002543    1
    Should Contain X Times    ${output}    vmin : -674304498    1
    Should Contain X Times    ${output}    vmax : -1586495876    1
    Should Contain X Times    ${output}    wwmin : -1490603558    1
    Should Contain X Times    ${output}    wmax : -1553643036    1
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
    Should Contain X Times    ${output}    xmin : -1275322379    1
    Should Contain X Times    ${output}    xmax : -1439809071    1
    Should Contain X Times    ${output}    ymin : -430421510    1
    Should Contain X Times    ${output}    ymax : 707797582    1
    Should Contain X Times    ${output}    zmin : -121514741    1
    Should Contain X Times    ${output}    zmax : -1023696242    1
    Should Contain X Times    ${output}    umin : 36770728    1
    Should Contain X Times    ${output}    umax : 738002543    1
    Should Contain X Times    ${output}    vmin : -674304498    1
    Should Contain X Times    ${output}    vmax : -1586495876    1
    Should Contain X Times    ${output}    wwmin : -1490603558    1
    Should Contain X Times    ${output}    wmax : -1553643036    1
    Should Contain X Times    ${output}    === [ackCommand_configureLimits] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
