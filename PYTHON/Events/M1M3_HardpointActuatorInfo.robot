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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 7.7853 -13445 -23004 4966 2608 11964 -2165 -1725744206 -1749021213 -382030954 -1993807833 -1715518597 -205931240 -3751 3630 -23516 -29404 -10402 -3392 6108 -8688 -4965 1221 -23040 8129 0.292817382105 0.909466169968 0.709629627558 0.585541912317 0.994051531211 0.5117584214 0.267834873759 0.590902122235 0.575210889853 0.655358822348 0.242246846224 0.870901832155 0.956186313983 0.483297349819 0.113015201582 0.442444643248 0.528598601953 0.625886540905 test test test test test test 15438 22680 24873 -16711 20455 12761 -19944 14632 17200 3743 -13822 11983 25479 -12528 30048 486 18348 -10928 -32149 -17175 19448 23595 19953 6314 -26165 12474 -12778 11174 -15698 -23933 12311 -3243 -10963 -9412 15059 -16768 -16144 19217 -18643 -23442 -23076 -5812 0.585846002911 0.578190839047 0.567644470635 0.331993347634 0.457051428599 0.906159037791 0.45512234401 0.34919955813 0.42215733453 0.987912703131 0.623379146641 0.0853613428101 0.651784391757 0.682812454346 0.361112050154 0.814505568137 0.145133303161 0.504552276591 0.884576821222 0.966310227028 0.169635717533 0.572426937822 0.56555092252 0.535486701862 0.511322328534 0.0655360717373 0.453540540172 0.393823444833 0.66951260466 0.0154381691501 0.572808599968 0.0376952304294 0.314073947941 0.267925371222 0.8015761386 0.425551247781 385824529
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
