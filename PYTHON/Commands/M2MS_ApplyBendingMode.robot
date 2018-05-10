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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -7887 -9530 17534 173 31715 -20485 29518 -8936 27654 -549 23695 -16729 20871 -15527 -24247 11766 -7097 2969 24572 27910 22229 5826 10121 15063 30239 1925 -24515 -26460 -18631 1277 26455 12941 34.0812 43.8566 77.8093 10.1244 6.8827 2.5422 67.8714 0.6033 35.6059 51.4572 66.7702 40.8342 15.1457 63.2985 68.6611 7.0071 59.0225 30.8479 87.3616 91.6031 13.7356 6.8009 83.5678 30.4046 58.5725 46.9881 3.2016 59.5258 78.8027 16.5779 10.4963 1.787
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -7887 -9530 17534 173 31715 -20485 29518 -8936 27654 -549 23695 -16729 20871 -15527 -24247 11766 -7097 2969 24572 27910 22229 5826 10121 15063 30239 1925 -24515 -26460 -18631 1277 26455 12941 34.0812 43.8566 77.8093 10.1244 6.8827 2.5422 67.8714 0.6033 35.6059 51.4572 66.7702 40.8342 15.1457 63.2985 68.6611 7.0071 59.0225 30.8479 87.3616 91.6031 13.7356 6.8009 83.5678 30.4046 58.5725 46.9881 3.2016 59.5258 78.8027 16.5779 10.4963 1.787
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -7887    1
    Should Contain X Times    ${output}    bendingModeValue : 34.0812    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-7887, -9530, 17534, 173, 31715, -20485, 29518, -8936, 27654, -549, 23695, -16729, 20871, -15527, -24247, 11766, -7097, 2969, 24572, 27910, 22229, 5826, 10121, 15063, 30239, 1925, -24515, -26460, -18631, 1277, 26455, 12941]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [34.0812, 43.8566, 77.8093, 10.1244, 6.8827, 2.5422, 67.8714, 0.6033, 35.6059, 51.4572, 66.7702, 40.8342, 15.1457, 63.2985, 68.6611, 7.0071, 59.0225, 30.8479, 87.3616, 91.6031, 13.7356, 6.8009, 83.5678, 30.4046, 58.5725, 46.9881, 3.2016, 59.5258, 78.8027, 16.5779, 10.4963, 1.787]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
