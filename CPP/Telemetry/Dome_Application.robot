*** Settings ***
Documentation    Dome_Application communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
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
    Should Contain X Times    ${output}    azError : 1    9
    Should Contain X Times    ${output}    azPosition : 1    9
    Should Contain X Times    ${output}    azTarget : 1    9
    Should Contain X Times    ${output}    elevError : 1    9
    Should Contain X Times    ${output}    elevPosition : 1    9
    Should Contain X Times    ${output}    elevTarget : 1    9
    Should Contain X Times    ${output}    lvError : 1    1
    Should Contain X Times    ${output}    lvError : 2    1
    Should Contain X Times    ${output}    lvError : 3    1
    Should Contain X Times    ${output}    lvError : 4    1
    Should Contain X Times    ${output}    lvError : 5    1
    Should Contain X Times    ${output}    lvError : 6    1
    Should Contain X Times    ${output}    lvError : 7    1
    Should Contain X Times    ${output}    lvError : 8    1
    Should Contain X Times    ${output}    lvError : 9    1
    Should Contain X Times    ${output}    lvPosition : 1    1
    Should Contain X Times    ${output}    lvPosition : 2    1
    Should Contain X Times    ${output}    lvPosition : 3    1
    Should Contain X Times    ${output}    lvPosition : 4    1
    Should Contain X Times    ${output}    lvPosition : 5    1
    Should Contain X Times    ${output}    lvPosition : 6    1
    Should Contain X Times    ${output}    lvPosition : 7    1
    Should Contain X Times    ${output}    lvPosition : 8    1
    Should Contain X Times    ${output}    lvPosition : 9    1
    Should Contain X Times    ${output}    lvTarget : 1    1
    Should Contain X Times    ${output}    lvTarget : 2    1
    Should Contain X Times    ${output}    lvTarget : 3    1
    Should Contain X Times    ${output}    lvTarget : 4    1
    Should Contain X Times    ${output}    lvTarget : 5    1
    Should Contain X Times    ${output}    lvTarget : 6    1
    Should Contain X Times    ${output}    lvTarget : 7    1
    Should Contain X Times    ${output}    lvTarget : 8    1
    Should Contain X Times    ${output}    lvTarget : 9    1
    Should Contain X Times    ${output}    scrError : 1    9
    Should Contain X Times    ${output}    scrPosition : 1    9
    Should Contain X Times    ${output}    scrTarget : 1    9
