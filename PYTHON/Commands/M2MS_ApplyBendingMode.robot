*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -17407 -13441 17456 -14137 -5344 30259 -24376 24724 -20220 -17051 27488 -1014 15108 -19621 3221 -17248 -31276 -23282 13583 32324 -22563 -24546 2017 14511 18850 10776 7117 -21954 9238 6362 -5340 20690 91.0578 67.0421 0.5412 50.5129 15.538 28.11 31.1695 93.3109 17.4764 3.9983 86.894 21.5456 18.927 21.8798 60.5901 47.7442 58.161 5.7215 42.2621 66.1785 85.3839 13.4418 98.915 16.5516 27.8403 18.5061 57.9942 94.5759 90.1088 79.3013 94.9428 17.4671
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -17407 -13441 17456 -14137 -5344 30259 -24376 24724 -20220 -17051 27488 -1014 15108 -19621 3221 -17248 -31276 -23282 13583 32324 -22563 -24546 2017 14511 18850 10776 7117 -21954 9238 6362 -5340 20690 91.0578 67.0421 0.5412 50.5129 15.538 28.11 31.1695 93.3109 17.4764 3.9983 86.894 21.5456 18.927 21.8798 60.5901 47.7442 58.161 5.7215 42.2621 66.1785 85.3839 13.4418 98.915 16.5516 27.8403 18.5061 57.9942 94.5759 90.1088 79.3013 94.9428 17.4671
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -17407    1
    Should Contain X Times    ${output}    bendingModeValue : 91.0578    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-17407, -13441, 17456, -14137, -5344, 30259, -24376, 24724, -20220, -17051, 27488, -1014, 15108, -19621, 3221, -17248, -31276, -23282, 13583, 32324, -22563, -24546, 2017, 14511, 18850, 10776, 7117, -21954, 9238, 6362, -5340, 20690]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [91.0578, 67.0421, 0.5412, 50.5129, 15.538, 28.11, 31.1695, 93.3109, 17.4764, 3.9983, 86.894, 21.5456, 18.927, 21.8798, 60.5901, 47.7442, 58.161, 5.7215, 42.2621, 66.1785, 85.3839, 13.4418, 98.915, 16.5516, 27.8403, 18.5061, 57.9942, 94.5759, 90.1088, 79.3013, 94.9428, 17.4671]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
