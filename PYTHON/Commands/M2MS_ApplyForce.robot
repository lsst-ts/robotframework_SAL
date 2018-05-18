*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.2907 74.2119 87.9103 69.1259 61.5655 28.2124 71.5247 81.8589 0.4861 35.0136 73.4952 67.7742 26.8561 77.3241 83.0084 75.21 25.9451 41.8922 33.684 66.4678 30.3018 32.8149 21.7654 10.9037 0.4644 1.8162 19.4342 34.0864 16.1152 16.3453 26.2995 8.5186 66.721 48.2327 85.0592 69.0086 90.6968 90.2032 55.3818 66.9417 74.8797 85.7599 97.6427 13.5307 75.9298 9.5664 29.5383 70.0352 6.5026 9.0406 88.3071 48.6055 10.0267 47.2602 21.7043 60.314 51.6581 43.1595 24.2267 67.0376 30.3821 77.8219 2.8559 75.8259 56.4739 20.0214 42.435 52.7121 1.343 90.7906 61.0046 93.3635
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 16.2907 74.2119 87.9103 69.1259 61.5655 28.2124 71.5247 81.8589 0.4861 35.0136 73.4952 67.7742 26.8561 77.3241 83.0084 75.21 25.9451 41.8922 33.684 66.4678 30.3018 32.8149 21.7654 10.9037 0.4644 1.8162 19.4342 34.0864 16.1152 16.3453 26.2995 8.5186 66.721 48.2327 85.0592 69.0086 90.6968 90.2032 55.3818 66.9417 74.8797 85.7599 97.6427 13.5307 75.9298 9.5664 29.5383 70.0352 6.5026 9.0406 88.3071 48.6055 10.0267 47.2602 21.7043 60.314 51.6581 43.1595 24.2267 67.0376 30.3821 77.8219 2.8559 75.8259 56.4739 20.0214 42.435 52.7121 1.343 90.7906 61.0046 93.3635
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 16.2907    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [16.2907, 74.2119, 87.9103, 69.1259, 61.5655, 28.2124, 71.5247, 81.8589, 0.4861, 35.0136, 73.4952, 67.7742, 26.8561, 77.3241, 83.0084, 75.21, 25.9451, 41.8922, 33.684, 66.4678, 30.3018, 32.8149, 21.7654, 10.9037, 0.4644, 1.8162, 19.4342, 34.0864, 16.1152, 16.3453, 26.2995, 8.5186, 66.721, 48.2327, 85.0592, 69.0086, 90.6968, 90.2032, 55.3818, 66.9417, 74.8797, 85.7599, 97.6427, 13.5307, 75.9298, 9.5664, 29.5383, 70.0352, 6.5026, 9.0406, 88.3071, 48.6055, 10.0267, 47.2602, 21.7043, 60.314, 51.6581, 43.1595, 24.2267, 67.0376, 30.3821, 77.8219, 2.8559, 75.8259, 56.4739, 20.0214, 42.435, 52.7121, 1.343, 90.7906, 61.0046, 93.3635]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
