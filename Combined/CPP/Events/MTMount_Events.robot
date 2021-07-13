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
    Comment    ======= Verify ${subSystem}_elevationLimitPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elevationLimitPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elevationLimitPositions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elevationLimitPositions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elevationLimitPositions generated =
    Comment    ======= Verify ${subSystem}_azimuthLimitPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthLimitPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthLimitPositions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthLimitPositions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthLimitPositions generated =
    Comment    ======= Verify ${subSystem}_cameraCableWrapLimitPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraCableWrapLimitPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraCableWrapLimitPositions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraCableWrapLimitPositions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraCableWrapLimitPositions generated =
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
    Comment    ======= Verify ${subSystem}_deployablePlatformMotionState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_deployablePlatformMotionState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event deployablePlatformMotionState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_deployablePlatformMotionState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event deployablePlatformMotionState generated =
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
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
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
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
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
    ${elevationLimitPositions_start}=    Get Index From List    ${full_list}    === Event elevationLimitPositions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLimitPositions_start}
    ${elevationLimitPositions_end}=    Evaluate    ${end}+${1}
    ${elevationLimitPositions_list}=    Get Slice From List    ${full_list}    start=${elevationLimitPositions_start}    end=${elevationLimitPositions_end}
    Should Contain X Times    ${elevationLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min : 1    1
    Should Contain X Times    ${elevationLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max : 1    1
    Should Contain X Times    ${elevationLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthLimitPositions_start}=    Get Index From List    ${full_list}    === Event azimuthLimitPositions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthLimitPositions_start}
    ${azimuthLimitPositions_end}=    Evaluate    ${end}+${1}
    ${azimuthLimitPositions_list}=    Get Slice From List    ${full_list}    start=${azimuthLimitPositions_start}    end=${azimuthLimitPositions_end}
    Should Contain X Times    ${azimuthLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min : 1    1
    Should Contain X Times    ${azimuthLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max : 1    1
    Should Contain X Times    ${azimuthLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraCableWrapLimitPositions_start}=    Get Index From List    ${full_list}    === Event cameraCableWrapLimitPositions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraCableWrapLimitPositions_start}
    ${cameraCableWrapLimitPositions_end}=    Evaluate    ${end}+${1}
    ${cameraCableWrapLimitPositions_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrapLimitPositions_start}    end=${cameraCableWrapLimitPositions_end}
    Should Contain X Times    ${cameraCableWrapLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min : 1    1
    Should Contain X Times    ${cameraCableWrapLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max : 1    1
    Should Contain X Times    ${cameraCableWrapLimitPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    ${deployablePlatformMotionState_start}=    Get Index From List    ${full_list}    === Event deployablePlatformMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${deployablePlatformMotionState_start}
    ${deployablePlatformMotionState_end}=    Evaluate    ${end}+${1}
    ${deployablePlatformMotionState_list}=    Get Slice From List    ${full_list}    start=${deployablePlatformMotionState_start}    end=${deployablePlatformMotionState_end}
    Should Contain X Times    ${deployablePlatformMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${deployablePlatformMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementState : 0    1
    Should Contain X Times    ${deployablePlatformMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elevationLockingPinMotionState_start}=    Get Index From List    ${full_list}    === Event elevationLockingPinMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elevationLockingPinMotionState_start}
    ${elevationLockingPinMotionState_end}=    Evaluate    ${end}+${1}
    ${elevationLockingPinMotionState_list}=    Get Slice From List    ${full_list}    start=${elevationLockingPinMotionState_start}    end=${elevationLockingPinMotionState_end}
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementState : 0    1
    Should Contain X Times    ${elevationLockingPinMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${error_start}=    Get Index From List    ${full_list}    === Event error received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${error_start}
    ${error_end}=    Evaluate    ${end}+${1}
    ${error_list}=    Get Slice From List    ${full_list}    start=${error_start}    end=${error_end}
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latched : 0    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 0    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}code : 0    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : RO    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : 0    1
    Should Contain X Times    ${error_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mirrorCoverLocksMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoverLocksMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoverLocksMotionState_start}
    ${mirrorCoverLocksMotionState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoverLocksMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocksMotionState_start}    end=${mirrorCoverLocksMotionState_end}
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementState : 0    1
    Should Contain X Times    ${mirrorCoverLocksMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mirrorCoversMotionState_start}=    Get Index From List    ${full_list}    === Event mirrorCoversMotionState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mirrorCoversMotionState_start}
    ${mirrorCoversMotionState_end}=    Evaluate    ${end}+${1}
    ${mirrorCoversMotionState_list}=    Get Slice From List    ${full_list}    start=${mirrorCoversMotionState_start}    end=${mirrorCoversMotionState_end}
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elementState : 0    1
    Should Contain X Times    ${mirrorCoversMotionState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === Event appliedSettingsMatchStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedSettingsMatchStart_start}
    ${appliedSettingsMatchStart_end}=    Evaluate    ${end}+${1}
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
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
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === Event settingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsApplied_start}
    ${settingsApplied_end}=    Evaluate    ${end}+${1}
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsVersion : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherSettingsEvents : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${authList_start}
    ${authList_end}=    Evaluate    ${end}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
