*** Settings ***
Documentation    M2MS_ApplyBendingMode communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -2049 -15216 -32477 -13459 18213 -24580 5158 4265 -40 -20120 29157 28432 -18629 -918 -26026 3777 -9452 -30745 -30843 32089 -7821 -24730 11689 -32318 -21158 31931 -17625 -21468 -17989 -5426 26051 11995 96.5044 14.957 87.5557 44.8704 47.5544 1.0924 99.7688 83.5202 40.6252 37.0288 68.5993 39.6846 95.2469 4.5017 17.064 18.5929 38.7751 99.1387 86.074 70.7035 30.4878 48.1722 47.2639 51.2049 8.6611 97.7266 83.2553 74.3194 88.2886 93.0523 61.2555 32.9708
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -2049 -15216 -32477 -13459 18213 -24580 5158 4265 -40 -20120 29157 28432 -18629 -918 -26026 3777 -9452 -30745 -30843 32089 -7821 -24730 11689 -32318 -21158 31931 -17625 -21468 -17989 -5426 26051 11995 96.5044 14.957 87.5557 44.8704 47.5544 1.0924 99.7688 83.5202 40.6252 37.0288 68.5993 39.6846 95.2469 4.5017 17.064 18.5929 38.7751 99.1387 86.074 70.7035 30.4878 48.1722 47.2639 51.2049 8.6611 97.7266 83.2553 74.3194 88.2886 93.0523 61.2555 32.9708
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -2049    1
    Should Contain X Times    ${output}    bendingModeValue : 96.5044    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-2049, -15216, -32477, -13459, 18213, -24580, 5158, 4265, -40, -20120, 29157, 28432, -18629, -918, -26026, 3777, -9452, -30745, -30843, 32089, -7821, -24730, 11689, -32318, -21158, 31931, -17625, -21468, -17989, -5426, 26051, 11995]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [96.5044, 14.957, 87.5557, 44.8704, 47.5544, 1.0924, 99.7688, 83.5202, 40.6252, 37.0288, 68.5993, 39.6846, 95.2469, 4.5017, 17.064, 18.5929, 38.7751, 99.1387, 86.074, 70.7035, 30.4878, 48.1722, 47.2639, 51.2049, 8.6611, 97.7266, 83.2553, 74.3194, 88.2886, 93.0523, 61.2555, 32.9708]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
