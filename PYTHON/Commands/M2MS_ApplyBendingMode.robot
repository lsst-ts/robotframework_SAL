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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 24334 19327 12690 22355 16937 17740 31030 12001 23352 25075 31756 3869 1201 17504 9699 30672 16282 17221 28209 28245 17909 5874 10495 28105 15143 12000 13230 16606 10547 32181 13096 8473 95.5289 36.0437 29.4819 23.4594 37.5361 12.9551 70.6655 11.3166 12.5924 22.5362 40.6029 52.6188 86.9139 42.5669 45.9985 20.1995 53.5796 35.6463 86.4347 18.8968 3.956 8.3689 31.2881 94.2174 25.4614 94.0612 42.9821 78.8088 75.4987 41.7643 97.8157 70.0305
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 24334 19327 12690 22355 16937 17740 31030 12001 23352 25075 31756 3869 1201 17504 9699 30672 16282 17221 28209 28245 17909 5874 10495 28105 15143 12000 13230 16606 10547 32181 13096 8473 95.5289 36.0437 29.4819 23.4594 37.5361 12.9551 70.6655 11.3166 12.5924 22.5362 40.6029 52.6188 86.9139 42.5669 45.9985 20.1995 53.5796 35.6463 86.4347 18.8968 3.956 8.3689 31.2881 94.2174 25.4614 94.0612 42.9821 78.8088 75.4987 41.7643 97.8157 70.0305
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 24334    1
    Should Contain X Times    ${output}    bendingModeValue : 95.5289    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [24334, 19327, 12690, 22355, 16937, 17740, 31030, 12001, 23352, 25075, 31756, 3869, 1201, 17504, 9699, 30672, 16282, 17221, 28209, 28245, 17909, 5874, 10495, 28105, 15143, 12000, 13230, 16606, 10547, 32181, 13096, 8473]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [95.5289, 36.0437, 29.4819, 23.4594, 37.5361, 12.9551, 70.6655, 11.3166, 12.5924, 22.5362, 40.6029, 52.6188, 86.9139, 42.5669, 45.9985, 20.1995, 53.5796, 35.6463, 86.4347, 18.8968, 3.956, 8.3689, 31.2881, 94.2174, 25.4614, 94.0612, 42.9821, 78.8088, 75.4987, 41.7643, 97.8157, 70.0305]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
