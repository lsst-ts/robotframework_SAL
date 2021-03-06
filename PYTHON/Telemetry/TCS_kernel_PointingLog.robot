*** Settings ***
Documentation    TCS_kernel_PointingLog communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    kernel_PointingLog
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
    Should Contain X Times    ${list}    Aux(3) = [0.0, 1.0, 2.0]    10
    Should Contain X Times    ${list}    Casspa = 1.0    10
    Should Contain X Times    ${list}    Decl = 1.0    10
    Should Contain X Times    ${list}    Fl = 1.0    10
    Should Contain X Times    ${list}    Humid = 1.0    10
    Should Contain X Times    ${list}    Marked = 1    10
    Should Contain X Times    ${list}    Pitch = 1.0    10
    Should Contain X Times    ${list}    Press = 1.0    10
    Should Contain X Times    ${list}    Ra = 1.0    10
    Should Contain X Times    ${list}    Rcorr = 1.0    10
    Should Contain X Times    ${list}    Roll = 1.0    10
    Should Contain X Times    ${list}    Temp = 1.0    10
    Should Contain X Times    ${list}    Tlr = 1.0    10
    Should Contain X Times    ${list}    Wavel = 1.0    10
    Should Contain X Times    ${list}    Xr = 1.0    10
    Should Contain X Times    ${list}    Yr = 1.0    10
