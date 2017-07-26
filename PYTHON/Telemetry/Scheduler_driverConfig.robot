*** Settings ***
Documentation    Scheduler_driverConfig communications tests.
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
${component}    driverConfig
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
    Should Contain X Times    ${list}    coadd_values = 1    10
    Should Contain X Times    ${list}    time_balancing = 1    10
    Should Contain X Times    ${list}    timecost_time_max = 1.0    10
    Should Contain X Times    ${list}    timecost_time_ref = 1.0    10
    Should Contain X Times    ${list}    timecost_cost_ref = 1.0    10
    Should Contain X Times    ${list}    timecost_weight = 1.0    10
    Should Contain X Times    ${list}    filtercost_weight = 1.0    10
    Should Contain X Times    ${list}    night_boundary = 1.0    10
    Should Contain X Times    ${list}    new_moon_phase_threshold = 1.0    10
    Should Contain X Times    ${list}    ignore_sky_brightness = 1    10
    Should Contain X Times    ${list}    ignore_airmass = 1    10
    Should Contain X Times    ${list}    ignore_clouds = 1    10
    Should Contain X Times    ${list}    ignore_seeing = 1    10
