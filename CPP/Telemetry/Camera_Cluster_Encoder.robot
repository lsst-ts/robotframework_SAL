*** Settings ***
Documentation    Camera_Cluster_Encoder communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${component}    Cluster_Encoder
${timeout}    30s
#${subOut}    ${subSystem}_${component}_sub.out
#${pubOut}    ${subSystem}_${component}_pub.out

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
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
    Login    ${UserName}    ${PassWord}
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
    ${input}=    Write    ./sacpp_${subSystem}_sub    #|tee ${subOut}
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${subOut}

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub    #|tee ${pubOut}
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9
    #File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/${pubOut}

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read Until    PSF : 0
    Log    ${output}
    Should Contain X Times    ${output}    [GetSample] message received :1    10
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9
    Should Contain X Times    ${output}    revCode \ :    10
    Should Contain X Times    ${output}    sndStamp \ :    10
    Should Contain X Times    ${output}    origin \ :    10
    Should Contain X Times    ${output}    host \ :    10
    Should Contain X Times    ${output}    Image_SD :    10
    Should Contain X Times    ${output}    Image_mean :    10
    Should Contain X Times    ${output}    Overscan_SD :    10
    Should Contain X Times    ${output}    Overscan_mean :    10
    Should Contain X Times    ${output}    PSF :    10
