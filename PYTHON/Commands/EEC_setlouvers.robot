*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 772 -16150 519 -10741 498 -19862 477 21159 224 -28946 203 -9132 950 20087 929 15081 676 5037 655 -2411 402 1559 380 -19152 127 9248 106 -11300 85 19659 832 25868 811 21678 558 22487 537 10485 284 20863 101 -2278 80 -31774 827 18165 806 -25426 553 4491 532 -31880 511 -232 257 -29042 236 -26198 983 7702 962 957 709 -22265 688 -32089 435 -30280 414 -20079 161 13982 140 14117 119 18890 866 21078 844 13369 591 -8290 570 -15918 317 -22710 296 -5872 43 20881 22 2124 769 16878 748 -26722 495 15435 474 -12048 453 -15531 270 6423 17 -25799 996 599 743 12649 721 -13593 468 19951 447 4065 194 -28793 173 8530
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 772 -16150 519 -10741 498 -19862 477 21159 224 -28946 203 -9132 950 20087 929 15081 676 5037 655 -2411 402 1559 380 -19152 127 9248 106 -11300 85 19659 832 25868 811 21678 558 22487 537 10485 284 20863 101 -2278 80 -31774 827 18165 806 -25426 553 4491 532 -31880 511 -232 257 -29042 236 -26198 983 7702 962 957 709 -22265 688 -32089 435 -30280 414 -20079 161 13982 140 14117 119 18890 866 21078 844 13369 591 -8290 570 -15918 317 -22710 296 -5872 43 20881 22 2124 769 16878 748 -26722 495 15435 474 -12048 453 -15531 270 6423 17 -25799 996 599 743 12649 721 -13593 468 19951 447 4065 194 -28793 173 8530
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : 772    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [772, -16150, 519, -10741, 498, -19862, 477, 21159, 224, -28946, 203, -9132, 950, 20087, 929, 15081, 676, 5037, 655, -2411, 402, 1559, 380, -19152, 127, 9248, 106, -11300, 85, 19659, 832, 25868, 811, 21678, 558, 22487, 537, 10485, 284, 20863, 101, -2278, 80, -31774, 827, 18165, 806, -25426, 553, 4491, 532, -31880, 511, -232, 257, -29042, 236, -26198, 983, 7702]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
