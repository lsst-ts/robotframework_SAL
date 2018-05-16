*** Settings ***
Documentation    Scheduler_observatoryState communications tests.
Force Tags    python    Checking if skipped: scheduler
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    scheduler
${component}    observatoryState
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
    Should Contain X Times    ${list}    timestamp = 1.0    10
    Should Contain X Times    ${list}    pointing_ra = 1.0    10
    Should Contain X Times    ${list}    pointing_dec = 1.0    10
    Should Contain X Times    ${list}    pointing_angle = 1.0    10
    Should Contain X Times    ${list}    pointing_altitude = 1.0    10
    Should Contain X Times    ${list}    pointing_azimuth = 1.0    10
    Should Contain X Times    ${list}    pointing_pa = 1.0    10
    Should Contain X Times    ${list}    pointing_rot = 1.0    10
    Should Contain X Times    ${list}    tracking = 1    10
    Should Contain X Times    ${list}    telescope_altitude = 1.0    10
    Should Contain X Times    ${list}    telescope_azimuth = 1.0    10
    Should Contain X Times    ${list}    telescope_rotator = 1.0    10
    Should Contain X Times    ${list}    dome_altitude = 1.0    10
    Should Contain X Times    ${list}    dome_azimuth = 1.0    10
    Should Contain X Times    ${list}    filter_position = LSST    10
    Should Contain X Times    ${list}    filter_mounted = LSST    10
    Should Contain X Times    ${list}    filter_unmounted = LSST    10
