*** Settings ***
Documentation    M1M3_ModbusResponse sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ModbusResponse
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 8.1525 0 -206 -7212 3265 -32196 26783 16918 -32372 27617 -6189 -5455 -19314 7538 -23068 -19954 24392 6692 -19167 24522 2239 -30925 -24892 13416 6281 -25522 5985 -29559 -28231 -11778 -83 18882 -3316 -6823 10003 20887 -9114 -25923 -12177 -1550 21441 -18989 19600 -27969 -1799 4979 -19727 4307 -15204 -2132 16254 10908 11427 -23052 -23246 -7679 -7366 -9628 -18081 1102 -15065 -26096 18737 3756 -16091 15997 -19617 20725 -1900 1331 3073 11545 -29862 -26048 -26991 5552 12396 5749 17674 8278 -25998 -21612 25079 -13916 -7100 -3384 16732 7134 -22022 29679 11874 -16929 3145 -13160 8701 9153 16988 22966 554 28407 6357 10285 -17978 5309 -13774 7663 -28110 -11487 12582 -24726 -19022 -24803 13440 752 -21624 -27182 -3564 -26768 24042 -14966 -7213 488 18032 29579 -11937 25025 -9900 5667 28904 -30001 -31916 -19172 12805 -16865 -14151 25594 29417 13955 -16480 -30657 17173 18474 8090 -32448 -28245 -9824 -6264 -14653 -11891 26781 -314 -27992 18262 -26098 11319 -28955 -20543 -1252 -349 15119 -21564 20842 -3809 13522 23850 -21250 -31040 -11457 -22649 25017 13965 -9704 -9467 -19721 -20541 17812 -29947 -9675 -1028 9795 30567 -11909 22636 -16075 25951 28756 -1716 19415 -22790 17462 -27687 8256 16774 -17586 2126 17342 -30037 -14205 -30050 16446 18220 12873 16156 -24236 10972 9714 2233 -6925 16971 -5495 21492 -2340 -24945 -30388 -20935 7128 -30327 27519 -19370 -13164 -2950 11634 -30935 6892 17244 1498 3949 -6778 -23963 29258 -3449 17009 -8594 17599 -16234 -28285 47 -28774 5845 -1141 6451 238 -3292 -6989 25063 -18031 -1881 -9922 -656 28033 27309 10032 26030 19112 24070 -23596 -218 21356 1255875306
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ModbusResponse writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ModbusResponse generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1255875306
    Log    ${output}
    Should Contain X Times    ${output}    === Event ModbusResponse received =     1
    Should Contain    ${output}    Timestamp : 8.1525
    Should Contain    ${output}    ResponseValid : 0
    Should Contain    ${output}    Address : -206
    Should Contain    ${output}    FunctionCode : -7212
    Should Contain    ${output}    DataLength : 3265
    Should Contain    ${output}    Data : -32196
    Should Contain    ${output}    CRC : 26783
    Should Contain    ${output}    priority : 16918
