*** Settings ***
Documentation    EEC_setlouvers communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    setlouvers
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 24919 21897 23132 4380 4801 4273 -21898 -12336 21910 -23225 -12028 -6122 8425 -16655 -25114 -11637 -9489 -16108 15336 -13080 -14376 23298 -16469 25053 -10795 20015 16570 528 19576 -7246 -12081 27438 6946 24645 -9095 -7138 17130 -12819 -26060 29869 7924 -1193 -22890 10676 -24875 -32172 22365 -17227 18631 -7270 -8346 -7928 -28192 1906 15250 -3529 -23136 -19995 -19902 6372
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 24919 21897 23132 4380 4801 4273 -21898 -12336 21910 -23225 -12028 -6122 8425 -16655 -25114 -11637 -9489 -16108 15336 -13080 -14376 23298 -16469 25053 -10795 20015 16570 528 19576 -7246 -12081 27438 6946 24645 -9095 -7138 17130 -12819 -26060 29869 7924 -1193 -22890 10676 -24875 -32172 22365 -17227 18631 -7270 -8346 -7928 -28192 1906 15250 -3529 -23136 -19995 -19902 6372
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : 24919    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [24919, 21897, 23132, 4380, 4801, 4273, -21898, -12336, 21910, -23225, -12028, -6122, 8425, -16655, -25114, -11637, -9489, -16108, 15336, -13080, -14376, 23298, -16469, 25053, -10795, 20015, 16570, 528, 19576, -7246, -12081, 27438, 6946, 24645, -9095, -7138, 17130, -12819, -26060, 29869, 7924, -1193, -22890, 10676, -24875, -32172, 22365, -17227, 18631, -7270, -8346, -7928, -28192, 1906, 15250, -3529, -23136, -19995, -19902, 6372]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
