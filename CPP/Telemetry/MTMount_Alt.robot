*** Settings ***
Documentation    MTMount_Alt communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    Alt
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
    ${output}=    Read Until    Drive_Status : 0
    Log    ${output}
    Should Contain X Times    ${output}    [GetSample] message received :1    10
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9
    Should Contain X Times    ${output}    revCode \ :    10
    Should Contain X Times    ${output}    sndStamp \ :    10
    Should Contain X Times    ${output}    origin \ :    10
    Should Contain X Times    ${output}    host \ :    10
    Should Contain X Times    ${output}    Angle_Set :    10
    Should Contain X Times    ${output}    Angle_Actual :    10
    Should Contain X Times    ${output}    EncHead_Actual_1 :    10
    Should Contain X Times    ${output}    EncHead_Actual_2 :    10
    Should Contain X Times    ${output}    EncHead_Actual_3 :    10
    Should Contain X Times    ${output}    EncHead_Actual_4 :    10
    Should Contain X Times    ${output}    Vel_Set :    10
    Should Contain X Times    ${output}    Vel_Actual :    10
    Should Contain X Times    ${output}    Acc_Actual :    10
    Should Contain X Times    ${output}    Torque_Set :    10
    Should Contain X Times    ${output}    Axis_Status :    10
    Should Contain X Times    ${output}    Positive_Adjustable_Software_Limit :    10
    Should Contain X Times    ${output}    Negative_Adjustable_Software_Limit :    10
    Should Contain X Times    ${output}    Positive_Operational_Directional_Limit_Switch :    10
    Should Contain X Times    ${output}    Negative_Operational_Directional_Limit_Switch :    10
    Should Contain X Times    ${output}    Positive_Software_Limit :    10
    Should Contain X Times    ${output}    Negative_Software_Limit :    10
    Should Contain X Times    ${output}    Positive_Directional_Limit_Switch :    10
    Should Contain X Times    ${output}    Negative_Directional_Limit_Switch :    10
    Should Contain X Times    ${output}    Positive_Power_Off_Switch :    10
    Should Contain X Times    ${output}    Negative_Power_Off_Switch :    10
    Should Contain X Times    ${output}    Curr_Actual :    10
    Should Contain X Times    ${output}    Drive_Status :    10
