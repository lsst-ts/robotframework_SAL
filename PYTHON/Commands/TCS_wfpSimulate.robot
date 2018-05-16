*** Settings ***
Documentation    TCS_wfpSimulate commander/controller tests.
Force Tags    python    Checking if skipped: tcs
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    wfpSimulate
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py RhJsuWrvdTEjpOzCNuZzaBmixaWWVsxPatwxPLiXPjoDvCltGHmDWcglLTvWvkqc 12.8574 88.8712 98.1274 13.6534 5.1377 84.2048 64.9666 17.0905 64.6869 95.5707 60.2252 51.2507 50.2644 58.5234 82.3305 84.0357 44.6426 33.3241
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py RhJsuWrvdTEjpOzCNuZzaBmixaWWVsxPatwxPLiXPjoDvCltGHmDWcglLTvWvkqc 12.8574 88.8712 98.1274 13.6534 5.1377 84.2048 64.9666 17.0905 64.6869 95.5707 60.2252 51.2507 50.2644 58.5234 82.3305 84.0357 44.6426 33.3241
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    uid : RhJsuWrvdTEjpOzCNuZzaBmixaWWVsxPatwxPLiXPjoDvCltGHmDWcglLTvWvkqc    1
    Should Contain X Times    ${output}    z_arr : 12.8574    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    uid = RhJsuWrvdTEjpOzCNuZzaBmixaWWVsxPatwxPLiXPjoDvCltGHmDWcglLTvWvkqc    1
    Should Contain X Times    ${output}    z_arr(18) = [12.8574, 88.8712, 98.1274, 13.6534, 5.1377, 84.2048, 64.9666, 17.0905, 64.6869, 95.5707, 60.2252, 51.2507, 50.2644, 58.5234, 82.3305, 84.0357, 44.6426, 33.3241]    1
    Should Contain X Times    ${output}    === [ackCommand_wfpSimulate] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
