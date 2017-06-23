*** Settings ***
Documentation    Camera_Cryo communications tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${component}    Cryo
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
    Should Contain X Times    ${list}    Cold_temperature(3) = [0.0, 1.0, 2.0]    10
    Should Contain X Times    ${list}    Compressor = 1.0    10
    Should Contain X Times    ${list}    Compressor_speed(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Cryo_temperature(12) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0]    10
    Should Contain X Times    ${list}    Discharge_pressure(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Discharge_temp(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Flow_interlock(2) = [0, 1]    10
    Should Contain X Times    ${list}    Heater_current(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Heater_voltage(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Intake_flow(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Intake_pressure(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Intake_temp(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Post_expansion_pressure(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Post_expansion_temp(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Pre_expansion_pressure(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Pre_expansion_temp(2) = [0.0, 1.0]    10
    Should Contain X Times    ${list}    Return_temp(2) = [0.0, 1.0]    10
