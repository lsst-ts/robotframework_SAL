*** Settings ***
Documentation    EEC_setlouvers communications tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 5985 -17635 -24912 12971 -23028 14518 22688 6054 29217 -18795 25317 -27781 -14354 4751 -19200 13919 29750 25290 10710 26055 -12878 9894 -24852 -32611 8895 -12693 -3748 -28103 16152 25899 -26733 6735 -22475 28925 -30403 9745 1358 17987 5668 11152 -17698 -22544 9524 27561 -7133 -873 4126 15027 -18314 3699 -17601 -18287 -6778 -14143 -19714 -12709 -12166 29701 14471 -13787
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 5985 -17635 -24912 12971 -23028 14518 22688 6054 29217 -18795 25317 -27781 -14354 4751 -19200 13919 29750 25290 10710 26055 -12878 9894 -24852 -32611 8895 -12693 -3748 -28103 16152 25899 -26733 6735 -22475 28925 -30403 9745 1358 17987 5668 11152 -17698 -22544 9524 27561 -7133 -873 4126 15027 -18314 3699 -17601 -18287 -6778 -14143 -19714 -12709 -12166 29701 14471 -13787
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : 5985    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [5985, -17635, -24912, 12971, -23028, 14518, 22688, 6054, 29217, -18795, 25317, -27781, -14354, 4751, -19200, 13919, 29750, 25290, 10710, 26055, -12878, 9894, -24852, -32611, 8895, -12693, -3748, -28103, 16152, 25899, -26733, 6735, -22475, 28925, -30403, 9745, 1358, 17987, 5668, 11152, -17698, -22544, 9524, 27561, -7133, -873, 4126, 15027, -18314, 3699, -17601, -18287, -6778, -14143, -19714, -12709, -12166, 29701, 14471, -13787]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
