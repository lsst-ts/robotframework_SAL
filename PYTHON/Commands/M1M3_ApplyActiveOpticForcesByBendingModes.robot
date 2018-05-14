*** Settings ***
Documentation    M1M3_ApplyActiveOpticForcesByBendingModes commander/controller tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyActiveOpticForcesByBendingModes
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.577309725843 0.699588034606 0.705439782717 0.0519187253899 0.486148321149 0.161286128654 0.77895921788 0.566737592292 0.332184878822 0.693671885896 0.164101906086 0.764636211875 0.525639862633 0.0253235299309 0.143086397906 0.771092562695 0.85047121401 0.0643553083419 0.201890639062 0.483399454126 0.302560284577 0.00128108713659
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.577309725843 0.699588034606 0.705439782717 0.0519187253899 0.486148321149 0.161286128654 0.77895921788 0.566737592292 0.332184878822 0.693671885896 0.164101906086 0.764636211875 0.525639862633 0.0253235299309 0.143086397906 0.771092562695 0.85047121401 0.0643553083419 0.201890639062 0.483399454126 0.302560284577 0.00128108713659
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    Coefficients : 0.577309725843    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    Coefficients(22) = [0.577309725843, 0.699588034606, 0.705439782717, 0.0519187253899, 0.486148321149, 0.161286128654, 0.77895921788, 0.566737592292, 0.332184878822, 0.693671885896, 0.164101906086, 0.764636211875, 0.525639862633, 0.0253235299309, 0.143086397906, 0.771092562695, 0.85047121401, 0.0643553083419, 0.201890639062, 0.483399454126, 0.302560284577, 0.00128108713659]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForcesByBendingModes] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
