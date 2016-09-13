*** Settings ***
Documentation    Scheduler_target communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    target
${timeout}    30s
#${subOut}    ${subSystem}_${component}_sub.out
#${pubOut}    ${subSystem}_${component}_pub.out

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
    ${input}=    Write    ./sacpp_${subSystem}_sub    #|tee ${subOut}
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${subOut}

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub    #|tee ${pubOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${pubOut}

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read
    Log    ${output}
    Should Contain X Times    ${output}    targetId :    9
    Should Contain X Times    ${output}    fieldId :    9
    Should Contain X Times    ${output}    filter :    9
    Should Contain X Times    ${output}    request_time :    9
    Should Contain X Times    ${output}    ra :    9
    Should Contain X Times    ${output}    dec :    9
    Should Contain X Times    ${output}    angle :    9
    Should Contain X Times    ${output}    num_exposures :    9
    Should Contain X Times    ${output}    exposure_times :    9
    Should Contain X Times    ${output}    airmass :    9
    Should Contain X Times    ${output}    sky_brightness :    9
    Should Contain X Times    ${output}    slew_time :    9
    Should Contain X Times    ${output}    cost_bonus :    9
    Should Contain X Times    ${output}    prop_boost :    9
    Should Contain X Times    ${output}    rank :    9
    Should Contain X Times    ${output}    num_proposals :    9
    Should Contain X Times    ${output}    proposal_Ids :    9
    Should Contain X Times    ${output}    proposal_values :    9
    Should Contain X Times    ${output}    proposal_needs :    9
    Should Contain X Times    ${output}    proposal_bonuses :    9
    Should Contain X Times    ${output}    proposal_boosts :    9
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
