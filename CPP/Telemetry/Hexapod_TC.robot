*** Settings ***
Documentation    Hexapod_TC communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    TC
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
    Should Contain X Times    ${output}    error : 1    1
    Should Contain X Times    ${output}    error : 2    1
    Should Contain X Times    ${output}    error : 3    1
    Should Contain X Times    ${output}    error : 4    1
    Should Contain X Times    ${output}    error : 5    1
    Should Contain X Times    ${output}    error : 6    1
    Should Contain X Times    ${output}    error : 7    1
    Should Contain X Times    ${output}    error : 8    1
    Should Contain X Times    ${output}    error : 9    1
    Should Contain X Times    ${output}    setpoint : 1    1
    Should Contain X Times    ${output}    setpoint : 2    1
    Should Contain X Times    ${output}    setpoint : 3    1
    Should Contain X Times    ${output}    setpoint : 4    1
    Should Contain X Times    ${output}    setpoint : 5    1
    Should Contain X Times    ${output}    setpoint : 6    1
    Should Contain X Times    ${output}    setpoint : 7    1
    Should Contain X Times    ${output}    setpoint : 8    1
    Should Contain X Times    ${output}    setpoint : 9    1
    Should Contain X Times    ${output}    status : 1    1
    Should Contain X Times    ${output}    status : 2    1
    Should Contain X Times    ${output}    status : 3    1
    Should Contain X Times    ${output}    status : 4    1
    Should Contain X Times    ${output}    status : 5    1
    Should Contain X Times    ${output}    status : 6    1
    Should Contain X Times    ${output}    status : 7    1
    Should Contain X Times    ${output}    status : 8    1
    Should Contain X Times    ${output}    status : 9    1
    Should Contain X Times    ${output}    temperature : 1    1
    Should Contain X Times    ${output}    temperature : 2    1
    Should Contain X Times    ${output}    temperature : 3    1
    Should Contain X Times    ${output}    temperature : 4    1
    Should Contain X Times    ${output}    temperature : 5    1
    Should Contain X Times    ${output}    temperature : 6    1
    Should Contain X Times    ${output}    temperature : 7    1
    Should Contain X Times    ${output}    temperature : 8    1
    Should Contain X Times    ${output}    temperature : 9    1
