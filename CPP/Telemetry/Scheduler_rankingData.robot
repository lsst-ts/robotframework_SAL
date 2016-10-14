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
    Should Contain X Times    ${output}    LST :    9
    Should Contain X Times    ${output}    MJD :    9
    Should Contain X Times    ${output}    date :    9
    Should Contain X Times    ${output}    dec :    9
    Should Contain X Times    ${output}    exposureTime :    9
    Should Contain X Times    ${output}    fieldId :    9
    Should Contain X Times    ${output}    filter :    9
    Should Contain X Times    ${output}    moonAlt :    9
    Should Contain X Times    ${output}    moonAz :    9
    Should Contain X Times    ${output}    moonDec :    9
    Should Contain X Times    ${output}    moonDistance :    9
    Should Contain X Times    ${output}    moonIllumination :    9
    Should Contain X Times    ${output}    moonRa :    9
    Should Contain X Times    ${output}    mountAltitude :    9
    Should Contain X Times    ${output}    mountAzimuth :    9
    Should Contain X Times    ${output}    observationNight :    9
    Should Contain X Times    ${output}    ra :    9
    Should Contain X Times    ${output}    rotatorAngle :    9
    Should Contain X Times    ${output}    seeing :    9
    Should Contain X Times    ${output}    skyAngle :    9
    Should Contain X Times    ${output}    skyBrightnessFilter :    9
    Should Contain X Times    ${output}    skyBrightnessV :    9
    Should Contain X Times    ${output}    slewTime :    9
    Should Contain X Times    ${output}    sunAlt :    9
    Should Contain X Times    ${output}    sunAz :    9
    Should Contain X Times    ${output}    sunElongation :    9
    Should Contain X Times    ${output}    transparency :    9
    Should Contain X Times    ${output}    visitTime :    9
    Should Contain X Times    ${output}    weatherHumidity :    9
    Should Contain X Times    ${output}    weatherWindDirection :    9
    Should Contain X Times    ${output}    weatherWindSpeed :    9
