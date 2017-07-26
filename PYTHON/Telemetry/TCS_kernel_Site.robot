*** Settings ***
Documentation    TCS_kernel_Site communications tests.
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
${component}    kernel_Site
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
    Should Contain X Times    ${list}    Amprms(21) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]    10
    Should Contain X Times    ${list}    Aoprms(15) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0]    10
    Should Contain X Times    ${list}    Daz = 1.0    10
    Should Contain X Times    ${list}    Diurab = 1.0    10
    Should Contain X Times    ${list}    Elong = 1.0    10
    Should Contain X Times    ${list}    Lat = 1.0    10
    Should Contain X Times    ${list}    Refa = 1.0    10
    Should Contain X Times    ${list}    Refb = 1.0    10
    Should Contain X Times    ${list}    St0 = 1.0    10
    Should Contain X Times    ${list}    T0 = 1.0    10
    Should Contain X Times    ${list}    Tt0 = 1.0    10
    Should Contain X Times    ${list}    Ttj = 1.0    10
    Should Contain X Times    ${list}    Ttmtai = 1.0    10
    Should Contain X Times    ${list}    Uau = 1.0    10
    Should Contain X Times    ${list}    Ukm = 1.0    10
    Should Contain X Times    ${list}    Vau = 1.0    10
    Should Contain X Times    ${list}    Vkm = 1.0    10
    Should Contain X Times    ${list}    delat = 1.0    10
    Should Contain X Times    ${list}    delut = 1.0    10
    Should Contain X Times    ${list}    elongm = 1.0    10
    Should Contain X Times    ${list}    hm = 1.0    10
    Should Contain X Times    ${list}    latm = 1.0    10
    Should Contain X Times    ${list}    tai = 1.0    10
    Should Contain X Times    ${list}    ttmtat = 1.0    10
    Should Contain X Times    ${list}    xpm = 1.0    10
    Should Contain X Times    ${list}    ypm = 1.0    10
