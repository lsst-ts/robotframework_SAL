*** Settings ***
Documentation    Scheduler_areaDistPropConfig communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    areaDistPropConfig
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
    Should Contain X Times    ${list}    name = LSST    10
    Should Contain X Times    ${list}    prop_id = 1    10
    Should Contain X Times    ${list}    twilight_boundary = 1.0    10
    Should Contain X Times    ${list}    delta_lst = 1.0    10
    Should Contain X Times    ${list}    dec_window = 1.0    10
    Should Contain X Times    ${list}    max_airmass = 1.0    10
    Should Contain X Times    ${list}    num_region_selections = 1    10
    Should Contain X Times    ${list}    region_types = LSST    10
    Should Contain X Times    ${list}    region_minimums(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    region_maximums(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    region_bounds(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    region_combiners = LSST    10
    Should Contain X Times    ${list}    num_exclusion_selections = 1    10
    Should Contain X Times    ${list}    exclusion_types = LSST    10
    Should Contain X Times    ${list}    exclusion_minimums(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    exclusion_maximums(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    exclusion_bounds(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    num_filters = 1    10
    Should Contain X Times    ${list}    filter_names = LSST    10
    Should Contain X Times    ${list}    num_visits(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    bright_limit(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    dark_limit(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    max_seeing(10) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]    10
    Should Contain X Times    ${list}    num_filter_exposures(10) = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]    10
    Should Contain X Times    ${list}    exposures(50) = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0]    10
    Should Contain X Times    ${list}    max_num_targets = 1    10
    Should Contain X Times    ${list}    accept_serendipity = 1    10
    Should Contain X Times    ${list}    accept_consecutive_visits = 1    10