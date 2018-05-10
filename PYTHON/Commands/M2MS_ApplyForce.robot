*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
${component}    ApplyForce
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.5719 84.5352 47.4706 91.6558 24.8333 66.2085 59.2361 15.9268 80.5384 74.6479 15.0965 16.8084 15.7278 7.7967 35.7108 89.5424 92.8503 4.4749 70.7684 76.7738 29.9929 97.277 28.3925 32.3309 70.6533 59.7461 65.2541 64.8024 10.4994 87.8203 13.2141 69.8552 31.9575 3.8295 41.8292 1.8451 23.6969 9.5557 10.6432 25.8546 7.9384 19.9799 68.0482 65.6031 83.3193 86.5298 30.6605 99.7899 67.3622 54.4175 82.9564 56.9032 39.2374 74.5926 89.2744 57.3575 11.3101 34.4433 16.5856 6.1524 61.3528 3.8696 18.4765 94.6177 38.4067 86.3456 9.8596 64.1299 12.4005 63.313 96.8338 65.8416
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.5719 84.5352 47.4706 91.6558 24.8333 66.2085 59.2361 15.9268 80.5384 74.6479 15.0965 16.8084 15.7278 7.7967 35.7108 89.5424 92.8503 4.4749 70.7684 76.7738 29.9929 97.277 28.3925 32.3309 70.6533 59.7461 65.2541 64.8024 10.4994 87.8203 13.2141 69.8552 31.9575 3.8295 41.8292 1.8451 23.6969 9.5557 10.6432 25.8546 7.9384 19.9799 68.0482 65.6031 83.3193 86.5298 30.6605 99.7899 67.3622 54.4175 82.9564 56.9032 39.2374 74.5926 89.2744 57.3575 11.3101 34.4433 16.5856 6.1524 61.3528 3.8696 18.4765 94.6177 38.4067 86.3456 9.8596 64.1299 12.4005 63.313 96.8338 65.8416
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 16.5719    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [16.5719, 84.5352, 47.4706, 91.6558, 24.8333, 66.2085, 59.2361, 15.9268, 80.5384, 74.6479, 15.0965, 16.8084, 15.7278, 7.7967, 35.7108, 89.5424, 92.8503, 4.4749, 70.7684, 76.7738, 29.9929, 97.277, 28.3925, 32.3309, 70.6533, 59.7461, 65.2541, 64.8024, 10.4994, 87.8203, 13.2141, 69.8552, 31.9575, 3.8295, 41.8292, 1.8451, 23.6969, 9.5557, 10.6432, 25.8546, 7.9384, 19.9799, 68.0482, 65.6031, 83.3193, 86.5298, 30.6605, 99.7899, 67.3622, 54.4175, 82.9564, 56.9032, 39.2374, 74.5926, 89.2744, 57.3575, 11.3101, 34.4433, 16.5856, 6.1524, 61.3528, 3.8696, 18.4765, 94.6177, 38.4067, 86.3456, 9.8596, 64.1299, 12.4005, 63.313, 96.8338, 65.8416]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
