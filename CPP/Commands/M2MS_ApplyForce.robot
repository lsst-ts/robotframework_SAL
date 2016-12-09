*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.1888 51.4051 45.9052 24.1025 78.5831 55.3508 73.9054 7.8282 80.1746 42.033 56.5314 83.2543 62.2762 30.9453 32.4318 93.7826 84.7289 48.017 36.0763 14.0507 5.1463 49.3297 39.3558 10.7917 52.3156 86.31 90.8646 47.1271 99.7871 21.8102 38.4433 86.7 1.0222 2.8853 54.1384 43.8894 34.5094 20.1421 93.6578 47.442 97.1962 33.9669 40.0937 73.974 59.5638 41.7647 26.4712 73.2464 66.3752 2.5284 46.1917 10.6515 51.5339 21.9926 3.7077 56.6589 20.826 68.9921 63.0183 90.8373 52.5681 64.7003 38.1139 16.624 35.5549 77.4249 46.6853 61.7939 16.236 63.996 51.9788 16.3624
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.1888 51.4051 45.9052 24.1025 78.5831 55.3508 73.9054 7.8282 80.1746 42.033 56.5314 83.2543 62.2762 30.9453 32.4318 93.7826 84.7289 48.017 36.0763 14.0507 5.1463 49.3297 39.3558 10.7917 52.3156 86.31 90.8646 47.1271 99.7871 21.8102 38.4433 86.7 1.0222 2.8853 54.1384 43.8894 34.5094 20.1421 93.6578 47.442 97.1962 33.9669 40.0937 73.974 59.5638 41.7647 26.4712 73.2464 66.3752 2.5284 46.1917 10.6515 51.5339 21.9926 3.7077 56.6589 20.826 68.9921 63.0183 90.8373 52.5681 64.7003 38.1139 16.624 35.5549 77.4249 46.6853 61.7939 16.236 63.996 51.9788 16.3624
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 0.1888    1
    Should Contain    ${output}    === command ApplyForce issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForce received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetPoint : 0.1888    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
