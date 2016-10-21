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
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

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
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Subscriber.
    ${input}=    Write    ./sacpp_${subSystem}_sub
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain X Times    ${output}    observationId : 1    9
    Should Contain X Times    ${output}    observation_start_time : 1    9
    Should Contain X Times    ${output}    observation_start_mjd : 1    9
    Should Contain X Times    ${output}    observation_start_lst : 1    9
    Should Contain X Times    ${output}    night : 1    9
    Should Contain X Times    ${output}    targetId : 1    9
    Should Contain X Times    ${output}    fieldId : 1    9
    Should Contain X Times    ${output}    filter : LSST    9
    Should Contain X Times    ${output}    ra : 1    9
    Should Contain X Times    ${output}    dec : 1    9
    Should Contain X Times    ${output}    angle : 1    9
    Should Contain X Times    ${output}    altitude : 1    9
    Should Contain X Times    ${output}    azimuth : 1    9
    Should Contain X Times    ${output}    num_exposures : 1    9
    Should Contain X Times    ${output}    exposure_times : 1    1
    Should Contain X Times    ${output}    exposure_times : 2    1
    Should Contain X Times    ${output}    exposure_times : 3    1
    Should Contain X Times    ${output}    exposure_times : 4    1
    Should Contain X Times    ${output}    exposure_times : 5    1
    Should Contain X Times    ${output}    exposure_times : 6    1
    Should Contain X Times    ${output}    exposure_times : 7    1
    Should Contain X Times    ${output}    exposure_times : 8    1
    Should Contain X Times    ${output}    exposure_times : 9    1
    Should Contain X Times    ${output}    visit_time : 1    9
    Should Contain X Times    ${output}    sky_brightness : 1    9
    Should Contain X Times    ${output}    airmass : 1    9
    Should Contain X Times    ${output}    cloud : 1    9
    Should Contain X Times    ${output}    seeing_fwhm_500 : 1    9
    Should Contain X Times    ${output}    seeing_fwhm_geom : 1    9
    Should Contain X Times    ${output}    seeing_fwhm_eff : 1    9
    Should Contain X Times    ${output}    moon_ra : 1    9
    Should Contain X Times    ${output}    moon_dec : 1    9
    Should Contain X Times    ${output}    moon_alt : 1    9
    Should Contain X Times    ${output}    moon_az : 1    9
    Should Contain X Times    ${output}    moon_phase : 1    9
    Should Contain X Times    ${output}    moon_distance : 1    9
    Should Contain X Times    ${output}    sun_alt : 1    9
    Should Contain X Times    ${output}    sun_az : 1    9
    Should Contain X Times    ${output}    sun_ra : 1    9
    Should Contain X Times    ${output}    sun_dec : 1    9
    Should Contain X Times    ${output}    sun_elong : 1    9
