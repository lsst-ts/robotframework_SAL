*** Settings ***
Documentation    Scheduler_target communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    target
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python

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
    Should Contain X Times    ${list}    targetId = 1    10
    Should Contain X Times    ${list}    fieldId = 1    10
    Should Contain X Times    ${list}    filter = LSST    10
    Should Contain X Times    ${list}    request_time = 1.0    10
    Should Contain X Times    ${list}    request_mjd = 1.0    10
    Should Contain X Times    ${list}    ra = 1.0    10
    Should Contain X Times    ${list}    dec = 1.0    10
    Should Contain X Times    ${list}    angle = 1.0    10
    Should Contain X Times    ${list}    num_exposures = 1    10
    Should Contain X Times    ${list}    exposure_times(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    airmass = 1.0    10
    Should Contain X Times    ${list}    sky_brightness = 1.0    10
    Should Contain X Times    ${list}    cloud = 1.0    10
    Should Contain X Times    ${list}    seeing = 1.0    10
    Should Contain X Times    ${list}    slew_time = 1.0    10
    Should Contain X Times    ${list}    cost_bonus = 1.0    10
    Should Contain X Times    ${list}    prop_boost = 1.0    10
    Should Contain X Times    ${list}    rank = 1.0    10
    Should Contain X Times    ${list}    num_proposals = 1    10
    Should Contain X Times    ${list}    proposal_Ids(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    proposal_values(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    proposal_needs(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    proposal_bonuses(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    proposal_boosts(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    moon_ra = 1.0    10
    Should Contain X Times    ${list}    moon_dec = 1.0    10
    Should Contain X Times    ${list}    moon_alt = 1.0    10
    Should Contain X Times    ${list}    moon_az = 1.0    10
    Should Contain X Times    ${list}    moon_phase = 1.0    10
    Should Contain X Times    ${list}    moon_distance = 1.0    10
    Should Contain X Times    ${list}    sun_alt = 1.0    10
    Should Contain X Times    ${list}    sun_az = 1.0    10
    Should Contain X Times    ${list}    sun_ra = 1.0    10
    Should Contain X Times    ${list}    sun_dec = 1.0    10
    Should Contain X Times    ${list}    sun_elong = 1.0    10
