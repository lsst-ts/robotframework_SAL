*** Settings ***
Documentation    Scheduler_slewConfig communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    slewConfig
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
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_domalt : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_domaz : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_domazsettle : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telalt : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telaz : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telopticsopenloop : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telopticsclosedloop : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telsettle : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_telrot : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_filter : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_exposures : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_readout : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_adc : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_ins_optics : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_guider_pos : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereq_guider_adq : LSST    9
