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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 38.0753 38.6702 36.4352 52.5425 51.6383 11.4708 95.9634 31.7311 5.4707 88.1639 42.234 65.1392 45.0447 92.8543 76.5945 21.3225 20.2021 72.635 40.1529 99.1664 23.4745 70.7102 67.0066 83.3011 14.0751 63.4715 60.7135 69.0504 88.2303 78.9555 40.5765 45.5938 93.2111 8.2979 74.5141 32.5971 97.4041 35.957 13.8957 25.7136 74.3793 10.542 58.332 80.3809 47.8415 44.6451 69.0976 83.3931 78.8924 41.1916 92.7792 52.5527 48.738 66.2231 71.4359 21.4023 65.1701 1.4774 18.9745 29.0995 20.3511 31.1128 34.8775 6.415 17.6988 25.2166 99.1603 41.4779 86.6758 68.6699 52.305 2.8183
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 38.0753 38.6702 36.4352 52.5425 51.6383 11.4708 95.9634 31.7311 5.4707 88.1639 42.234 65.1392 45.0447 92.8543 76.5945 21.3225 20.2021 72.635 40.1529 99.1664 23.4745 70.7102 67.0066 83.3011 14.0751 63.4715 60.7135 69.0504 88.2303 78.9555 40.5765 45.5938 93.2111 8.2979 74.5141 32.5971 97.4041 35.957 13.8957 25.7136 74.3793 10.542 58.332 80.3809 47.8415 44.6451 69.0976 83.3931 78.8924 41.1916 92.7792 52.5527 48.738 66.2231 71.4359 21.4023 65.1701 1.4774 18.9745 29.0995 20.3511 31.1128 34.8775 6.415 17.6988 25.2166 99.1603 41.4779 86.6758 68.6699 52.305 2.8183
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 38.0753    1
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
    Should Contain X Times    ${output}    forceSetPoint : 38.0753    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
