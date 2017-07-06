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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.9418 6.2771 8.121 18.7924 41.7252 28.9293 13.483 3.517 70.9329 84.8087 31.7284 85.6171 1.0091 2.6095 63.729 34.1035 86.9554 89.6568 51.1401 15.0267 43.5655 77.4699 23.4171 54.3667 27.5335 26.8062 18.523 76.4009 72.3154 26.501 34.9545 35.4924 14.008 39.0756 24.6407 86.1724 79.5603 64.0778 66.5306 8.2347 21.8303 55.3812 53.9636 57.7265 51.2565 14.5153 20.4967 82.9614 90.6259 88.9988 53.8596 88.117 57.8397 61.9936 49.3863 3.3695 13.8488 94.9436 50.0705 45.2637 4.4514 21.3999 51.508 84.7959 4.1609 94.9885 75.6886 32.8099 34.1782 6.4641 67.0948 57.9747
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.9418 6.2771 8.121 18.7924 41.7252 28.9293 13.483 3.517 70.9329 84.8087 31.7284 85.6171 1.0091 2.6095 63.729 34.1035 86.9554 89.6568 51.1401 15.0267 43.5655 77.4699 23.4171 54.3667 27.5335 26.8062 18.523 76.4009 72.3154 26.501 34.9545 35.4924 14.008 39.0756 24.6407 86.1724 79.5603 64.0778 66.5306 8.2347 21.8303 55.3812 53.9636 57.7265 51.2565 14.5153 20.4967 82.9614 90.6259 88.9988 53.8596 88.117 57.8397 61.9936 49.3863 3.3695 13.8488 94.9436 50.0705 45.2637 4.4514 21.3999 51.508 84.7959 4.1609 94.9885 75.6886 32.8099 34.1782 6.4641 67.0948 57.9747
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 16.9418    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [16.9418, 6.2771, 8.121, 18.7924, 41.7252, 28.9293, 13.483, 3.517, 70.9329, 84.8087, 31.7284, 85.6171, 1.0091, 2.6095, 63.729, 34.1035, 86.9554, 89.6568, 51.1401, 15.0267, 43.5655, 77.4699, 23.4171, 54.3667, 27.5335, 26.8062, 18.523, 76.4009, 72.3154, 26.501, 34.9545, 35.4924, 14.008, 39.0756, 24.6407, 86.1724, 79.5603, 64.0778, 66.5306, 8.2347, 21.8303, 55.3812, 53.9636, 57.7265, 51.2565, 14.5153, 20.4967, 82.9614, 90.6259, 88.9988, 53.8596, 88.117, 57.8397, 61.9936, 49.3863, 3.3695, 13.8488, 94.9436, 50.0705, 45.2637, 4.4514, 21.3999, 51.508, 84.7959, 4.1609, 94.9885, 75.6886, 32.8099, 34.1782, 6.4641, 67.0948, 57.9747]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
