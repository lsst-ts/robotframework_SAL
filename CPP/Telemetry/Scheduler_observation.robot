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
    Should Contain X Times    ${output}    observationId :    9
    Should Contain X Times    ${output}    observation_start_time :    9
    Should Contain X Times    ${output}    observation_start_mjd :    9
    Should Contain X Times    ${output}    observation_start_lst :    9
    Should Contain X Times    ${output}    night :    9
    Should Contain X Times    ${output}    targetId :    9
    Should Contain X Times    ${output}    fieldId :    9
    Should Contain X Times    ${output}    filter :    9
    Should Contain X Times    ${output}    ra :    9
    Should Contain X Times    ${output}    dec :    9
    Should Contain X Times    ${output}    angle :    9
    Should Contain X Times    ${output}    altitude :    9
    Should Contain X Times    ${output}    azimuth :    9
    Should Contain X Times    ${output}    num_exposures :    9
    Should Contain X Times    ${output}    exposure_times :    9
    Should Contain X Times    ${output}    visit_time :    9
    Should Contain X Times    ${output}    sky_brightness :    9
    Should Contain X Times    ${output}    airmass :    9
    Should Contain X Times    ${output}    cloud :    9
    Should Contain X Times    ${output}    seeing_fwhm_500 :    9
    Should Contain X Times    ${output}    seeing_fwhm_geom :    9
    Should Contain X Times    ${output}    seeing_fwhm_eff :    9
    Should Contain X Times    ${output}    moon_ra :    9
    Should Contain X Times    ${output}    moon_dec :    9
    Should Contain X Times    ${output}    moon_alt :    9
    Should Contain X Times    ${output}    moon_az :    9
    Should Contain X Times    ${output}    moon_phase :    9
    Should Contain X Times    ${output}    moon_distance :    9
    Should Contain X Times    ${output}    sun_alt :    9
    Should Contain X Times    ${output}    sun_az :    9
    Should Contain X Times    ${output}    sun_ra :    9
    Should Contain X Times    ${output}    sun_dec :    9
    Should Contain X Times    ${output}    sun_elong :    9
