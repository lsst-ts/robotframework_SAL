*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    cpp    
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 15.7268 2.3552 40.6518 98.7321 22.0279 37.9294 72.3976 69.7435 21.8543 25.1262 5.572 52.7897 49.7858 55.9608 71.5663 86.0786 3.5148 31.7586 19.8777 4.695 4.5701 14.1752 78.8767 89.7388 22.9013 68.1543 71.4843 99.1685 1.8916 46.8368 13.7103 11.3008 44.3193 27.3169 22.3825 33.8356 4.1669 40.6427 67.9196 67.0969 97.8161 82.1215 30.8808 85.4687 15.3917 85.8157 71.8381 93.0231 56.5267 30.6261 71.7995 73.5459 58.2305 2.1116 63.855 35.2559 46.4406 73.5299 23.8013 58.9583 94.9815 36.7215 20.7187 8.8275 5.0322 53.2723 11.7505 94.5119 98.8629 48.3748 44.0353 69.8626
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 15.7268 2.3552 40.6518 98.7321 22.0279 37.9294 72.3976 69.7435 21.8543 25.1262 5.572 52.7897 49.7858 55.9608 71.5663 86.0786 3.5148 31.7586 19.8777 4.695 4.5701 14.1752 78.8767 89.7388 22.9013 68.1543 71.4843 99.1685 1.8916 46.8368 13.7103 11.3008 44.3193 27.3169 22.3825 33.8356 4.1669 40.6427 67.9196 67.0969 97.8161 82.1215 30.8808 85.4687 15.3917 85.8157 71.8381 93.0231 56.5267 30.6261 71.7995 73.5459 58.2305 2.1116 63.855 35.2559 46.4406 73.5299 23.8013 58.9583 94.9815 36.7215 20.7187 8.8275 5.0322 53.2723 11.7505 94.5119 98.8629 48.3748 44.0353 69.8626
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 15.7268    1
    Should Contain    ${output}    === command ApplyForce issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForce received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetPoint : 15.7268    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
