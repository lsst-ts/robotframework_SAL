*** Settings ***
Documentation    ATMCS_Events communications tests.
Force Tags    messaging    cpp    atmcs    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional    logger
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional    sender    robot:continue-on-failure
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_detailedState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_detailedState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event detailedState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_atMountState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_atMountState test messages =======
    Should Contain X Times    ${output.stdout}    === Event atMountState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_atMountState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event atMountState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3State"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3State test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3State iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3State writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3State generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3PortSelected"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3PortSelected test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3PortSelected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3PortSelected writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3PortSelected generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_positionLimits"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_positionLimits test messages =======
    Should Contain X Times    ${output.stdout}    === Event positionLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_positionLimits writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event positionLimits generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_target"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_target test messages =======
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_target writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event target generated =
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
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth1RotatorInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth1RotatorInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth1RotatorInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth1RotatorInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth1RotatorInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth2RotatorInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth2RotatorInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth2RotatorInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth2RotatorInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth2RotatorInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3InPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3InPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3InPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3InPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3InPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_allAxesInPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_allAxesInPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event allAxesInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_allAxesInPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event allAxesInPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthToppleBlockCCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthToppleBlockCCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlockCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthToppleBlockCCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthToppleBlockCCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthToppleBlockCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthToppleBlockCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthToppleBlockCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthToppleBlockCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthToppleBlockCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3RotatorDetentSwitches"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3RotatorDetentSwitches test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3RotatorDetentSwitches iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3RotatorDetentSwitches writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3RotatorDetentSwitches generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationLimitSwitchLower"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationLimitSwitchLower test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationLimitSwitchLower iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationLimitSwitchLower writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationLimitSwitchLower generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationLimitSwitchUpper"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationLimitSwitchUpper test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationLimitSwitchUpper iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationLimitSwitchUpper writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationLimitSwitchUpper generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthLimitSwitchCCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthLimitSwitchCCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthLimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthLimitSwitchCCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthLimitSwitchCCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthLimitSwitchCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthLimitSwitchCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthLimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthLimitSwitchCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthLimitSwitchCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth1LimitSwitchCCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth1LimitSwitchCCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth1LimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth1LimitSwitchCCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth1LimitSwitchCCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth1LimitSwitchCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth1LimitSwitchCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth1LimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth1LimitSwitchCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth1LimitSwitchCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth2LimitSwitchCCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth2LimitSwitchCCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth2LimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth2LimitSwitchCCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth2LimitSwitchCCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth2LimitSwitchCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth2LimitSwitchCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth2LimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth2LimitSwitchCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth2LimitSwitchCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3RotatorLimitSwitchCCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3RotatorLimitSwitchCCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3RotatorLimitSwitchCCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3RotatorLimitSwitchCCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3RotatorLimitSwitchCCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3RotatorLimitSwitchCW"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3RotatorLimitSwitchCW test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3RotatorLimitSwitchCW iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3RotatorLimitSwitchCW writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3RotatorLimitSwitchCW generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationDriveStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationDriveStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationDriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationDriveStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationDriveStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthDrive1Status"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthDrive1Status test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthDrive1Status iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthDrive1Status writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthDrive1Status generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthDrive2Status"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthDrive2Status test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthDrive2Status iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthDrive2Status writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthDrive2Status generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth1DriveStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth1DriveStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth1DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth1DriveStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth1DriveStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth2DriveStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth2DriveStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth2DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth2DriveStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth2DriveStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_m3DriveStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_m3DriveStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event m3DriveStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_m3DriveStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event m3DriveStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_elevationBrake"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_elevationBrake test messages =======
    Should Contain X Times    ${output.stdout}    === Event elevationBrake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_elevationBrake writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event elevationBrake generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthBrake1"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthBrake1 test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthBrake1 iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthBrake1 writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthBrake1 generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_azimuthBrake2"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azimuthBrake2 test messages =======
    Should Contain X Times    ${output.stdout}    === Event azimuthBrake2 iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_azimuthBrake2 writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event azimuthBrake2 generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth1Brake"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth1Brake test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth1Brake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth1Brake writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth1Brake generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_nasmyth2Brake"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth2Brake test messages =======
    Should Contain X Times    ${output.stdout}    === Event nasmyth2Brake iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_nasmyth2Brake writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event nasmyth2Brake generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_crioSummaryState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_crioSummaryState test messages =======
    Should Contain X Times    ${output.stdout}    === Event crioSummaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_crioSummaryState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event crioSummaryState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_heartbeat"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_heartbeat writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event heartbeat generated =
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
    [Tags]    functional    logger    robot:continue-on-failure
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Evaluate    ${detailedState_start}+${3}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    ${atMountState_start}=    Get Index From List    ${full_list}    === Event atMountState received =${SPACE}
    ${end}=    Evaluate    ${atMountState_start}+${3}
    ${atMountState_list}=    Get Slice From List    ${full_list}    start=${atMountState_start}    end=${end}
    Should Contain X Times    ${atMountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${m3State_start}=    Get Index From List    ${full_list}    === Event m3State received =${SPACE}
    ${end}=    Evaluate    ${m3State_start}+${3}
    ${m3State_list}=    Get Slice From List    ${full_list}    start=${m3State_start}    end=${end}
    Should Contain X Times    ${m3State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${m3PortSelected_start}=    Get Index From List    ${full_list}    === Event m3PortSelected received =${SPACE}
    ${end}=    Evaluate    ${m3PortSelected_start}+${3}
    ${m3PortSelected_list}=    Get Slice From List    ${full_list}    start=${m3PortSelected_start}    end=${end}
    Should Contain X Times    ${m3PortSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selected : 1    1
    ${positionLimits_start}=    Get Index From List    ${full_list}    === Event positionLimits received =${SPACE}
    ${end}=    Evaluate    ${positionLimits_start}+${4}
    ${positionLimits_list}=    Get Slice From List    ${full_list}    start=${positionLimits_start}    end=${end}
    Should Contain X Times    ${positionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minimum : 0    1
    Should Contain X Times    ${positionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maximum : 0    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Evaluate    ${target_start}+${14}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${end}
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
    ${elevationInPosition_start}=    Get Index From List    ${full_list}    === Event elevationInPosition received =${SPACE}
    ${end}=    Evaluate    ${elevationInPosition_start}+${3}
    ${elevationInPosition_list}=    Get Slice From List    ${full_list}    start=${elevationInPosition_start}    end=${end}
    Should Contain X Times    ${elevationInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${azimuthInPosition_start}=    Get Index From List    ${full_list}    === Event azimuthInPosition received =${SPACE}
    ${end}=    Evaluate    ${azimuthInPosition_start}+${3}
    ${azimuthInPosition_list}=    Get Slice From List    ${full_list}    start=${azimuthInPosition_start}    end=${end}
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${nasmyth1RotatorInPosition_start}=    Get Index From List    ${full_list}    === Event nasmyth1RotatorInPosition received =${SPACE}
    ${end}=    Evaluate    ${nasmyth1RotatorInPosition_start}+${3}
    ${nasmyth1RotatorInPosition_list}=    Get Slice From List    ${full_list}    start=${nasmyth1RotatorInPosition_start}    end=${end}
    Should Contain X Times    ${nasmyth1RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${nasmyth2RotatorInPosition_start}=    Get Index From List    ${full_list}    === Event nasmyth2RotatorInPosition received =${SPACE}
    ${end}=    Evaluate    ${nasmyth2RotatorInPosition_start}+${3}
    ${nasmyth2RotatorInPosition_list}=    Get Slice From List    ${full_list}    start=${nasmyth2RotatorInPosition_start}    end=${end}
    Should Contain X Times    ${nasmyth2RotatorInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${m3InPosition_start}=    Get Index From List    ${full_list}    === Event m3InPosition received =${SPACE}
    ${end}=    Evaluate    ${m3InPosition_start}+${3}
    ${m3InPosition_list}=    Get Slice From List    ${full_list}    start=${m3InPosition_start}    end=${end}
    Should Contain X Times    ${m3InPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${allAxesInPosition_start}=    Get Index From List    ${full_list}    === Event allAxesInPosition received =${SPACE}
    ${end}=    Evaluate    ${allAxesInPosition_start}+${3}
    ${allAxesInPosition_list}=    Get Slice From List    ${full_list}    start=${allAxesInPosition_start}    end=${end}
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${azimuthToppleBlockCCW_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlockCCW received =${SPACE}
    ${end}=    Evaluate    ${azimuthToppleBlockCCW_start}+${3}
    ${azimuthToppleBlockCCW_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlockCCW_start}    end=${end}
    Should Contain X Times    ${azimuthToppleBlockCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${azimuthToppleBlockCW_start}=    Get Index From List    ${full_list}    === Event azimuthToppleBlockCW received =${SPACE}
    ${end}=    Evaluate    ${azimuthToppleBlockCW_start}+${3}
    ${azimuthToppleBlockCW_list}=    Get Slice From List    ${full_list}    start=${azimuthToppleBlockCW_start}    end=${end}
    Should Contain X Times    ${azimuthToppleBlockCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${m3RotatorDetentSwitches_start}=    Get Index From List    ${full_list}    === Event m3RotatorDetentSwitches received =${SPACE}
    ${end}=    Evaluate    ${m3RotatorDetentSwitches_start}+${5}
    ${m3RotatorDetentSwitches_list}=    Get Slice From List    ${full_list}    start=${m3RotatorDetentSwitches_start}    end=${end}
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Active : 1    1
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port3Active : 1    1
    Should Contain X Times    ${m3RotatorDetentSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Active : 1    1
    ${elevationLimitSwitchLower_start}=    Get Index From List    ${full_list}    === Event elevationLimitSwitchLower received =${SPACE}
    ${end}=    Evaluate    ${elevationLimitSwitchLower_start}+${3}
    ${elevationLimitSwitchLower_list}=    Get Slice From List    ${full_list}    start=${elevationLimitSwitchLower_start}    end=${end}
    Should Contain X Times    ${elevationLimitSwitchLower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${elevationLimitSwitchUpper_start}=    Get Index From List    ${full_list}    === Event elevationLimitSwitchUpper received =${SPACE}
    ${end}=    Evaluate    ${elevationLimitSwitchUpper_start}+${3}
    ${elevationLimitSwitchUpper_list}=    Get Slice From List    ${full_list}    start=${elevationLimitSwitchUpper_start}    end=${end}
    Should Contain X Times    ${elevationLimitSwitchUpper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${azimuthLimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event azimuthLimitSwitchCCW received =${SPACE}
    ${end}=    Evaluate    ${azimuthLimitSwitchCCW_start}+${3}
    ${azimuthLimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${azimuthLimitSwitchCCW_start}    end=${end}
    Should Contain X Times    ${azimuthLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${azimuthLimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event azimuthLimitSwitchCW received =${SPACE}
    ${end}=    Evaluate    ${azimuthLimitSwitchCW_start}+${3}
    ${azimuthLimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${azimuthLimitSwitchCW_start}    end=${end}
    Should Contain X Times    ${azimuthLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${nasmyth1LimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event nasmyth1LimitSwitchCCW received =${SPACE}
    ${end}=    Evaluate    ${nasmyth1LimitSwitchCCW_start}+${3}
    ${nasmyth1LimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth1LimitSwitchCCW_start}    end=${end}
    Should Contain X Times    ${nasmyth1LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${nasmyth1LimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event nasmyth1LimitSwitchCW received =${SPACE}
    ${end}=    Evaluate    ${nasmyth1LimitSwitchCW_start}+${3}
    ${nasmyth1LimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth1LimitSwitchCW_start}    end=${end}
    Should Contain X Times    ${nasmyth1LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${nasmyth2LimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event nasmyth2LimitSwitchCCW received =${SPACE}
    ${end}=    Evaluate    ${nasmyth2LimitSwitchCCW_start}+${3}
    ${nasmyth2LimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth2LimitSwitchCCW_start}    end=${end}
    Should Contain X Times    ${nasmyth2LimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${nasmyth2LimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event nasmyth2LimitSwitchCW received =${SPACE}
    ${end}=    Evaluate    ${nasmyth2LimitSwitchCW_start}+${3}
    ${nasmyth2LimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${nasmyth2LimitSwitchCW_start}    end=${end}
    Should Contain X Times    ${nasmyth2LimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${m3RotatorLimitSwitchCCW_start}=    Get Index From List    ${full_list}    === Event m3RotatorLimitSwitchCCW received =${SPACE}
    ${end}=    Evaluate    ${m3RotatorLimitSwitchCCW_start}+${3}
    ${m3RotatorLimitSwitchCCW_list}=    Get Slice From List    ${full_list}    start=${m3RotatorLimitSwitchCCW_start}    end=${end}
    Should Contain X Times    ${m3RotatorLimitSwitchCCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${m3RotatorLimitSwitchCW_start}=    Get Index From List    ${full_list}    === Event m3RotatorLimitSwitchCW received =${SPACE}
    ${end}=    Evaluate    ${m3RotatorLimitSwitchCW_start}+${3}
    ${m3RotatorLimitSwitchCW_list}=    Get Slice From List    ${full_list}    start=${m3RotatorLimitSwitchCW_start}    end=${end}
    Should Contain X Times    ${m3RotatorLimitSwitchCW_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    ${elevationDriveStatus_start}=    Get Index From List    ${full_list}    === Event elevationDriveStatus received =${SPACE}
    ${end}=    Evaluate    ${elevationDriveStatus_start}+${3}
    ${elevationDriveStatus_list}=    Get Slice From List    ${full_list}    start=${elevationDriveStatus_start}    end=${end}
    Should Contain X Times    ${elevationDriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${azimuthDrive1Status_start}=    Get Index From List    ${full_list}    === Event azimuthDrive1Status received =${SPACE}
    ${end}=    Evaluate    ${azimuthDrive1Status_start}+${3}
    ${azimuthDrive1Status_list}=    Get Slice From List    ${full_list}    start=${azimuthDrive1Status_start}    end=${end}
    Should Contain X Times    ${azimuthDrive1Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${azimuthDrive2Status_start}=    Get Index From List    ${full_list}    === Event azimuthDrive2Status received =${SPACE}
    ${end}=    Evaluate    ${azimuthDrive2Status_start}+${3}
    ${azimuthDrive2Status_list}=    Get Slice From List    ${full_list}    start=${azimuthDrive2Status_start}    end=${end}
    Should Contain X Times    ${azimuthDrive2Status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${nasmyth1DriveStatus_start}=    Get Index From List    ${full_list}    === Event nasmyth1DriveStatus received =${SPACE}
    ${end}=    Evaluate    ${nasmyth1DriveStatus_start}+${3}
    ${nasmyth1DriveStatus_list}=    Get Slice From List    ${full_list}    start=${nasmyth1DriveStatus_start}    end=${end}
    Should Contain X Times    ${nasmyth1DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${nasmyth2DriveStatus_start}=    Get Index From List    ${full_list}    === Event nasmyth2DriveStatus received =${SPACE}
    ${end}=    Evaluate    ${nasmyth2DriveStatus_start}+${3}
    ${nasmyth2DriveStatus_list}=    Get Slice From List    ${full_list}    start=${nasmyth2DriveStatus_start}    end=${end}
    Should Contain X Times    ${nasmyth2DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${m3DriveStatus_start}=    Get Index From List    ${full_list}    === Event m3DriveStatus received =${SPACE}
    ${end}=    Evaluate    ${m3DriveStatus_start}+${3}
    ${m3DriveStatus_list}=    Get Slice From List    ${full_list}    start=${m3DriveStatus_start}    end=${end}
    Should Contain X Times    ${m3DriveStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    ${elevationBrake_start}=    Get Index From List    ${full_list}    === Event elevationBrake received =${SPACE}
    ${end}=    Evaluate    ${elevationBrake_start}+${3}
    ${elevationBrake_list}=    Get Slice From List    ${full_list}    start=${elevationBrake_start}    end=${end}
    Should Contain X Times    ${elevationBrake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${azimuthBrake1_start}=    Get Index From List    ${full_list}    === Event azimuthBrake1 received =${SPACE}
    ${end}=    Evaluate    ${azimuthBrake1_start}+${3}
    ${azimuthBrake1_list}=    Get Slice From List    ${full_list}    start=${azimuthBrake1_start}    end=${end}
    Should Contain X Times    ${azimuthBrake1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${azimuthBrake2_start}=    Get Index From List    ${full_list}    === Event azimuthBrake2 received =${SPACE}
    ${end}=    Evaluate    ${azimuthBrake2_start}+${3}
    ${azimuthBrake2_list}=    Get Slice From List    ${full_list}    start=${azimuthBrake2_start}    end=${end}
    Should Contain X Times    ${azimuthBrake2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${nasmyth1Brake_start}=    Get Index From List    ${full_list}    === Event nasmyth1Brake received =${SPACE}
    ${end}=    Evaluate    ${nasmyth1Brake_start}+${3}
    ${nasmyth1Brake_list}=    Get Slice From List    ${full_list}    start=${nasmyth1Brake_start}    end=${end}
    Should Contain X Times    ${nasmyth1Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${nasmyth2Brake_start}=    Get Index From List    ${full_list}    === Event nasmyth2Brake received =${SPACE}
    ${end}=    Evaluate    ${nasmyth2Brake_start}+${3}
    ${nasmyth2Brake_list}=    Get Slice From List    ${full_list}    start=${nasmyth2Brake_start}    end=${end}
    Should Contain X Times    ${nasmyth2Brake_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${crioSummaryState_start}=    Get Index From List    ${full_list}    === Event crioSummaryState received =${SPACE}
    ${end}=    Evaluate    ${crioSummaryState_start}+${3}
    ${crioSummaryState_list}=    Get Slice From List    ${full_list}    start=${crioSummaryState_start}    end=${end}
    Should Contain X Times    ${crioSummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${2}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${4}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${11}
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
    ${end}=    Evaluate    ${softwareVersions_start}+${7}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${5}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${3}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${3}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === Event configurationApplied received =${SPACE}
    ${end}=    Evaluate    ${configurationApplied_start}+${7}
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${end}
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurations : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherInfo : RO    1
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === Event configurationsAvailable received =${SPACE}
    ${end}=    Evaluate    ${configurationsAvailable_start}+${6}
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${end}
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overrides : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
