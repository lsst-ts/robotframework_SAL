*** Settings ***
Documentation    MTMount_Events communications tests.
Force Tags    messaging    cpp    mtmount    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_availableSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_availableSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event availableSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_availableSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event availableSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_controllerSettingsName"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_controllerSettingsName test messages =======
    Should Contain X Times    ${output.stdout}    === Event controllerSettingsName iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_controllerSettingsName writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event controllerSettingsName generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthControllerSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthControllerSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthControllerSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthControllerSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationControllerSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationControllerSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationControllerSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationControllerSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapControllerSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapControllerSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapControllerSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapControllerSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthHomed"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthHomed test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthHomed iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthHomed writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthHomed generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationHomed"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationHomed test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationHomed iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationHomed writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationHomed generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_balanceSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_balanceSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event balanceSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_balanceSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event balanceSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mirrorCoversSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mirrorCoversSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mirrorCoversSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mirrorCoversSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mirrorCoversSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mirrorCoverLocksSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mirrorCoverLocksSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mirrorCoverLocksSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mirrorCoverLocksSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mirrorCoverLocksSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthCableWrapSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthCableWrapSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthCableWrapSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthCableWrapSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthCableWrapSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_lockingPinsSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_lockingPinsSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event lockingPinsSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_lockingPinsSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event lockingPinsSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_deployablePlatformsSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_deployablePlatformsSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event deployablePlatformsSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_deployablePlatformsSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event deployablePlatformsSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_oilSupplySystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_oilSupplySystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event oilSupplySystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_oilSupplySystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event oilSupplySystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthDrivesThermalSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthDrivesThermalSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthDrivesThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthDrivesThermalSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthDrivesThermalSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationDrivesThermalSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationDrivesThermalSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationDrivesThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationDrivesThermalSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationDrivesThermalSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cabinet0101ThermalSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cabinet0101ThermalSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event cabinet0101ThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cabinet0101ThermalSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cabinet0101ThermalSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_auxiliaryCabinetsThermalSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_auxiliaryCabinetsThermalSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event auxiliaryCabinetsThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_auxiliaryCabinetsThermalSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event auxiliaryCabinetsThermalSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mainCabinetThermalSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mainCabinetThermalSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mainCabinetThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mainCabinetThermalSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mainCabinetThermalSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mainAxesPowerSupplySystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mainAxesPowerSupplySystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mainAxesPowerSupplySystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mainAxesPowerSupplySystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mainAxesPowerSupplySystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_topEndChillerSystemState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_topEndChillerSystemState test messages =======
    Should Contain X Times    ${output.stdout}    === Event topEndChillerSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_topEndChillerSystemState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event topEndChillerSystemState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationLimits"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationLimits test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationLimits writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationLimits generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthLimits"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthLimits test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthLimits writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthLimits generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapLimits"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapLimits test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapLimits writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapLimits generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthToppleBlock"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthToppleBlock test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlock iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthToppleBlock writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthToppleBlock generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapFollowing"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapFollowing test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapFollowing iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapFollowing writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapFollowing generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_cameraCableWrapTarget"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_cameraCableWrapTarget test messages =======
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_cameraCableWrapTarget writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event cameraCableWrapTarget generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_commander"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_commander test messages =======
    Should Contain X Times    ${output.stdout}    === Event commander iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_commander writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event commander generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_connected"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_connected test messages =======
    Should Contain X Times    ${output.stdout}    === Event connected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_connected writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event connected generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_telemetryConnected"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_telemetryConnected test messages =======
    Should Contain X Times    ${output.stdout}    === Event telemetryConnected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_telemetryConnected writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event telemetryConnected generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_deployablePlatformsMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_deployablePlatformsMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event deployablePlatformsMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_deployablePlatformsMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event deployablePlatformsMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationLockingPinMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationLockingPinMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationLockingPinMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationLockingPinMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationLockingPinMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_error"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_error test messages =======
    Should Contain X Times    ${output.stdout}    === Event error iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_error writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event error generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mirrorCoverLocksMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mirrorCoverLocksMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mirrorCoverLocksMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mirrorCoverLocksMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mirrorCoverLocksMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mirrorCoversMotionState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mirrorCoversMotionState test messages =======
    Should Contain X Times    ${output.stdout}    === Event mirrorCoversMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mirrorCoversMotionState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mirrorCoversMotionState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_safetyInterlocks"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_safetyInterlocks test messages =======
    Should Contain X Times    ${output.stdout}    === Event safetyInterlocks iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_safetyInterlocks writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event safetyInterlocks generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_target"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_target test messages =======
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_target writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event target generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_warning"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_warning test messages =======
    Should Contain X Times    ${output.stdout}    === Event warning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_warning writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event warning generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_heartbeat"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_heartbeat writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_clockOffset"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_clockOffset test messages =======
    Should Contain X Times    ${output.stdout}    === Event clockOffset iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_clockOffset writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event clockOffset generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logLevel"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logLevel writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logLevel generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logMessage"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logMessage writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logMessage generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_softwareVersions"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_softwareVersions writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_errorCode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_errorCode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event errorCode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_simulationMode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_simulationMode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_summaryState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_summaryState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event summaryState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationApplied"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationApplied test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationApplied writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationApplied generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationsAvailable"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationsAvailable test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationsAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationsAvailable writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationsAvailable generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${availableSettings_start}=    Get Index From List    ${full_list}    === Event availableSettings received =${SPACE}
    ${end}=    Evaluate    ${availableSettings_start}+${5}
    ${availableSettings_list}=    Get Slice From List    ${full_list}    start=${availableSettings_start}    end=${end}
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}names : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}descriptions : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}createdDates : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modifiedDates : RO    1
    ${controllerSettingsName_start}=    Get Index From List    ${full_list}    === Event controllerSettingsName received =${SPACE}
    ${end}=    Evaluate    ${controllerSettingsName_start}+${2}
    ${controllerSettingsName_list}=    Get Slice From List    ${full_list}    start=${controllerSettingsName_start}    end=${end}
    Should Contain X Times    ${controllerSettingsName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsName : RO    1
    ${azimuthControllerSettings_start}=    Get Index From List    ${full_list}    === Event azimuthControllerSettings received =${SPACE}
    ${end}=    Evaluate    ${azimuthControllerSettings_start}+${20}
    ${azimuthControllerSettings_list}=    Get Slice From List    ${full_list}    start=${azimuthControllerSettings_start}    end=${end}
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minCmdPositionEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdPositionEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minOperationalL1LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxOperationalL1LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL2LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL2LimitEnabled : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minCmdPosition : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdPosition : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1Limit : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1Limit : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdVelocity : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveVelocity : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveAcceleration : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveJerk : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingVelocity : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingAcceleration : 1    1
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingJerk : 1    1
    ${elevationControllerSettings_start}=    Get Index From List    ${full_list}    === Event elevationControllerSettings received =${SPACE}
    ${end}=    Evaluate    ${elevationControllerSettings_start}+${22}
    ${elevationControllerSettings_list}=    Get Slice From List    ${full_list}    start=${elevationControllerSettings_start}    end=${end}
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minCmdPositionEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdPositionEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minOperationalL1LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxOperationalL1LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minOperationalL2LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxOperationalL2LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL2LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL2LimitEnabled : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minCmdPosition : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdPosition : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1Limit : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1Limit : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdVelocity : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveVelocity : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveAcceleration : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveJerk : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingVelocity : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingAcceleration : 1    1
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingJerk : 1    1
    ${cameraCableWrapControllerSettings_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapControllerSettings received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapControllerSettings_start}+${16}
    ${cameraCableWrapControllerSettings_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapControllerSettings_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1LimitEnabled : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1LimitEnabled : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL2LimitEnabled : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL2LimitEnabled : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minCmdPosition : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdPosition : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minL1Limit : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxL1Limit : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCmdVelocity : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveVelocity : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveAcceleration : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxMoveJerk : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingVelocity : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingAcceleration : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxTrackingJerk : 1    1
    ${azimuthHomed_start}=    Get Index From List    ${full_list}    === Event azimuthHomed received =${SPACE}
    ${end}=    Evaluate    ${azimuthHomed_start}+${2}
    ${azimuthHomed_list}=    Get Slice From List    ${full_list}    start=${azimuthHomed_start}    end=${end}
    Should Contain X Times    ${azimuthHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homed : 1    1
    ${elevationHomed_start}=    Get Index From List    ${full_list}    === Event elevationHomed received =${SPACE}
    ${end}=    Evaluate    ${elevationHomed_start}+${2}
    ${elevationHomed_list}=    Get Slice From List    ${full_list}    start=${elevationHomed_start}    end=${end}
    Should Contain X Times    ${elevationHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homed : 1    1
    ${azimuthSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthSystemState received =${SPACE}
    ${end}=    Evaluate    ${azimuthSystemState_start}+${3}
    ${azimuthSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthSystemState_start}    end=${end}
    Should Contain X Times    ${azimuthSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${elevationSystemState_start}=    Get Index From List    ${full_list}    === Event elevationSystemState received =${SPACE}
    ${end}=    Evaluate    ${elevationSystemState_start}+${3}
    ${elevationSystemState_list}=    Get Slice From List    ${full_list}    start=${elevationSystemState_start}    end=${end}
    Should Contain X Times    ${elevationSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${elevationSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${cameraCableWrapSystemState_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapSystemState received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapSystemState_start}+${3}
    ${cameraCableWrapSystemState_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapSystemState_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${cameraCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${balanceSystemState_start}=    Get Index From List    ${full_list}    === Event balanceSystemState received =${SPACE}
    ${end}=    Evaluate    ${balanceSystemState_start}+${4}
    ${balanceSystemState_list}=    Get Slice From List    ${full_list}    start=${balanceSystemState_start}    end=${end}
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${mirrorCoversSystemState_start}=    Get Index From List    ${full_list}    === Event mirrorCoversSystemState received =${SPACE}
    ${end}=    Evaluate    ${mirrorCoversSystemState_start}+${4}
    ${mirrorCoversSystemState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoversSystemState_start}    end=${end}
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${mirrorCoverLocksSystemState_start}=    Get Index From List    ${full_list}    === Event mirrorCoverLocksSystemState received =${SPACE}
    ${end}=    Evaluate    ${mirrorCoverLocksSystemState_start}+${4}
    ${mirrorCoverLocksSystemState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocksSystemState_start}    end=${end}
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${azimuthCableWrapSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthCableWrapSystemState received =${SPACE}
    ${end}=    Evaluate    ${azimuthCableWrapSystemState_start}+${3}
    ${azimuthCableWrapSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthCableWrapSystemState_start}    end=${end}
    Should Contain X Times    ${azimuthCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${lockingPinsSystemState_start}=    Get Index From List    ${full_list}    === Event lockingPinsSystemState received =${SPACE}
    ${end}=    Evaluate    ${lockingPinsSystemState_start}+${4}
    ${lockingPinsSystemState_list}=    Get Slice From List    ${full_list}    start=${lockingPinsSystemState_start}    end=${end}
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${deployablePlatformsSystemState_start}=    Get Index From List    ${full_list}    === Event deployablePlatformsSystemState received =${SPACE}
    ${end}=    Evaluate    ${deployablePlatformsSystemState_start}+${4}
    ${deployablePlatformsSystemState_list}=    Get Slice From List    ${full_list}    start=${deployablePlatformsSystemState_start}    end=${end}
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    ${oilSupplySystemState_start}=    Get Index From List    ${full_list}    === Event oilSupplySystemState received =${SPACE}
    ${end}=    Evaluate    ${oilSupplySystemState_start}+${7}
    ${oilSupplySystemState_list}=    Get Slice From List    ${full_list}    start=${oilSupplySystemState_start}    end=${end}
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolingPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}circulationPumpPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainPumpPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    ${azimuthDrivesThermalSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthDrivesThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${azimuthDrivesThermalSystemState_start}+${5}
    ${azimuthDrivesThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthDrivesThermalSystemState_start}    end=${end}
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    ${elevationDrivesThermalSystemState_start}=    Get Index From List    ${full_list}    === Event elevationDrivesThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${elevationDrivesThermalSystemState_start}+${5}
    ${elevationDrivesThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${elevationDrivesThermalSystemState_start}    end=${end}
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    ${cabinet0101ThermalSystemState_start}=    Get Index From List    ${full_list}    === Event cabinet0101ThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${cabinet0101ThermalSystemState_start}+${4}
    ${cabinet0101ThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${cabinet0101ThermalSystemState_start}    end=${end}
    Should Contain X Times    ${cabinet0101ThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${cabinet0101ThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${cabinet0101ThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    ${auxiliaryCabinetsThermalSystemState_start}=    Get Index From List    ${full_list}    === Event auxiliaryCabinetsThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${auxiliaryCabinetsThermalSystemState_start}+${5}
    ${auxiliaryCabinetsThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${auxiliaryCabinetsThermalSystemState_start}    end=${end}
    Should Contain X Times    ${auxiliaryCabinetsThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${auxiliaryCabinetsThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${auxiliaryCabinetsThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${auxiliaryCabinetsThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    ${mainCabinetThermalSystemState_start}=    Get Index From List    ${full_list}    === Event mainCabinetThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${mainCabinetThermalSystemState_start}+${4}
    ${mainCabinetThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${mainCabinetThermalSystemState_start}    end=${end}
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    ${mainAxesPowerSupplySystemState_start}=    Get Index From List    ${full_list}    === Event mainAxesPowerSupplySystemState received =${SPACE}
    ${end}=    Evaluate    ${mainAxesPowerSupplySystemState_start}+${2}
    ${mainAxesPowerSupplySystemState_list}=    Get Slice From List    ${full_list}    start=${mainAxesPowerSupplySystemState_start}    end=${end}
    Should Contain X Times    ${mainAxesPowerSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    ${topEndChillerSystemState_start}=    Get Index From List    ${full_list}    === Event topEndChillerSystemState received =${SPACE}
    ${end}=    Evaluate    ${topEndChillerSystemState_start}+${4}
    ${topEndChillerSystemState_list}=    Get Slice From List    ${full_list}    start=${topEndChillerSystemState_start}    end=${end}
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    ${elevationInPosition_start}=    Get Index From List    ${full_list}    === Event elevationInPosition received =${SPACE}
    ${end}=    Evaluate    ${elevationInPosition_start}+${2}
    ${elevationInPosition_list}=    Get Slice From List    ${full_list}    start=${elevationInPosition_start}    end=${end}
    Should Contain X Times    ${elevationInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${azimuthInPosition_start}=    Get Index From List    ${full_list}    === Event azimuthInPosition received =${SPACE}
    ${end}=    Evaluate    ${azimuthInPosition_start}+${2}
    ${azimuthInPosition_list}=    Get Slice From List    ${full_list}    start=${azimuthInPosition_start}    end=${end}
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${cameraCableWrapInPosition_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapInPosition received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapInPosition_start}+${2}
    ${cameraCableWrapInPosition_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapInPosition_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${elevationMotionState_start}=    Get Index From List    ${full_list}    === Event elevationMotionState received =${SPACE}
    ${end}=    Evaluate    ${elevationMotionState_start}+${2}
    ${elevationMotionState_list}=    Get Slice From List    ${full_list}    start=${elevationMotionState_start}    end=${end}
    Should Contain X Times    ${elevationMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${azimuthMotionState_start}=    Get Index From List    ${full_list}    === Event azimuthMotionState received =${SPACE}
    ${end}=    Evaluate    ${azimuthMotionState_start}+${2}
    ${azimuthMotionState_list}=    Get Slice From List    ${full_list}    start=${azimuthMotionState_start}    end=${end}
    Should Contain X Times    ${azimuthMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${cameraCableWrapMotionState_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapMotionState received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapMotionState_start}+${2}
    ${cameraCableWrapMotionState_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapMotionState_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${elevationLimits_start}=    Get Index From List    ${full_list}    === Event elevationLimits received =${SPACE}
    ${end}=    Evaluate    ${elevationLimits_start}+${2}
    ${elevationLimits_list}=    Get Slice From List    ${full_list}    start=${elevationLimits_start}    end=${end}
    Should Contain X Times    ${elevationLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    ${azimuthLimits_start}=    Get Index From List    ${full_list}    === Event azimuthLimits received =${SPACE}
    ${end}=    Evaluate    ${azimuthLimits_start}+${2}
    ${azimuthLimits_list}=    Get Slice From List    ${full_list}    start=${azimuthLimits_start}    end=${end}
    Should Contain X Times    ${azimuthLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    ${cameraCableWrapLimits_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapLimits received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapLimits_start}+${2}
    ${cameraCableWrapLimits_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapLimits_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    ${azimuthToppleBlock_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlock received =${SPACE}
    ${end}=    Evaluate    ${azimuthToppleBlock_start}+${3}
    ${azimuthToppleBlock_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlock_start}    end=${end}
    Should Contain X Times    ${azimuthToppleBlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 1    1
    Should Contain X Times    ${azimuthToppleBlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 1    1
    ${cameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapFollowing received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapFollowing_start}+${2}
    ${cameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapFollowing_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabled : 1    1
    ${cameraCableWrapTarget_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapTarget received =${SPACE}
    ${end}=    Evaluate    ${cameraCableWrapTarget_start}+${4}
    ${cameraCableWrapTarget_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapTarget_start}    end=${end}
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    ${commander_start}=    Get Index From List    ${full_list}    === Event commander received =${SPACE}
    ${end}=    Evaluate    ${commander_start}+${2}
    ${commander_list}=    Get Slice From List    ${full_list}    start=${commander_start}    end=${end}
    Should Contain X Times    ${commander_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commander : 1    1
    ${connected_start}=    Get Index From List    ${full_list}    === Event connected received =${SPACE}
    ${end}=    Evaluate    ${connected_start}+${2}
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${end}
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connected : 1    1
    ${telemetryConnected_start}=    Get Index From List    ${full_list}    === Event telemetryConnected received =${SPACE}
    ${end}=    Evaluate    ${telemetryConnected_start}+${2}
    ${telemetryConnected_list}=    Get Slice From List    ${full_list}    start=${telemetryConnected_start}    end=${end}
    Should Contain X Times    ${telemetryConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connected : 1    1
    ${deployablePlatformsMotionState_start}=    Get Index From List    ${full_list}    === Event deployablePlatformsMotionState received =${SPACE}
    ${end}=    Evaluate    ${deployablePlatformsMotionState_start}+${3}
    ${deployablePlatformsMotionState_list}=    Get Slice From List    ${full_list}    start=${deployablePlatformsMotionState_start}    end=${end}
    Should Contain X Times    ${deployablePlatformsMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${deployablePlatformsMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${elevationLockingPinMotionState_start}=    Get Index From List    ${full_list}    === Event elevationLockingPinMotionState received =${SPACE}
    ${end}=    Evaluate    ${elevationLockingPinMotionState_start}+${3}
    ${elevationLockingPinMotionState_list}=    Get Slice From List    ${full_list}    start=${elevationLockingPinMotionState_start}    end=${end}
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${error_start}=    Get Index From List    ${full_list}    === Event error received =${SPACE}
    ${end}=    Evaluate    ${error_start}+${6}
    ${error_list}=    Get Slice From List    ${full_list}    start=${error_start}    end=${end}
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latched : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}code : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : RO    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : 1    1
    ${mirrorCoverLocksMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoverLocksMotionState received =${SPACE}
    ${end}=    Evaluate    ${mirrorCoverLocksMotionState_start}+${3}
    ${mirrorCoverLocksMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocksMotionState_start}    end=${end}
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${mirrorCoversMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoversMotionState received =${SPACE}
    ${end}=    Evaluate    ${mirrorCoversMotionState_start}+${3}
    ${mirrorCoversMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoversMotionState_start}    end=${end}
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${safetyInterlocks_start}=    Get Index From List    ${full_list}    === Event safetyInterlocks received =${SPACE}
    ${end}=    Evaluate    ${safetyInterlocks_start}+${11}
    ${safetyInterlocks_list}=    Get Slice From List    ${full_list}    start=${safetyInterlocks_start}    end=${end}
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}causes : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesEmergencyStop : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesLimitSwitch : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesDeployablePlatform : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesDoorHatchLadder : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesMirrorCover : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesLockingPin : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesCapacitorDoor : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subcausesBrakesFailed : 1    1
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}effects : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Evaluate    ${target_start}+${9}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracksys : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radesys : RO    1
    ${warning_start}=    Get Index From List    ${full_list}    === Event warning received =${SPACE}
    ${end}=    Evaluate    ${warning_start}+${5}
    ${warning_list}=    Get Slice From List    ${full_list}    start=${warning_start}    end=${end}
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}code : 1    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : RO    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${clockOffset_start}=    Get Index From List    ${full_list}    === Event clockOffset received =${SPACE}
    ${end}=    Evaluate    ${clockOffset_start}+${2}
    ${clockOffset_list}=    Get Slice From List    ${full_list}    start=${clockOffset_start}    end=${end}
    Should Contain X Times    ${clockOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offset : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${3}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${10}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${6}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${4}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${2}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${2}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === Event configurationApplied received =${SPACE}
    ${end}=    Evaluate    ${configurationApplied_start}+${6}
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${end}
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurations : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherInfo : RO    1
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === Event configurationsAvailable received =${SPACE}
    ${end}=    Evaluate    ${configurationsAvailable_start}+${5}
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${end}
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overrides : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
