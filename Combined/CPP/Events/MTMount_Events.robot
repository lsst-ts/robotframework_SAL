*** Settings ***
Documentation    MTMount_Events communications tests.
Force Tags    messaging    cpp    
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
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_availableSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_availableSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event availableSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_availableSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event availableSettings generated =
    Comment    ======= Verify ${subSystem}_controllerSettingsName test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_controllerSettingsName
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event controllerSettingsName iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_controllerSettingsName_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event controllerSettingsName generated =
    Comment    ======= Verify ${subSystem}_azimuthControllerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthControllerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthControllerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthControllerSettings generated =
    Comment    ======= Verify ${subSystem}_elevationControllerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationControllerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationControllerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationControllerSettings generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapControllerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapControllerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapControllerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapControllerSettings generated =
    Comment    ======= Verify ${subSystem}_azimuthSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthSystemState generated =
    Comment    ======= Verify ${subSystem}_elevationSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationSystemState generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapSystemState generated =
    Comment    ======= Verify ${subSystem}_balanceSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_balanceSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event balanceSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_balanceSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event balanceSystemState generated =
    Comment    ======= Verify ${subSystem}_mirrorCoversSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mirrorCoversSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mirrorCoversSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mirrorCoversSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mirrorCoversSystemState generated =
    Comment    ======= Verify ${subSystem}_mirrorCoverLocksSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mirrorCoverLocksSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mirrorCoverLocksSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mirrorCoverLocksSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mirrorCoverLocksSystemState generated =
    Comment    ======= Verify ${subSystem}_azimuthCableWrapSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthCableWrapSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthCableWrapSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthCableWrapSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthCableWrapSystemState generated =
    Comment    ======= Verify ${subSystem}_lockingPinsSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinsSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event lockingPinsSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinsSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event lockingPinsSystemState generated =
    Comment    ======= Verify ${subSystem}_deployablePlatformsSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_deployablePlatformsSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event deployablePlatformsSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_deployablePlatformsSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event deployablePlatformsSystemState generated =
    Comment    ======= Verify ${subSystem}_oilSupplySystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oilSupplySystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event oilSupplySystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oilSupplySystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oilSupplySystemState generated =
    Comment    ======= Verify ${subSystem}_azimuthDrivesThermalSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthDrivesThermalSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthDrivesThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthDrivesThermalSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthDrivesThermalSystemState generated =
    Comment    ======= Verify ${subSystem}_elevationDrivesThermalSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationDrivesThermalSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationDrivesThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationDrivesThermalSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationDrivesThermalSystemState generated =
    Comment    ======= Verify ${subSystem}_az0101CabinetThermalSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_az0101CabinetThermalSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event az0101CabinetThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_az0101CabinetThermalSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event az0101CabinetThermalSystemState generated =
    Comment    ======= Verify ${subSystem}_modbusTemperatureControllersSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_modbusTemperatureControllersSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event modbusTemperatureControllersSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_modbusTemperatureControllersSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event modbusTemperatureControllersSystemState generated =
    Comment    ======= Verify ${subSystem}_mainCabinetThermalSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainCabinetThermalSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainCabinetThermalSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainCabinetThermalSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainCabinetThermalSystemState generated =
    Comment    ======= Verify ${subSystem}_mainAxesPowerSupplySystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainAxesPowerSupplySystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainAxesPowerSupplySystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainAxesPowerSupplySystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainAxesPowerSupplySystemState generated =
    Comment    ======= Verify ${subSystem}_topEndChillerSystemState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_topEndChillerSystemState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event topEndChillerSystemState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_topEndChillerSystemState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event topEndChillerSystemState generated =
    Comment    ======= Verify ${subSystem}_elevationInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationInPosition generated =
    Comment    ======= Verify ${subSystem}_azimuthInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthInPosition generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapInPosition generated =
    Comment    ======= Verify ${subSystem}_elevationMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationMotionState generated =
    Comment    ======= Verify ${subSystem}_azimuthMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthMotionState generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapMotionState generated =
    Comment    ======= Verify ${subSystem}_elevationLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationLimits generated =
    Comment    ======= Verify ${subSystem}_azimuthLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthLimits generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapLimits generated =
    Comment    ======= Verify ${subSystem}_azimuthToppleBlock test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthToppleBlock
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlock iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthToppleBlock_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthToppleBlock generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapFollowing test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapFollowing
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapFollowing iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapFollowing_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapFollowing generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapTarget generated =
    Comment    ======= Verify ${subSystem}_commander test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_commander
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event commander iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_commander_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event commander generated =
    Comment    ======= Verify ${subSystem}_connected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_connected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event connected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_connected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event connected generated =
    Comment    ======= Verify ${subSystem}_deployablePlatformsMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_deployablePlatformsMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event deployablePlatformsMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_deployablePlatformsMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event deployablePlatformsMotionState generated =
    Comment    ======= Verify ${subSystem}_elevationLockingPinMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationLockingPinMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationLockingPinMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationLockingPinMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationLockingPinMotionState generated =
    Comment    ======= Verify ${subSystem}_error test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_error
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event error iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_error_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event error generated =
    Comment    ======= Verify ${subSystem}_mirrorCoverLocksMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mirrorCoverLocksMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mirrorCoverLocksMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mirrorCoverLocksMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mirrorCoverLocksMotionState generated =
    Comment    ======= Verify ${subSystem}_mirrorCoversMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mirrorCoversMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mirrorCoversMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mirrorCoversMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mirrorCoversMotionState generated =
    Comment    ======= Verify ${subSystem}_safetyInterlocks test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_safetyInterlocks
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event safetyInterlocks iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_safetyInterlocks_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event safetyInterlocks generated =
    Comment    ======= Verify ${subSystem}_target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_target_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event target generated =
    Comment    ======= Verify ${subSystem}_warning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_warning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event warning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_warning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event warning generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${availableSettings_start}=    Get Index From List    ${full_list}    === Event availableSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${availableSettings_start}
    ${availableSettings_end}=    Evaluate    ${end}+${1}
    ${availableSettings_list}=    Get Slice From List    ${full_list}    start=${availableSettings_start}    end=${availableSettings_end}
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}names : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}descriptions : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}createdDates : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modifiedDates : RO    1
    Should Contain X Times    ${availableSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${controllerSettingsName_start}=    Get Index From List    ${full_list}    === Event controllerSettingsName received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${controllerSettingsName_start}
    ${controllerSettingsName_end}=    Evaluate    ${end}+${1}
    ${controllerSettingsName_list}=    Get Slice From List    ${full_list}    start=${controllerSettingsName_start}    end=${controllerSettingsName_end}
    Should Contain X Times    ${controllerSettingsName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsName : RO    1
    Should Contain X Times    ${controllerSettingsName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthControllerSettings_start}=    Get Index From List    ${full_list}    === Event azimuthControllerSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthControllerSettings_start}
    ${azimuthControllerSettings_end}=    Evaluate    ${end}+${1}
    ${azimuthControllerSettings_list}=    Get Slice From List    ${full_list}    start=${azimuthControllerSettings_start}    end=${azimuthControllerSettings_end}
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
    Should Contain X Times    ${azimuthControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationControllerSettings_start}=    Get Index From List    ${full_list}    === Event elevationControllerSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationControllerSettings_start}
    ${elevationControllerSettings_end}=    Evaluate    ${end}+${1}
    ${elevationControllerSettings_list}=    Get Slice From List    ${full_list}    start=${elevationControllerSettings_start}    end=${elevationControllerSettings_end}
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
    Should Contain X Times    ${elevationControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapControllerSettings_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapControllerSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapControllerSettings_start}
    ${cameraCableWrapControllerSettings_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapControllerSettings_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapControllerSettings_start}    end=${cameraCableWrapControllerSettings_end}
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}l1LimitsEnabled : 1    1
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}l2LimitsEnabled : 1    1
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
    Should Contain X Times    ${cameraCableWrapControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthSystemState_start}
    ${azimuthSystemState_end}=    Evaluate    ${end}+${1}
    ${azimuthSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthSystemState_start}    end=${azimuthSystemState_end}
    Should Contain X Times    ${azimuthSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${azimuthSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationSystemState_start}=    Get Index From List    ${full_list}    === Event elevationSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationSystemState_start}
    ${elevationSystemState_end}=    Evaluate    ${end}+${1}
    ${elevationSystemState_list}=    Get Slice From List    ${full_list}    start=${elevationSystemState_start}    end=${elevationSystemState_end}
    Should Contain X Times    ${elevationSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${elevationSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${elevationSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapSystemState_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapSystemState_start}
    ${cameraCableWrapSystemState_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapSystemState_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapSystemState_start}    end=${cameraCableWrapSystemState_end}
    Should Contain X Times    ${cameraCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${cameraCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${cameraCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${balanceSystemState_start}=    Get Index From List    ${full_list}    === Event balanceSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${balanceSystemState_start}
    ${balanceSystemState_end}=    Evaluate    ${end}+${1}
    ${balanceSystemState_list}=    Get Slice From List    ${full_list}    start=${balanceSystemState_start}    end=${balanceSystemState_end}
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${balanceSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mirrorCoversSystemState_start}=    Get Index From List    ${full_list}    === Event mirrorCoversSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoversSystemState_start}
    ${mirrorCoversSystemState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoversSystemState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoversSystemState_start}    end=${mirrorCoversSystemState_end}
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${mirrorCoversSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mirrorCoverLocksSystemState_start}=    Get Index From List    ${full_list}    === Event mirrorCoverLocksSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoverLocksSystemState_start}
    ${mirrorCoverLocksSystemState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoverLocksSystemState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocksSystemState_start}    end=${mirrorCoverLocksSystemState_end}
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${mirrorCoverLocksSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthCableWrapSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthCableWrapSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthCableWrapSystemState_start}
    ${azimuthCableWrapSystemState_end}=    Evaluate    ${end}+${1}
    ${azimuthCableWrapSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthCableWrapSystemState_start}    end=${azimuthCableWrapSystemState_end}
    Should Contain X Times    ${azimuthCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${azimuthCableWrapSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinsSystemState_start}=    Get Index From List    ${full_list}    === Event lockingPinsSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${lockingPinsSystemState_start}
    ${lockingPinsSystemState_end}=    Evaluate    ${end}+${1}
    ${lockingPinsSystemState_list}=    Get Slice From List    ${full_list}    start=${lockingPinsSystemState_start}    end=${lockingPinsSystemState_end}
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${lockingPinsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${deployablePlatformsSystemState_start}=    Get Index From List    ${full_list}    === Event deployablePlatformsSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${deployablePlatformsSystemState_start}
    ${deployablePlatformsSystemState_end}=    Evaluate    ${end}+${1}
    ${deployablePlatformsSystemState_list}=    Get Slice From List    ${full_list}    start=${deployablePlatformsSystemState_start}    end=${deployablePlatformsSystemState_end}
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionControllerState : 0    1
    Should Contain X Times    ${deployablePlatformsSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oilSupplySystemState_start}=    Get Index From List    ${full_list}    === Event oilSupplySystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oilSupplySystemState_start}
    ${oilSupplySystemState_end}=    Evaluate    ${end}+${1}
    ${oilSupplySystemState_list}=    Get Slice From List    ${full_list}    start=${oilSupplySystemState_start}    end=${oilSupplySystemState_end}
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolingPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainPumpPowerState : 1    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    Should Contain X Times    ${oilSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthDrivesThermalSystemState_start}=    Get Index From List    ${full_list}    === Event azimuthDrivesThermalSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthDrivesThermalSystemState_start}
    ${azimuthDrivesThermalSystemState_end}=    Evaluate    ${end}+${1}
    ${azimuthDrivesThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${azimuthDrivesThermalSystemState_start}    end=${azimuthDrivesThermalSystemState_end}
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    Should Contain X Times    ${azimuthDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationDrivesThermalSystemState_start}=    Get Index From List    ${full_list}    === Event elevationDrivesThermalSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationDrivesThermalSystemState_start}
    ${elevationDrivesThermalSystemState_end}=    Evaluate    ${end}+${1}
    ${elevationDrivesThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${elevationDrivesThermalSystemState_start}    end=${elevationDrivesThermalSystemState_end}
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    Should Contain X Times    ${elevationDrivesThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${az0101CabinetThermalSystemState_start}=    Get Index From List    ${full_list}    === Event az0101CabinetThermalSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${az0101CabinetThermalSystemState_start}
    ${az0101CabinetThermalSystemState_end}=    Evaluate    ${end}+${1}
    ${az0101CabinetThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${az0101CabinetThermalSystemState_start}    end=${az0101CabinetThermalSystemState_end}
    Should Contain X Times    ${az0101CabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${az0101CabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${az0101CabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    Should Contain X Times    ${az0101CabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${modbusTemperatureControllersSystemState_start}=    Get Index From List    ${full_list}    === Event modbusTemperatureControllersSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${modbusTemperatureControllersSystemState_start}
    ${modbusTemperatureControllersSystemState_end}=    Evaluate    ${end}+${1}
    ${modbusTemperatureControllersSystemState_list}=    Get Slice From List    ${full_list}    start=${modbusTemperatureControllersSystemState_start}    end=${modbusTemperatureControllersSystemState_end}
    Should Contain X Times    ${modbusTemperatureControllersSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${modbusTemperatureControllersSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementPowerState : 0    1
    Should Contain X Times    ${modbusTemperatureControllersSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 0    1
    Should Contain X Times    ${modbusTemperatureControllersSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 0    1
    ${mainCabinetThermalSystemState_start}=    Get Index From List    ${full_list}    === Event mainCabinetThermalSystemState received =${SPACE}
    ${end}=    Evaluate    ${mainCabinetThermalSystemState_start}+${4}
    ${mainCabinetThermalSystemState_list}=    Get Slice From List    ${full_list}    start=${mainCabinetThermalSystemState_start}    end=${end}
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${mainCabinetThermalSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    ${mainAxesPowerSupplySystemState_start}=    Get Index From List    ${full_list}    === Event mainAxesPowerSupplySystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mainAxesPowerSupplySystemState_start}
    ${mainAxesPowerSupplySystemState_end}=    Evaluate    ${end}+${1}
    ${mainAxesPowerSupplySystemState_list}=    Get Slice From List    ${full_list}    start=${mainAxesPowerSupplySystemState_start}    end=${mainAxesPowerSupplySystemState_end}
    Should Contain X Times    ${mainAxesPowerSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${mainAxesPowerSupplySystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${topEndChillerSystemState_start}=    Get Index From List    ${full_list}    === Event topEndChillerSystemState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${topEndChillerSystemState_start}
    ${topEndChillerSystemState_end}=    Evaluate    ${end}+${1}
    ${topEndChillerSystemState_list}=    Get Slice From List    ${full_list}    start=${topEndChillerSystemState_start}    end=${topEndChillerSystemState_end}
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerState : 1    1
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackAmbient : 1    1
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    1
    Should Contain X Times    ${topEndChillerSystemState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationInPosition_start}=    Get Index From List    ${full_list}    === Event elevationInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationInPosition_start}
    ${elevationInPosition_end}=    Evaluate    ${end}+${1}
    ${elevationInPosition_list}=    Get Slice From List    ${full_list}    start=${elevationInPosition_start}    end=${elevationInPosition_end}
    Should Contain X Times    ${elevationInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${elevationInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthInPosition_start}=    Get Index From List    ${full_list}    === Event azimuthInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthInPosition_start}
    ${azimuthInPosition_end}=    Evaluate    ${end}+${1}
    ${azimuthInPosition_list}=    Get Slice From List    ${full_list}    start=${azimuthInPosition_start}    end=${azimuthInPosition_end}
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapInPosition_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapInPosition_start}
    ${cameraCableWrapInPosition_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapInPosition_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapInPosition_start}    end=${cameraCableWrapInPosition_end}
    Should Contain X Times    ${cameraCableWrapInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${cameraCableWrapInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationMotionState_start}=    Get Index From List    ${full_list}    === Event elevationMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationMotionState_start}
    ${elevationMotionState_end}=    Evaluate    ${end}+${1}
    ${elevationMotionState_list}=    Get Slice From List    ${full_list}    start=${elevationMotionState_start}    end=${elevationMotionState_end}
    Should Contain X Times    ${elevationMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elevationMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthMotionState_start}=    Get Index From List    ${full_list}    === Event azimuthMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthMotionState_start}
    ${azimuthMotionState_end}=    Evaluate    ${end}+${1}
    ${azimuthMotionState_list}=    Get Slice From List    ${full_list}    start=${azimuthMotionState_start}    end=${azimuthMotionState_end}
    Should Contain X Times    ${azimuthMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${azimuthMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapMotionState_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapMotionState_start}
    ${cameraCableWrapMotionState_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapMotionState_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapMotionState_start}    end=${cameraCableWrapMotionState_end}
    Should Contain X Times    ${cameraCableWrapMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${cameraCableWrapMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationLimits_start}=    Get Index From List    ${full_list}    === Event elevationLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLimits_start}
    ${elevationLimits_end}=    Evaluate    ${end}+${1}
    ${elevationLimits_list}=    Get Slice From List    ${full_list}    start=${elevationLimits_start}    end=${elevationLimits_end}
    Should Contain X Times    ${elevationLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    Should Contain X Times    ${elevationLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthLimits_start}=    Get Index From List    ${full_list}    === Event azimuthLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthLimits_start}
    ${azimuthLimits_end}=    Evaluate    ${end}+${1}
    ${azimuthLimits_list}=    Get Slice From List    ${full_list}    start=${azimuthLimits_start}    end=${azimuthLimits_end}
    Should Contain X Times    ${azimuthLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    Should Contain X Times    ${azimuthLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapLimits_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapLimits_start}
    ${cameraCableWrapLimits_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapLimits_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapLimits_start}    end=${cameraCableWrapLimits_end}
    Should Contain X Times    ${cameraCableWrapLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limits : 1    1
    Should Contain X Times    ${cameraCableWrapLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthToppleBlock_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlock received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthToppleBlock_start}
    ${azimuthToppleBlock_end}=    Evaluate    ${end}+${1}
    ${azimuthToppleBlock_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlock_start}    end=${azimuthToppleBlock_end}
    Should Contain X Times    ${azimuthToppleBlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 1    1
    Should Contain X Times    ${azimuthToppleBlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 1    1
    Should Contain X Times    ${azimuthToppleBlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapFollowing received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapFollowing_start}
    ${cameraCableWrapFollowing_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapFollowing_start}    end=${cameraCableWrapFollowing_end}
    Should Contain X Times    ${cameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabled : 1    1
    Should Contain X Times    ${cameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapTarget_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapTarget_start}
    ${cameraCableWrapTarget_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapTarget_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapTarget_start}    end=${cameraCableWrapTarget_end}
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${cameraCableWrapTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${commander_start}=    Get Index From List    ${full_list}    === Event commander received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${commander_start}
    ${commander_end}=    Evaluate    ${end}+${1}
    ${commander_list}=    Get Slice From List    ${full_list}    start=${commander_start}    end=${commander_end}
    Should Contain X Times    ${commander_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commander : 1    1
    Should Contain X Times    ${commander_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${connected_start}=    Get Index From List    ${full_list}    === Event connected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${connected_start}
    ${connected_end}=    Evaluate    ${end}+${1}
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${connected_end}
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}command : 1    1
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}replies : 1    1
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${deployablePlatformsMotionState_start}=    Get Index From List    ${full_list}    === Event deployablePlatformsMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${deployablePlatformsMotionState_start}
    ${deployablePlatformsMotionState_end}=    Evaluate    ${end}+${1}
    ${deployablePlatformsMotionState_list}=    Get Slice From List    ${full_list}    start=${deployablePlatformsMotionState_start}    end=${deployablePlatformsMotionState_end}
    Should Contain X Times    ${deployablePlatformsMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${deployablePlatformsMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${elevationLockingPinMotionState_start}=    Get Index From List    ${full_list}    === Event elevationLockingPinMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLockingPinMotionState_start}
    ${elevationLockingPinMotionState_end}=    Evaluate    ${end}+${1}
    ${elevationLockingPinMotionState_list}=    Get Slice From List    ${full_list}    start=${elevationLockingPinMotionState_start}    end=${elevationLockingPinMotionState_end}
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${error_start}=    Get Index From List    ${full_list}    === Event error received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${error_start}
    ${error_end}=    Evaluate    ${end}+${1}
    ${error_list}=    Get Slice From List    ${full_list}    start=${error_start}    end=${error_end}
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latched : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}code : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : RO    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : 1    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mirrorCoverLocksMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoverLocksMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoverLocksMotionState_start}
    ${mirrorCoverLocksMotionState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoverLocksMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocksMotionState_start}    end=${mirrorCoverLocksMotionState_end}
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${mirrorCoversMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoversMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoversMotionState_start}
    ${mirrorCoversMotionState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoversMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoversMotionState_start}    end=${mirrorCoversMotionState_end}
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementsState : 0    1
    ${safetyInterlocks_start}=    Get Index From List    ${full_list}    === Event safetyInterlocks received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${safetyInterlocks_start}
    ${safetyInterlocks_end}=    Evaluate    ${end}+${1}
    ${safetyInterlocks_list}=    Get Slice From List    ${full_list}    start=${safetyInterlocks_start}    end=${safetyInterlocks_end}
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
    Should Contain X Times    ${safetyInterlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${target_start}
    ${target_end}=    Evaluate    ${end}+${1}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracksys : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radesys : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${warning_start}=    Get Index From List    ${full_list}    === Event warning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${warning_start}
    ${warning_end}=    Evaluate    ${end}+${1}
    ${warning_list}=    Get Slice From List    ${full_list}    start=${warning_start}    end=${warning_end}
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}code : 1    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : RO    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : 1    1
    Should Contain X Times    ${warning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logMessage_start}
    ${logMessage_end}=    Evaluate    ${end}+${1}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersions_start}
    ${softwareVersions_end}=    Evaluate    ${end}+${1}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${authList_start}
    ${authList_end}=    Evaluate    ${end}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
