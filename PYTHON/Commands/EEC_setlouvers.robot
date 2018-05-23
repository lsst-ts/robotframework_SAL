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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 31305 -27407 -23940 -20035 -16033 176 -11383 -19795 24578 -5497 28068 27320 -11603 -5726 -21008 3568 -18686 -30201 -4307 23601 -15138 8337 5370 -22008 -6478 25863 29915 -32702 -31169 -23363 -10734 16895 5905 17324 31689 27802 -3923 24120 24141 -27346 -21266 -18091 -3934 14756 5767 4458 21471 -19469 6167 -16512 -26995 -3284 23007 -9689 27457 24335 -2371 -22156 23297 -22233
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 31305 -27407 -23940 -20035 -16033 176 -11383 -19795 24578 -5497 28068 27320 -11603 -5726 -21008 3568 -18686 -30201 -4307 23601 -15138 8337 5370 -22008 -6478 25863 29915 -32702 -31169 -23363 -10734 16895 5905 17324 31689 27802 -3923 24120 24141 -27346 -21266 -18091 -3934 14756 5767 4458 21471 -19469 6167 -16512 -26995 -3284 23007 -9689 27457 24335 -2371 -22156 23297 -22233
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : 31305    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [31305, -27407, -23940, -20035, -16033, 176, -11383, -19795, 24578, -5497, 28068, 27320, -11603, -5726, -21008, 3568, -18686, -30201, -4307, 23601, -15138, 8337, 5370, -22008, -6478, 25863, 29915, -32702, -31169, -23363, -10734, 16895, 5905, 17324, 31689, 27802, -3923, 24120, 24141, -27346, -21266, -18091, -3934, 14756, 5767, 4458, 21471, -19469, 6167, -16512, -26995, -3284, 23007, -9689, 27457, 24335, -2371, -22156, 23297, -22233]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
