*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    cpp
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 43.9533 82.5019 44.2966 24.7494 67.018 13.6914 9.3018 58.5032 88.9401 87.9298 33.0759 24.5665 34.6595 27.2059 22.6055 6.4271 67.2867 35.1184 0.7575 79.0321 56.5132 85.8267 71.2586 57.8668 90.1884 62.1734 93.5689 40.83 25.6955 46.8493 68.2813 83.613 22.7306 68.391 16.5855 91.8632 22.6122 15.3916 41.4391 43.531 62.9306 98.1174 0.9342 70.4198 10.1924 36.6976 39.6603 9.3782 16.0561 97.8966 42.3685 22.3615 84.0886 78.718 13.305 1.7655 12.1778 35.7851 71.0816 82.8407 8.3994 94.2515 24.1349 57.5897 73.878 78.871 80.9349 65.2414 74.1379 61.6212 35.864 66.8719
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 43.9533 82.5019 44.2966 24.7494 67.018 13.6914 9.3018 58.5032 88.9401 87.9298 33.0759 24.5665 34.6595 27.2059 22.6055 6.4271 67.2867 35.1184 0.7575 79.0321 56.5132 85.8267 71.2586 57.8668 90.1884 62.1734 93.5689 40.83 25.6955 46.8493 68.2813 83.613 22.7306 68.391 16.5855 91.8632 22.6122 15.3916 41.4391 43.531 62.9306 98.1174 0.9342 70.4198 10.1924 36.6976 39.6603 9.3782 16.0561 97.8966 42.3685 22.3615 84.0886 78.718 13.305 1.7655 12.1778 35.7851 71.0816 82.8407 8.3994 94.2515 24.1349 57.5897 73.878 78.871 80.9349 65.2414 74.1379 61.6212 35.864 66.8719
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 43.9533    1
    Should Contain    ${output}    === command ApplyForce issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForce received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetPoint : 43.9533    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
