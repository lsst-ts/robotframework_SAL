*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 10219 8264 25998 10057 27307 19217 32116 28676 2738 25611 23791 18741 25536 27352 9550 11100 25146 6063 30844 2549 28285 8245 10290 15450 31551 17266 32064 29244 2140 12701 11287 5219 6.0868 45.0199 16.8018 43.1191 74.8882 46.3279 66.0673 35.8804 32.9315 99.3327 30.666 29.6475 80.1198 58.3478 86.8047 97.3689 93.6628 84.1036 46.1348 45.6053 75.6994 70.0591 49.9097 67.0566 88.6883 32.2383 25.2325 92.4193 7.792 19.83 26.8312 56.5395
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 10219 8264 25998 10057 27307 19217 32116 28676 2738 25611 23791 18741 25536 27352 9550 11100 25146 6063 30844 2549 28285 8245 10290 15450 31551 17266 32064 29244 2140 12701 11287 5219 6.0868 45.0199 16.8018 43.1191 74.8882 46.3279 66.0673 35.8804 32.9315 99.3327 30.666 29.6475 80.1198 58.3478 86.8047 97.3689 93.6628 84.1036 46.1348 45.6053 75.6994 70.0591 49.9097 67.0566 88.6883 32.2383 25.2325 92.4193 7.792 19.83 26.8312 56.5395
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 10219    1
    Should Contain X Times    ${output}    bendingModeValue : 6.0868    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [10219, 8264, 25998, 10057, 27307, 19217, 32116, 28676, 2738, 25611, 23791, 18741, 25536, 27352, 9550, 11100, 25146, 6063, 30844, 2549, 28285, 8245, 10290, 15450, 31551, 17266, 32064, 29244, 2140, 12701, 11287, 5219]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [6.0868, 45.0199, 16.8018, 43.1191, 74.8882, 46.3279, 66.0673, 35.8804, 32.9315, 99.3327, 30.666, 29.6475, 80.1198, 58.3478, 86.8047, 97.3689, 93.6628, 84.1036, 46.1348, 45.6053, 75.6994, 70.0591, 49.9097, 67.0566, 88.6883, 32.2383, 25.2325, 92.4193, 7.792, 19.83, 26.8312, 56.5395]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
