*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 74.338 9.7243 41.5709 25.2576 16.1928 25.5064 18.4191 84.9532 2.8554 38.4493 34.9936 13.8526 33.449 56.0518 4.0183 46.0216 96.0468 79.1458 50.8621 35.6454 51.8256 21.174 6.6936 46.1767 83.5089 82.8757 64.805 9.3806 51.6798 48.9585 81.331 83.3679 9.5979 52.5674 87.5975 28.2501 49.3929 6.0347 72.0945 28.005 97.6614 34.9995 87.5339 28.2116 34.0942 58.2243 48.1511 60.3587 15.239 35.712 70.5955 98.5061 64.4633 22.7112 14.2359 93.6305 76.4622 7.7559 3.4936 7.9708 13.3028 8.1954 79.9683 38.6284 18.925 35.458 2.9798 83.8098 33.2891 52.4394 8.6418 13.1898
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 74.338 9.7243 41.5709 25.2576 16.1928 25.5064 18.4191 84.9532 2.8554 38.4493 34.9936 13.8526 33.449 56.0518 4.0183 46.0216 96.0468 79.1458 50.8621 35.6454 51.8256 21.174 6.6936 46.1767 83.5089 82.8757 64.805 9.3806 51.6798 48.9585 81.331 83.3679 9.5979 52.5674 87.5975 28.2501 49.3929 6.0347 72.0945 28.005 97.6614 34.9995 87.5339 28.2116 34.0942 58.2243 48.1511 60.3587 15.239 35.712 70.5955 98.5061 64.4633 22.7112 14.2359 93.6305 76.4622 7.7559 3.4936 7.9708 13.3028 8.1954 79.9683 38.6284 18.925 35.458 2.9798 83.8098 33.2891 52.4394 8.6418 13.1898
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 74.338    1
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [74.338, 9.7243, 41.5709, 25.2576, 16.1928, 25.5064, 18.4191, 84.9532, 2.8554, 38.4493, 34.9936, 13.8526, 33.449, 56.0518, 4.0183, 46.0216, 96.0468, 79.1458, 50.8621, 35.6454, 51.8256, 21.174, 6.6936, 46.1767, 83.5089, 82.8757, 64.805, 9.3806, 51.6798, 48.9585, 81.331, 83.3679, 9.5979, 52.5674, 87.5975, 28.2501, 49.3929, 6.0347, 72.0945, 28.005, 97.6614, 34.9995, 87.5339, 28.2116, 34.0942, 58.2243, 48.1511, 60.3587, 15.239, 35.712, 70.5955, 98.5061, 64.4633, 22.7112, 14.2359, 93.6305, 76.4622, 7.7559, 3.4936, 7.9708, 13.3028, 8.1954, 79.9683, 38.6284, 18.925, 35.458, 2.9798, 83.8098, 33.2891, 52.4394, 8.6418, 13.1898]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
