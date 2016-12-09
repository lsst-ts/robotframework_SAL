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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 93.6686 77.5732 40.5148 37.2847 65.8201 50.4937 83.4567 56.7276 8.7505 87.0903 44.733 96.11 53.1604 91.2157 53.5994 41.3111 5.8969 21.8878 56.1372 49.0308 50.3915 51.3385 90.4638 75.9679 47.5933 67.6967 13.9852 3.1939 69.9446 24.6478 79.795 15.0599 65.8238 35.3838 73.282 80.8283 68.9123 2.758 25.5319 41.4032 45.6892 59.0279 78.8832 2.4489 20.0574 58.4733 8.1816 24.9401 74.2735 46.7385 45.5569 83.2893 66.6664 7.6154 40.5611 21.0769 67.8654 72.5285 66.0789 93.0025 29.5701 6.1673 91.076 38.3318 22.4852 93.7146 30.9878 23.5413 55.4469 84.7474 57.5093 43.6079
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 93.6686 77.5732 40.5148 37.2847 65.8201 50.4937 83.4567 56.7276 8.7505 87.0903 44.733 96.11 53.1604 91.2157 53.5994 41.3111 5.8969 21.8878 56.1372 49.0308 50.3915 51.3385 90.4638 75.9679 47.5933 67.6967 13.9852 3.1939 69.9446 24.6478 79.795 15.0599 65.8238 35.3838 73.282 80.8283 68.9123 2.758 25.5319 41.4032 45.6892 59.0279 78.8832 2.4489 20.0574 58.4733 8.1816 24.9401 74.2735 46.7385 45.5569 83.2893 66.6664 7.6154 40.5611 21.0769 67.8654 72.5285 66.0789 93.0025 29.5701 6.1673 91.076 38.3318 22.4852 93.7146 30.9878 23.5413 55.4469 84.7474 57.5093 43.6079
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : louvers    1
    Should Contain X Times    ${output}    property : position    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    openPercent : 93.6686    1
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
    Should Contain X Times    ${output}    openPercent : 93.6686    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
