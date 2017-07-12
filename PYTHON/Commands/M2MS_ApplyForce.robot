*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 37.6222 97.9634 37.6238 84.1016 42.4748 95.92 7.1628 60.2136 0.8498 12.7523 41.53 15.05 41.5096 47.4928 88.4444 65.2975 23.3105 18.8071 18.367 98.8127 28.5753 21.7021 20.4876 46.8011 91.7932 80.3266 68.6306 51.2565 73.6245 86.6935 83.9332 55.9318 30.5443 16.5363 41.4467 16.0325 17.0157 85.7831 17.5181 89.2472 74.6222 26.9993 36.3101 51.8345 3.6128 66.5227 15.3963 77.7265 16.6091 42.0687 31.0493 20.8329 37.869 18.2688 61.3394 20.7239 50.7181 34.4601 58.4485 83.717 36.8427 54.3607 45.2182 81.9981 68.2471 62.4151 41.5245 93.8958 79.6471 94.9373 40.3652 43.9512
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 37.6222 97.9634 37.6238 84.1016 42.4748 95.92 7.1628 60.2136 0.8498 12.7523 41.53 15.05 41.5096 47.4928 88.4444 65.2975 23.3105 18.8071 18.367 98.8127 28.5753 21.7021 20.4876 46.8011 91.7932 80.3266 68.6306 51.2565 73.6245 86.6935 83.9332 55.9318 30.5443 16.5363 41.4467 16.0325 17.0157 85.7831 17.5181 89.2472 74.6222 26.9993 36.3101 51.8345 3.6128 66.5227 15.3963 77.7265 16.6091 42.0687 31.0493 20.8329 37.869 18.2688 61.3394 20.7239 50.7181 34.4601 58.4485 83.717 36.8427 54.3607 45.2182 81.9981 68.2471 62.4151 41.5245 93.8958 79.6471 94.9373 40.3652 43.9512
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 37.6222    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [37.6222, 97.9634, 37.6238, 84.1016, 42.4748, 95.92, 7.1628, 60.2136, 0.8498, 12.7523, 41.53, 15.05, 41.5096, 47.4928, 88.4444, 65.2975, 23.3105, 18.8071, 18.367, 98.8127, 28.5753, 21.7021, 20.4876, 46.8011, 91.7932, 80.3266, 68.6306, 51.2565, 73.6245, 86.6935, 83.9332, 55.9318, 30.5443, 16.5363, 41.4467, 16.0325, 17.0157, 85.7831, 17.5181, 89.2472, 74.6222, 26.9993, 36.3101, 51.8345, 3.6128, 66.5227, 15.3963, 77.7265, 16.6091, 42.0687, 31.0493, 20.8329, 37.869, 18.2688, 61.3394, 20.7239, 50.7181, 34.4601, 58.4485, 83.717, 36.8427, 54.3607, 45.2182, 81.9981, 68.2471, 62.4151, 41.5245, 93.8958, 79.6471, 94.9373, 40.3652, 43.9512]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
