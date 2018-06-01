*** Settings ***
Documentation    M1M3_ModbusResponse communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ModbusResponse
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ResponseValid Address FunctionCode DataLength Data CRC priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 31.3634 1 29640 12245 -8244 22167 -8286 1357 -23786 -20486 5695 -3699 15090 27181 -833 -8582 14364 -22508 -4649 -12181 29431 2040 30913 -7091 -13921 -9905 11156 -11447 3495 25972 11097 -13115 -6075 2931 17160 19909 -15216 -7705 -30306 30994 -18156 30519 31458 21882 17013 1394 -31640 6334 11084 -5356 -12277 -11316 -5447 -7361 -4617 3971 -7426 26134 31122 -17561 -24328 4857 22066 24448 22923 31367 -28460 8519 -19792 -15768 -15156 11162 10420 -16808 -11374 25443 -26444 31000 16074 21899 23158 12970 -16305 -17224 -2297 4316 -8200 26445 23474 7000 11941 -12086 8855 27297 12759 -31687 1725 -30105 8578 15666 -5962 -24877 -8147 18298 4160 -19064 -25652 -12923 -2420 -5683 27114 22048 3813 6860 -32259 31240 15217 26879 -11636 18252 -21873 22761 2320 16418 30963 27997 -31743 -12258 4149 -2235 -9514 21255 -25477 30866 22590 2867 -4009 8669 9060 26756 29920 -2119 27524 7351 -27060 11740 32619 -414 -27048 22630 -25367 29415 19279 16489 18692 99 2441 -1901 -27248 -22020 -10727 18271 3144 -17360 2460 -7049 8515 27071 30840 -1191 -6019 26160 -6812 18568 10507 26903 -18491 22224 -26667 -22350 -23417 -14236 5172 -27124 12853 24978 -9449 23556 31176 13023 -23498 4845 -6805 -22915 -8224 18427 -29974 -25322 9227 -18800 -32065 -12459 19065 26939 15048 11092 1717 -30010 -19650 -1597 29903 1697 -9022 -808 -32283 8986 22544 17249 -7704 -3534 -11967 14221 15754 11979 -12003 7862 13126 15246 -19828 28165 1572 94 16769 -24667 10604 27172 13821 -2236 -31956 -25691 -9638 28851 -19326 -17148 -11075 15564 4660 9301 -3282 -1535 -27627 11685 21435 -6373 -29408 12890 6878 27277 -79171013
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ModbusResponse writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
