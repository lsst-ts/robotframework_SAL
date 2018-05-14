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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -13292 -3043 1820 -14720 -14364 1036 -15271 25589 2981 -19225 8467 -19675 168 4920 2398 -2814 -14558 22962 21439 -9492 -15885 8211 -31341 -18256 -15761 -24047 4204 -21223 -15176 26968 -9573 -31088 2.697 90.9966 48.9444 89.9353 83.7923 21.1807 66.25 84.6513 85.2598 36.7352 76.6728 55.1378 56.2879 44.4464 9.0881 84.3771 50.2383 7.4827 91.5826 9.2743 16.4914 82.376 9.0579 17.5405 45.7348 40.6497 81.1588 83.9184 34.1033 0.953 26.8927 40.4661
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -13292 -3043 1820 -14720 -14364 1036 -15271 25589 2981 -19225 8467 -19675 168 4920 2398 -2814 -14558 22962 21439 -9492 -15885 8211 -31341 -18256 -15761 -24047 4204 -21223 -15176 26968 -9573 -31088 2.697 90.9966 48.9444 89.9353 83.7923 21.1807 66.25 84.6513 85.2598 36.7352 76.6728 55.1378 56.2879 44.4464 9.0881 84.3771 50.2383 7.4827 91.5826 9.2743 16.4914 82.376 9.0579 17.5405 45.7348 40.6497 81.1588 83.9184 34.1033 0.953 26.8927 40.4661
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -13292    1
    Should Contain X Times    ${output}    bendingModeValue : 2.697    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-13292, -3043, 1820, -14720, -14364, 1036, -15271, 25589, 2981, -19225, 8467, -19675, 168, 4920, 2398, -2814, -14558, 22962, 21439, -9492, -15885, 8211, -31341, -18256, -15761, -24047, 4204, -21223, -15176, 26968, -9573, -31088]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [2.697, 90.9966, 48.9444, 89.9353, 83.7923, 21.1807, 66.25, 84.6513, 85.2598, 36.7352, 76.6728, 55.1378, 56.2879, 44.4464, 9.0881, 84.3771, 50.2383, 7.4827, 91.5826, 9.2743, 16.4914, 82.376, 9.0579, 17.5405, 45.7348, 40.6497, 81.1588, 83.9184, 34.1033, 0.953, 26.8927, 40.4661]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
