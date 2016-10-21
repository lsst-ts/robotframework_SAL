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
    Should Contain X Times    ${output}    LST : 1    9
    Should Contain X Times    ${output}    MJD : 1    9
    Should Contain X Times    ${output}    date : 1    9
    Should Contain X Times    ${output}    dec : 1    9
    Should Contain X Times    ${output}    exposureTime : 1    1
    Should Contain X Times    ${output}    exposureTime : 2    1
    Should Contain X Times    ${output}    exposureTime : 3    1
    Should Contain X Times    ${output}    exposureTime : 4    1
    Should Contain X Times    ${output}    exposureTime : 5    1
    Should Contain X Times    ${output}    exposureTime : 6    1
    Should Contain X Times    ${output}    exposureTime : 7    1
    Should Contain X Times    ${output}    exposureTime : 8    1
    Should Contain X Times    ${output}    exposureTime : 9    1
    Should Contain X Times    ${output}    fieldId : 1    9
    Should Contain X Times    ${output}    filter : LSST    9
    Should Contain X Times    ${output}    moonAlt : 1    9
    Should Contain X Times    ${output}    moonAz : 1    9
    Should Contain X Times    ${output}    moonDec : 1    9
    Should Contain X Times    ${output}    moonDistance : 1    9
    Should Contain X Times    ${output}    moonIllumination : 1    9
    Should Contain X Times    ${output}    moonRa : 1    9
    Should Contain X Times    ${output}    mountAltitude : 1    9
    Should Contain X Times    ${output}    mountAzimuth : 1    9
    Should Contain X Times    ${output}    observationNight : 1    9
    Should Contain X Times    ${output}    ra : 1    9
    Should Contain X Times    ${output}    rotatorAngle : 1    9
    Should Contain X Times    ${output}    seeing : 1    9
    Should Contain X Times    ${output}    skyAngle : 1    9
    Should Contain X Times    ${output}    skyBrightnessFilter : 1    9
    Should Contain X Times    ${output}    skyBrightnessV : 1    9
    Should Contain X Times    ${output}    slewTime : 1    9
    Should Contain X Times    ${output}    sunAlt : 1    9
    Should Contain X Times    ${output}    sunAz : 1    9
    Should Contain X Times    ${output}    sunElongation : 1    9
    Should Contain X Times    ${output}    transparency : 1    9
    Should Contain X Times    ${output}    visitTime : 1    9
    Should Contain X Times    ${output}    weatherHumidity : 1    9
    Should Contain X Times    ${output}    weatherWindDirection : 1    9
    Should Contain X Times    ${output}    weatherWindSpeed : 1    9
