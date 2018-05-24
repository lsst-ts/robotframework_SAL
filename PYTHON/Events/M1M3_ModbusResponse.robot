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
