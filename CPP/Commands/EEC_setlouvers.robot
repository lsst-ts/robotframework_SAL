*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
Force Tags    cpp    
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 26 -21859 773 -9606 752 19840 498 20722 477 18699 224 6362 203 25088 20 -10449 767 20926 746 1277 493 -6960 472 27895 451 -27972 198 -8416 177 3529 924 19642 903 24262 650 -417 629 3297 375 14378 354 -13752 101 -26117 80 30990 59 -25087 806 13450 785 22551 532 -27863 511 -26072 258 -2947 237 -16191 984 18378 962 -8058 709 -2154 688 -11565 435 -3919 414 -19705 393 13198 140 10418 957 -20174 936 -28190 683 -29887 662 -1751 409 -24517 388 25970 135 -4169 114 31779 93 -18337 840 -4480 818 -1113 565 -3226 544 19256 291 29581 270 5662 17 -8405 996 -12249 743 -28488 722 16356 469 2682 448 8707 427 18493
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 26 -21859 773 -9606 752 19840 498 20722 477 18699 224 6362 203 25088 20 -10449 767 20926 746 1277 493 -6960 472 27895 451 -27972 198 -8416 177 3529 924 19642 903 24262 650 -417 629 3297 375 14378 354 -13752 101 -26117 80 30990 59 -25087 806 13450 785 22551 532 -27863 511 -26072 258 -2947 237 -16191 984 18378 962 -8058 709 -2154 688 -11565 435 -3919 414 -19705 393 13198 140 10418 957 -20174 936 -28190 683 -29887 662 -1751 409 -24517 388 25970 135 -4169 114 31779 93 -18337 840 -4480 818 -1113 565 -3226 544 19256 291 29581 270 5662 17 -8405 996 -12249 743 -28488 722 16356 469 2682 448 8707 427 18493
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    position : 26    1
    Should Contain    ${output}    === command setlouvers issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command setlouvers received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    position : 26    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
