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
    Should Contain X Times    ${output}    name :    9
    Should Contain X Times    ${output}    prop_id :    9
    Should Contain X Times    ${output}    twilight_boundary :    9
    Should Contain X Times    ${output}    delta_lst :    9
    Should Contain X Times    ${output}    dec_window :    9
    Should Contain X Times    ${output}    max_airmass :    9
    Should Contain X Times    ${output}    max_cloud :    9
    Should Contain X Times    ${output}    num_region_selections :    9
    Should Contain X Times    ${output}    region_types :    9
    Should Contain X Times    ${output}    region_minimums :    9
    Should Contain X Times    ${output}    region_maximums :    9
    Should Contain X Times    ${output}    region_bounds :    9
    Should Contain X Times    ${output}    region_combiners :    9
    Should Contain X Times    ${output}    num_exclusion_selections :    9
    Should Contain X Times    ${output}    exclusion_types :    9
    Should Contain X Times    ${output}    exclusion_minimums :    9
    Should Contain X Times    ${output}    exclusion_maximums :    9
    Should Contain X Times    ${output}    exclusion_bounds :    9
    Should Contain X Times    ${output}    num_filters :    9
    Should Contain X Times    ${output}    filter_names :    9
    Should Contain X Times    ${output}    num_visits :    9
    Should Contain X Times    ${output}    bright_limit :    9
    Should Contain X Times    ${output}    dark_limit :    9
    Should Contain X Times    ${output}    max_seeing :    9
    Should Contain X Times    ${output}    num_filter_exposures :    9
    Should Contain X Times    ${output}    exposures :    9
    Should Contain X Times    ${output}    max_num_targets :    9
    Should Contain X Times    ${output}    accept_serendipity :    9
    Should Contain X Times    ${output}    accept_consecutive_visits :    9
