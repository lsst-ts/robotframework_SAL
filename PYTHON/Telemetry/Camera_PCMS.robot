*** Settings ***
Documentation    Camera_PCMS communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${component}    PCMS
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
    Should Contain X Times    ${list}    Bias_Status = 1    10
    Should Contain X Times    ${list}    Bias_current = 1.0    10
    Should Contain X Times    ${list}    Bias_voltage = 1.0    10
    Should Contain X Times    ${list}    Clock_Status = 1    10
    Should Contain X Times    ${list}    Clock_current = 1.0    10
    Should Contain X Times    ${list}    Clock_voltage = 1.0    10
    Should Contain X Times    ${list}    FPGA_Status = 1    10
    Should Contain X Times    ${list}    FPGA_current = 1.0    10
    Should Contain X Times    ${list}    FPGA_voltage = 1.0    10
    Should Contain X Times    ${list}    Low_Status = 1    10
    Should Contain X Times    ${list}    Low_current = 1.0    10
    Should Contain X Times    ${list}    Low_voltage = 1.0    10
    Should Contain X Times    ${list}    OD_Status = 1    10
    Should Contain X Times    ${list}    OD_current = 1.0    10
    Should Contain X Times    ${list}    OD_voltage = 1.0    10
    Should Contain X Times    ${list}    REB_ID = 1    10
