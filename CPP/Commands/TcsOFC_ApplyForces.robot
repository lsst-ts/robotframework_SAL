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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 74.0588 57.6646 5.2568 44.3931 64.0794 66.6442 25.2925 61.8684 13.5536 68.0113 28.4689 53.0952 40.8998 27.1795 76.2946 15.3792 13.2175 22.306 1.5303 10.4742 74.6101 63.9567 48.5261 0.3047 88.1273 99.9791 36.3007 28.7185 65.255 17.2272 37.6954 50.6633 24.3973 51.9508 43.9848 46.1958 55.3027 43.8383 22.696 67.1339 58.2168 72.7664 40.9356 2.0588 80.6217 51.8907 45.2401 37.1691 96.0435 55.6333 19.2603 86.7824 4.6958 17.5992 38.8858 86.4383 20.6493 36.0327 85.3075 92.9892 68.0914 30.8009 76.3425 1.8003 4.7519 36.1761 26.8376 54.8725 1.6677 35.7439 82.6128 48.3426
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 74.0588 57.6646 5.2568 44.3931 64.0794 66.6442 25.2925 61.8684 13.5536 68.0113 28.4689 53.0952 40.8998 27.1795 76.2946 15.3792 13.2175 22.306 1.5303 10.4742 74.6101 63.9567 48.5261 0.3047 88.1273 99.9791 36.3007 28.7185 65.255 17.2272 37.6954 50.6633 24.3973 51.9508 43.9848 46.1958 55.3027 43.8383 22.696 67.1339 58.2168 72.7664 40.9356 2.0588 80.6217 51.8907 45.2401 37.1691 96.0435 55.6333 19.2603 86.7824 4.6958 17.5992 38.8858 86.4383 20.6493 36.0327 85.3075 92.9892 68.0914 30.8009 76.3425 1.8003 4.7519 36.1761 26.8376 54.8725 1.6677 35.7439 82.6128 48.3426
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetpoint : 74.0588    1
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
    Should Contain X Times    ${output}    forceSetpoint : 74.0588    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
