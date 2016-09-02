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
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 7.4724 55.1537 4.1546 93.4634 39.3203 40.1623 44.0639 20.7214 4.8574 84.4056 11.5584 94.1694 2.4611 62.1485 59.8246 43.1314 72.8512 4.5824 60.791 44.8218 50.0582 55.7091 1.5644 48.9356 25.7795 58.6754 53.828 28.8061 94.3946 54.2005 32.6087 81.1771 18.0909 24.537 92.1025 15.2788 67.0718 18.0973 64.8429 55.1479 23.4242 30.8084 79.6127 3.4553 59.8692 52.3856 44.7438 81.0434 81.931 87.5437 86.3513 99.4865 49.0774 5.6411 88.8784 1.7858 93.0902 11.5146 71.7404 34.3998 63.6067 52.6595 75.2081 60.4476 48.4336 1.4507 22.4751 80.8339 2.6429 76.1414 18.3843 52.6224
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 7.4724 55.1537 4.1546 93.4634 39.3203 40.1623 44.0639 20.7214 4.8574 84.4056 11.5584 94.1694 2.4611 62.1485 59.8246 43.1314 72.8512 4.5824 60.791 44.8218 50.0582 55.7091 1.5644 48.9356 25.7795 58.6754 53.828 28.8061 94.3946 54.2005 32.6087 81.1771 18.0909 24.537 92.1025 15.2788 67.0718 18.0973 64.8429 55.1479 23.4242 30.8084 79.6127 3.4553 59.8692 52.3856 44.7438 81.0434 81.931 87.5437 86.3513 99.4865 49.0774 5.6411 88.8784 1.7858 93.0902 11.5146 71.7404 34.3998 63.6067 52.6595 75.2081 60.4476 48.4336 1.4507 22.4751 80.8339 2.6429 76.1414 18.3843 52.6224
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    Mode : 7.4724    1
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
    Should Contain X Times    ${output}    Mode : 7.4724    1
    Should Contain X Times    ${output}    === [ackCommand_SetCorrectionBendingMode] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
