*** Settings ***
Documentation    TCS_wfpSimulate communications tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py qClvdkAtFhpkkPugbZYiSdYNfUssNkrcVCVIJZNWmMLSHvQohEUmkySHxVbQAfWc 8.6241 9.4048 19.5539 2.5726 75.8421 32.4794 85.7468 51.7837 47.8888 56.2743 73.7496 13.4847 70.068 76.7568 76.1755 3.4367 91.5141 76.2649
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py qClvdkAtFhpkkPugbZYiSdYNfUssNkrcVCVIJZNWmMLSHvQohEUmkySHxVbQAfWc 8.6241 9.4048 19.5539 2.5726 75.8421 32.4794 85.7468 51.7837 47.8888 56.2743 73.7496 13.4847 70.068 76.7568 76.1755 3.4367 91.5141 76.2649
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    uid : qClvdkAtFhpkkPugbZYiSdYNfUssNkrcVCVIJZNWmMLSHvQohEUmkySHxVbQAfWc    1
    Should Contain X Times    ${output}    z_arr : 8.6241    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    uid = qClvdkAtFhpkkPugbZYiSdYNfUssNkrcVCVIJZNWmMLSHvQohEUmkySHxVbQAfWc    1
    Should Contain X Times    ${output}    z_arr(18) = [8.6241, 9.4048, 19.5539, 2.5726, 75.8421, 32.4794, 85.7468, 51.7837, 47.8888, 56.2743, 73.7496, 13.4847, 70.068, 76.7568, 76.1755, 3.4367, 91.5141, 76.2649]    1
    Should Contain X Times    ${output}    === [ackCommand_wfpSimulate] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
