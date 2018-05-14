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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 97.1282 30.4621 68.7542 36.2354 57.4514 10.5737 30.3262 84.2169 25.9553 35.9744 10.569 57.6511 89.4286 33.8639 48.927 54.4948 48.2625 94.7749 89.9878 35.0144 65.1945 50.3077 97.2826 98.822 55.6284 76.546 18.0684 4.6246 47.5607 16.2452 85.9595 18.7542 79.8359 0.8088 52.2863 12.1754 19.7015 72.0009 8.307 32.7728 73.6479 2.129 84.0588 10.5878 85.9481 78.1196 45.7012 83.3902 40.0593 13.2409 69.6615 11.2472 80.0832 32.4373 30.7039 28.3462 44.1665 32.1022 39.3044 5.6067 83.8208 48.9667 11.8002 95.3016 61.8357 34.3486 36.5946 1.127 76.9041 91.9793 41.918 97.9658
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 97.1282 30.4621 68.7542 36.2354 57.4514 10.5737 30.3262 84.2169 25.9553 35.9744 10.569 57.6511 89.4286 33.8639 48.927 54.4948 48.2625 94.7749 89.9878 35.0144 65.1945 50.3077 97.2826 98.822 55.6284 76.546 18.0684 4.6246 47.5607 16.2452 85.9595 18.7542 79.8359 0.8088 52.2863 12.1754 19.7015 72.0009 8.307 32.7728 73.6479 2.129 84.0588 10.5878 85.9481 78.1196 45.7012 83.3902 40.0593 13.2409 69.6615 11.2472 80.0832 32.4373 30.7039 28.3462 44.1665 32.1022 39.3044 5.6067 83.8208 48.9667 11.8002 95.3016 61.8357 34.3486 36.5946 1.127 76.9041 91.9793 41.918 97.9658
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetpoint : 97.1282    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetpoint(72) = [97.1282, 30.4621, 68.7542, 36.2354, 57.4514, 10.5737, 30.3262, 84.2169, 25.9553, 35.9744, 10.569, 57.6511, 89.4286, 33.8639, 48.927, 54.4948, 48.2625, 94.7749, 89.9878, 35.0144, 65.1945, 50.3077, 97.2826, 98.822, 55.6284, 76.546, 18.0684, 4.6246, 47.5607, 16.2452, 85.9595, 18.7542, 79.8359, 0.8088, 52.2863, 12.1754, 19.7015, 72.0009, 8.307, 32.7728, 73.6479, 2.129, 84.0588, 10.5878, 85.9481, 78.1196, 45.7012, 83.3902, 40.0593, 13.2409, 69.6615, 11.2472, 80.0832, 32.4373, 30.7039, 28.3462, 44.1665, 32.1022, 39.3044, 5.6067, 83.8208, 48.9667, 11.8002, 95.3016, 61.8357, 34.3486, 36.5946, 1.127, 76.9041, 91.9793, 41.918, 97.9658]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
