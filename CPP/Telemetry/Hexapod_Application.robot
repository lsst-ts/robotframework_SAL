*** Settings ***
Documentation    Hexapod_Application communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    Application
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
    Should Contain X Times    ${output}    Demand : 1    1
    Should Contain X Times    ${output}    Demand : 2    1
    Should Contain X Times    ${output}    Demand : 3    1
    Should Contain X Times    ${output}    Demand : 4    1
    Should Contain X Times    ${output}    Demand : 5    1
    Should Contain X Times    ${output}    Demand : 6    1
    Should Contain X Times    ${output}    Demand : 7    1
    Should Contain X Times    ${output}    Demand : 8    1
    Should Contain X Times    ${output}    Demand : 9    1
    Should Contain X Times    ${output}    Error : 1    1
    Should Contain X Times    ${output}    Error : 2    1
    Should Contain X Times    ${output}    Error : 3    1
    Should Contain X Times    ${output}    Error : 4    1
    Should Contain X Times    ${output}    Error : 5    1
    Should Contain X Times    ${output}    Error : 6    1
    Should Contain X Times    ${output}    Error : 7    1
    Should Contain X Times    ${output}    Error : 8    1
    Should Contain X Times    ${output}    Error : 9    1
    Should Contain X Times    ${output}    Position : 1    1
    Should Contain X Times    ${output}    Position : 2    1
    Should Contain X Times    ${output}    Position : 3    1
    Should Contain X Times    ${output}    Position : 4    1
    Should Contain X Times    ${output}    Position : 5    1
    Should Contain X Times    ${output}    Position : 6    1
    Should Contain X Times    ${output}    Position : 7    1
    Should Contain X Times    ${output}    Position : 8    1
    Should Contain X Times    ${output}    Position : 9    1
