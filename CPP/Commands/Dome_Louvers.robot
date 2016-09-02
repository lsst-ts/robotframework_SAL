*** Settings ***
Documentation    Dome_Louvers commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${component}    Louvers
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.8527 58.9387 82.5645 92.922 9.0948 35.0253 96.1381 3.7309 58.1598 30.1681 64.456 53.1574 4.1428 97.975 13.9097 58.1373 96.1761 90.3516 78.9785 95.0117 96.997 38.3303 49.461 8.7132 45.3495 48.5245 50.1114 20.0656 37.0189 77.2123 74.7024 66.8438 87.4293 83.6981 69.6993 28.845 96.4292 92.9342 87.8872 16.9454 30.0829 77.3814 20.2391 71.7391 8.7406 68.6152 64.0405 74.224 51.4543 69.1426 78.208 15.6427 63.1631 49.389 40.7359 70.6148 15.876 6.911 45.2904 20.3962 35.4289 54.4566 58.6946 64.7805 25.6165 35.1397 19.3165 38.7308 4.8232 6.1039 59.5513 37.8715
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.8527 58.9387 82.5645 92.922 9.0948 35.0253 96.1381 3.7309 58.1598 30.1681 64.456 53.1574 4.1428 97.975 13.9097 58.1373 96.1761 90.3516 78.9785 95.0117 96.997 38.3303 49.461 8.7132 45.3495 48.5245 50.1114 20.0656 37.0189 77.2123 74.7024 66.8438 87.4293 83.6981 69.6993 28.845 96.4292 92.9342 87.8872 16.9454 30.0829 77.3814 20.2391 71.7391 8.7406 68.6152 64.0405 74.224 51.4543 69.1426 78.208 15.6427 63.1631 49.389 40.7359 70.6148 15.876 6.911 45.2904 20.3962 35.4289 54.4566 58.6946 64.7805 25.6165 35.1397 19.3165 38.7308 4.8232 6.1039 59.5513 37.8715
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : louvers    1
    Should Contain X Times    ${output}    property : position    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    openPercent : 25.8527    1
    Should Contain    ${output}    === command Louvers issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command Louvers received =
    Should Contain    ${output}    device : louvers
    Should Contain    ${output}    property : position
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    openPercent : 25.8527    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
