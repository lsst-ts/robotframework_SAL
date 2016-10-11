*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
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
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 27364 28769 32150 24606 24690 32057 9552 25148 17110 20468 19616 28720 23 13533 6861 23961 21637 12802 20010 27696 5943 2311 27695 10197 19879 23092 20327 5842 4862 17226 32508 1275 59.1184 48.0082 85.661 82.076 47.7146 78.7704 72.9654 72.8913 46.9532 63.5893 36.7884 17.9083 65.9168 25.2813 54.0751 28.8575 59.7948 16.0601 68.5373 40.8404 95.9904 14.4153 21.2629 45.3275 49.9405 38.5471 9.62 96.0251 80.0976 53.8202 90.0153 96.6496
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 timed out :

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 27364 28769 32150 24606 24690 32057 9552 25148 17110 20468 19616 28720 23 13533 6861 23961 21637 12802 20010 27696 5943 2311 27695 10197 19879 23092 20327 5842 4862 17226 32508 1275 59.1184 48.0082 85.661 82.076 47.7146 78.7704 72.9654 72.8913 46.9532 63.5893 36.7884 17.9083 65.9168 25.2813 54.0751 28.8575 59.7948 16.0601 68.5373 40.8404 95.9904 14.4153 21.2629 45.3275 49.9405 38.5471 9.62 96.0251 80.0976 53.8202 90.0153 96.6496
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 27364    1
    Should Contain X Times    ${output}    bendingModeValue : 59.1184    1
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [27364, 28769, 32150, 24606, 24690, 32057, 9552, 25148, 17110, 20468, 19616, 28720, 23, 13533, 6861, 23961, 21637, 12802, 20010, 27696, 5943, 2311, 27695, 10197, 19879, 23092, 20327, 5842, 4862, 17226, 32508, 1275]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [59.1184, 48.0082, 85.661, 82.076, 47.7146, 78.7704, 72.9654, 72.8913, 46.9532, 63.5893, 36.7884, 17.9083, 65.9168, 25.2813, 54.0751, 28.8575, 59.7948, 16.0601, 68.5373, 40.8404, 95.9904, 14.4153, 21.2629, 45.3275, 49.9405, 38.5471, 9.62, 96.0251, 80.0976, 53.8202, 90.0153, 96.6496]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
