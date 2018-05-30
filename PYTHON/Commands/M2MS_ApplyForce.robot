*** Settings ***
Documentation    M2MS_ApplyForce communications tests.
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
${component}    ApplyForce
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 59.1836 69.6574 53.9349 61.2279 63.7269 85.3811 53.2008 14.9506 8.2994 85.4383 26.0263 57.2804 59.4307 76.157 27.0408 69.9106 40.676 46.5269 21.2401 79.7554 21.1607 31.9178 6.4263 72.1769 5.4585 33.0541 99.6357 11.6406 47.6742 47.1072 46.8758 68.4261 51.7708 17.8079 83.8885 5.8035 78.0593 43.0673 87.2157 45.854 94.5689 10.1766 0.761 94.5428 94.465 17.9254 54.0577 25.9187 68.6769 78.5099 41.4893 87.8801 60.4402 49.5634 16.1838 56.3754 18.92 2.8947 22.3883 17.2087 44.6371 53.5716 98.3778 86.7723 61.085 20.4125 93.5491 27.7559 56.6488 70.0758 71.1211 98.1951
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 59.1836 69.6574 53.9349 61.2279 63.7269 85.3811 53.2008 14.9506 8.2994 85.4383 26.0263 57.2804 59.4307 76.157 27.0408 69.9106 40.676 46.5269 21.2401 79.7554 21.1607 31.9178 6.4263 72.1769 5.4585 33.0541 99.6357 11.6406 47.6742 47.1072 46.8758 68.4261 51.7708 17.8079 83.8885 5.8035 78.0593 43.0673 87.2157 45.854 94.5689 10.1766 0.761 94.5428 94.465 17.9254 54.0577 25.9187 68.6769 78.5099 41.4893 87.8801 60.4402 49.5634 16.1838 56.3754 18.92 2.8947 22.3883 17.2087 44.6371 53.5716 98.3778 86.7723 61.085 20.4125 93.5491 27.7559 56.6488 70.0758 71.1211 98.1951
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 59.1836    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [59.1836, 69.6574, 53.9349, 61.2279, 63.7269, 85.3811, 53.2008, 14.9506, 8.2994, 85.4383, 26.0263, 57.2804, 59.4307, 76.157, 27.0408, 69.9106, 40.676, 46.5269, 21.2401, 79.7554, 21.1607, 31.9178, 6.4263, 72.1769, 5.4585, 33.0541, 99.6357, 11.6406, 47.6742, 47.1072, 46.8758, 68.4261, 51.7708, 17.8079, 83.8885, 5.8035, 78.0593, 43.0673, 87.2157, 45.854, 94.5689, 10.1766, 0.761, 94.5428, 94.465, 17.9254, 54.0577, 25.9187, 68.6769, 78.5099, 41.4893, 87.8801, 60.4402, 49.5634, 16.1838, 56.3754, 18.92, 2.8947, 22.3883, 17.2087, 44.6371, 53.5716, 98.3778, 86.7723, 61.085, 20.4125, 93.5491, 27.7559, 56.6488, 70.0758, 71.1211, 98.1951]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
