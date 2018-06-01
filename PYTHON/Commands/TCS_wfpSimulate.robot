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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py MyhACZwkNGSqTZajutIpFsCOlavlZTubsozZrVKHokGmpUAHSnlPyhUalCNwhBag 64.005 25.9079 9.5367 61.9897 40.1498 33.1087 44.3384 63.6252 96.2438 69.9949 59.0614 51.4114 92.1073 33.2623 77.4603 63.5838 47.5162 44.5202
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py MyhACZwkNGSqTZajutIpFsCOlavlZTubsozZrVKHokGmpUAHSnlPyhUalCNwhBag 64.005 25.9079 9.5367 61.9897 40.1498 33.1087 44.3384 63.6252 96.2438 69.9949 59.0614 51.4114 92.1073 33.2623 77.4603 63.5838 47.5162 44.5202
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    uid : MyhACZwkNGSqTZajutIpFsCOlavlZTubsozZrVKHokGmpUAHSnlPyhUalCNwhBag    1
    Should Contain X Times    ${output}    z_arr : 64.005    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    uid = MyhACZwkNGSqTZajutIpFsCOlavlZTubsozZrVKHokGmpUAHSnlPyhUalCNwhBag    1
    Should Contain X Times    ${output}    z_arr(18) = [64.005, 25.9079, 9.5367, 61.9897, 40.1498, 33.1087, 44.3384, 63.6252, 96.2438, 69.9949, 59.0614, 51.4114, 92.1073, 33.2623, 77.4603, 63.5838, 47.5162, 44.5202]    1
    Should Contain X Times    ${output}    === [ackCommand_wfpSimulate] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
