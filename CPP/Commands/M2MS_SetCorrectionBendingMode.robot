*** Settings ***
Documentation    M2MS_SetCorrectionBendingMode commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    SetCorrectionBendingMode
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 64.8689 30.7553 45.1647 22.4339 42.3623 29.0328 28.5573 29.6017 38.1115 35.5407 21.764 8.5721 39.6114 80.0276 42.9244 73.0919 40.1371 40.2724 69.1603 61.9467 59.7816 64.7309 80.365 50.9442 8.0522 51.6616 47.0501 85.4775 22.871 78.8989 45.908 48.9294 29.0767 44.2297 91.5354 95.7706 18.3654 31.7871 53.9698 60.8809 67.3725 25.2055 29.7378 49.8887 7.0337 89.0169 21.1416 68.2126 40.1626 44.8643 17.2358 33.5113 12.8854 65.2713 60.8709 22.1541 15.4062 84.3149 2.2334 13.5622 68.4419 3.1849 14.9412 6.273 24.6248 44.4011 30.461 72.9995 71.5033 85.3647 42.676 69.8649
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 timed out :

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 64.8689 30.7553 45.1647 22.4339 42.3623 29.0328 28.5573 29.6017 38.1115 35.5407 21.764 8.5721 39.6114 80.0276 42.9244 73.0919 40.1371 40.2724 69.1603 61.9467 59.7816 64.7309 80.365 50.9442 8.0522 51.6616 47.0501 85.4775 22.871 78.8989 45.908 48.9294 29.0767 44.2297 91.5354 95.7706 18.3654 31.7871 53.9698 60.8809 67.3725 25.2055 29.7378 49.8887 7.0337 89.0169 21.1416 68.2126 40.1626 44.8643 17.2358 33.5113 12.8854 65.2713 60.8709 22.1541 15.4062 84.3149 2.2334 13.5622 68.4419 3.1849 14.9412 6.273 24.6248 44.4011 30.461 72.9995 71.5033 85.3647 42.676 69.8649
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    Mode : 64.8689    1
    Should Contain    ${output}    === command SetCorrectionBendingMode issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command SetCorrectionBendingMode received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    Mode : 64.8689    1
    Should Contain X Times    ${output}    === [ackCommand_SetCorrectionBendingMode] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
