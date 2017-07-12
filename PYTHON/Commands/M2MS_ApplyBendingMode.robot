*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -19829 26738 13981 30553 -12721 -3916 9085 -5562 4083 -16706 -19175 23995 14791 27401 16632 -15156 22483 -3765 7350 28216 -9445 26355 -29162 31723 10557 17277 -25343 26936 29084 -15989 12933 -24647 9.1194 15.6659 63.8569 6.404 99.0036 68.9516 20.7161 28.0605 55.2722 2.323 60.6824 11.73 97.4451 23.8707 54.4595 70.5063 52.909 49.0868 36.3272 46.7059 88.5437 23.0727 90.2238 39.5936 93.7148 97.4839 37.8594 52.6356 72.6312 65.4516 47.8558 45.853
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -19829 26738 13981 30553 -12721 -3916 9085 -5562 4083 -16706 -19175 23995 14791 27401 16632 -15156 22483 -3765 7350 28216 -9445 26355 -29162 31723 10557 17277 -25343 26936 29084 -15989 12933 -24647 9.1194 15.6659 63.8569 6.404 99.0036 68.9516 20.7161 28.0605 55.2722 2.323 60.6824 11.73 97.4451 23.8707 54.4595 70.5063 52.909 49.0868 36.3272 46.7059 88.5437 23.0727 90.2238 39.5936 93.7148 97.4839 37.8594 52.6356 72.6312 65.4516 47.8558 45.853
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -19829    1
    Should Contain X Times    ${output}    bendingModeValue : 9.1194    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-19829, 26738, 13981, 30553, -12721, -3916, 9085, -5562, 4083, -16706, -19175, 23995, 14791, 27401, 16632, -15156, 22483, -3765, 7350, 28216, -9445, 26355, -29162, 31723, 10557, 17277, -25343, 26936, 29084, -15989, 12933, -24647]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [9.1194, 15.6659, 63.8569, 6.404, 99.0036, 68.9516, 20.7161, 28.0605, 55.2722, 2.323, 60.6824, 11.73, 97.4451, 23.8707, 54.4595, 70.5063, 52.909, 49.0868, 36.3272, 46.7059, 88.5437, 23.0727, 90.2238, 39.5936, 93.7148, 97.4839, 37.8594, 52.6356, 72.6312, 65.4516, 47.8558, 45.853]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
