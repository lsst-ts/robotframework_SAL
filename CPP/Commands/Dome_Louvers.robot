*** Settings ***
Documentation    Dome_Louvers commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${component}    Louvers
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
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
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 30.5388 81.152 75.8469 56.3769 16.4301 72.3161 94.9528 51.0597 91.6678 4.1306 63.2302 25.6194 20.6687 3.2066 37.3576 10.3108 39.3052 9.4478 72.4843 57.2333 43.7868 66.8703 93.569 96.6008 35.3551 88.2785 42.0418 21.1053 69.6955 61.9313 27.7584 75.4207 82.3685 34.6769 11.2103 64.5753 40.9712 22.978 91.2765 38.1388 82.5344 94.691 37.3669 66.1862 58.2638 77.5969 54.1516 67.8867 33.6874 21.3157 93.2404 77.9055 81.3426 96.4991 25.2779 49.8126 70.4182 65.8557 77.9204 3.6948 87.5198 4.8091 24.6303 92.4094 70.9671 4.5695 11.7525 56.9689 31.6138 58.1319 92.8648 85.6143
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 30.5388 81.152 75.8469 56.3769 16.4301 72.3161 94.9528 51.0597 91.6678 4.1306 63.2302 25.6194 20.6687 3.2066 37.3576 10.3108 39.3052 9.4478 72.4843 57.2333 43.7868 66.8703 93.569 96.6008 35.3551 88.2785 42.0418 21.1053 69.6955 61.9313 27.7584 75.4207 82.3685 34.6769 11.2103 64.5753 40.9712 22.978 91.2765 38.1388 82.5344 94.691 37.3669 66.1862 58.2638 77.5969 54.1516 67.8867 33.6874 21.3157 93.2404 77.9055 81.3426 96.4991 25.2779 49.8126 70.4182 65.8557 77.9204 3.6948 87.5198 4.8091 24.6303 92.4094 70.9671 4.5695 11.7525 56.9689 31.6138 58.1319 92.8648 85.6143
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : louvers    1
    Should Contain X Times    ${output}    property : position    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    openPercent : 30.5388    1
    Should Contain    ${output}    === command Louvers issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command Louvers received =
    Should Contain    ${output}    device : louvers
    Should Contain    ${output}    property : position
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    openPercent : 30.5388    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
