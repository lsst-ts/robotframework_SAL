*** Settings ***
Documentation    TcsOFC_ApplyForces commander/controller tests.
Force Tags    cpp    TSS-2625
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.2806 64.7059 80.0321 58.2715 63.9221 35.7574 84.3581 35.2043 19.2483 74.3002 82.7755 7.9699 69.9036 92.1069 22.1438 34.8299 10.8969 8.1339 21.2913 17.9854 4.596 51.3269 15.7992 24.2697 47.7451 63.9918 71.8288 10.5694 85.449 90.2393 91.0778 79.0363 50.2847 62.7762 26.4361 29.9807 13.7422 63.9033 57.4207 84.1943 40.3918 70.6559 80.7959 54.6308 66.6427 5.5153 4.0539 27.0145 95.893 30.1607 58.6834 83.361 36.4638 80.0014 24.7616 17.0964 19.6027 43.4924 4.9825 44.9206 46.0656 53.1045 20.333 42.5354 36.7594 9.5278 49.3681 63.4168 54.4109 16.814 85.5412 7.386
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.2806 64.7059 80.0321 58.2715 63.9221 35.7574 84.3581 35.2043 19.2483 74.3002 82.7755 7.9699 69.9036 92.1069 22.1438 34.8299 10.8969 8.1339 21.2913 17.9854 4.596 51.3269 15.7992 24.2697 47.7451 63.9918 71.8288 10.5694 85.449 90.2393 91.0778 79.0363 50.2847 62.7762 26.4361 29.9807 13.7422 63.9033 57.4207 84.1943 40.3918 70.6559 80.7959 54.6308 66.6427 5.5153 4.0539 27.0145 95.893 30.1607 58.6834 83.361 36.4638 80.0014 24.7616 17.0964 19.6027 43.4924 4.9825 44.9206 46.0656 53.1045 20.333 42.5354 36.7594 9.5278 49.3681 63.4168 54.4109 16.814 85.5412 7.386
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetpoint : 25.2806    1
    Should Contain    ${output}    === command ApplyForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetpoint : 25.2806    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
