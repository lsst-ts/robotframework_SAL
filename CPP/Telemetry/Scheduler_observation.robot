*** Settings ***
Documentation    Scheduler_observation communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    scheduler
${component}    observation
${timeout}    30s

*** Test Cases ***
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
    ${output}=    Read Until    [Subscriber] Ready ...
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
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observation_start_time : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observation_start_mjd : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observation_start_lst : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}night : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}num_proposals : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}num_exposures : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}visit_time : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sky_brightness : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloud : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing_fwhm_500 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing_fwhm_geom : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing_fwhm_eff : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}five_sigma_depth : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_ra : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_dec : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_alt : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_az : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_phase : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_distance : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_alt : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_az : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_ra : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_dec : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}solar_elong : 1    9
