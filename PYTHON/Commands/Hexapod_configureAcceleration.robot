*** Settings ***
Documentation    Hexapod_configureAcceleration commander/controller tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 62.5152 76.5135 41.2906 74.4609 2.5271 77.4605 55.9588 89.1 2.9927 89.1961 91.2466 82.068
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 62.5152 76.5135 41.2906 74.4609 2.5271 77.4605 55.9588 89.1 2.9927 89.1961 91.2466 82.068
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 62.5152    1
    Should Contain X Times    ${output}    xmax : 76.5135    1
    Should Contain X Times    ${output}    ymin : 41.2906    1
    Should Contain X Times    ${output}    ymax : 74.4609    1
    Should Contain X Times    ${output}    zmin : 2.5271    1
    Should Contain X Times    ${output}    zmax : 77.4605    1
    Should Contain X Times    ${output}    umin : 55.9588    1
    Should Contain X Times    ${output}    umax : 89.1    1
    Should Contain X Times    ${output}    vmin : 2.9927    1
    Should Contain X Times    ${output}    vmax : 89.1961    1
    Should Contain X Times    ${output}    wmin : 91.2466    1
    Should Contain X Times    ${output}    wmax : 82.068    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 62.5152    1
    Should Contain X Times    ${output}    xmax = 76.5135    1
    Should Contain X Times    ${output}    ymin = 41.2906    1
    Should Contain X Times    ${output}    ymax = 74.4609    1
    Should Contain X Times    ${output}    zmin = 2.5271    1
    Should Contain X Times    ${output}    zmax = 77.4605    1
    Should Contain X Times    ${output}    umin = 55.9588    1
    Should Contain X Times    ${output}    umax = 89.1    1
    Should Contain X Times    ${output}    vmin = 2.9927    1
    Should Contain X Times    ${output}    vmax = 89.1961    1
    Should Contain X Times    ${output}    wmin = 91.2466    1
    Should Contain X Times    ${output}    wmax = 82.068    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
