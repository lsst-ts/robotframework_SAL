*** Settings ***
Documentation    TCS_kernel_Site communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    tcs
${component}    kernel_Site
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
    Should Contain X Times    ${output}    Amprms :    9
    Should Contain X Times    ${output}    Aoprms :    9
    Should Contain X Times    ${output}    Daz :    9
    Should Contain X Times    ${output}    Diurab :    9
    Should Contain X Times    ${output}    Elong :    9
    Should Contain X Times    ${output}    Lat :    9
    Should Contain X Times    ${output}    Refa :    9
    Should Contain X Times    ${output}    Refb :    9
    Should Contain X Times    ${output}    St0 :    9
    Should Contain X Times    ${output}    T0 :    9
    Should Contain X Times    ${output}    Tt0 :    9
    Should Contain X Times    ${output}    Ttj :    9
    Should Contain X Times    ${output}    Ttmtai :    9
    Should Contain X Times    ${output}    Uau :    9
    Should Contain X Times    ${output}    Ukm :    9
    Should Contain X Times    ${output}    Vau :    9
    Should Contain X Times    ${output}    Vkm :    9
    Should Contain X Times    ${output}    delat :    9
    Should Contain X Times    ${output}    delut :    9
    Should Contain X Times    ${output}    elongm :    9
    Should Contain X Times    ${output}    hm :    9
    Should Contain X Times    ${output}    latm :    9
    Should Contain X Times    ${output}    tai :    9
    Should Contain X Times    ${output}    ttmtat :    9
    Should Contain X Times    ${output}    xpm :    9
    Should Contain X Times    ${output}    ypm :    9
