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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -28271 8115 27021 12557 -2926 -3141 30431 -31163 13341 -3516 -1460 904 16513 4740 17301 18611 -20540 -27589 20950 -16701 -29560 -4621 19755 -20213 16971 16781 28283 -14496 23715 133 -4872 29807 11.465 77.4108 22.1161 49.8402 6.5742 44.3064 22.227 50.524 70.0365 29.7387 48.4723 72.983 80.1113 68.495 19.7433 41.0751 27.1313 88.1254 11.3867 0.2207 29.4509 96.8221 66.1682 40.044 37.9455 43.9314 95.9169 18.3505 7.1929 93.7978 1.9247 37.066
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -28271 8115 27021 12557 -2926 -3141 30431 -31163 13341 -3516 -1460 904 16513 4740 17301 18611 -20540 -27589 20950 -16701 -29560 -4621 19755 -20213 16971 16781 28283 -14496 23715 133 -4872 29807 11.465 77.4108 22.1161 49.8402 6.5742 44.3064 22.227 50.524 70.0365 29.7387 48.4723 72.983 80.1113 68.495 19.7433 41.0751 27.1313 88.1254 11.3867 0.2207 29.4509 96.8221 66.1682 40.044 37.9455 43.9314 95.9169 18.3505 7.1929 93.7978 1.9247 37.066
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -28271    1
    Should Contain X Times    ${output}    bendingModeValue : 11.465    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-28271, 8115, 27021, 12557, -2926, -3141, 30431, -31163, 13341, -3516, -1460, 904, 16513, 4740, 17301, 18611, -20540, -27589, 20950, -16701, -29560, -4621, 19755, -20213, 16971, 16781, 28283, -14496, 23715, 133, -4872, 29807]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [11.465, 77.4108, 22.1161, 49.8402, 6.5742, 44.3064, 22.227, 50.524, 70.0365, 29.7387, 48.4723, 72.983, 80.1113, 68.495, 19.7433, 41.0751, 27.1313, 88.1254, 11.3867, 0.2207, 29.4509, 96.8221, 66.1682, 40.044, 37.9455, 43.9314, 95.9169, 18.3505, 7.1929, 93.7978, 1.9247, 37.066]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
