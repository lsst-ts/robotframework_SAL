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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 78.0426 48.8245 21.654 98.2843 60.9758 2.442 49.1036 17.9087 12.9864 74.0028 6.7458 65.431 69.1462 11.1566 62.5741 13.1017 52.4542 22.4166 78.8988 65.3872 84.4239 47.8004 56.4344 25.6737 98.6057 51.6788 86.51 52.6797 82.4494 88.1094 30.3849 17.2975 13.7105 57.3626 50.7325 10.0117 52.2149 59.9005 13.9978 6.3929 63.2103 38.5798 48.1105 27.8464 40.1845 67.2952 20.8282 87.0764 11.5031 64.5104 27.6539 7.4696 73.2217 63.6086 3.9262 9.2609 10.8177 0.095 94.5634 55.7435 47.8759 73.3437 81.3733 55.6283 55.7769 56.8875 43.2611 76.2938 87.8554 70.5323 64.6588 25.6438
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 78.0426 48.8245 21.654 98.2843 60.9758 2.442 49.1036 17.9087 12.9864 74.0028 6.7458 65.431 69.1462 11.1566 62.5741 13.1017 52.4542 22.4166 78.8988 65.3872 84.4239 47.8004 56.4344 25.6737 98.6057 51.6788 86.51 52.6797 82.4494 88.1094 30.3849 17.2975 13.7105 57.3626 50.7325 10.0117 52.2149 59.9005 13.9978 6.3929 63.2103 38.5798 48.1105 27.8464 40.1845 67.2952 20.8282 87.0764 11.5031 64.5104 27.6539 7.4696 73.2217 63.6086 3.9262 9.2609 10.8177 0.095 94.5634 55.7435 47.8759 73.3437 81.3733 55.6283 55.7769 56.8875 43.2611 76.2938 87.8554 70.5323 64.6588 25.6438
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 78.0426    1
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
    Should Contain X Times    ${output}    forceSetPoint : 78.0426    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
