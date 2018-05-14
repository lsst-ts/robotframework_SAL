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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 37.0051 90.8305 93.8002 55.2574 40.6583 51.0588 22.6025 3.8849 83.9607 69.2344 32.1492 13.1833 13.0266 93.086 85.5383 99.616 56.1892 10.4227 55.9512 0.8452 0.054 13.5422 86.7948 89.7791 10.4263 60.0399 72.0862 51.3267 11.6865 97.4438 39.6449 34.9139 66.3689 97.9554 22.5692 84.1134 45.0008 30.0598 0.1349 50.801 86.536 79.2845 12.9721 85.9358 47.371 63.2814 19.294 28.8157 61.0893 17.6867 91.3843 99.6026 78.0099 35.3519 92.9879 53.6387 30.6797 65.5455 90.2369 99.4673 23.429 48.3676 55.2515 1.9274 38.4995 2.645 51.2889 78.3895 59.3774 89.2953 63.1155 64.0041
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 37.0051 90.8305 93.8002 55.2574 40.6583 51.0588 22.6025 3.8849 83.9607 69.2344 32.1492 13.1833 13.0266 93.086 85.5383 99.616 56.1892 10.4227 55.9512 0.8452 0.054 13.5422 86.7948 89.7791 10.4263 60.0399 72.0862 51.3267 11.6865 97.4438 39.6449 34.9139 66.3689 97.9554 22.5692 84.1134 45.0008 30.0598 0.1349 50.801 86.536 79.2845 12.9721 85.9358 47.371 63.2814 19.294 28.8157 61.0893 17.6867 91.3843 99.6026 78.0099 35.3519 92.9879 53.6387 30.6797 65.5455 90.2369 99.4673 23.429 48.3676 55.2515 1.9274 38.4995 2.645 51.2889 78.3895 59.3774 89.2953 63.1155 64.0041
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 37.0051    1
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
    Should Contain X Times    ${output}    forceSetPoint : 37.0051    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
