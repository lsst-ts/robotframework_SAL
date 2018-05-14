*** Settings ***
Documentation    TcsOFC_ApplyForces commander/controller tests.
Force Tags    python    TSS-2625
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsOfc
${component}    ApplyForces
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 85.574 64.1532 19.2002 7.4497 24.6845 15.0722 83.374 39.0263 53.2131 71.1933 49.01 57.5846 52.7664 2.0356 87.4352 74.5343 47.9436 75.3375 9.2939 66.1099 0.0988 86.7904 15.5132 79.126 22.1942 46.6792 49.7007 94.9295 16.0307 43.4816 55.7138 75.7828 93.5842 24.263 92.1821 92.2407 50.9651 32.0242 25.9089 50.102 63.364 41.2297 76.133 79.5264 30.0437 94.4125 86.4398 70.0673 48.5957 14.8614 53.6418 51.5202 73.9393 29.764 75.2424 80.8248 11.9859 61.8668 31.1248 79.231 11.7518 40.3222 41.1609 88.9839 94.0164 18.5132 64.6947 74.9601 21.7051 85.5743 81.6635 31.4203
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 85.574 64.1532 19.2002 7.4497 24.6845 15.0722 83.374 39.0263 53.2131 71.1933 49.01 57.5846 52.7664 2.0356 87.4352 74.5343 47.9436 75.3375 9.2939 66.1099 0.0988 86.7904 15.5132 79.126 22.1942 46.6792 49.7007 94.9295 16.0307 43.4816 55.7138 75.7828 93.5842 24.263 92.1821 92.2407 50.9651 32.0242 25.9089 50.102 63.364 41.2297 76.133 79.5264 30.0437 94.4125 86.4398 70.0673 48.5957 14.8614 53.6418 51.5202 73.9393 29.764 75.2424 80.8248 11.9859 61.8668 31.1248 79.231 11.7518 40.3222 41.1609 88.9839 94.0164 18.5132 64.6947 74.9601 21.7051 85.5743 81.6635 31.4203
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 85.574    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [85.574, 64.1532, 19.2002, 7.4497, 24.6845, 15.0722, 83.374, 39.0263, 53.2131, 71.1933, 49.01, 57.5846, 52.7664, 2.0356, 87.4352, 74.5343, 47.9436, 75.3375, 9.2939, 66.1099, 0.0988, 86.7904, 15.5132, 79.126, 22.1942, 46.6792, 49.7007, 94.9295, 16.0307, 43.4816, 55.7138, 75.7828, 93.5842, 24.263, 92.1821, 92.2407, 50.9651, 32.0242, 25.9089, 50.102, 63.364, 41.2297, 76.133, 79.5264, 30.0437, 94.4125, 86.4398, 70.0673, 48.5957, 14.8614, 53.6418, 51.5202, 73.9393, 29.764, 75.2424, 80.8248, 11.9859, 61.8668, 31.1248, 79.231, 11.7518, 40.3222, 41.1609, 88.9839, 94.0164, 18.5132, 64.6947, 74.9601, 21.7051, 85.5743, 81.6635, 31.4203]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
