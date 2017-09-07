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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 10996 -26451 10874 -24962 -32673 -9781 -12123 -13239 8921 4271 2374 -10630 8476 -287 -21483 -4206 -25126 16502 15361 11172 20645 19476 11410 32589 -24871 4683 -263 25732 -6154 29642 -530 25164 4.2115 47.1439 13.6679 44.9038 58.5321 23.3238 0.2368 58.7317 14.5098 6.2627 42.6568 66.1665 17.7581 93.606 59.5818 6.2722 30.9771 53.2655 39.1872 29.9949 31.3477 83.4799 14.1882 9.9094 39.0897 25.2765 62.6644 3.1621 5.8275 47.4128 66.9372 17.3449
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 10996 -26451 10874 -24962 -32673 -9781 -12123 -13239 8921 4271 2374 -10630 8476 -287 -21483 -4206 -25126 16502 15361 11172 20645 19476 11410 32589 -24871 4683 -263 25732 -6154 29642 -530 25164 4.2115 47.1439 13.6679 44.9038 58.5321 23.3238 0.2368 58.7317 14.5098 6.2627 42.6568 66.1665 17.7581 93.606 59.5818 6.2722 30.9771 53.2655 39.1872 29.9949 31.3477 83.4799 14.1882 9.9094 39.0897 25.2765 62.6644 3.1621 5.8275 47.4128 66.9372 17.3449
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : 10996    1
    Should Contain X Times    ${output}    bendingModeValue : 4.2115    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [10996, -26451, 10874, -24962, -32673, -9781, -12123, -13239, 8921, 4271, 2374, -10630, 8476, -287, -21483, -4206, -25126, 16502, 15361, 11172, 20645, 19476, 11410, 32589, -24871, 4683, -263, 25732, -6154, 29642, -530, 25164]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [4.2115, 47.1439, 13.6679, 44.9038, 58.5321, 23.3238, 0.2368, 58.7317, 14.5098, 6.2627, 42.6568, 66.1665, 17.7581, 93.606, 59.5818, 6.2722, 30.9771, 53.2655, 39.1872, 29.9949, 31.3477, 83.4799, 14.1882, 9.9094, 39.0897, 25.2765, 62.6644, 3.1621, 5.8275, 47.4128, 66.9372, 17.3449]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
