*** Settings ***
Documentation    M1M3_HardpointActuatorData communications tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointActuatorData
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
    Should Contain X Times    ${list}    Timestamp = 1.0    10
    Should Contain X Times    ${list}    StepsQueued(6) = [0, 1, 2, 3, 4, 5]    10
    Should Contain X Times    ${list}    StepsCommanded(6) = [0, 1, 2, 3, 4, 5]    10
    Should Contain X Times    ${list}    MeasuredForce(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Encoder(6) = [0, 1, 2, 3, 4, 5]    10
    Should Contain X Times    ${list}    Displacement(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Fx = 1.0    10
    Should Contain X Times    ${list}    Fy = 1.0    10
    Should Contain X Times    ${list}    Fz = 1.0    10
    Should Contain X Times    ${list}    Mx = 1.0    10
    Should Contain X Times    ${list}    My = 1.0    10
    Should Contain X Times    ${list}    Mz = 1.0    10
    Should Contain X Times    ${list}    ForceMagnitude = 1.0    10
    Should Contain X Times    ${list}    XPosition = 1.0    10
    Should Contain X Times    ${list}    YPosition = 1.0    10
    Should Contain X Times    ${list}    ZPosition = 1.0    10
    Should Contain X Times    ${list}    XRotation = 1.0    10
    Should Contain X Times    ${list}    YRotation = 1.0    10
    Should Contain X Times    ${list}    ZRotation = 1.0    10
