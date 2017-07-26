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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 79.6486 0.2783 73.3612 66.5889 88.2627 50.3911 78.7018 40.2928 60.4774 50.0376 71.6238 10.8596 11.5305 92.2327 5.8577 96.7732 94.7112 97.9516 91.5883 69.5087 40.981 78.8991 44.5867 77.3677 24.4579 13.4982 29.6823 8.4036 13.8646 77.1156 24.7135 31.5632 17.1373 33.3348 64.9835 40.8304 1.7899 62.8091 24.0508 61.3678 60.7198 97.3478 9.1891 24.3105 98.9683 58.6929 34.5248 97.1128 73.9483 68.8889 31.6263 0.801 49.776 21.7423 87.3479 53.8855 91.385 29.3216 30.5434 65.8722 98.6902 41.2115 90.7854 38.8423 23.5324 80.6703 35.1684 16.0696 17.4111 45.8604 57.3688 85.2657
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 79.6486 0.2783 73.3612 66.5889 88.2627 50.3911 78.7018 40.2928 60.4774 50.0376 71.6238 10.8596 11.5305 92.2327 5.8577 96.7732 94.7112 97.9516 91.5883 69.5087 40.981 78.8991 44.5867 77.3677 24.4579 13.4982 29.6823 8.4036 13.8646 77.1156 24.7135 31.5632 17.1373 33.3348 64.9835 40.8304 1.7899 62.8091 24.0508 61.3678 60.7198 97.3478 9.1891 24.3105 98.9683 58.6929 34.5248 97.1128 73.9483 68.8889 31.6263 0.801 49.776 21.7423 87.3479 53.8855 91.385 29.3216 30.5434 65.8722 98.6902 41.2115 90.7854 38.8423 23.5324 80.6703 35.1684 16.0696 17.4111 45.8604 57.3688 85.2657
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 79.6486    1
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
    Should Contain X Times    ${output}    forceSetPoint : 79.6486    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
