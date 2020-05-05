*** Settings ***
Documentation    ATMCS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
${component}    all
${timeout}    45s

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
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_atMountState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_atMountState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event atMountState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_atMountState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event atMountState generated =
    Comment    ======= Verify ${subSystem}_m3State test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3State
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3State iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3State_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3State generated =
    Comment    ======= Verify ${subSystem}_m3PortSelected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3PortSelected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3PortSelected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3PortSelected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3PortSelected generated =
    Comment    ======= Verify ${subSystem}_positionLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_positionLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event positionLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_positionLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event positionLimits generated =
    Comment    ======= Verify ${subSystem}_target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_target_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event target generated =
    Comment    ======= Verify ${subSystem}_elevationInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationInPosition generated =
    Comment    ======= Verify ${subSystem}_azimuthInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthInPosition generated =
    Comment    ======= Verify ${subSystem}_nasmyth1RotatorInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth1RotatorInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth1RotatorInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth1RotatorInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth1RotatorInPosition generated =
    Comment    ======= Verify ${subSystem}_nasmyth2RotatorInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth2RotatorInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth2RotatorInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth2RotatorInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth2RotatorInPosition generated =
    Comment    ======= Verify ${subSystem}_m3InPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3InPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3InPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3InPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3InPosition generated =
    Comment    ======= Verify ${subSystem}_allAxesInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_allAxesInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event allAxesInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_allAxesInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event allAxesInPosition generated =
    Comment    ======= Verify ${subSystem}_azimuthToppleBlockCCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthToppleBlockCCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlockCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthToppleBlockCCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthToppleBlockCCW generated =
    Comment    ======= Verify ${subSystem}_azimuthToppleBlockCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthToppleBlockCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlockCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthToppleBlockCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthToppleBlockCW generated =
    Comment    ======= Verify ${subSystem}_m3RotatorDetentSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3RotatorDetentSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3RotatorDetentSwitches iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3RotatorDetentSwitches_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3RotatorDetentSwitches generated =
    Comment    ======= Verify ${subSystem}_elevationLimitSwitchLower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationLimitSwitchLower
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationLimitSwitchLower iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationLimitSwitchLower_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationLimitSwitchLower generated =
    Comment    ======= Verify ${subSystem}_elevationLimitSwitchUpper test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationLimitSwitchUpper
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationLimitSwitchUpper iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationLimitSwitchUpper_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationLimitSwitchUpper generated =
    Comment    ======= Verify ${subSystem}_azimuthLimitSwitchCCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthLimitSwitchCCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthLimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthLimitSwitchCCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthLimitSwitchCCW generated =
    Comment    ======= Verify ${subSystem}_azimuthLimitSwitchCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthLimitSwitchCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthLimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthLimitSwitchCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthLimitSwitchCW generated =
    Comment    ======= Verify ${subSystem}_nasmyth1LimitSwitchCCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth1LimitSwitchCCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth1LimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth1LimitSwitchCCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth1LimitSwitchCCW generated =
    Comment    ======= Verify ${subSystem}_nasmyth1LimitSwitchCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth1LimitSwitchCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth1LimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth1LimitSwitchCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth1LimitSwitchCW generated =
    Comment    ======= Verify ${subSystem}_nasmyth2LimitSwitchCCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth2LimitSwitchCCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth2LimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth2LimitSwitchCCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth2LimitSwitchCCW generated =
    Comment    ======= Verify ${subSystem}_nasmyth2LimitSwitchCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth2LimitSwitchCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth2LimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth2LimitSwitchCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth2LimitSwitchCW generated =
    Comment    ======= Verify ${subSystem}_m3RotatorLimitSwitchCCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3RotatorLimitSwitchCCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3RotatorLimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3RotatorLimitSwitchCCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3RotatorLimitSwitchCCW generated =
    Comment    ======= Verify ${subSystem}_m3RotatorLimitSwitchCW test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3RotatorLimitSwitchCW
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3RotatorLimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3RotatorLimitSwitchCW_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3RotatorLimitSwitchCW generated =
    Comment    ======= Verify ${subSystem}_elevationDriveStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationDriveStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationDriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationDriveStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationDriveStatus generated =
    Comment    ======= Verify ${subSystem}_azimuthDrive1Status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthDrive1Status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthDrive1Status iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthDrive1Status_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthDrive1Status generated =
    Comment    ======= Verify ${subSystem}_azimuthDrive2Status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthDrive2Status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthDrive2Status iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthDrive2Status_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthDrive2Status generated =
    Comment    ======= Verify ${subSystem}_nasmyth1DriveStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth1DriveStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth1DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth1DriveStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth1DriveStatus generated =
    Comment    ======= Verify ${subSystem}_nasmyth2DriveStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth2DriveStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth2DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth2DriveStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth2DriveStatus generated =
    Comment    ======= Verify ${subSystem}_m3DriveStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m3DriveStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m3DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m3DriveStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m3DriveStatus generated =
    Comment    ======= Verify ${subSystem}_elevationBrake test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationBrake
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationBrake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationBrake_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationBrake generated =
    Comment    ======= Verify ${subSystem}_azimuthBrake1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthBrake1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthBrake1 iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthBrake1_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthBrake1 generated =
    Comment    ======= Verify ${subSystem}_azimuthBrake2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthBrake2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthBrake2 iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthBrake2_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthBrake2 generated =
    Comment    ======= Verify ${subSystem}_nasmyth1Brake test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth1Brake
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth1Brake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth1Brake_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth1Brake generated =
    Comment    ======= Verify ${subSystem}_nasmyth2Brake test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nasmyth2Brake
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nasmyth2Brake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nasmyth2Brake_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nasmyth2Brake generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${atMountState_start}=    Get Index From List    ${full_list}    === Event atMountState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${atMountState_start}
    ${atMountState_end}=    Evaluate    ${end}+${1}
    ${atMountState_list}=    Get Slice From List    ${full_list}    start=${atMountState_start}    end=${atMountState_end}
    Should Contain X Times    ${atMountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${atMountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3State_start}=    Get Index From List    ${full_list}    === Event m3State received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3State_start}
    ${m3State_end}=    Evaluate    ${end}+${1}
    ${m3State_list}=    Get Slice From List    ${full_list}    start=${m3State_start}    end=${m3State_end}
    Should Contain X Times    ${m3State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m3State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3PortSelected_start}=    Get Index From List    ${full_list}    === Event m3PortSelected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3PortSelected_start}
    ${m3PortSelected_end}=    Evaluate    ${end}+${1}
    ${m3PortSelected_list}=    Get Slice From List    ${full_list}    start=${m3PortSelected_start}    end=${m3PortSelected_end}
    Should Contain X Times    ${m3PortSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selected : 1    1
    Should Contain X Times    ${m3PortSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${positionLimits_start}=    Get Index From List    ${full_list}    === Event positionLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${positionLimits_start}
    ${positionLimits_end}=    Evaluate    ${end}+${1}
    ${positionLimits_list}=    Get Slice From List    ${full_list}    start=${positionLimits_start}    end=${positionLimits_end}
    Should Contain X Times    ${positionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minimum : 0    1
    Should Contain X Times    ${positionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maximum : 0    1
    Should Contain X Times    ${positionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${target_start}
    ${target_end}=    Evaluate    ${end}+${1}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracksys : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radesys : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    ${nasmyth1RotatorInPosition_start}=    Get Index From List    ${full_list}    === Event nasmyth1RotatorInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth1RotatorInPosition_start}
    ${nasmyth1RotatorInPosition_end}=    Evaluate    ${end}+${1}
    ${nasmyth1RotatorInPosition_list}=    Get Slice From List    ${full_list}    start=${nasmyth1RotatorInPosition_start}    end=${nasmyth1RotatorInPosition_end}
    Should Contain X Times    ${nasmyth1RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${nasmyth1RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth2RotatorInPosition_start}=    Get Index From List    ${full_list}    === Event nasmyth2RotatorInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth2RotatorInPosition_start}
    ${nasmyth2RotatorInPosition_end}=    Evaluate    ${end}+${1}
    ${nasmyth2RotatorInPosition_list}=    Get Slice From List    ${full_list}    start=${nasmyth2RotatorInPosition_start}    end=${nasmyth2RotatorInPosition_end}
    Should Contain X Times    ${nasmyth2RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${nasmyth2RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3InPosition_start}=    Get Index From List    ${full_list}    === Event m3InPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3InPosition_start}
    ${m3InPosition_end}=    Evaluate    ${end}+${1}
    ${m3InPosition_list}=    Get Slice From List    ${full_list}    start=${m3InPosition_start}    end=${m3InPosition_end}
    Should Contain X Times    ${m3InPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${m3InPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${allAxesInPosition_start}=    Get Index From List    ${full_list}    === Event allAxesInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${allAxesInPosition_start}
    ${allAxesInPosition_end}=    Evaluate    ${end}+${1}
    ${allAxesInPosition_list}=    Get Slice From List    ${full_list}    start=${allAxesInPosition_start}    end=${allAxesInPosition_end}
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthToppleBlockCCW_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlockCCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthToppleBlockCCW_start}
    ${azimuthToppleBlockCCW_end}=    Evaluate    ${end}+${1}
    ${azimuthToppleBlockCCW_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlockCCW_start}    end=${azimuthToppleBlockCCW_end}
    Should Contain X Times    ${azimuthToppleBlockCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${azimuthToppleBlockCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthToppleBlockCW_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlockCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthToppleBlockCW_start}
    ${azimuthToppleBlockCW_end}=    Evaluate    ${end}+${1}
    ${azimuthToppleBlockCW_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlockCW_start}    end=${azimuthToppleBlockCW_end}
    Should Contain X Times    ${azimuthToppleBlockCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${azimuthToppleBlockCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3RotatorDetentSwitches_start}=    Get Index From List    ${full_list}    === Event m3RotatorDetentSwitches received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3RotatorDetentSwitches_start}
    ${m3RotatorDetentSwitches_end}=    Evaluate    ${end}+${1}
    ${m3RotatorDetentSwitches_list}=    Get Slice From List    ${full_list}    start=${m3RotatorDetentSwitches_start}    end=${m3RotatorDetentSwitches_end}
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Active : 1    1
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port3Active : 1    1
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Active : 1    1
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationLimitSwitchLower_start}=    Get Index From List    ${full_list}    === Event elevationLimitSwitchLower received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLimitSwitchLower_start}
    ${elevationLimitSwitchLower_end}=    Evaluate    ${end}+${1}
    ${elevationLimitSwitchLower_list}=    Get Slice From List    ${full_list}    start=${elevationLimitSwitchLower_start}    end=${elevationLimitSwitchLower_end}
    Should Contain X Times    ${elevationLimitSwitchLower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${elevationLimitSwitchLower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationLimitSwitchUpper_start}=    Get Index From List    ${full_list}    === Event elevationLimitSwitchUpper received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLimitSwitchUpper_start}
    ${elevationLimitSwitchUpper_end}=    Evaluate    ${end}+${1}
    ${elevationLimitSwitchUpper_list}=    Get Slice From List    ${full_list}    start=${elevationLimitSwitchUpper_start}    end=${elevationLimitSwitchUpper_end}
    Should Contain X Times    ${elevationLimitSwitchUpper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${elevationLimitSwitchUpper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthLimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event azimuthLimitSwitchCCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthLimitSwitchCCW_start}
    ${azimuthLimitSwitchCCW_end}=    Evaluate    ${end}+${1}
    ${azimuthLimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${azimuthLimitSwitchCCW_start}    end=${azimuthLimitSwitchCCW_end}
    Should Contain X Times    ${azimuthLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${azimuthLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthLimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event azimuthLimitSwitchCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthLimitSwitchCW_start}
    ${azimuthLimitSwitchCW_end}=    Evaluate    ${end}+${1}
    ${azimuthLimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${azimuthLimitSwitchCW_start}    end=${azimuthLimitSwitchCW_end}
    Should Contain X Times    ${azimuthLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${azimuthLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth1LimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event nasmyth1LimitSwitchCCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth1LimitSwitchCCW_start}
    ${nasmyth1LimitSwitchCCW_end}=    Evaluate    ${end}+${1}
    ${nasmyth1LimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth1LimitSwitchCCW_start}    end=${nasmyth1LimitSwitchCCW_end}
    Should Contain X Times    ${nasmyth1LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${nasmyth1LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth1LimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event nasmyth1LimitSwitchCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth1LimitSwitchCW_start}
    ${nasmyth1LimitSwitchCW_end}=    Evaluate    ${end}+${1}
    ${nasmyth1LimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth1LimitSwitchCW_start}    end=${nasmyth1LimitSwitchCW_end}
    Should Contain X Times    ${nasmyth1LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${nasmyth1LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth2LimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event nasmyth2LimitSwitchCCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth2LimitSwitchCCW_start}
    ${nasmyth2LimitSwitchCCW_end}=    Evaluate    ${end}+${1}
    ${nasmyth2LimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth2LimitSwitchCCW_start}    end=${nasmyth2LimitSwitchCCW_end}
    Should Contain X Times    ${nasmyth2LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${nasmyth2LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth2LimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event nasmyth2LimitSwitchCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth2LimitSwitchCW_start}
    ${nasmyth2LimitSwitchCW_end}=    Evaluate    ${end}+${1}
    ${nasmyth2LimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth2LimitSwitchCW_start}    end=${nasmyth2LimitSwitchCW_end}
    Should Contain X Times    ${nasmyth2LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${nasmyth2LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3RotatorLimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event m3RotatorLimitSwitchCCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3RotatorLimitSwitchCCW_start}
    ${m3RotatorLimitSwitchCCW_end}=    Evaluate    ${end}+${1}
    ${m3RotatorLimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${m3RotatorLimitSwitchCCW_start}    end=${m3RotatorLimitSwitchCCW_end}
    Should Contain X Times    ${m3RotatorLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${m3RotatorLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3RotatorLimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event m3RotatorLimitSwitchCW received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3RotatorLimitSwitchCW_start}
    ${m3RotatorLimitSwitchCW_end}=    Evaluate    ${end}+${1}
    ${m3RotatorLimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${m3RotatorLimitSwitchCW_start}    end=${m3RotatorLimitSwitchCW_end}
    Should Contain X Times    ${m3RotatorLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${m3RotatorLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationDriveStatus_start}=    Get Index From List    ${full_list}    === Event elevationDriveStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationDriveStatus_start}
    ${elevationDriveStatus_end}=    Evaluate    ${end}+${1}
    ${elevationDriveStatus_list}=    Get Slice From List    ${full_list}    start=${elevationDriveStatus_start}    end=${elevationDriveStatus_end}
    Should Contain X Times    ${elevationDriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${elevationDriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthDrive1Status_start}=    Get Index From List    ${full_list}    === Event azimuthDrive1Status received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthDrive1Status_start}
    ${azimuthDrive1Status_end}=    Evaluate    ${end}+${1}
    ${azimuthDrive1Status_list}=    Get Slice From List    ${full_list}    start=${azimuthDrive1Status_start}    end=${azimuthDrive1Status_end}
    Should Contain X Times    ${azimuthDrive1Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${azimuthDrive1Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthDrive2Status_start}=    Get Index From List    ${full_list}    === Event azimuthDrive2Status received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthDrive2Status_start}
    ${azimuthDrive2Status_end}=    Evaluate    ${end}+${1}
    ${azimuthDrive2Status_list}=    Get Slice From List    ${full_list}    start=${azimuthDrive2Status_start}    end=${azimuthDrive2Status_end}
    Should Contain X Times    ${azimuthDrive2Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${azimuthDrive2Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth1DriveStatus_start}=    Get Index From List    ${full_list}    === Event nasmyth1DriveStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth1DriveStatus_start}
    ${nasmyth1DriveStatus_end}=    Evaluate    ${end}+${1}
    ${nasmyth1DriveStatus_list}=    Get Slice From List    ${full_list}    start=${nasmyth1DriveStatus_start}    end=${nasmyth1DriveStatus_end}
    Should Contain X Times    ${nasmyth1DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${nasmyth1DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth2DriveStatus_start}=    Get Index From List    ${full_list}    === Event nasmyth2DriveStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth2DriveStatus_start}
    ${nasmyth2DriveStatus_end}=    Evaluate    ${end}+${1}
    ${nasmyth2DriveStatus_list}=    Get Slice From List    ${full_list}    start=${nasmyth2DriveStatus_start}    end=${nasmyth2DriveStatus_end}
    Should Contain X Times    ${nasmyth2DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${nasmyth2DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m3DriveStatus_start}=    Get Index From List    ${full_list}    === Event m3DriveStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m3DriveStatus_start}
    ${m3DriveStatus_end}=    Evaluate    ${end}+${1}
    ${m3DriveStatus_list}=    Get Slice From List    ${full_list}    start=${m3DriveStatus_start}    end=${m3DriveStatus_end}
    Should Contain X Times    ${m3DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${m3DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationBrake_start}=    Get Index From List    ${full_list}    === Event elevationBrake received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationBrake_start}
    ${elevationBrake_end}=    Evaluate    ${end}+${1}
    ${elevationBrake_list}=    Get Slice From List    ${full_list}    start=${elevationBrake_start}    end=${elevationBrake_end}
    Should Contain X Times    ${elevationBrake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${elevationBrake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthBrake1_start}=    Get Index From List    ${full_list}    === Event azimuthBrake1 received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthBrake1_start}
    ${azimuthBrake1_end}=    Evaluate    ${end}+${1}
    ${azimuthBrake1_list}=    Get Slice From List    ${full_list}    start=${azimuthBrake1_start}    end=${azimuthBrake1_end}
    Should Contain X Times    ${azimuthBrake1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${azimuthBrake1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthBrake2_start}=    Get Index From List    ${full_list}    === Event azimuthBrake2 received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthBrake2_start}
    ${azimuthBrake2_end}=    Evaluate    ${end}+${1}
    ${azimuthBrake2_list}=    Get Slice From List    ${full_list}    start=${azimuthBrake2_start}    end=${azimuthBrake2_end}
    Should Contain X Times    ${azimuthBrake2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${azimuthBrake2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth1Brake_start}=    Get Index From List    ${full_list}    === Event nasmyth1Brake received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth1Brake_start}
    ${nasmyth1Brake_end}=    Evaluate    ${end}+${1}
    ${nasmyth1Brake_list}=    Get Slice From List    ${full_list}    start=${nasmyth1Brake_start}    end=${nasmyth1Brake_end}
    Should Contain X Times    ${nasmyth1Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${nasmyth1Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nasmyth2Brake_start}=    Get Index From List    ${full_list}    === Event nasmyth2Brake received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nasmyth2Brake_start}
    ${nasmyth2Brake_end}=    Evaluate    ${end}+${1}
    ${nasmyth2Brake_list}=    Get Slice From List    ${full_list}    start=${nasmyth2Brake_start}    end=${nasmyth2Brake_end}
    Should Contain X Times    ${nasmyth2Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${nasmyth2Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
