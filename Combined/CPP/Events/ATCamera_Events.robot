*** Settings ***
Documentation    ATCamera_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
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
    Comment    ======= Verify ${subSystem}_offlineDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_offlineDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event offlineDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_offlineDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event offlineDetailedState generated =
    Comment    ======= Verify ${subSystem}_endReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endReadout generated =
    Comment    ======= Verify ${subSystem}_endTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endTakeImage generated =
    Comment    ======= Verify ${subSystem}_imageReadinessDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadinessDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadinessDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadinessDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadinessDetailedState generated =
    Comment    ======= Verify ${subSystem}_notReadyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_notReadyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event notReadyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_notReadyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event notReadyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_startShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterClose generated =
    Comment    ======= Verify ${subSystem}_endShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterClose generated =
    Comment    ======= Verify ${subSystem}_endOfImageTelemetry test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endOfImageTelemetry
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endOfImageTelemetry iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endOfImageTelemetry_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endOfImageTelemetry generated =
    Comment    ======= Verify ${subSystem}_calibrationDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_calibrationDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event calibrationDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_calibrationDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event calibrationDetailedState generated =
    Comment    ======= Verify ${subSystem}_shutterDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterDetailedState generated =
    Comment    ======= Verify ${subSystem}_readyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_readyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event readyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_readyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event readyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_ccsCommandState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ccsCommandState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ccsCommandState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ccsCommandState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ccsCommandState generated =
    Comment    ======= Verify ${subSystem}_prepareToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_prepareToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event prepareToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_prepareToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event prepareToTakeImage generated =
    Comment    ======= Verify ${subSystem}_endShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterOpen generated =
    Comment    ======= Verify ${subSystem}_startIntegration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startIntegration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startIntegration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startIntegration_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startIntegration generated =
    Comment    ======= Verify ${subSystem}_startShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterOpen generated =
    Comment    ======= Verify ${subSystem}_raftsDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_raftsDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event raftsDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_raftsDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event raftsDetailedState generated =
    Comment    ======= Verify ${subSystem}_startReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startReadout generated =
    Comment    ======= Verify ${subSystem}_shutterMotionProfile test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterMotionProfile
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterMotionProfile iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterMotionProfile_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterMotionProfile generated =
    Comment    ======= Verify ${subSystem}_imageReadoutParameters test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadoutParameters
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadoutParameters iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadoutParameters_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadoutParameters generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedLegacy test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedLegacy
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedLegacy iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedLegacy_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedLegacy generated =
    Comment    ======= Verify ${subSystem}_bonnShutterSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_bonnShutterSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event bonnShutterSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_bonnShutterSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event bonnShutterSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_wrebSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wrebSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event wrebSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wrebSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wrebSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_softwareVersionsSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersionsSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersionsSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersionsSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersionsSettingsApplied generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === Event offlineDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${offlineDetailedState_start}
    ${offlineDetailedState_end}=    Evaluate    ${end}+${1}
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end}
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transitionTimestamp : 1    1
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endReadout_start}=    Get Index From List    ${full_list}    === Event endReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endReadout_start}
    ${endReadout_end}=    Evaluate    ${end}+${1}
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end}
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestedExposureTime : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampEndOfReadout : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === Event endTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endTakeImage_start}
    ${endTakeImage_end}=    Evaluate    ${end}+${1}
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end}
    Should Contain X Times    ${endTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === Event imageReadinessDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${imageReadinessDetailedState_start}
    ${imageReadinessDetailedState_end}=    Evaluate    ${end}+${1}
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end}
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transitionTimestamp : 1    1
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === Event notReadyToTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${notReadyToTakeImage_start}
    ${notReadyToTakeImage_end}=    Evaluate    ${end}+${1}
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end}
    Should Contain X Times    ${notReadyToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === Event startShutterClose received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startShutterClose_start}
    ${startShutterClose_end}=    Evaluate    ${end}+${1}
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end}
    Should Contain X Times    ${startShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === Event endShutterClose received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endShutterClose_start}
    ${endShutterClose_end}=    Evaluate    ${end}+${1}
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end}
    Should Contain X Times    ${endShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === Event endOfImageTelemetry received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endOfImageTelemetry_start}
    ${endOfImageTelemetry_end}=    Evaluate    ${end}+${1}
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end}
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageTag : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampDateObs : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampDateEnd : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredShutterOpenTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === Event calibrationDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${calibrationDetailedState_start}
    ${calibrationDetailedState_end}=    Evaluate    ${end}+${1}
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end}
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transitionTimestamp : 1    1
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === Event shutterDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${shutterDetailedState_start}
    ${shutterDetailedState_end}=    Evaluate    ${end}+${1}
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end}
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transitionTimestamp : 1    1
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === Event readyToTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${readyToTakeImage_start}
    ${readyToTakeImage_end}=    Evaluate    ${end}+${1}
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end}
    Should Contain X Times    ${readyToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === Event ccsCommandState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${ccsCommandState_start}
    ${ccsCommandState_end}=    Evaluate    ${end}+${1}
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end}
    Should Contain X Times    ${ccsCommandState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${ccsCommandState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === Event prepareToTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${prepareToTakeImage_start}
    ${prepareToTakeImage_end}=    Evaluate    ${end}+${1}
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end}
    Should Contain X Times    ${prepareToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === Event endShutterOpen received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endShutterOpen_start}
    ${endShutterOpen_end}=    Evaluate    ${end}+${1}
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end}
    Should Contain X Times    ${endShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startIntegration_start}=    Get Index From List    ${full_list}    === Event startIntegration received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startIntegration_start}
    ${startIntegration_end}=    Evaluate    ${end}+${1}
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end}
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === Event startShutterOpen received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startShutterOpen_start}
    ${startShutterOpen_end}=    Evaluate    ${end}+${1}
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end}
    Should Contain X Times    ${startShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === Event raftsDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${raftsDetailedState_start}
    ${raftsDetailedState_end}=    Evaluate    ${end}+${1}
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end}
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transitionTimestamp : 1    1
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startReadout_start}=    Get Index From List    ${full_list}    === Event startReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startReadout_start}
    ${startReadout_end}=    Evaluate    ${end}+${1}
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end}
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampStartOfReadout : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterMotionProfile_start}=    Get Index From List    ${full_list}    === Event shutterMotionProfile received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${shutterMotionProfile_start}
    ${shutterMotionProfile_end}=    Evaluate    ${end}+${1}
    ${shutterMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterMotionProfile_start}    end=${shutterMotionProfile_end}
    Should Contain X Times    ${shutterMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredExposureTime : 1    1
    Should Contain X Times    ${shutterMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === Event imageReadoutParameters received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${imageReadoutParameters_start}
    ${imageReadoutParameters_end}=    Evaluate    ${end}+${1}
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end}
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdLocation : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftBay : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdSlot : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdType : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overRows : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overCols : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readRows : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols2 : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preCols : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preRows : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postCols : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}underCols : 1    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqFolder : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqAnnotation : RO    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedLegacy_start}=    Get Index From List    ${full_list}    === Event settingsAppliedLegacy received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedLegacy_start}
    ${settingsAppliedLegacy_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedLegacy_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedLegacy_start}    end=${settingsAppliedLegacy_end}
    Should Contain X Times    ${settingsAppliedLegacy_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settings : RO    1
    Should Contain X Times    ${settingsAppliedLegacy_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${settingsAppliedLegacy_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrebSettingsVersion : RO    1
    Should Contain X Times    ${settingsAppliedLegacy_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bonnShutterSettingsVersion : RO    1
    Should Contain X Times    ${settingsAppliedLegacy_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${bonnShutterSettingsApplied_start}=    Get Index From List    ${full_list}    === Event bonnShutterSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${bonnShutterSettingsApplied_start}
    ${bonnShutterSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${bonnShutterSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonnShutterSettingsApplied_start}    end=${bonnShutterSettingsApplied_end}
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startA : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startB : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}travelDistance : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startVelocity : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceleration : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxVelocity : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threshold : 1    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutterVersion : RO    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}firmwareVersion : RO    1
    Should Contain X Times    ${bonnShutterSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wrebSettingsApplied_start}=    Get Index From List    ${full_list}    === Event wrebSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${wrebSettingsApplied_start}
    ${wrebSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${wrebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${wrebSettingsApplied_start}    end=${wrebSettingsApplied_end}
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerKey : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerChecksum : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqVersion : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}firmwareVersion : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic0_af1 : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic0_clamp : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic0_gain : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic0_rc : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic0_tm : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic1_af1 : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic1_clamp : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic1_gain : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic1_rc : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspic1_tm : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_csGate : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_csGateP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gd : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_od : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_og : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rd : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_csGate : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHigh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLow : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHigh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLow : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHigh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLow : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowP : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowSh : 1    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdManufacturer : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdType : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdSerialNumber : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdName : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebName : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebSerialNumber : RO    1
    Should Contain X Times    ${wrebSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersionsSettingsApplied_start}=    Get Index From List    ${full_list}    === Event softwareVersionsSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersionsSettingsApplied_start}
    ${softwareVersionsSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${softwareVersionsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${softwareVersionsSettingsApplied_start}    end=${softwareVersionsSettingsApplied_end}
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mcmVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ocsbridgeVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebPowerVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pduVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bonnShutterVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrebFirmwareVersion : RO    1
    Should Contain X Times    ${softwareVersionsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
