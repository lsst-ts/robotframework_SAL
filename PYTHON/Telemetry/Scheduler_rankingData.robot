*** Settings ***
Documentation    Scheduler_rankingData communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    scheduler
${component}    rankingData
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
    Should Contain X Times    ${list}    LST = 1.0    10
    Should Contain X Times    ${list}    MJD = 1.0    10
    Should Contain X Times    ${list}    date = 1.0    10
    Should Contain X Times    ${list}    decl = 1.0    10
    Should Contain X Times    ${list}    exposureTime(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    fieldId = 1    10
    Should Contain X Times    ${list}    filter = LSST    10
    Should Contain X Times    ${list}    moonAlt = 1.0    10
    Should Contain X Times    ${list}    moonAz = 1.0    10
    Should Contain X Times    ${list}    moonDec = 1.0    10
    Should Contain X Times    ${list}    moonDistance = 1.0    10
    Should Contain X Times    ${list}    moonIllumination = 1.0    10
    Should Contain X Times    ${list}    moonRa = 1.0    10
    Should Contain X Times    ${list}    mountAltitude = 1.0    10
    Should Contain X Times    ${list}    mountAzimuth = 1.0    10
    Should Contain X Times    ${list}    observationNight = 1    10
    Should Contain X Times    ${list}    ra = 1.0    10
    Should Contain X Times    ${list}    rotatorAngle = 1.0    10
    Should Contain X Times    ${list}    seeing = 1.0    10
    Should Contain X Times    ${list}    skyAngle = 1.0    10
    Should Contain X Times    ${list}    skyBrightnessFilter = 1.0    10
    Should Contain X Times    ${list}    skyBrightnessV = 1.0    10
    Should Contain X Times    ${list}    slewTime = 1.0    10
    Should Contain X Times    ${list}    sunAlt = 1.0    10
    Should Contain X Times    ${list}    sunAz = 1.0    10
    Should Contain X Times    ${list}    sunElongation = 1.0    10
    Should Contain X Times    ${list}    transparency = 1.0    10
    Should Contain X Times    ${list}    visitTime = 1.0    10
    Should Contain X Times    ${list}    weatherHumidity = 1.0    10
    Should Contain X Times    ${list}    weatherWindDirection = 1.0    10
    Should Contain X Times    ${list}    weatherWindSpeed = 1.0    10
