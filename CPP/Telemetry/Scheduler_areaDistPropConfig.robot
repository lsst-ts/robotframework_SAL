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
    Should Contain X Times    ${output}    name : LSST    9
    Should Contain X Times    ${output}    prop_id : 1    9
    Should Contain X Times    ${output}    twilight_boundary : 1    9
    Should Contain X Times    ${output}    delta_lst : 1    9
    Should Contain X Times    ${output}    dec_window : 1    9
    Should Contain X Times    ${output}    max_airmass : 1    9
    Should Contain X Times    ${output}    max_cloud : 1    9
    Should Contain X Times    ${output}    num_region_selections : 1    9
    Should Contain X Times    ${output}    region_types : LSST    9
    Should Contain X Times    ${output}    region_minimums : 1    1
    Should Contain X Times    ${output}    region_minimums : 2    1
    Should Contain X Times    ${output}    region_minimums : 3    1
    Should Contain X Times    ${output}    region_minimums : 4    1
    Should Contain X Times    ${output}    region_minimums : 5    1
    Should Contain X Times    ${output}    region_minimums : 6    1
    Should Contain X Times    ${output}    region_minimums : 7    1
    Should Contain X Times    ${output}    region_minimums : 8    1
    Should Contain X Times    ${output}    region_minimums : 9    1
    Should Contain X Times    ${output}    region_maximums : 1    1
    Should Contain X Times    ${output}    region_maximums : 2    1
    Should Contain X Times    ${output}    region_maximums : 3    1
    Should Contain X Times    ${output}    region_maximums : 4    1
    Should Contain X Times    ${output}    region_maximums : 5    1
    Should Contain X Times    ${output}    region_maximums : 6    1
    Should Contain X Times    ${output}    region_maximums : 7    1
    Should Contain X Times    ${output}    region_maximums : 8    1
    Should Contain X Times    ${output}    region_maximums : 9    1
    Should Contain X Times    ${output}    region_bounds : 1    1
    Should Contain X Times    ${output}    region_bounds : 2    1
    Should Contain X Times    ${output}    region_bounds : 3    1
    Should Contain X Times    ${output}    region_bounds : 4    1
    Should Contain X Times    ${output}    region_bounds : 5    1
    Should Contain X Times    ${output}    region_bounds : 6    1
    Should Contain X Times    ${output}    region_bounds : 7    1
    Should Contain X Times    ${output}    region_bounds : 8    1
    Should Contain X Times    ${output}    region_bounds : 9    1
    Should Contain X Times    ${output}    region_combiners : LSST    9
    Should Contain X Times    ${output}    num_exclusion_selections : 1    9
    Should Contain X Times    ${output}    exclusion_types : LSST    9
    Should Contain X Times    ${output}    exclusion_minimums : 1    1
    Should Contain X Times    ${output}    exclusion_minimums : 2    1
    Should Contain X Times    ${output}    exclusion_minimums : 3    1
    Should Contain X Times    ${output}    exclusion_minimums : 4    1
    Should Contain X Times    ${output}    exclusion_minimums : 5    1
    Should Contain X Times    ${output}    exclusion_minimums : 6    1
    Should Contain X Times    ${output}    exclusion_minimums : 7    1
    Should Contain X Times    ${output}    exclusion_minimums : 8    1
    Should Contain X Times    ${output}    exclusion_minimums : 9    1
    Should Contain X Times    ${output}    exclusion_maximums : 1    1
    Should Contain X Times    ${output}    exclusion_maximums : 2    1
    Should Contain X Times    ${output}    exclusion_maximums : 3    1
    Should Contain X Times    ${output}    exclusion_maximums : 4    1
    Should Contain X Times    ${output}    exclusion_maximums : 5    1
    Should Contain X Times    ${output}    exclusion_maximums : 6    1
    Should Contain X Times    ${output}    exclusion_maximums : 7    1
    Should Contain X Times    ${output}    exclusion_maximums : 8    1
    Should Contain X Times    ${output}    exclusion_maximums : 9    1
    Should Contain X Times    ${output}    exclusion_bounds : 1    1
    Should Contain X Times    ${output}    exclusion_bounds : 2    1
    Should Contain X Times    ${output}    exclusion_bounds : 3    1
    Should Contain X Times    ${output}    exclusion_bounds : 4    1
    Should Contain X Times    ${output}    exclusion_bounds : 5    1
    Should Contain X Times    ${output}    exclusion_bounds : 6    1
    Should Contain X Times    ${output}    exclusion_bounds : 7    1
    Should Contain X Times    ${output}    exclusion_bounds : 8    1
    Should Contain X Times    ${output}    exclusion_bounds : 9    1
    Should Contain X Times    ${output}    num_filters : 1    9
    Should Contain X Times    ${output}    filter_names : LSST    9
    Should Contain X Times    ${output}    num_visits : 1    1
    Should Contain X Times    ${output}    num_visits : 2    1
    Should Contain X Times    ${output}    num_visits : 3    1
    Should Contain X Times    ${output}    num_visits : 4    1
    Should Contain X Times    ${output}    num_visits : 5    1
    Should Contain X Times    ${output}    num_visits : 6    1
    Should Contain X Times    ${output}    num_visits : 7    1
    Should Contain X Times    ${output}    num_visits : 8    1
    Should Contain X Times    ${output}    num_visits : 9    1
    Should Contain X Times    ${output}    bright_limit : 1    1
    Should Contain X Times    ${output}    bright_limit : 2    1
    Should Contain X Times    ${output}    bright_limit : 3    1
    Should Contain X Times    ${output}    bright_limit : 4    1
    Should Contain X Times    ${output}    bright_limit : 5    1
    Should Contain X Times    ${output}    bright_limit : 6    1
    Should Contain X Times    ${output}    bright_limit : 7    1
    Should Contain X Times    ${output}    bright_limit : 8    1
    Should Contain X Times    ${output}    bright_limit : 9    1
    Should Contain X Times    ${output}    dark_limit : 1    1
    Should Contain X Times    ${output}    dark_limit : 2    1
    Should Contain X Times    ${output}    dark_limit : 3    1
    Should Contain X Times    ${output}    dark_limit : 4    1
    Should Contain X Times    ${output}    dark_limit : 5    1
    Should Contain X Times    ${output}    dark_limit : 6    1
    Should Contain X Times    ${output}    dark_limit : 7    1
    Should Contain X Times    ${output}    dark_limit : 8    1
    Should Contain X Times    ${output}    dark_limit : 9    1
    Should Contain X Times    ${output}    max_seeing : 1    1
    Should Contain X Times    ${output}    max_seeing : 2    1
    Should Contain X Times    ${output}    max_seeing : 3    1
    Should Contain X Times    ${output}    max_seeing : 4    1
    Should Contain X Times    ${output}    max_seeing : 5    1
    Should Contain X Times    ${output}    max_seeing : 6    1
    Should Contain X Times    ${output}    max_seeing : 7    1
    Should Contain X Times    ${output}    max_seeing : 8    1
    Should Contain X Times    ${output}    max_seeing : 9    1
    Should Contain X Times    ${output}    num_filter_exposures : 1    1
    Should Contain X Times    ${output}    num_filter_exposures : 2    1
    Should Contain X Times    ${output}    num_filter_exposures : 3    1
    Should Contain X Times    ${output}    num_filter_exposures : 4    1
    Should Contain X Times    ${output}    num_filter_exposures : 5    1
    Should Contain X Times    ${output}    num_filter_exposures : 6    1
    Should Contain X Times    ${output}    num_filter_exposures : 7    1
    Should Contain X Times    ${output}    num_filter_exposures : 8    1
    Should Contain X Times    ${output}    num_filter_exposures : 9    1
    Should Contain X Times    ${output}    exposures : 1    1
    Should Contain X Times    ${output}    exposures : 2    1
    Should Contain X Times    ${output}    exposures : 3    1
    Should Contain X Times    ${output}    exposures : 4    1
    Should Contain X Times    ${output}    exposures : 5    1
    Should Contain X Times    ${output}    exposures : 6    1
    Should Contain X Times    ${output}    exposures : 7    1
    Should Contain X Times    ${output}    exposures : 8    1
    Should Contain X Times    ${output}    exposures : 9    1
    Should Contain X Times    ${output}    max_num_targets : 1    9
    Should Contain X Times    ${output}    accept_serendipity : 1    9
    Should Contain X Times    ${output}    accept_consecutive_visits : 1    9
