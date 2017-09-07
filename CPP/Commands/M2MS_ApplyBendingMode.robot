*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
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
${component}    ApplyBendingMode
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -6039 29851 9831 2824 13785 -29245 -24020 -9842 19418 14571 27299 25067 -3201 -24631 -21694 4465 579 12276 -7164 -13040 -3660 24661 18871 -6965 26497 16460 -25476 9795 4446 28159 -730 -17261 85.5635 88.8255 19.4819 13.3637 39.1273 71.8438 57.0829 32.5037 10.4971 83.6197 47.1353 86.65 51.4089 83.0003 75.3578 8.4054 54.9845 7.3548 21.202 31.0462 31.8388 81.7601 90.9375 82.188 81.1867 80.678 72.6305 92.5695 76.401 83.0355 92.7582 17.7982
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -6039 29851 9831 2824 13785 -29245 -24020 -9842 19418 14571 27299 25067 -3201 -24631 -21694 4465 579 12276 -7164 -13040 -3660 24661 18871 -6965 26497 16460 -25476 9795 4446 28159 -730 -17261 85.5635 88.8255 19.4819 13.3637 39.1273 71.8438 57.0829 32.5037 10.4971 83.6197 47.1353 86.65 51.4089 83.0003 75.3578 8.4054 54.9845 7.3548 21.202 31.0462 31.8388 81.7601 90.9375 82.188 81.1867 80.678 72.6305 92.5695 76.401 83.0355 92.7582 17.7982
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    bendingModeNbr : -6039    1
    Should Contain X Times    ${output}    bendingModeValue : 85.5635    1
    Should Contain    ${output}    === command ApplyBendingMode issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyBendingMode received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    bendingModeNbr : -6039    1
    Should Contain X Times    ${output}    bendingModeValue : 85.5635    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
