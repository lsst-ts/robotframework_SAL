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
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 44.4233 65.7571 95.7076 90.7197 47.1886 91.4341 54.0138 43.5449 42.7136 59.3571 90.9668 0.7506 35.0175 61.3967 33.5444 28.1563 69.329 60.3819 30.8484 21.0714 48.7022 32.8633 19.6579 15.8662 32.2899 41.4472 86.5897 75.0843 41.4116 52.932 27.8886 27.486 62.4066 28.2971 45.2855 91.0542 88.8703 73.9258 90.2423 98.0367 45.8164 15.3338 57.8468 64.9473 97.5011 2.8038 61.4479 73.0557 6.8107 21.3537 33.2827 78.6439 36.6091 96.1293 8.1491 39.041 55.4338 42.6429 87.1745 56.8682 2.609 28.6928 19.7648 53.0192 65.1091 9.4954 77.9042 95.2222 99.4939 26.542 94.5524 62.4906
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 44.4233 65.7571 95.7076 90.7197 47.1886 91.4341 54.0138 43.5449 42.7136 59.3571 90.9668 0.7506 35.0175 61.3967 33.5444 28.1563 69.329 60.3819 30.8484 21.0714 48.7022 32.8633 19.6579 15.8662 32.2899 41.4472 86.5897 75.0843 41.4116 52.932 27.8886 27.486 62.4066 28.2971 45.2855 91.0542 88.8703 73.9258 90.2423 98.0367 45.8164 15.3338 57.8468 64.9473 97.5011 2.8038 61.4479 73.0557 6.8107 21.3537 33.2827 78.6439 36.6091 96.1293 8.1491 39.041 55.4338 42.6429 87.1745 56.8682 2.609 28.6928 19.7648 53.0192 65.1091 9.4954 77.9042 95.2222 99.4939 26.542 94.5524 62.4906
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 44.4233    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [44.4233, 65.7571, 95.7076, 90.7197, 47.1886, 91.4341, 54.0138, 43.5449, 42.7136, 59.3571, 90.9668, 0.7506, 35.0175, 61.3967, 33.5444, 28.1563, 69.329, 60.3819, 30.8484, 21.0714, 48.7022, 32.8633, 19.6579, 15.8662, 32.2899, 41.4472, 86.5897, 75.0843, 41.4116, 52.932, 27.8886, 27.486, 62.4066, 28.2971, 45.2855, 91.0542, 88.8703, 73.9258, 90.2423, 98.0367, 45.8164, 15.3338, 57.8468, 64.9473, 97.5011, 2.8038, 61.4479, 73.0557, 6.8107, 21.3537, 33.2827, 78.6439, 36.6091, 96.1293, 8.1491, 39.041, 55.4338, 42.6429, 87.1745, 56.8682, 2.609, 28.6928, 19.7648, 53.0192, 65.1091, 9.4954, 77.9042, 95.2222, 99.4939, 26.542, 94.5524, 62.4906]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
