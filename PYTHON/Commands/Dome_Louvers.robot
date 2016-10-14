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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 91.5806 85.3718 3.0394 87.8978 55.3373 87.5543 75.8581 67.734 44.6853 12.1771 71.5357 54.7764 66.6241 54.8619 98.8858 40.5832 86.7953 98.2587 5.5103 2.4632 57.5744 32.0915 27.7692 5.3771 12.5409 34.9927 9.5344 82.6513 83.2149 45.275 47.7296 29.1746 43.4298 32.7891 69.9802 31.2997 76.4061 78.8499 3.4211 83.2813 85.7962 39.4563 95.0096 86.3986 76.7794 22.1703 26.9563 3.4603 61.2842 50.504 84.7886 47.8487 63.4665 41.3237 39.8294 35.2356 76.248 76.189 49.7147 22.2188 95.8343 3.0478 41.0011 21.015 94.3046 66.2658 55.654 85.1604 74.6726 36.8241 84.2936 43.4171
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 91.5806 85.3718 3.0394 87.8978 55.3373 87.5543 75.8581 67.734 44.6853 12.1771 71.5357 54.7764 66.6241 54.8619 98.8858 40.5832 86.7953 98.2587 5.5103 2.4632 57.5744 32.0915 27.7692 5.3771 12.5409 34.9927 9.5344 82.6513 83.2149 45.275 47.7296 29.1746 43.4298 32.7891 69.9802 31.2997 76.4061 78.8499 3.4211 83.2813 85.7962 39.4563 95.0096 86.3986 76.7794 22.1703 26.9563 3.4603 61.2842 50.504 84.7886 47.8487 63.4665 41.3237 39.8294 35.2356 76.248 76.189 49.7147 22.2188 95.8343 3.0478 41.0011 21.015 94.3046 66.2658 55.654 85.1604 74.6726 36.8241 84.2936 43.4171
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    openPercent : 91.5806    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    openPercent(72) = [91.5806, 85.3718, 3.0394, 87.8978, 55.3373, 87.5543, 75.8581, 67.734, 44.6853, 12.1771, 71.5357, 54.7764, 66.6241, 54.8619, 98.8858, 40.5832, 86.7953, 98.2587, 5.5103, 2.4632, 57.5744, 32.0915, 27.7692, 5.3771, 12.5409, 34.9927, 9.5344, 82.6513, 83.2149, 45.275, 47.7296, 29.1746, 43.4298, 32.7891, 69.9802, 31.2997, 76.4061, 78.8499, 3.4211, 83.2813, 85.7962, 39.4563, 95.0096, 86.3986, 76.7794, 22.1703, 26.9563, 3.4603, 61.2842, 50.504, 84.7886, 47.8487, 63.4665, 41.3237, 39.8294, 35.2356, 76.248, 76.189, 49.7147, 22.2188, 95.8343, 3.0478, 41.0011, 21.015, 94.3046, 66.2658, 55.654, 85.1604, 74.6726, 36.8241, 84.2936, 43.4171]    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
