*** Settings ***
Documentation    M2MS_ApplyForce communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 29.639 41.4097 99.6606 55.2075 60.4517 43.4708 93.2878 72.8626 52.7563 99.8466 62.4637 50.6 18.2669 58.079 34.5559 48.7753 58.3168 27.6203 24.3091 3.5436 94.4167 35.3412 67.6825 69.8888 82.7238 4.8309 44.5536 80.8895 17.856 32.933 29.834 3.8416 21.805 17.1252 80.6243 51.8488 23.1882 1.6207 2.94 45.9982 10.9549 13.1563 21.2916 68.3562 48.556 65.6578 23.1932 47.1132 27.5236 81.3833 16.599 34.9584 67.4548 60.9026 25.4566 99.1327 4.8832 54.0288 66.8217 62.5778 56.8174 99.6742 72.9999 91.0697 55.9594 56.9354 15.5373 83.334 92.2913 9.7253 20.2248 48.5925
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 29.639 41.4097 99.6606 55.2075 60.4517 43.4708 93.2878 72.8626 52.7563 99.8466 62.4637 50.6 18.2669 58.079 34.5559 48.7753 58.3168 27.6203 24.3091 3.5436 94.4167 35.3412 67.6825 69.8888 82.7238 4.8309 44.5536 80.8895 17.856 32.933 29.834 3.8416 21.805 17.1252 80.6243 51.8488 23.1882 1.6207 2.94 45.9982 10.9549 13.1563 21.2916 68.3562 48.556 65.6578 23.1932 47.1132 27.5236 81.3833 16.599 34.9584 67.4548 60.9026 25.4566 99.1327 4.8832 54.0288 66.8217 62.5778 56.8174 99.6742 72.9999 91.0697 55.9594 56.9354 15.5373 83.334 92.2913 9.7253 20.2248 48.5925
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 29.639    1
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
    Should Contain X Times    ${output}    forceSetPoint : 29.639    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
