*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT communications tests.
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
${component}    configureTemperatureRawLUT
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 14635 4403 -14685 15037 24498 -22943 8434 -26988 -28660 0.072111 0.030202 0.004938 0.731153 0.103079 0.929286 0.900256 0.683471 0.853428 0.428293 0.697688 0.667821 0.712693 0.972225 0.750134 0.200727 0.579802 0.746106 0.632471 0.47485 0.656484 0.921129 0.446565 0.417439 0.037193 0.792135 0.265531 0.468911 0.571785 0.794147 0.006676 0.384982 0.132227 0.243615 0.828924 0.912572 0.146887 0.664875 0.308364 0.988701 0.365124 0.84642 0.375658 0.209811 0.870698 0.95833 0.027407 0.124048 0.442879 0.801668 0.988762 0.799956 0.18516 0.998076
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 14635 4403 -14685 15037 24498 -22943 8434 -26988 -28660 0.072111 0.030202 0.004938 0.731153 0.103079 0.929286 0.900256 0.683471 0.853428 0.428293 0.697688 0.667821 0.712693 0.972225 0.750134 0.200727 0.579802 0.746106 0.632471 0.47485 0.656484 0.921129 0.446565 0.417439 0.037193 0.792135 0.265531 0.468911 0.571785 0.794147 0.006676 0.384982 0.132227 0.243615 0.828924 0.912572 0.146887 0.664875 0.308364 0.988701 0.365124 0.84642 0.375658 0.209811 0.870698 0.95833 0.027407 0.124048 0.442879 0.801668 0.988762 0.799956 0.18516 0.998076
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : 14635    1
    Should Contain X Times    ${output}    rx : 0.072111    1
    Should Contain X Times    ${output}    ry : 0.428293    1
    Should Contain X Times    ${output}    rz : 0.632471    1
    Should Contain X Times    ${output}    tx : 0.468911    1
    Should Contain X Times    ${output}    ty : 0.146887    1
    Should Contain X Times    ${output}    tz : 0.95833    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = 14635    1
    Should Contain X Times    ${output}    rx = 0.072111    1
    Should Contain X Times    ${output}    ry = 0.428293    1
    Should Contain X Times    ${output}    rz = 0.632471    1
    Should Contain X Times    ${output}    tx = 0.468911    1
    Should Contain X Times    ${output}    ty = 0.146887    1
    Should Contain X Times    ${output}    tz = 0.95833    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
