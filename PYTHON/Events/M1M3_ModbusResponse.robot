*** Settings ***
Documentation    M1M3_ModbusResponse sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 67.0922 0 -20751 15881 23516 -27165 -25185 10223 5009 -18107 -25443 14504 -2906 -20587 -8841 31734 -4481 -21436 9264 -2139 911 -15506 -1430 -26105 19383 -2821 -16577 20032 11951 25908 -18285 -5068 26836 -21062 9863 30110 -21563 -19876 20871 -7087 6082 -9737 -31663 -32124 -21082 23555 -28195 12207 27243 -16028 30624 7318 -26131 4622 13269 10059 2991 6246 25275 -7252 26443 25269 14311 5787 -32627 -18493 24539 -30788 -451 4148 3348 -26594 -22875 -25930 12288 29990 -24999 -28015 18675 -24837 26898 13766 -18798 -29258 503 32611 4873 891 19359 26193 -15517 -28591 -21593 16303 20838 11824 26341 18380 -3994 -5580 31384 -26088 -7281 -26948 -26667 -1803 20556 -27099 8547 28256 5365 28345 11219 26616 -21571 -5227 -8265 21165 10350 9778 9998 -574 2750 -10344 24900 -30034 -4281 -21831 1191 -20437 -1550 -13258 2999 -10184 27692 -25596 5307 -28368 -3351 9230 21987 -8591 29659 4097 -7566 2682 8280 26388 30807 -26100 -13294 -3663 -21740 31277 14824 11541 -25012 -31318 20239 -22694 23798 3227 2422 -28114 -18213 20186 32399 -20097 22293 17172 17116 17026 24170 291 251 19446 -32460 -15278 -25990 -26372 2830 19792 -30193 -29462 -28133 -9834 15962 2488 -8838 -19725 -30070 2284 -19625 16460 -17775 21795 -24353 21690 -30291 -24535 10165 18227 25275 -22151 -14527 -25918 -14494 -23080 5764 -29961 11152 -16275 15995 30872 -26406 30735 -6605 590 -21905 21078 7104 16241 13228 -5150 19547 6752 -1580 -2191 23455 -10407 -12502 1672 2302 -800 30946 31926 -7836 6058 31937 24521 9551 8495 29938 3466 13410 16900 -14036 -4961 -16049 2223 -20095 6615 24489 -20039 24491 -23340 17259 64939 -140092498
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 37.1165 0 13425 -7912 -701 19760 -10542 21255 26287 9266 -18652 19059 -8442 7135 -20456 -27455 6080 -16855 -5704 12864 -11500 28768 465 16823 -13708 12358 -3992 14359 -30147 21702 28609 -2353 -3380 9354 -30159 -10106 -30767 32666 30990 1040 2719 -25047 843 -9379 -21794 -22350 5674 8552 13134 22068 16714 29994 13894 -23886 -15123 -29021 -32121 -22015 -19217 4614 -30147 2298 -2219 -22027 6940 26233 12475 4793 -7606 22058 -13874 -3142 11555 -29917 -26592 -10930 16572 -5548 -11392 15904 16995 -6407 7326 -7061 -5356 -18516 6190 7264 22140 -5590 -16120 17365 31900 -22092 -371 -1997 24791 -730 26862 -27446 -26813 -20497 31866 6410 12522 -3933 -31966 26880 -6798 -3743 -4781 -9021 -17183 -10619 17505 23670 -22242 2791 -14984 31327 16196 16997 4236 -29552 14839 -3770 -7952 19313 25439 -16410 -23000 19584 1878 17447 -30313 25728 -8121 -18126 13816 4317 12765 21441 -1460 -13678 187 21983 -25770 -12922 10125 20440 26937 17101 -12757 -23223 6583 -19059 -32244 -30967 16895 -25728 -11931 30217 -13532 84 6837 17422 -15839 -14736 -10787 17688 -27842 28732 32722 4026 -32448 5727 12054 26377 2585 17517 -16368 31423 26067 -28881 -12140 25714 -31050 14567 -21323 -13434 26756 -15539 -22290 -25407 -9536 -21268 27436 30768 1374 28048 -22903 -9800 -12088 13214 25682 14444 8619 -16884 -13724 -31775 4530 -12667 -32498 7610 24756 -25009 -9963 -31798 -9911 920 25981 4918 -22874 10261 -4373 -26678 -14071 4726 -9733 -20472 -16314 16615 15926 19355 21876 30103 -25811 -13568 -10216 -741 24696 20721 -9507 -6821 -28456 -18787 936 17875 11229 7657 -2347 -5557 30022 -29743 24018 28630 29918 2596 1863571748
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
