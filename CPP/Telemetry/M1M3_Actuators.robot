*** Settings ***
Documentation    M1M3_Actuators communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m1m3
${component}    Actuators
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
    Should Contain X Times    ${output}    cyltemp : 1    1
    Should Contain X Times    ${output}    cyltemp : 2    1
    Should Contain X Times    ${output}    cyltemp : 3    1
    Should Contain X Times    ${output}    cyltemp : 4    1
    Should Contain X Times    ${output}    cyltemp : 5    1
    Should Contain X Times    ${output}    cyltemp : 6    1
    Should Contain X Times    ${output}    cyltemp : 7    1
    Should Contain X Times    ${output}    cyltemp : 8    1
    Should Contain X Times    ${output}    cyltemp : 9    1
    Should Contain X Times    ${output}    envtemp : 1    1
    Should Contain X Times    ${output}    envtemp : 2    1
    Should Contain X Times    ${output}    envtemp : 3    1
    Should Contain X Times    ${output}    envtemp : 4    1
    Should Contain X Times    ${output}    envtemp : 5    1
    Should Contain X Times    ${output}    envtemp : 6    1
    Should Contain X Times    ${output}    envtemp : 7    1
    Should Contain X Times    ${output}    envtemp : 8    1
    Should Contain X Times    ${output}    envtemp : 9    1
    Should Contain X Times    ${output}    error : 1    1
    Should Contain X Times    ${output}    error : 2    1
    Should Contain X Times    ${output}    error : 3    1
    Should Contain X Times    ${output}    error : 4    1
    Should Contain X Times    ${output}    error : 5    1
    Should Contain X Times    ${output}    error : 6    1
    Should Contain X Times    ${output}    error : 7    1
    Should Contain X Times    ${output}    error : 8    1
    Should Contain X Times    ${output}    error : 9    1
    Should Contain X Times    ${output}    lvdtcorr : 1    1
    Should Contain X Times    ${output}    lvdtcorr : 2    1
    Should Contain X Times    ${output}    lvdtcorr : 3    1
    Should Contain X Times    ${output}    lvdtcorr : 4    1
    Should Contain X Times    ${output}    lvdtcorr : 5    1
    Should Contain X Times    ${output}    lvdtcorr : 6    1
    Should Contain X Times    ${output}    lvdtcorr : 7    1
    Should Contain X Times    ${output}    lvdtcorr : 8    1
    Should Contain X Times    ${output}    lvdtcorr : 9    1
    Should Contain X Times    ${output}    position : 1    1
    Should Contain X Times    ${output}    position : 2    1
    Should Contain X Times    ${output}    position : 3    1
    Should Contain X Times    ${output}    position : 4    1
    Should Contain X Times    ${output}    position : 5    1
    Should Contain X Times    ${output}    position : 6    1
    Should Contain X Times    ${output}    position : 7    1
    Should Contain X Times    ${output}    position : 8    1
    Should Contain X Times    ${output}    position : 9    1
    Should Contain X Times    ${output}    pressure : 1    1
    Should Contain X Times    ${output}    pressure : 2    1
    Should Contain X Times    ${output}    pressure : 3    1
    Should Contain X Times    ${output}    pressure : 4    1
    Should Contain X Times    ${output}    pressure : 5    1
    Should Contain X Times    ${output}    pressure : 6    1
    Should Contain X Times    ${output}    pressure : 7    1
    Should Contain X Times    ${output}    pressure : 8    1
    Should Contain X Times    ${output}    pressure : 9    1
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
