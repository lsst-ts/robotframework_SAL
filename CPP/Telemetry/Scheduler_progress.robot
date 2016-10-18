*** Settings ***
Documentation    Scheduler_progress communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    progress
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
    Should Contain X Times    ${output}    completion : 1    1
    Should Contain X Times    ${output}    completion : 2    1
    Should Contain X Times    ${output}    completion : 3    1
    Should Contain X Times    ${output}    completion : 4    1
    Should Contain X Times    ${output}    completion : 5    1
    Should Contain X Times    ${output}    completion : 6    1
    Should Contain X Times    ${output}    completion : 7    1
    Should Contain X Times    ${output}    completion : 8    1
    Should Contain X Times    ${output}    completion : 9    1
    Should Contain X Times    ${output}    priority : 1    1
    Should Contain X Times    ${output}    priority : 2    1
    Should Contain X Times    ${output}    priority : 3    1
    Should Contain X Times    ${output}    priority : 4    1
    Should Contain X Times    ${output}    priority : 5    1
    Should Contain X Times    ${output}    priority : 6    1
    Should Contain X Times    ${output}    priority : 7    1
    Should Contain X Times    ${output}    priority : 8    1
    Should Contain X Times    ${output}    priority : 9    1
    Should Contain X Times    ${output}    projection : 1    1
    Should Contain X Times    ${output}    projection : 2    1
    Should Contain X Times    ${output}    projection : 3    1
    Should Contain X Times    ${output}    projection : 4    1
    Should Contain X Times    ${output}    projection : 5    1
    Should Contain X Times    ${output}    projection : 6    1
    Should Contain X Times    ${output}    projection : 7    1
    Should Contain X Times    ${output}    projection : 8    1
    Should Contain X Times    ${output}    projection : 9    1
    Should Contain X Times    ${output}    taskid : 1    1
    Should Contain X Times    ${output}    taskid : 2    1
    Should Contain X Times    ${output}    taskid : 3    1
    Should Contain X Times    ${output}    taskid : 4    1
    Should Contain X Times    ${output}    taskid : 5    1
    Should Contain X Times    ${output}    taskid : 6    1
    Should Contain X Times    ${output}    taskid : 7    1
    Should Contain X Times    ${output}    taskid : 8    1
    Should Contain X Times    ${output}    taskid : 9    1
