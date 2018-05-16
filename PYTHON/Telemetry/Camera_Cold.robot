*** Settings ***
Documentation    Camera_Cold communications tests.
Force Tags    python    Checking if skipped: camera
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    Cold
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
    Should Contain X Times    ${list}    Compressor_load(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Compressor_speed(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Discharge_pressure(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Discharge_temp(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Flow_interlock(6) = [0, 1, 2, 3, 4, 5]    10
    Should Contain X Times    ${list}    Heater_current(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Heater_voltage(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Intake_flow(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Intake_pressure(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Intake_temp(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Ion_pump(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    Mech_pump(4) = [0, 1, 2, 3]    10
    Should Contain X Times    ${list}    Post_expansion_pressure(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Post_expansion_temp(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Pre_expansion_pressure(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    Pre_expansion_temp(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    RGA(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    Return_temp(6) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]    10
    Should Contain X Times    ${list}    UtilityRoom_temperature = 1.0    10
    Should Contain X Times    ${list}    Vacuum_gauge(5) = [0.0, 1.0, 2.0, 3.0, 4.0]    10
    Should Contain X Times    ${list}    Valve_status(6) = [0, 1, 2, 3, 4, 5]    10
