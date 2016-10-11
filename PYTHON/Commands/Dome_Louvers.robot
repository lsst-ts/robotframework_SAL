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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 52.8539 60.2461 52.2738 62.8637 9.3698 57.1945 65.2461 44.984 59.2345 86.062 55.1247 79.1395 86.9515 50.0154 46.5873 45.1983 73.2544 11.9582 75.2396 8.0793 98.8515 30.7849 27.6635 7.2741 77.1744 0.9658 18.9967 77.5473 71.5621 70.8096 39.992 52.738 1.2372 35.7531 59.8317 63.2967 16.7636 66.2801 54.7502 92.4276 25.8382 21.3505 80.147 71.0699 66.1144 78.8937 3.2547 57.1853 49.8919 25.3553 53.625 40.7386 55.425 81.8102 91.7818 40.7309 50.4203 9.7314 11.0456 86.3598 52.7894 71.7521 25.2293 65.9102 88.3152 53.509 45.0549 26.1493 50.7925 36.7573 30.0919 26.164
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 timed out :

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 52.8539 60.2461 52.2738 62.8637 9.3698 57.1945 65.2461 44.984 59.2345 86.062 55.1247 79.1395 86.9515 50.0154 46.5873 45.1983 73.2544 11.9582 75.2396 8.0793 98.8515 30.7849 27.6635 7.2741 77.1744 0.9658 18.9967 77.5473 71.5621 70.8096 39.992 52.738 1.2372 35.7531 59.8317 63.2967 16.7636 66.2801 54.7502 92.4276 25.8382 21.3505 80.147 71.0699 66.1144 78.8937 3.2547 57.1853 49.8919 25.3553 53.625 40.7386 55.425 81.8102 91.7818 40.7309 50.4203 9.7314 11.0456 86.3598 52.7894 71.7521 25.2293 65.9102 88.3152 53.509 45.0549 26.1493 50.7925 36.7573 30.0919 26.164
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    openPercent : 52.8539    1
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    openPercent(72) = [52.8539, 60.2461, 52.2738, 62.8637, 9.3698, 57.1945, 65.2461, 44.984, 59.2345, 86.062, 55.1247, 79.1395, 86.9515, 50.0154, 46.5873, 45.1983, 73.2544, 11.9582, 75.2396, 8.0793, 98.8515, 30.7849, 27.6635, 7.2741, 77.1744, 0.9658, 18.9967, 77.5473, 71.5621, 70.8096, 39.992, 52.738, 1.2372, 35.7531, 59.8317, 63.2967, 16.7636, 66.2801, 54.7502, 92.4276, 25.8382, 21.3505, 80.147, 71.0699, 66.1144, 78.8937, 3.2547, 57.1853, 49.8919, 25.3553, 53.625, 40.7386, 55.425, 81.8102, 91.7818, 40.7309, 50.4203, 9.7314, 11.0456, 86.3598, 52.7894, 71.7521, 25.2293, 65.9102, 88.3152, 53.509, 45.0549, 26.1493, 50.7925, 36.7573, 30.0919, 26.164]    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
