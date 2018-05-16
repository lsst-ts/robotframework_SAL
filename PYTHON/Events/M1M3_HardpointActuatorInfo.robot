*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 46.6206 -810 11668 -24310 16153 -25814 15443 -1027545609 1869541502 -2053237833 176682175 -621893524 -162451856 3417 15607 437 -10427 -912 -31222 23714 19779 18418 -21124 218 28502 0.741301032697 0.405151522302 0.472792934854 0.479287226644 0.646477693109 0.458028291777 0.3254090647 0.458524458478 0.670195592324 0.277828565002 0.971902345972 0.471036414148 0.606074956716 0.48649657216 0.58388956744 0.949938058435 0.257903012849 0.953543719369 test test test test test test 31257 5102 -17594 -23728 -24494 19783 -25246 -4319 -2057 -21795 -26507 13529 -27776 -22907 29501 28223 28896 6073 20377 -15932 -4742 -28881 20161 24307 -720 -8797 -710 -22092 -13366 7141 25413 4508 544 -29909 12380 -19871 -12876 -13149 7276 10929 -16280 20817 0.236779791912 0.575258437319 0.732360899847 0.509161373783 0.139400680597 0.687769444207 0.238321904036 0.169256667752 0.225046895239 0.0117471500788 0.861172987155 0.918007256067 0.0299409181205 0.760125356266 0.828453198044 0.85019751052 0.217700107884 0.639678994437 0.816716065044 0.00612345955612 0.93277407305 0.810925883408 0.551091187454 0.262979257677 0.63108533447 0.991847396492 0.564433185245 0.2802610674 0.0257436352901 0.84319947973 0.519140262606 0.78683994366 0.962054598914 0.812098343261 0.0683237126406 0.317099542503 -225968539
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
