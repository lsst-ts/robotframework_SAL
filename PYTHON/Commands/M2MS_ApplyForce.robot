*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 58.6739 31.5294 45.8738 64.1721 16.4446 39.4891 97.8643 64.5235 9.9826 96.696 13.0122 74.6241 45.7 49.2012 3.3874 82.1379 13.6682 45.3654 8.536 60.8168 80.0642 60.7319 49.9176 63.5904 2.3218 56.728 44.377 36.5235 43.6813 30.9625 52.98 90.187 77.5291 66.6266 66.0778 99.6408 40.2738 37.3825 27.1804 78.6267 75.8414 67.7891 90.5259 58.0785 89.7934 36.2169 90.7981 0.2185 83.0145 88.7604 92.986 35.4996 20.8462 74.0956 87.9536 22.1365 39.9495 50.9903 61.4054 25.3455 70.0949 66.1672 48.852 53.7965 69.0115 99.0555 14.1776 63.8404 6.9025 46.3676 3.0756 46.2714
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 58.6739 31.5294 45.8738 64.1721 16.4446 39.4891 97.8643 64.5235 9.9826 96.696 13.0122 74.6241 45.7 49.2012 3.3874 82.1379 13.6682 45.3654 8.536 60.8168 80.0642 60.7319 49.9176 63.5904 2.3218 56.728 44.377 36.5235 43.6813 30.9625 52.98 90.187 77.5291 66.6266 66.0778 99.6408 40.2738 37.3825 27.1804 78.6267 75.8414 67.7891 90.5259 58.0785 89.7934 36.2169 90.7981 0.2185 83.0145 88.7604 92.986 35.4996 20.8462 74.0956 87.9536 22.1365 39.9495 50.9903 61.4054 25.3455 70.0949 66.1672 48.852 53.7965 69.0115 99.0555 14.1776 63.8404 6.9025 46.3676 3.0756 46.2714
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 58.6739    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [58.6739, 31.5294, 45.8738, 64.1721, 16.4446, 39.4891, 97.8643, 64.5235, 9.9826, 96.696, 13.0122, 74.6241, 45.7, 49.2012, 3.3874, 82.1379, 13.6682, 45.3654, 8.536, 60.8168, 80.0642, 60.7319, 49.9176, 63.5904, 2.3218, 56.728, 44.377, 36.5235, 43.6813, 30.9625, 52.98, 90.187, 77.5291, 66.6266, 66.0778, 99.6408, 40.2738, 37.3825, 27.1804, 78.6267, 75.8414, 67.7891, 90.5259, 58.0785, 89.7934, 36.2169, 90.7981, 0.2185, 83.0145, 88.7604, 92.986, 35.4996, 20.8462, 74.0956, 87.9536, 22.1365, 39.9495, 50.9903, 61.4054, 25.3455, 70.0949, 66.1672, 48.852, 53.7965, 69.0115, 99.0555, 14.1776, 63.8404, 6.9025, 46.3676, 3.0756, 46.2714]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
