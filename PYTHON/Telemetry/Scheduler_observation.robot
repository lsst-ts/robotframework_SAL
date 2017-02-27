*** Settings ***
Documentation    Scheduler_observation communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    observation
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    Should Contain X Times    ${list}    observationId = 1    10
    Should Contain X Times    ${list}    observation_start_time = 1.0    10
    Should Contain X Times    ${list}    observation_start_mjd = 1.0    10
    Should Contain X Times    ${list}    observation_start_lst = 1.0    10
    Should Contain X Times    ${list}    night = 1    10
    Should Contain X Times    ${list}    targetId = 1    10
    Should Contain X Times    ${list}    fieldId = 1    10
    Should Contain X Times    ${list}    groupId = 1    10
    Should Contain X Times    ${list}    filter = LSST    10
    Should Contain X Times    ${list}    num_proposals = 1    10
    Should Contain X Times    ${list}    proposal_Ids(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    ra = 1.0    10
    Should Contain X Times    ${list}    dec = 1.0    10
    Should Contain X Times    ${list}    angle = 1.0    10
    Should Contain X Times    ${list}    altitude = 1.0    10
    Should Contain X Times    ${list}    azimuth = 1.0    10
    Should Contain X Times    ${list}    num_exposures = 1    10
    Should Contain X Times    ${list}    exposure_times(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    visit_time = 1.0    10
    Should Contain X Times    ${list}    sky_brightness = 1.0    10
    Should Contain X Times    ${list}    airmass = 1.0    10
    Should Contain X Times    ${list}    cloud = 1.0    10
    Should Contain X Times    ${list}    seeing_fwhm_500 = 1.0    10
    Should Contain X Times    ${list}    seeing_fwhm_geom = 1.0    10
    Should Contain X Times    ${list}    seeing_fwhm_eff = 1.0    10
    Should Contain X Times    ${list}    five_sigma_depth = 1.0    10
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
    Should Contain X Times    ${list}    solar_elong = 1.0    10
