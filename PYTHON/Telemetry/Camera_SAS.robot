*** Settings ***
Documentation    Camera_SAS communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    SAS
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
    Should Contain X Times    ${list}    Board_ID = 1    10
    Should Contain X Times    ${list}    Board_current(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    Board_temp(12) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0]    10
    Should Contain X Times    ${list}    Board_voltage(4) = [0.0, 1.0, 2.0, 3.0]    10
    Should Contain X Times    ${list}    CABAC_MUX(12) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]    10
    Should Contain X Times    ${list}    CCD_ID(3) = [0, 1, 2]    10
    Should Contain X Times    ${list}    CCD_temp(3) = [0, 1, 2]    10
    Should Contain X Times    ${list}    FPGACheckSum(6) = [0, 1, 2, 3, 4, 5]    10
    Should Contain X Times    ${list}    REB_ID = 1    10
