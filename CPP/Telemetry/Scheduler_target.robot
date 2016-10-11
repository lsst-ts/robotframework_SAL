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
	#${str}=    Remove String    ${output}    \ \ \ \ \
	#Log    ${str}
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}request_time :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}dec :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}num_exposures :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure_times :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sky_brightness :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}slew_time :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}cost_bonus :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prop_boost :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}rank :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}num_proposals :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_Ids :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_values :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_needs :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_bonuses :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposal_boosts :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_ra :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_dec :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_alt :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_az :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_phase :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moon_distance :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_alt :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_az :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_ra :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_dec :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sun_elong :    9
