*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 76.9893 39.1277 89.14 94.2927 47.2204 8.4738 63.7955 37.5003 5.6494 46.5128 54.3525 61.3762 73.4826 89.8901 4.5372 67.9754 45.9887 83.1286 9.525 75.192 32.2947 40.1736 51.3936 57.699 31.6908 85.3862 66.8648 74.5803 74.5889 10.8291 98.1763 70.0189 0.3371 91.0492 32.3942 31.8632 80.0808 11.4684 28.1921 68.1693 7.4403 2.137 17.4422 4.9901 79.9999 84.4164 87.0372 90.4452 76.5595 31.3669 19.0724 16.2074 14.8301 20.42 69.5557 0.5425 79.065 63.4586 9.8974 73.4212 72.2101 27.7861 76.8461 84.2865 77.684 55.0777 96.8228 67.321 6.5202 57.3393 26.0848 83.5913
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 76.9893 39.1277 89.14 94.2927 47.2204 8.4738 63.7955 37.5003 5.6494 46.5128 54.3525 61.3762 73.4826 89.8901 4.5372 67.9754 45.9887 83.1286 9.525 75.192 32.2947 40.1736 51.3936 57.699 31.6908 85.3862 66.8648 74.5803 74.5889 10.8291 98.1763 70.0189 0.3371 91.0492 32.3942 31.8632 80.0808 11.4684 28.1921 68.1693 7.4403 2.137 17.4422 4.9901 79.9999 84.4164 87.0372 90.4452 76.5595 31.3669 19.0724 16.2074 14.8301 20.42 69.5557 0.5425 79.065 63.4586 9.8974 73.4212 72.2101 27.7861 76.8461 84.2865 77.684 55.0777 96.8228 67.321 6.5202 57.3393 26.0848 83.5913
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 76.9893    1
    Should Contain    ${output}    === command ApplyForce issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForce received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetPoint : 76.9893    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
