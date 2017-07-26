*** Settings ***
Documentation    TCS_kernel_TrackRefSys communications tests.
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
${component}    kernel_TrackRefSys
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
    Should Contain X Times    ${list}    ae2mt(9) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]    10
    Should Contain X Times    ${list}    amprms(21) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]    10
    Should Contain X Times    ${list}    cst = 1.0    10
    Should Contain X Times    ${list}    diurab = 1.0    10
    Should Contain X Times    ${list}    hm = 1.0    10
    Should Contain X Times    ${list}    humid = 1.0    10
    Should Contain X Times    ${list}    press = 1.0    10
    Should Contain X Times    ${list}    refa = 1.0    10
    Should Contain X Times    ${list}    refb = 1.0    10
    Should Contain X Times    ${list}    sst = 1.0    10
    Should Contain X Times    ${list}    tdbj = 1.0    10
    Should Contain X Times    ${list}    temp = 1.0    10
    Should Contain X Times    ${list}    tlat = 1.0    10
    Should Contain X Times    ${list}    tlr = 1.0    10
    Should Contain X Times    ${list}    wavel = 1.0    10
