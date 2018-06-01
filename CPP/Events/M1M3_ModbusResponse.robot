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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 67.3988 0 13377 -18565 29836 -4324 -22723 11002 28192 9253 -20464 24355 24644 21524 -2940 32129 -23514 -30306 -26339 -32016 -22580 5815 15966 -24024 23344 -21822 -6069 25545 -20706 -7251 -28377 -25076 18075 -10943 16689 21602 -11749 -28000 25479 27109 -3409 -30526 29362 -13744 474 -17641 12482 -26136 -27870 -18432 -17839 727 -30572 4865 -16422 -21180 10718 302 -12193 -18842 -31039 -23021 10456 18468 14142 -17494 32647 -9638 -9264 -5246 -3780 -6452 28803 -22209 -9472 16168 5513 6416 -18729 -22867 -8350 -11960 14860 -6651 29473 17400 22984 -7001 -3145 -11619 21772 15163 7134 25264 -11691 32094 -14998 -3858 -5915 30211 25263 29708 25305 -4707 16168 31726 11883 21607 -24414 30503 16733 -27016 -19617 -18744 -4101 32597 25336 31590 -1427 -23772 -22153 7076 22979 -6493 -8817 22957 8091 -30621 -12679 -10503 -27651 27640 31672 23572 17842 21638 21790 -7570 29562 406 -9683 -15595 -17777 19296 5344 -15897 4016 -20010 -2883 -6773 -32018 9845 -19330 3366 29707 -26670 23765 2213 20459 -19988 -18549 -28327 -10462 -14758 -29727 2959 -15588 22482 -28646 -6538 24540 -24434 -9372 -7521 -26858 30372 30044 24569 18400 11691 487 4116 10764 -6973 -23401 20675 5181 -19789 20819 -2273 703 16463 5737 32527 12132 23559 26830 296 -480 -4926 -10400 -8028 24953 -3892 -23432 -13692 24469 -5171 10791 17939 13321 18349 14931 -96 -11690 -25768 -7835 17367 8161 1175 -12379 -81 21746 5240 -19628 -11402 -16968 -30154 -3475 -28578 -21693 17808 -18561 -10497 16433 12637 26236 14373 -7807 13346 11903 -24985 -26314 23775 -10730 -15901 4654 -31713 32111 20668 5941 -22861 4990 10801 -3399 -10574 682 24960 -1239180315
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ModbusResponse writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ModbusResponse generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1239180315
    Log    ${output}
    Should Contain X Times    ${output}    === Event ModbusResponse received =     1
    Should Contain    ${output}    Timestamp : 67.3988
    Should Contain    ${output}    ResponseValid : 0
    Should Contain    ${output}    Address : 13377
    Should Contain    ${output}    FunctionCode : -18565
    Should Contain    ${output}    DataLength : 29836
    Should Contain    ${output}    Data : -4324
    Should Contain    ${output}    CRC : -22723
    Should Contain    ${output}    priority : 11002
