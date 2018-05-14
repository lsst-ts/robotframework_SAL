*** Settings ***
Documentation    AtCamera_WREB communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    WREB
${timeout}    30s

*** Test Cases ***
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
    Should Contain X Times    ${list}    CKPSH_V = 1.0    10
    Should Contain X Times    ${list}    CKPOV = 1.0    10
    Should Contain X Times    ${list}    OGOV = 1.0    10
    Should Contain X Times    ${list}    Temp1 = 1.0    10
    Should Contain X Times    ${list}    Temp2 = 1.0    10
    Should Contain X Times    ${list}    Temp3 = 1.0    10
    Should Contain X Times    ${list}    Temp4 = 1.0    10
    Should Contain X Times    ${list}    Temp5 = 1.0    10
    Should Contain X Times    ${list}    Temp6 = 1.0    10
    Should Contain X Times    ${list}    Atemp0U = 1.0    10
    Should Contain X Times    ${list}    Atemp0L = 1.0    10
    Should Contain X Times    ${list}    CCDtemp0 = 1.0    10
    Should Contain X Times    ${list}    RTDtemp = 1.0    10
    Should Contain X Times    ${list}    DigPS_V = 1.0    10
    Should Contain X Times    ${list}    DigPS_I = 1.0    10
    Should Contain X Times    ${list}    AnaPS_V = 1.0    10
    Should Contain X Times    ${list}    AnaPS_I = 1.0    10
    Should Contain X Times    ${list}    ClkHPS_V = 1.0    10
    Should Contain X Times    ${list}    ClkHPS_I = 1.0    10
    Should Contain X Times    ${list}    ODPS_V = 1.0    10
    Should Contain X Times    ${list}    ODPS_I = 1.0    10
    Should Contain X Times    ${list}    HtrPS_V = 1.0    10
    Should Contain X Times    ${list}    HtrPS_I = 1.0    10
    Should Contain X Times    ${list}    Power = 1.0    10
    Should Contain X Times    ${list}    SCKU_V = 1.0    10
    Should Contain X Times    ${list}    SCKL_V = 1.0    10
    Should Contain X Times    ${list}    RGU_V = 1.0    10
    Should Contain X Times    ${list}    RGL_V = 1.0    10
    Should Contain X Times    ${list}    CKS0V = 1.0    10
    Should Contain X Times    ${list}    RG0V = 1.0    10
    Should Contain X Times    ${list}    OD0V = 1.0    10
    Should Contain X Times    ${list}    RD0V = 1.0    10
    Should Contain X Times    ${list}    GD0V = 1.0    10
    Should Contain X Times    ${list}    OD0I = 1.0    10
