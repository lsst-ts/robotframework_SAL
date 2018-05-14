*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    setlouvers
${timeout}    30s

*** Test Cases ***
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -20187 7776 -5710 30089 3937 -21959 12914 294 31230 8140 -21378 8379 -15808 18006 -19991 -15885 -24398 5573 -3614 -10252 -23286 -12810 11119 -5509 -5955 -739 9153 -15951 -1022 -14477 557 -22978 -16745 -3266 -616 26184 28085 -14001 -15502 25532 -1598 -25378 -24751 17294 -6498 30080 -14934 16230 21913 -31078 -13248 7299 30307 26260 -1224 26286 -14037 29003 18951 -2308
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -20187 7776 -5710 30089 3937 -21959 12914 294 31230 8140 -21378 8379 -15808 18006 -19991 -15885 -24398 5573 -3614 -10252 -23286 -12810 11119 -5509 -5955 -739 9153 -15951 -1022 -14477 557 -22978 -16745 -3266 -616 26184 28085 -14001 -15502 25532 -1598 -25378 -24751 17294 -6498 30080 -14934 16230 21913 -31078 -13248 7299 30307 26260 -1224 26286 -14037 29003 18951 -2308
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : -20187    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [-20187, 7776, -5710, 30089, 3937, -21959, 12914, 294, 31230, 8140, -21378, 8379, -15808, 18006, -19991, -15885, -24398, 5573, -3614, -10252, -23286, -12810, 11119, -5509, -5955, -739, 9153, -15951, -1022, -14477, 557, -22978, -16745, -3266, -616, 26184, 28085, -14001, -15502, 25532, -1598, -25378, -24751, 17294, -6498, 30080, -14934, 16230, 21913, -31078, -13248, 7299, 30307, 26260, -1224, 26286, -14037, 29003, 18951, -2308]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
