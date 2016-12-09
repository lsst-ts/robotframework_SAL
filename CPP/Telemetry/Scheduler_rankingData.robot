*** Settings ***
Documentation    Scheduler_rankingData communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    rankingData
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
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}LST : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MJD : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}date : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}dec : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : LSST    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonIllumination : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAltitude : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzimuth : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationNight : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotatorAngle : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightnessFilter : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightnessV : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunElongation : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}transparency : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitTime : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherHumidity : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherWindDirection : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherWindSpeed : 1    9
