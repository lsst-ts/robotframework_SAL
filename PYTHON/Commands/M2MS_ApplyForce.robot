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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 77.3668 76.0968 41.9161 93.7867 93.5807 61.59 93.5793 44.1137 4.3786 29.5606 38.064 51.841 67.0541 39.672 17.884 72.49 25.4777 9.0212 74.2817 76.5679 68.382 54.6932 48.5121 58.8344 23.5611 61.0049 57.7089 6.5409 18.6929 35.5005 90.1198 9.222 66.4895 30.9259 26.5338 30.723 46.2639 62.8366 44.2118 51.6115 59.4472 22.5532 67.8896 96.2347 3.8021 61.8676 61.4484 35.3619 42.8428 15.6013 44.3246 34.541 22.0443 92.6189 57.8388 88.3763 63.5509 25.1905 26.9393 93.9923 89.7641 11.4301 28.5243 91.8213 8.5265 15.2717 32.5221 24.6063 31.9968 59.3728 26.6764 69.558
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 77.3668 76.0968 41.9161 93.7867 93.5807 61.59 93.5793 44.1137 4.3786 29.5606 38.064 51.841 67.0541 39.672 17.884 72.49 25.4777 9.0212 74.2817 76.5679 68.382 54.6932 48.5121 58.8344 23.5611 61.0049 57.7089 6.5409 18.6929 35.5005 90.1198 9.222 66.4895 30.9259 26.5338 30.723 46.2639 62.8366 44.2118 51.6115 59.4472 22.5532 67.8896 96.2347 3.8021 61.8676 61.4484 35.3619 42.8428 15.6013 44.3246 34.541 22.0443 92.6189 57.8388 88.3763 63.5509 25.1905 26.9393 93.9923 89.7641 11.4301 28.5243 91.8213 8.5265 15.2717 32.5221 24.6063 31.9968 59.3728 26.6764 69.558
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 77.3668    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [77.3668, 76.0968, 41.9161, 93.7867, 93.5807, 61.59, 93.5793, 44.1137, 4.3786, 29.5606, 38.064, 51.841, 67.0541, 39.672, 17.884, 72.49, 25.4777, 9.0212, 74.2817, 76.5679, 68.382, 54.6932, 48.5121, 58.8344, 23.5611, 61.0049, 57.7089, 6.5409, 18.6929, 35.5005, 90.1198, 9.222, 66.4895, 30.9259, 26.5338, 30.723, 46.2639, 62.8366, 44.2118, 51.6115, 59.4472, 22.5532, 67.8896, 96.2347, 3.8021, 61.8676, 61.4484, 35.3619, 42.8428, 15.6013, 44.3246, 34.541, 22.0443, 92.6189, 57.8388, 88.3763, 63.5509, 25.1905, 26.9393, 93.9923, 89.7641, 11.4301, 28.5243, 91.8213, 8.5265, 15.2717, 32.5221, 24.6063, 31.9968, 59.3728, 26.6764, 69.558]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
