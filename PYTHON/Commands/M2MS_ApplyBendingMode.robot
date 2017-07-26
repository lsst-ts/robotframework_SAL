*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 21801 -22035 -24929 -8369 14173 -26016 -8023 28480 28877 -30149 -9877 6887 -5209 -26536 -18504 -1152 -23991 -24200 -13022 25157 -14364 -12352 26365 -6345 19796 13457 -11544 27747 31435 16517 -10134 8433 39.0293 68.1987 61.8305 4.1353 32.9513 11.7666 44.9253 39.5229 96.548 54.127 34.0619 55.4824 91.2387 95.4697 61.5094 41.0416 97.2934 71.1469 42.9346 81.095 5.5603 71.8209 95.9583 63.9847 25.8944 62.6762 87.9685 79.5333 72.0616 3.0312 20.2477 31.6776
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 21801 -22035 -24929 -8369 14173 -26016 -8023 28480 28877 -30149 -9877 6887 -5209 -26536 -18504 -1152 -23991 -24200 -13022 25157 -14364 -12352 26365 -6345 19796 13457 -11544 27747 31435 16517 -10134 8433 39.0293 68.1987 61.8305 4.1353 32.9513 11.7666 44.9253 39.5229 96.548 54.127 34.0619 55.4824 91.2387 95.4697 61.5094 41.0416 97.2934 71.1469 42.9346 81.095 5.5603 71.8209 95.9583 63.9847 25.8944 62.6762 87.9685 79.5333 72.0616 3.0312 20.2477 31.6776
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 21801    1
    Should Contain X Times    ${output}    bendingModeValue : 39.0293    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [21801, -22035, -24929, -8369, 14173, -26016, -8023, 28480, 28877, -30149, -9877, 6887, -5209, -26536, -18504, -1152, -23991, -24200, -13022, 25157, -14364, -12352, 26365, -6345, 19796, 13457, -11544, 27747, 31435, 16517, -10134, 8433]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [39.0293, 68.1987, 61.8305, 4.1353, 32.9513, 11.7666, 44.9253, 39.5229, 96.548, 54.127, 34.0619, 55.4824, 91.2387, 95.4697, 61.5094, 41.0416, 97.2934, 71.1469, 42.9346, 81.095, 5.5603, 71.8209, 95.9583, 63.9847, 25.8944, 62.6762, 87.9685, 79.5333, 72.0616, 3.0312, 20.2477, 31.6776]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
