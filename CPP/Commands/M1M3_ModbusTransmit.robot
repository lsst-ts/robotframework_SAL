*** Settings ***
Documentation    M1M3_ModbusTransmit communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ModbusTransmit
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 869342672 -17514 29641 19372 -24597 -24967 27276 -20853 11024 23208 5779 -28689 -22190 -4406 18517 -23704 29216 -19403 -21454 -331 7739 19153 20711 27136 -16717 32062 -27017 -29724 2909 -19878 -23907 11666 -8617 -18784 -15351 -30628 10034 10721 -20708 2061 -7994 -141 -6270 -27549 -17440 -27844 23239 -25602 18885 9001 -27244 -81 9682 -18591 -11489 14881 -11839 23210 11146 8117 -17380 10566 -23797 28559 -4568 24472 -14074 -27323 25988 -1313 -26009 -3016 7564 -27869 -15738 -26879 -26503 27654 -15611 17803 26108 4847 -25765 23060 14110 -11893 4144 30492 15230 8653 -23812 31542 5458 -22120 18791 23515 -5264 6476 21260 -3632 22868 -31370 31603 -9119 -19286 2105 31111 1570 2965 18589 28048 2187 -1490 -15887 -12129 -15872 20903 -2187 -15211 -20773 18482 -16979 1557 20148 -24668 -31891 -24572 23623 -3524 10932 -27042 -14212 2189 19513 -219 -31035 -13677 -4915 626 8245 -14907 13052 -9476 12676 3982 -13938 -20929 10124 27601 10769 -24628 -3048 27178 11783 13087 -20418 -26974 -31623 -5853 24211 30725 -2165 13330 21992 -5652 28378 -28195 -26561 -29300 -11354 -2266 -1184 -17170 28178 -1869 20957 -2944 -17333 30085 4741 -29769 -19117 5848 14541 -15568 23942 25032 2168 -23259 -25283 -4508 -8106 11463 16697 -3911 31463 -13506 17 3149 -11406 -15298 -27428 -23475 -4811 32210 26855 1111 -32674 -12111 -29262 -8003 14934 -7029 -7273 -20010 9890 24958 13824 8173 30784 -27015 -14092 -24222 -9596 -17774 19460 -15613 20195 9995 -8585 -16587 8218 30751 -1808 5455 -29272 32110 6047 6200 32667 -6119 -9236 5545 31674 9691 -10679 30477 -26480 15359 7226 21143 -31478 27860 -9840 6389
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 869342672 -17514 29641 19372 -24597 -24967 27276 -20853 11024 23208 5779 -28689 -22190 -4406 18517 -23704 29216 -19403 -21454 -331 7739 19153 20711 27136 -16717 32062 -27017 -29724 2909 -19878 -23907 11666 -8617 -18784 -15351 -30628 10034 10721 -20708 2061 -7994 -141 -6270 -27549 -17440 -27844 23239 -25602 18885 9001 -27244 -81 9682 -18591 -11489 14881 -11839 23210 11146 8117 -17380 10566 -23797 28559 -4568 24472 -14074 -27323 25988 -1313 -26009 -3016 7564 -27869 -15738 -26879 -26503 27654 -15611 17803 26108 4847 -25765 23060 14110 -11893 4144 30492 15230 8653 -23812 31542 5458 -22120 18791 23515 -5264 6476 21260 -3632 22868 -31370 31603 -9119 -19286 2105 31111 1570 2965 18589 28048 2187 -1490 -15887 -12129 -15872 20903 -2187 -15211 -20773 18482 -16979 1557 20148 -24668 -31891 -24572 23623 -3524 10932 -27042 -14212 2189 19513 -219 -31035 -13677 -4915 626 8245 -14907 13052 -9476 12676 3982 -13938 -20929 10124 27601 10769 -24628 -3048 27178 11783 13087 -20418 -26974 -31623 -5853 24211 30725 -2165 13330 21992 -5652 28378 -28195 -26561 -29300 -11354 -2266 -1184 -17170 28178 -1869 20957 -2944 -17333 30085 4741 -29769 -19117 5848 14541 -15568 23942 25032 2168 -23259 -25283 -4508 -8106 11463 16697 -3911 31463 -13506 17 3149 -11406 -15298 -27428 -23475 -4811 32210 26855 1111 -32674 -12111 -29262 -8003 14934 -7029 -7273 -20010 9890 24958 13824 8173 30784 -27015 -14092 -24222 -9596 -17774 19460 -15613 20195 9995 -8585 -16587 8218 30751 -1808 5455 -29272 32110 6047 6200 32667 -6119 -9236 5545 31674 9691 -10679 30477 -26480 15359 7226 21143 -31478 27860 -9840 6389
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ActuatorId : 869342672    1
    Should Contain X Times    ${output}    FunctionCode : -17514    1
    Should Contain X Times    ${output}    Data : 29641    1
    Should Contain X Times    ${output}    DataLength :     1
    Should Contain    ${output}    === command ModbusTransmit issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ModbusTransmit received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ActuatorId : 869342672    1
    Should Contain X Times    ${output}    FunctionCode : -17514    1
    Should Contain X Times    ${output}    Data : 29641    1
    Should Contain X Times    ${output}    DataLength :     1
    Should Contain X Times    ${output}    === [ackCommand_ModbusTransmit] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
