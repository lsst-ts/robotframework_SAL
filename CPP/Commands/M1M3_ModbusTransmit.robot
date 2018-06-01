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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -390512529 -29914 -3929 -9261 12766 23122 1319 31943 18890 -22598 -6786 22042 21209 23472 6303 12934 -7426 -12544 27794 5216 18500 5797 -26108 8516 7906 2937 15872 23640 -32097 -12368 13921 1802 -14982 -1647 278 31384 -26490 -3620 -16254 21065 -9399 -11249 -4494 20692 8544 19244 -28369 24007 5173 22759 -14009 17347 -29475 -19731 -28648 11627 17652 21958 1782 3573 21378 10661 -3282 10658 -4180 28361 3290 -19627 -14321 -31953 29946 16701 -13354 -19809 -30856 -19953 19521 6517 23353 4585 -13544 20824 14980 -28257 6715 25340 28174 16991 -16121 25393 7493 5581 10579 -15312 -12840 8029 24860 10431 -9264 -25541 25872 8164 17811 23004 -10098 -12260 4279 -11412 29759 -30240 -31301 31707 26679 9408 3457 -9194 -4256 30393 16646 -9407 7913 31622 -4658 3948 -31001 32546 -2795 3292 -16695 -28539 21665 18456 -2702 -30721 -2284 -21173 11295 13256 -6496 5373 -23021 10914 30339 13473 -29551 -21547 -29052 -28267 -30946 -28680 -20753 -11061 25697 1038 -7204 -8017 14498 -8616 9102 -5970 -396 -23310 -24300 -2866 -21495 30812 20505 28527 -16715 -31081 -13209 -26573 -5963 16365 20708 20531 -11390 26842 13040 31458 4470 -30295 -14369 -8673 -2298 -25786 9945 22145 -20927 27509 -24784 34 11501 29406 -7533 6332 -7878 -13411 -28063 -5634 -22043 1741 22011 21669 -6062 14223 14238 10610 26343 21491 -7148 14144 -13163 -20969 -19711 -27563 -3953 -4738 -17137 7721 7362 -8975 -19273 17451 -17214 15292 19592 28880 -23620 29654 -14058 17283 28227 18779 -5545 -22661 -15081 -92 -27793 26772 30534 -17054 9228 14254 22379 -2407 15950 -6048 -28354 -31681 -9287 -29967 31924 -15377 -29566
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -390512529 -29914 -3929 -9261 12766 23122 1319 31943 18890 -22598 -6786 22042 21209 23472 6303 12934 -7426 -12544 27794 5216 18500 5797 -26108 8516 7906 2937 15872 23640 -32097 -12368 13921 1802 -14982 -1647 278 31384 -26490 -3620 -16254 21065 -9399 -11249 -4494 20692 8544 19244 -28369 24007 5173 22759 -14009 17347 -29475 -19731 -28648 11627 17652 21958 1782 3573 21378 10661 -3282 10658 -4180 28361 3290 -19627 -14321 -31953 29946 16701 -13354 -19809 -30856 -19953 19521 6517 23353 4585 -13544 20824 14980 -28257 6715 25340 28174 16991 -16121 25393 7493 5581 10579 -15312 -12840 8029 24860 10431 -9264 -25541 25872 8164 17811 23004 -10098 -12260 4279 -11412 29759 -30240 -31301 31707 26679 9408 3457 -9194 -4256 30393 16646 -9407 7913 31622 -4658 3948 -31001 32546 -2795 3292 -16695 -28539 21665 18456 -2702 -30721 -2284 -21173 11295 13256 -6496 5373 -23021 10914 30339 13473 -29551 -21547 -29052 -28267 -30946 -28680 -20753 -11061 25697 1038 -7204 -8017 14498 -8616 9102 -5970 -396 -23310 -24300 -2866 -21495 30812 20505 28527 -16715 -31081 -13209 -26573 -5963 16365 20708 20531 -11390 26842 13040 31458 4470 -30295 -14369 -8673 -2298 -25786 9945 22145 -20927 27509 -24784 34 11501 29406 -7533 6332 -7878 -13411 -28063 -5634 -22043 1741 22011 21669 -6062 14223 14238 10610 26343 21491 -7148 14144 -13163 -20969 -19711 -27563 -3953 -4738 -17137 7721 7362 -8975 -19273 17451 -17214 15292 19592 28880 -23620 29654 -14058 17283 28227 18779 -5545 -22661 -15081 -92 -27793 26772 30534 -17054 9228 14254 22379 -2407 15950 -6048 -28354 -31681 -9287 -29967 31924 -15377 -29566
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ActuatorId : -390512529    1
    Should Contain X Times    ${output}    FunctionCode : -29914    1
    Should Contain X Times    ${output}    Data : -3929    1
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
    Should Contain X Times    ${output}    ActuatorId : -390512529    1
    Should Contain X Times    ${output}    FunctionCode : -29914    1
    Should Contain X Times    ${output}    Data : -3929    1
    Should Contain X Times    ${output}    DataLength :     1
    Should Contain X Times    ${output}    === [ackCommand_ModbusTransmit] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
