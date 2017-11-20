*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
Force Tags    python    
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ReferencePosition XPosition YPosition ZPosition ILCUniqueId ILCApplicationType NetworkNodeType ILCSelectedOptions NetworkNodeOptions MajorRevision MinorRevision ADCScanRate MainADCCalibrationK1 MainADCCalibrationK2 MainADCCalibrationK3 MainADCCalibrationK4 MainLoadCellOffset MainLoadCellSensitivity BackupADCCalibrationK1 BackupADCCalibrationK2 BackupADCCalibrationK3 BackupADCCalibrationK4 BackupLoadCellOffset BackupLoadCellSensitivity MainCalibrationError BackupCalibrationError UniqueIdCRCError ApplicationTypeMismatch ApplicationMissing ApplicationCRCMismatch OneWireMissing OneWire1Mismatch OneWire2Mismatch priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 39.4455 -356817469 586533185 -2050658659 -149419599 -1704886176 1119082517 1317322416 1298652482 2082625564 -187423552 -241633962 -1182574917 0.900989641672 0.0479538858214 0.621819704595 0.384988993781 0.84252989023 0.0108958475552 0.912748711173 0.665356245096 0.844325009763 0.957010018933 0.425246752214 0.0545442470708 0.7672220619 0.139717680583 0.214668047253 0.48905285225 0.972692432594 0.0430046090255 test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test 0.681202931813 0.458397452243 0.680483793861 0.447682081282 0.914006373683 0.227242974449 0.0187145785684 0.988992300815 0.0490474399297 0.151189301609 0.51060455834 0.380968015462 0.0825935584568 0.284502909363 0.00541168978971 0.609926805074 0.620877450192 0.209864895844 0.196849121257 0.547521108585 0.803307810103 0.922863127672 0.880927693652 0.788645783327 0.621856447841 0.25186052066 0.877064094489 0.0616522905887 0.153463680383 0.530934087397 0.968839212879 0.201691612846 0.805628495618 0.077355708519 0.24386587764 0.358829270411 0.918501377557 0.0120062520187 0.061906951586 0.0343279795327 0.117207849223 0.972598574829 0.170464315568 0.284351051703 0.949277385805 0.872011885538 0.630430198711 0.329394765246 0.721814850089 0.433188124408 0.356374163738 0.364282607963 0.0994076742291 0.286124608118 0.205722474243 0.219645087338 0.287903135312 0.685958449879 0.293109952947 0.245539593571 0.637526325258 0.514494673905 0.427669576788 0.518962221847 0.362072388664 0.376973066714 0.815305955894 0.448143618179 0.549132397687 0.365631323736 0.0520522740297 0.386942221565 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 1 1 1 1 0 0 0 1 0 1 0 1 0 0 1 1 1 0 1 1 0 1 0 0 0 0 -599799561
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
