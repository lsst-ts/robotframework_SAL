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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 69.7741 37.6319 47.3665 16.7081 3.8417 47.8763 5.058 91.6155 67.3603 68.9086 7.0676 38.7806
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 69.7741 37.6319 47.3665 16.7081 3.8417 47.8763 5.058 91.6155 67.3603 68.9086 7.0676 38.7806
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 69.7741    1
    Should Contain X Times    ${output}    xmax : 37.6319    1
    Should Contain X Times    ${output}    ymin : 47.3665    1
    Should Contain X Times    ${output}    ymax : 16.7081    1
    Should Contain X Times    ${output}    zmin : 3.8417    1
    Should Contain X Times    ${output}    zmax : 47.8763    1
    Should Contain X Times    ${output}    umin : 5.058    1
    Should Contain X Times    ${output}    umax : 91.6155    1
    Should Contain X Times    ${output}    vmin : 67.3603    1
    Should Contain X Times    ${output}    vmax : 68.9086    1
    Should Contain X Times    ${output}    wmin : 7.0676    1
    Should Contain X Times    ${output}    wmax : 38.7806    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 69.7741    1
    Should Contain X Times    ${output}    xmax = 37.6319    1
    Should Contain X Times    ${output}    ymin = 47.3665    1
    Should Contain X Times    ${output}    ymax = 16.7081    1
    Should Contain X Times    ${output}    zmin = 3.8417    1
    Should Contain X Times    ${output}    zmax = 47.8763    1
    Should Contain X Times    ${output}    umin = 5.058    1
    Should Contain X Times    ${output}    umax = 91.6155    1
    Should Contain X Times    ${output}    vmin = 67.3603    1
    Should Contain X Times    ${output}    vmax = 68.9086    1
    Should Contain X Times    ${output}    wmin = 7.0676    1
    Should Contain X Times    ${output}    wmax = 38.7806    1
    Should Contain X Times    ${output}    === [ackCommand_configureVelocity] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
