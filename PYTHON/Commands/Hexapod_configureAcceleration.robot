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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 91.1771 70.1489 36.1105 77.485 34.0806 54.866 31.3751 66.7818 34.632 16.4742 62.8311 26.3652
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 91.1771 70.1489 36.1105 77.485 34.0806 54.866 31.3751 66.7818 34.632 16.4742 62.8311 26.3652
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    xmin : 91.1771    1
    Should Contain X Times    ${output}    xmax : 70.1489    1
    Should Contain X Times    ${output}    ymin : 36.1105    1
    Should Contain X Times    ${output}    ymax : 77.485    1
    Should Contain X Times    ${output}    zmin : 34.0806    1
    Should Contain X Times    ${output}    zmax : 54.866    1
    Should Contain X Times    ${output}    umin : 31.3751    1
    Should Contain X Times    ${output}    umax : 66.7818    1
    Should Contain X Times    ${output}    vmin : 34.632    1
    Should Contain X Times    ${output}    vmax : 16.4742    1
    Should Contain X Times    ${output}    wmin : 62.8311    1
    Should Contain X Times    ${output}    wmax : 26.3652    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    xmin = 91.1771    1
    Should Contain X Times    ${output}    xmax = 70.1489    1
    Should Contain X Times    ${output}    ymin = 36.1105    1
    Should Contain X Times    ${output}    ymax = 77.485    1
    Should Contain X Times    ${output}    zmin = 34.0806    1
    Should Contain X Times    ${output}    zmax = 54.866    1
    Should Contain X Times    ${output}    umin = 31.3751    1
    Should Contain X Times    ${output}    umax = 66.7818    1
    Should Contain X Times    ${output}    vmin = 34.632    1
    Should Contain X Times    ${output}    vmax = 16.4742    1
    Should Contain X Times    ${output}    wmin = 62.8311    1
    Should Contain X Times    ${output}    wmax = 26.3652    1
    Should Contain X Times    ${output}    === [ackCommand_configureAcceleration] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
