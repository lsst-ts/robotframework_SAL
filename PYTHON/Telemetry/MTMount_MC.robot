*** Settings ***
Documentation    MTMount_MC communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    MTMount
${component}    MC
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
    Should Contain X Times    ${list}    Pos_Set = 1.0    10
    Should Contain X Times    ${list}    Pos_Actual = 1.0    10
    Should Contain X Times    ${list}    Positive_Directional_Limit_Switch = 1    10
    Should Contain X Times    ${list}    Negative_Directional_Limit_Switch = 1    10
    Should Contain X Times    ${list}    Axis_Status = 1    10
    Should Contain X Times    ${list}    Curr_Actual_1 = 1.0    10
    Should Contain X Times    ${list}    Curr_Actual_2 = 1.0    10
    Should Contain X Times    ${list}    Curr_Actual_3 = 1.0    10
    Should Contain X Times    ${list}    Curr_Actual_4 = 1.0    10
    Should Contain X Times    ${list}    Drive_Status_1 = 1    10
    Should Contain X Times    ${list}    Drive_Status_2 = 1    10
    Should Contain X Times    ${list}    Drive_Status_3 = 1    10
    Should Contain X Times    ${list}    Drive_Status_4 = 1    10
