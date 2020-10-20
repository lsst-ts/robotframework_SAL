*** Settings ***
Documentation    ATCamera_Events communications tests.
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
${subSystem}    ATCamera
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
    Comment    ======= Verify ${subSystem}_offlineDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_offlineDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event offlineDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_offlineDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event offlineDetailedState generated =
    Comment    ======= Verify ${subSystem}_endReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event endReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endReadout generated =
    Comment    ======= Verify ${subSystem}_endTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event endTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endTakeImage generated =
    Comment    ======= Verify ${subSystem}_imageReadinessDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadinessDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadinessDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadinessDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadinessDetailedState generated =
    Comment    ======= Verify ${subSystem}_notReadyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_notReadyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event notReadyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_notReadyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event notReadyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_startShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterClose generated =
    Comment    ======= Verify ${subSystem}_endShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterClose generated =
    Comment    ======= Verify ${subSystem}_endOfImageTelemetry test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endOfImageTelemetry
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event endOfImageTelemetry iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endOfImageTelemetry_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endOfImageTelemetry generated =
    Comment    ======= Verify ${subSystem}_calibrationDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_calibrationDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event calibrationDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_calibrationDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event calibrationDetailedState generated =
    Comment    ======= Verify ${subSystem}_shutterDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterDetailedState generated =
    Comment    ======= Verify ${subSystem}_readyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_readyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event readyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_readyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event readyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_ccsCommandState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ccsCommandState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event ccsCommandState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ccsCommandState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ccsCommandState generated =
    Comment    ======= Verify ${subSystem}_prepareToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_prepareToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event prepareToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_prepareToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event prepareToTakeImage generated =
    Comment    ======= Verify ${subSystem}_endShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterOpen generated =
    Comment    ======= Verify ${subSystem}_startIntegration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startIntegration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event startIntegration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startIntegration_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startIntegration generated =
    Comment    ======= Verify ${subSystem}_startShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterOpen generated =
    Comment    ======= Verify ${subSystem}_raftsDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_raftsDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event raftsDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_raftsDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event raftsDetailedState generated =
    Comment    ======= Verify ${subSystem}_startReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event startReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startReadout generated =
    Comment    ======= Verify ${subSystem}_shutterMotionProfile test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterMotionProfile
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterMotionProfile iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterMotionProfile_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterMotionProfile generated =
    Comment    ======= Verify ${subSystem}_imageReadoutParameters test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadoutParameters
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadoutParameters iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadoutParameters_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadoutParameters generated =
    Comment    ======= Verify ${subSystem}_focalPlaneSummaryInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneSummaryInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneSummaryInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneSummaryInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneSummaryInfo generated =
    Comment    ======= Verify ${subSystem}_focalPlaneHardwareIdSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneHardwareIdSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneHardwareIdSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneHardwareIdSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneHardwareIdSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneRaftTempControlStatusSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneRaftTempControlStatusSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneRaftTempControlStatusSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneRaftTempControlStatusSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneRaftTempControlStatusSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneRaftTempControlSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneRaftTempControlSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneRaftTempControlSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneRaftTempControlSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneRaftTempControlSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneDAQSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneDAQSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneDAQSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneDAQSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneDAQSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneSequencerConfigSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneSequencerConfigSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneSequencerConfigSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneSequencerConfigSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneSequencerConfigSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneRebRaftsSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneRebRaftsSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneRebRaftsSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneRebRaftsSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneRebRaftsSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_focalPlaneRebRaftsPowerSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focalPlaneRebRaftsPowerSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focalPlaneRebRaftsPowerSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focalPlaneRebRaftsPowerSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focalPlaneRebRaftsPowerSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_daq_monitorSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_daq_monitorSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event daq_monitorSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_daq_monitorSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event daq_monitorSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_daq_monitor_StatsSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_daq_monitor_StatsSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event daq_monitor_StatsSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_daq_monitor_StatsSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event daq_monitor_StatsSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_daq_monitor_StoreSettingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_daq_monitor_StoreSettingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event daq_monitor_StoreSettingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_daq_monitor_StoreSettingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event daq_monitor_StoreSettingsApplied generated =
    Comment    ======= Verify ${subSystem}_shutterBladeMotionProfile test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterBladeMotionProfile
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterBladeMotionProfile iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterBladeMotionProfile_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterBladeMotionProfile generated =
    Comment    ======= Verify ${subSystem}_imageStored test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageStored
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageStored iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageStored_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageStored generated =
    Comment    ======= Verify ${subSystem}_fitsFilesWritten test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_fitsFilesWritten
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event fitsFilesWritten iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_fitsFilesWritten_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event fitsFilesWritten generated =
    Comment    ======= Verify ${subSystem}_fileCommandExecution test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_fileCommandExecution
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event fileCommandExecution iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_fileCommandExecution_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event fileCommandExecution generated =
    Comment    ======= Verify ${subSystem}_imageVisualization test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageVisualization
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageVisualization iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageVisualization_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageVisualization generated =
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
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === Event offlineDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${offlineDetailedState_start}
    ${offlineDetailedState_end}=    Evaluate    ${end}+${1}
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end}
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endReadout_start}=    Get Index From List    ${full_list}    === Event endReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endReadout_start}
    ${endReadout_end}=    Evaluate    ${end}+${1}
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end}
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAcquisitionStart : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestedExposureTime : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampEndOfReadout : 1    1
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
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
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
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAcquisitionStart : 1    1
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
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === Event shutterDetailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${shutterDetailedState_start}
    ${shutterDetailedState_end}=    Evaluate    ${end}+${1}
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end}
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
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
    Should Contain X Times    ${ccsCommandState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
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
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAcquisitionStart : 1    1
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
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampTransition : 1    1
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startReadout_start}=    Get Index From List    ${full_list}    === Event startReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startReadout_start}
    ${startReadout_end}=    Evaluate    ${end}+${1}
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end}
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalKeys : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}additionalValues : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : RO    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAcquisitionStart : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampStartOfReadout : 1    1
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
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === Event focalPlaneSummaryInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneSummaryInfo_start}
    ${focalPlaneSummaryInfo_end}=    Evaluate    ${end}+${1}
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end}
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdLocation : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftBay : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdSlot : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebSerialNumber : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebLSSTName : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdLSSTName : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftLSSTName : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdManSerNum : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdManufacturer : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdType : 1    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdTempSetPoint : 1    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerKey : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerChecksum : RO    1
    Should Contain X Times    ${focalPlaneSummaryInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneHardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneHardwareIdSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneHardwareIdSettingsApplied_start}
    ${focalPlaneHardwareIdSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneHardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneHardwareIdSettingsApplied_start}    end=${focalPlaneHardwareIdSettingsApplied_end}
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebLocation : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebLSSTName : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdLocation : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdLSSTName : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdManSerNum : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftLocation : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftLSSTName : RO    1
    Should Contain X Times    ${focalPlaneHardwareIdSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneRaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneRaftTempControlStatusSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneRaftTempControlStatusSettingsApplied_start}
    ${focalPlaneRaftTempControlStatusSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneRaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlStatusSettingsApplied_start}    end=${focalPlaneRaftTempControlStatusSettingsApplied_end}
    Should Contain X Times    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftLocation : RO    1
    Should Contain X Times    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_active : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneRaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneRaftTempControlSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneRaftTempControlSettingsApplied_start}
    ${focalPlaneRaftTempControlSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneRaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlSettingsApplied_start}    end=${focalPlaneRaftTempControlSettingsApplied_end}
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raftLocation : RO    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_awGain : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_basePower : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_gain : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_maxInput : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_maxOutput : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_minInput : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_minOutput : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_rebs : RO    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_setTemp : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_smoothTime : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_tempChans : RO    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_timeConst : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft_TempControl_tolerance : 1    1
    Should Contain X Times    ${focalPlaneRaftTempControlSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneDAQSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneDAQSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneDAQSettingsApplied_start}
    ${focalPlaneDAQSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneDAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneDAQSettingsApplied_start}    end=${focalPlaneDAQSettingsApplied_end}
    Should Contain X Times    ${focalPlaneDAQSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneDAQSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqFolder : RO    1
    Should Contain X Times    ${focalPlaneDAQSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqPartition : RO    1
    Should Contain X Times    ${focalPlaneDAQSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}emulatedDAQ : 1    1
    Should Contain X Times    ${focalPlaneDAQSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneSequencerConfigSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneSequencerConfigSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneSequencerConfigSettingsApplied_start}
    ${focalPlaneSequencerConfigSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneSequencerConfigSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSequencerConfigSettingsApplied_start}    end=${focalPlaneSequencerConfigSettingsApplied_end}
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clearCountParameter : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clearMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}idleFlushMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}integrateMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}metaDataRegisters : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overCols : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overRows : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postCols : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postRows : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preCols : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preRows : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pseudoReadMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols2 : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readRows : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rowShiftForwardMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rowShiftReverseMain : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scanMode : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencer : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerChecksums : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shiftCountParameter : RO    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transparentMode : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}underCols : 1    1
    Should Contain X Times    ${focalPlaneSequencerConfigSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneRebRaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneRebRaftsSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneRebRaftsSettingsApplied_start}
    ${focalPlaneRebRaftsSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneRebRaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsSettingsApplied_start}    end=${focalPlaneRebRaftsSettingsApplied_end}
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_csGateP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_csGateP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_odP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_csGateP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_odP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowP : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}disableRTDHardwareCheck : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serialNum : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focalPlaneRebRaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === Event focalPlaneRebRaftsPowerSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focalPlaneRebRaftsPowerSettingsApplied_start}
    ${focalPlaneRebRaftsPowerSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${focalPlaneRebRaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsPowerSettingsApplied_start}    end=${focalPlaneRebRaftsPowerSettingsApplied_end}
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_gdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odIMax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_odZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_ogZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias0_rdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_gdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_odCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_odIMax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_odTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_odZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_ogZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias1_rdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_gdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_odCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_odIMax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_odTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_odZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_ogZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdTestVolts : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias2_rdZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkhiAmin : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkhiQmax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkliAmin : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkliQmax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_clkhIMax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_clklIMax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkHighZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_pclkLowZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgHighZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_rgLowZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkHighZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowCal : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowTestV : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowValueErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dac_sclkLowZeroErr : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxDelta : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxStep : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minTol : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nPowerOnPub : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odiAmin : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odiQmax : 1    1
    Should Contain X Times    ${focalPlaneRebRaftsPowerSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${daq_monitorSettingsApplied_start}=    Get Index From List    ${full_list}    === Event daq_monitorSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${daq_monitorSettingsApplied_start}
    ${daq_monitorSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${daq_monitorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitorSettingsApplied_start}    end=${daq_monitorSettingsApplied_end}
    Should Contain X Times    ${daq_monitorSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${daq_monitorSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqPartition : RO    1
    Should Contain X Times    ${daq_monitorSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${daq_monitor_StatsSettingsApplied_start}=    Get Index From List    ${full_list}    === Event daq_monitor_StatsSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${daq_monitor_StatsSettingsApplied_start}
    ${daq_monitor_StatsSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${daq_monitor_StatsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StatsSettingsApplied_start}    end=${daq_monitor_StatsSettingsApplied_end}
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enablePeriodicPublication : 1    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDiffAlertWarning : 1    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDiffLogWarning : 1    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumDriverChecks : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumDriverStats : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumFirmwareChecks : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumFirmwareStats : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumRdsChecks : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumRdsStats : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumRmsChecks : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sumRmsStats : RO    1
    Should Contain X Times    ${daq_monitor_StatsSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === Event daq_monitor_StoreSettingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${daq_monitor_StoreSettingsApplied_start}
    ${daq_monitor_StoreSettingsApplied_end}=    Evaluate    ${end}+${1}
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end}
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daqFolder : RO    1
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enableAutoPurge : 1    1
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}purgeTarget : 1    1
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}purgeThreshold : 1    1
    Should Contain X Times    ${daq_monitor_StoreSettingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === Event shutterBladeMotionProfile received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${shutterBladeMotionProfile_start}
    ${shutterBladeMotionProfile_end}=    Evaluate    ${end}+${1}
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end}
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blade : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}direction : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampStart : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startPosition : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetDuration : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetPosition : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}endPosition : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualDuration : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hallSensorCount : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampHallSensor : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hallSensorID : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hallSensorPosition : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hallSensorTransition : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderCount : 1    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampEncoder : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderPosition : 0    1
    Should Contain X Times    ${shutterBladeMotionProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageStored_start}=    Get Index From List    ${full_list}    === Event imageStored received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${imageStored_start}
    ${imageStored_end}=    Evaluate    ${end}+${1}
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end}
    Should Contain X Times    ${imageStored_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${imageStored_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampImageStored : 1    1
    Should Contain X Times    ${imageStored_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === Event fitsFilesWritten received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${fitsFilesWritten_start}
    ${fitsFilesWritten_end}=    Evaluate    ${end}+${1}
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end}
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampFilesWritten : 1    1
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rootFileName : RO    1
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}relativeFileNames : RO    1
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fileNode : RO    1
    Should Contain X Times    ${fitsFilesWritten_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === Event fileCommandExecution received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${fileCommandExecution_start}
    ${fileCommandExecution_end}=    Evaluate    ${end}+${1}
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end}
    Should Contain X Times    ${fileCommandExecution_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${fileCommandExecution_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampCommandComplete : 1    1
    Should Contain X Times    ${fileCommandExecution_list}    ${SPACE}${SPACE}${SPACE}${SPACE}command : RO    1
    Should Contain X Times    ${fileCommandExecution_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rc : 1    1
    Should Contain X Times    ${fileCommandExecution_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === Event imageVisualization received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${imageVisualization_start}
    ${imageVisualization_end}=    Evaluate    ${end}+${1}
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end}
    Should Contain X Times    ${imageVisualization_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : RO    1
    Should Contain X Times    ${imageVisualization_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampVisualizationAvailable : 1    1
    Should Contain X Times    ${imageVisualization_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${imageVisualization_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thumbnail : RO    1
    Should Contain X Times    ${imageVisualization_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
