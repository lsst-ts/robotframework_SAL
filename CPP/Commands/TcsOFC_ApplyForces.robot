*** Settings ***
Documentation    TcsOFC_ApplyForces commander/controller tests.
Force Tags    cpp    TSS-2625
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsOfc
${component}    ApplyForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 96.4515 91.4008 19.9948 61.2536 50.0129 10.3835 3.205 47.4963 69.9816 64.1763 40.5711 99.5032 63.7931 14.927 93.8192 66.0895 86.9811 63.1752 58.9981 56.3798 63.9999 32.4728 81.0703 87.5845 0.3039 46.9184 44.1026 11.6866 62.956 38.4728 78.7232 60.4724 78.3838 31.7061 82.6324 21.9793 63.8215 17.1047 4.7099 72.1899 29.3378 73.7875 65.5499 82.8715 64.7872 46.246 13.7656 89.3682 8.2967 77.1602 77.48 86.9035 63.4757 79.0054 63.6709 39.9978 96.1341 80.9905 49.0116 72.6581 90.3897 86.4429 24.6014 46.4097 55.1741 10.1962 25.0157 70.9973 40.0091 97.1485 98.5828 47.8349
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 96.4515 91.4008 19.9948 61.2536 50.0129 10.3835 3.205 47.4963 69.9816 64.1763 40.5711 99.5032 63.7931 14.927 93.8192 66.0895 86.9811 63.1752 58.9981 56.3798 63.9999 32.4728 81.0703 87.5845 0.3039 46.9184 44.1026 11.6866 62.956 38.4728 78.7232 60.4724 78.3838 31.7061 82.6324 21.9793 63.8215 17.1047 4.7099 72.1899 29.3378 73.7875 65.5499 82.8715 64.7872 46.246 13.7656 89.3682 8.2967 77.1602 77.48 86.9035 63.4757 79.0054 63.6709 39.9978 96.1341 80.9905 49.0116 72.6581 90.3897 86.4429 24.6014 46.4097 55.1741 10.1962 25.0157 70.9973 40.0091 97.1485 98.5828 47.8349
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetpoint : 96.4515    1
    Should Contain    ${output}    === command ApplyForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetpoint : 96.4515    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
