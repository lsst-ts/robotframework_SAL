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
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}LST :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MJD :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}date :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}dec :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonIllumination :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAltitude :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzimuth :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationNight :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotatorAngle :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightnessFilter :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightnessV :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunElongation :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}transparency :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitTime :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherHumidity :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherWindDirection :    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}weatherWindSpeed :    9
