*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
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
${component}    HardpointActuatorInfo
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ReferencePosition ModbusSubnet ModbusAddress XPosition YPosition ZPosition ILCUniqueId ILCApplicationType NetworkNodeType ILCSelectedOptions NetworkNodeOptions MajorRevision MinorRevision ADCScanRate MainLoadCellCoefficient MainLoadCellOffset MainLoadCellSensitivity BackupLoadCellCoefficient BackupLoadCellOffset BackupLoadCellSensitivity priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 48.3235 29072 5993 20632 13364 10483 10067 -2131572169 -1339885309 534604385 -535089592 1212451192 1425569920 32666 18123 23226 8330 -6198 -24898 31834 -29531 -13624 17895 1753 -1434 0.102428642078 0.458703149816 0.317910160371 0.552554272447 0.338401608396 0.144654020071 0.60390206227 0.611925821302 0.626011006063 0.950618895585 0.123880699891 0.203148283292 0.0435495867478 0.0534372672872 0.150697041141 0.699843084774 0.580819298395 0.193148406589 test test test test test test -22123 15820 -12547 -8520 14071 7291 18778 -7897 32408 7280 11543 -21020 15265 -11165 10783 -853 8466 -18560 30600 2467 -1429 -21957 25651 3093 24064 23539 -2159 4227 3883 -10220 -14464 -10692 7392 -3680 -9275 -4517 30210 4129 18303 -24968 -26614 -1528 0.488027644877 0.681927202588 0.151230272841 0.195164930863 0.872918054003 0.705252252991 0.159238223347 0.292101302819 0.697655724442 0.627414981252 0.815085446581 0.688907734633 0.0959219867396 0.450447465096 0.395542162201 0.148391724461 0.190934523906 0.0759948836224 0.343826953874 0.444555455532 0.813027602744 0.762773351822 0.867591459469 0.586388695288 0.24187185324 0.0429593951973 0.577451495767 0.818390950407 0.657801344523 0.0557607891579 0.740575157094 0.660895984821 0.681835427252 0.79125714386 0.498869709605 0.152571261731 -703478000
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
