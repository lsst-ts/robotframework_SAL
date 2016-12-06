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
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
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
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 21858 28265 10862 9688 11848 16955 18021 487 28028 22512 4238 20821 21022 19051 25781 19505 16818 8278 12106 16448 19409 13350 14557 17065 5614 18214 15652 26542 28697 10739 15369 2702 78.8129 89.4026 43.7827 31.3387 58.1891 34.8023 18.2675 30.2676 71.107 73.5694 40.8238 76.228 79.6676 23.1316 79.5105 7.561 79.9219 72.9459 11.1812 5.6358 22.3735 44.2011 78.7325 62.3119 7.839 96.6915 98.0761 85.731 22.5041 2.2817 57.1286 59.8993
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 21858 28265 10862 9688 11848 16955 18021 487 28028 22512 4238 20821 21022 19051 25781 19505 16818 8278 12106 16448 19409 13350 14557 17065 5614 18214 15652 26542 28697 10739 15369 2702 78.8129 89.4026 43.7827 31.3387 58.1891 34.8023 18.2675 30.2676 71.107 73.5694 40.8238 76.228 79.6676 23.1316 79.5105 7.561 79.9219 72.9459 11.1812 5.6358 22.3735 44.2011 78.7325 62.3119 7.839 96.6915 98.0761 85.731 22.5041 2.2817 57.1286 59.8993
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 21858    1
    Should Contain X Times    ${output}    bendingModeValue : 78.8129    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [21858, 28265, 10862, 9688, 11848, 16955, 18021, 487, 28028, 22512, 4238, 20821, 21022, 19051, 25781, 19505, 16818, 8278, 12106, 16448, 19409, 13350, 14557, 17065, 5614, 18214, 15652, 26542, 28697, 10739, 15369, 2702]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [78.8129, 89.4026, 43.7827, 31.3387, 58.1891, 34.8023, 18.2675, 30.2676, 71.107, 73.5694, 40.8238, 76.228, 79.6676, 23.1316, 79.5105, 7.561, 79.9219, 72.9459, 11.1812, 5.6358, 22.3735, 44.2011, 78.7325, 62.3119, 7.839, 96.6915, 98.0761, 85.731, 22.5041, 2.2817, 57.1286, 59.8993]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
