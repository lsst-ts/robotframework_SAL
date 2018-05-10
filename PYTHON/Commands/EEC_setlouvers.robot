*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -24028 -7003 -16910 -6382 4743 -12426 23418 18734 10670 7502 3753 21949 18439 29821 -29194 10916 21393 -11985 -26605 -10662 -27277 -18217 26268 -3425 22876 14530 -12529 -22849 724 10594 -11189 -30120 -10842 -25737 -31206 12935 -11576 9579 -27095 -5894 12695 2072 292 1895 -25265 -2652 -4051 -23184 17405 -4553 -213 3465 24377 12670 7729 28205 22352 12861 -7758 20835
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -24028 -7003 -16910 -6382 4743 -12426 23418 18734 10670 7502 3753 21949 18439 29821 -29194 10916 21393 -11985 -26605 -10662 -27277 -18217 26268 -3425 22876 14530 -12529 -22849 724 10594 -11189 -30120 -10842 -25737 -31206 12935 -11576 9579 -27095 -5894 12695 2072 292 1895 -25265 -2652 -4051 -23184 17405 -4553 -213 3465 24377 12670 7729 28205 22352 12861 -7758 20835
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : -24028    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [-24028, -7003, -16910, -6382, 4743, -12426, 23418, 18734, 10670, 7502, 3753, 21949, 18439, 29821, -29194, 10916, 21393, -11985, -26605, -10662, -27277, -18217, 26268, -3425, 22876, 14530, -12529, -22849, 724, 10594, -11189, -30120, -10842, -25737, -31206, 12935, -11576, 9579, -27095, -5894, 12695, 2072, 292, 1895, -25265, -2652, -4051, -23184, 17405, -4553, -213, 3465, 24377, 12670, 7729, 28205, 22352, 12861, -7758, 20835]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
