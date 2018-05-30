*** Settings ***
Documentation    M1M3_ModbusResponse communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 95.5752 0 -32741 -15437 25848 -15675 16451 25344 2792 11004 -26967 -12861 11150 12711 -15657 -9200 18019 16437 5980 10597 24944 17274 -15581 31160 32482 18972 -1431 24561 23270 -26988 11648 -24323 -19950 19000 11431 21471 15028 14028 14640 31506 25372 6149 4401 27344 -11167 29854 5309 -5090 30620 -11663 15963 22923 -23006 -10342 14625 8424 2720 7393 -2482 20200 4487 -13255 4692 -8481 -13453 25738 -11068 -18973 5049 -11629 9653 32298 -28306 -23574 28582 32744 -24188 30173 10556 -10834 22636 5698 -158 -21155 2404 -31909 963 28785 -30142 -4411 -18699 2195 -28655 -7893 -6005 -18530 -30392 7556 21776 -4039 7963 8476 2213 -6563 -23463 -32379 -1270 -31626 -15568 -9245 -11713 23196 -5856 -18436 19479 -22141 -24914 6575 -12459 31329 -20735 32054 21033 8367 -24800 -25217 23626 2102 -29723 -25226 14882 30127 -22604 -22166 25881 -18538 7272 -29067 -1957 4148 -23071 -26106 28924 -16965 21721 -6547 -4177 13677 5742 21911 -15662 12959 -19259 9803 -8162 -23632 -26974 -9136 -5840 18482 11034 -12330 24237 -15653 15667 -5982 -6202 -28943 436 -7634 -4563 23629 242 -28195 -24438 -22715 7901 -31720 -16740 3859 25288 -6381 -29831 -19331 24542 -11492 12433 13000 4871 -8226 -31300 -3707 29973 -2205 -7417 14670 9876 -31435 -21734 26956 4449 13575 -8981 13823 -27326 9859 -15606 1861 -9470 6071 -1302 3284 3906 -20754 19271 18325 -1168 11318 24560 -30066 21428 -10789 -30934 -4744 -8723 22699 24466 -29432 25591 19546 -18879 -9504 6949 5788 -24316 23676 3262 -879 -21069 27575 -14309 -1599 5649 24519 26167 16914 951 23082 16187 -29826 -25022 -5586 -2283 -15792 -12805 17177 -19281 63759 -2064663780
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ModbusResponse writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ModbusResponse generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2064663780
    Log    ${output}
    Should Contain X Times    ${output}    === Event ModbusResponse received =     1
    Should Contain    ${output}    Timestamp : 95.5752
    Should Contain    ${output}    ResponseValid : 0
    Should Contain    ${output}    Address : -32741
    Should Contain    ${output}    FunctionCode : -15437
    Should Contain    ${output}    DataLength : 25848
    Should Contain    ${output}    Data : -15675
    Should Contain    ${output}    CRC : 16451
    Should Contain    ${output}    priority : 25344
