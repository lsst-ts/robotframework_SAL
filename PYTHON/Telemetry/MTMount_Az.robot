*** Settings ***
Documentation    MTMount_Az communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    Az
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_${component}_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_${component}_Publisher.py

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Subscriber.
    ${input}=    Write    python ${subSystem}_${component}_Subscriber.py
    ${output}=    Read Until    subscriber ready
    Log    ${output}
    Should Be Equal    ${output}    ${subSystem}_${component} subscriber ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Publisher.
    ${input}=    Write    python ${subSystem}_${component}_Publisher.py
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :   10
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    10

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    Angle_Set = 1.0    10
    Should Contain X Times    ${list}    Angle_Actual = 1.0    10
    Should Contain X Times    ${list}    EncHead_Actual_1 = 1    10
    Should Contain X Times    ${list}    EncHead_Actual_2 = 1    10
    Should Contain X Times    ${list}    EncHead_Actual_3 = 1    10
    Should Contain X Times    ${list}    EncHead_Actual_4 = 1    10
    Should Contain X Times    ${list}    Vel_Set = 1.0    10
    Should Contain X Times    ${list}    Vel_Actual = 1.0    10
    Should Contain X Times    ${list}    Acc_Actual = 1.0    10
    Should Contain X Times    ${list}    Torque_Set = 1.0    10
    Should Contain X Times    ${list}    Axis_Status = 1    10
    Should Contain X Times    ${list}    Positive_Adjustable_Software_Limit = 1    10
    Should Contain X Times    ${list}    Negative_Adjustable_Software_Limit = 1    10
    Should Contain X Times    ${list}    Positive_Software_Limit = 1    10
    Should Contain X Times    ${list}    Negative_Software_Limit = 1    10
    Should Contain X Times    ${list}    Positive_Directional_Limit_Switch = 1    10
    Should Contain X Times    ${list}    Negative_Directional_Limit_Switch = 1    10
    Should Contain X Times    ${list}    Positive_Power_Off_Switch = 1    10
    Should Contain X Times    ${list}    Negative_Power_Off_Switch = 1    10
    Should Contain X Times    ${list}    Curr_Actual = 1.0    10
    Should Contain X Times    ${list}    Drive_Status = 1    10
