*** Settings ***
Documentation    Camera_GAS communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${component}    GAS
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
    Should Contain X Times    ${output}    Board_ID : 1    9
    Should Contain X Times    ${output}    Board_current : 1    1
    Should Contain X Times    ${output}    Board_current : 2    1
    Should Contain X Times    ${output}    Board_current : 3    1
    Should Contain X Times    ${output}    Board_current : 4    1
    Should Contain X Times    ${output}    Board_current : 5    1
    Should Contain X Times    ${output}    Board_current : 6    1
    Should Contain X Times    ${output}    Board_current : 7    1
    Should Contain X Times    ${output}    Board_current : 8    1
    Should Contain X Times    ${output}    Board_current : 9    1
    Should Contain X Times    ${output}    Board_temp : 1    1
    Should Contain X Times    ${output}    Board_temp : 2    1
    Should Contain X Times    ${output}    Board_temp : 3    1
    Should Contain X Times    ${output}    Board_temp : 4    1
    Should Contain X Times    ${output}    Board_temp : 5    1
    Should Contain X Times    ${output}    Board_temp : 6    1
    Should Contain X Times    ${output}    Board_temp : 7    1
    Should Contain X Times    ${output}    Board_temp : 8    1
    Should Contain X Times    ${output}    Board_temp : 9    1
    Should Contain X Times    ${output}    Board_voltage : 1    1
    Should Contain X Times    ${output}    Board_voltage : 2    1
    Should Contain X Times    ${output}    Board_voltage : 3    1
    Should Contain X Times    ${output}    Board_voltage : 4    1
    Should Contain X Times    ${output}    Board_voltage : 5    1
    Should Contain X Times    ${output}    Board_voltage : 6    1
    Should Contain X Times    ${output}    Board_voltage : 7    1
    Should Contain X Times    ${output}    Board_voltage : 8    1
    Should Contain X Times    ${output}    Board_voltage : 9    1
    Should Contain X Times    ${output}    CABAC_MUX : 1    1
    Should Contain X Times    ${output}    CABAC_MUX : 2    1
    Should Contain X Times    ${output}    CABAC_MUX : 3    1
    Should Contain X Times    ${output}    CABAC_MUX : 4    1
    Should Contain X Times    ${output}    CABAC_MUX : 5    1
    Should Contain X Times    ${output}    CABAC_MUX : 6    1
    Should Contain X Times    ${output}    CABAC_MUX : 7    1
    Should Contain X Times    ${output}    CABAC_MUX : 8    1
    Should Contain X Times    ${output}    CABAC_MUX : 9    1
    Should Contain X Times    ${output}    CCD_ID : 1    9
    Should Contain X Times    ${output}    CCD_temp : 1    9
    Should Contain X Times    ${output}    FPGACheckSum : 1    1
    Should Contain X Times    ${output}    FPGACheckSum : 2    1
    Should Contain X Times    ${output}    FPGACheckSum : 3    1
    Should Contain X Times    ${output}    FPGACheckSum : 4    1
    Should Contain X Times    ${output}    FPGACheckSum : 5    1
    Should Contain X Times    ${output}    FPGACheckSum : 6    1
    Should Contain X Times    ${output}    FPGACheckSum : 7    1
    Should Contain X Times    ${output}    FPGACheckSum : 8    1
    Should Contain X Times    ${output}    FPGACheckSum : 9    1
    Should Contain X Times    ${output}    REB_ID : 1    9
