*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 60.5115 89.1039 32.2221 62.601 2.5295 59.8225 29.1707 43.6222 2.6781 90.0715 32.5594 55.437 81.1165 75.6997 1.9325 49.9231 64.2813 22.7286 60.6822 63.5621 2.5481 57.3752 29.8632 3.7614 4.9687 18.9082 93.0907 31.8064 5.7552 31.8476 56.4581 17.2106 43.3152 17.9893 96.7656 14.582 68.8135 18.4153 43.6988 69.6127 30.8656 27.4426 18.4656 23.6712 99.3248 36.9566 4.8113 7.1613 4.6868 43.4895 94.3821 93.1062 36.6201 49.9264 73.5458 59.2721 99.6267 4.0338 57.7828 32.2091 9.9115 30.1411 81.9262 15.4821 17.6821 16.5875 73.1281 60.9872 79.2202 12.4936 34.5628 83.8279
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 60.5115 89.1039 32.2221 62.601 2.5295 59.8225 29.1707 43.6222 2.6781 90.0715 32.5594 55.437 81.1165 75.6997 1.9325 49.9231 64.2813 22.7286 60.6822 63.5621 2.5481 57.3752 29.8632 3.7614 4.9687 18.9082 93.0907 31.8064 5.7552 31.8476 56.4581 17.2106 43.3152 17.9893 96.7656 14.582 68.8135 18.4153 43.6988 69.6127 30.8656 27.4426 18.4656 23.6712 99.3248 36.9566 4.8113 7.1613 4.6868 43.4895 94.3821 93.1062 36.6201 49.9264 73.5458 59.2721 99.6267 4.0338 57.7828 32.2091 9.9115 30.1411 81.9262 15.4821 17.6821 16.5875 73.1281 60.9872 79.2202 12.4936 34.5628 83.8279
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 60.5115    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [60.5115, 89.1039, 32.2221, 62.601, 2.5295, 59.8225, 29.1707, 43.6222, 2.6781, 90.0715, 32.5594, 55.437, 81.1165, 75.6997, 1.9325, 49.9231, 64.2813, 22.7286, 60.6822, 63.5621, 2.5481, 57.3752, 29.8632, 3.7614, 4.9687, 18.9082, 93.0907, 31.8064, 5.7552, 31.8476, 56.4581, 17.2106, 43.3152, 17.9893, 96.7656, 14.582, 68.8135, 18.4153, 43.6988, 69.6127, 30.8656, 27.4426, 18.4656, 23.6712, 99.3248, 36.9566, 4.8113, 7.1613, 4.6868, 43.4895, 94.3821, 93.1062, 36.6201, 49.9264, 73.5458, 59.2721, 99.6267, 4.0338, 57.7828, 32.2091, 9.9115, 30.1411, 81.9262, 15.4821, 17.6821, 16.5875, 73.1281, 60.9872, 79.2202, 12.4936, 34.5628, 83.8279]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
