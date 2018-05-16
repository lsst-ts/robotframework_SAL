*** Settings ***
Documentation    MTMount_Alt_OSS communications tests.
Force Tags    python    Checking if skipped: MTMount
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    MTMount
${component}    Alt_OSS
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
    Should Contain X Times    ${list}    Local_Remote = 1    10
    Should Contain X Times    ${list}    Floating = 1    10
    Should Contain X Times    ${list}    Cooling = 1    10
    Should Contain X Times    ${list}    Oil = 1    10
    Should Contain X Times    ${list}    Pump = 1    10
    Should Contain X Times    ${list}    Oil_Flow = 1.0    10
    Should Contain X Times    ${list}    Oil_Pressure = 1.0    10
    Should Contain X Times    ${list}    Oil_Temperature = 1.0    10
    Should Contain X Times    ${list}    Oil_Film = 1.0    10
    Should Contain X Times    ${list}    Oil_Filter_Pressure = 1.0    10
    Should Contain X Times    ${list}    Status = 1    10
