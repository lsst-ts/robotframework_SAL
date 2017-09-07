*** Settings ***
Documentation    Hexapod_configureVelocity commander/controller tests.
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
${component}    configureVelocity
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1.022 95.8355 50.0813 92.5165 42.1178 61.2718 96.3751 43.3179 5.7853 78.3396 70.5808 12.4825
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1.022 95.8355 50.0813 92.5165 42.1178 61.2718 96.3751 43.3179 5.7853 78.3396 70.5808 12.4825
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 1.022    1
    Should Contain X Times    ${output}    xmax : 95.8355    1
    Should Contain X Times    ${output}    ymin : 50.0813    1
    Should Contain X Times    ${output}    ymax : 92.5165    1
    Should Contain X Times    ${output}    zmin : 42.1178    1
    Should Contain X Times    ${output}    zmax : 61.2718    1
    Should Contain X Times    ${output}    umin : 96.3751    1
    Should Contain X Times    ${output}    umax : 43.3179    1
    Should Contain X Times    ${output}    vmin : 5.7853    1
    Should Contain X Times    ${output}    vmax : 78.3396    1
    Should Contain X Times    ${output}    wmin : 70.5808    1
    Should Contain X Times    ${output}    wmax : 12.4825    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 1.022    1
    Should Contain X Times    ${output}    xmax = 95.8355    1
    Should Contain X Times    ${output}    ymin = 50.0813    1
    Should Contain X Times    ${output}    ymax = 92.5165    1
    Should Contain X Times    ${output}    zmin = 42.1178    1
    Should Contain X Times    ${output}    zmax = 61.2718    1
    Should Contain X Times    ${output}    umin = 96.3751    1
    Should Contain X Times    ${output}    umax = 43.3179    1
    Should Contain X Times    ${output}    vmin = 5.7853    1
    Should Contain X Times    ${output}    vmax = 78.3396    1
    Should Contain X Times    ${output}    wmin = 70.5808    1
    Should Contain X Times    ${output}    wmax = 12.4825    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
