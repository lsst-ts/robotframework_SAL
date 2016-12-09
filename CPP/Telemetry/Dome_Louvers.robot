*** Settings ***
Documentation    Dome_Louvers communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${component}    Louvers
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}windSpeed : 9    1
