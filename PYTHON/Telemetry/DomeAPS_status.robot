*** Settings ***
Documentation    DomeAPS_status communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    domeAPS
${component}    status
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
    Should Contain X Times    ${list}    position_error = 1.0    10
    Should Contain X Times    ${list}    position_actual = 1.0    10
    Should Contain X Times    ${list}    position_cmd = 1.0    10
    Should Contain X Times    ${list}    drive_torque_actual(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    drive_torque_error(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    drive_torque_cmd(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    drive_current_actual(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    drive_temp_actual(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    resolver_head_raw(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    resolver_head_calibrated(4) = [0.0, 1.0, 2.0, 3.0]    10
