*** Settings ***
Documentation    Scheduler_slewConfig communications tests.
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
${component}    slewConfig
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
    Should Contain X Times    ${list}    prereq_domalt = LSST    10
    Should Contain X Times    ${list}    prereq_domaz = LSST    10
    Should Contain X Times    ${list}    prereq_domazsettle = LSST    10
    Should Contain X Times    ${list}    prereq_telalt = LSST    10
    Should Contain X Times    ${list}    prereq_telaz = LSST    10
    Should Contain X Times    ${list}    prereq_telopticsopenloop = LSST    10
    Should Contain X Times    ${list}    prereq_telopticsclosedloop = LSST    10
    Should Contain X Times    ${list}    prereq_telsettle = LSST    10
    Should Contain X Times    ${list}    prereq_telrot = LSST    10
    Should Contain X Times    ${list}    prereq_filter = LSST    10
    Should Contain X Times    ${list}    prereq_exposures = LSST    10
    Should Contain X Times    ${list}    prereq_readout = LSST    10
    Should Contain X Times    ${list}    prereq_adc = LSST    10
    Should Contain X Times    ${list}    prereq_ins_optics = LSST    10
    Should Contain X Times    ${list}    prereq_guider_pos = LSST    10
    Should Contain X Times    ${list}    prereq_guider_adq = LSST    10
