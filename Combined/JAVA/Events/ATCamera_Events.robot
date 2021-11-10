*** Settings ***
Documentation    ATCamera_Events communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
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
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutLogger.txt

Start Sender
    [Tags]    functional
    Comment    Sender program waiting for Logger program to be Ready.
    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     'ATCamera all loggers ready' in $loggerOutput
        ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
        Sleep    3s
    END
    Comment    Executing Combined Java Sender Program.
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === ATCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === ATCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === ATCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === ATCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === ATCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === ATCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === ATCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === ATCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === ATCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === ATCamera_imageReadinessDetailedState end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === ATCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === ATCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === ATCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === ATCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === ATCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === ATCamera_startShutterClose end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === ATCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === ATCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === ATCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === ATCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === ATCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === ATCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === ATCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === ATCamera_endOfImageTelemetry end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === ATCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === ATCamera_calibrationDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === ATCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === ATCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === ATCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === ATCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === ATCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === ATCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === ATCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === ATCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === ATCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === ATCamera_prepareToTakeImage end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === ATCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === ATCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === ATCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === ATCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === ATCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === ATCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === ATCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === ATCamera_startIntegration end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === ATCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === ATCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === ATCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === ATCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === ATCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === ATCamera_raftsDetailedState end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === ATCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === ATCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === ATCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === ATCamera_startReadout end of topic ===
    ${shutterMotionProfile_start}=    Get Index From List    ${full_list}    === ATCamera_shutterMotionProfile start of topic ===
    ${shutterMotionProfile_end}=    Get Index From List    ${full_list}    === ATCamera_shutterMotionProfile end of topic ===
    ${shutterMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterMotionProfile_start}    end=${shutterMotionProfile_end + 1}
    Log Many    ${shutterMotionProfile_list}
    Should Contain    ${shutterMotionProfile_list}    === ATCamera_shutterMotionProfile start of topic ===
    Should Contain    ${shutterMotionProfile_list}    === ATCamera_shutterMotionProfile end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === ATCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === ATCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === ATCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === ATCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === ATCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === ATCamera_focalPlaneSummaryInfo end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied start of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_AgentMonitorService_timersSettingsApplied_start}    end=${ats_power_AgentMonitorService_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_AgentMonitorService_timersSettingsApplied_list}
    Should Contain    ${ats_power_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_I_LimitsSettingsApplied_start}    end=${ats_power_Analog_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Analog_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied start of topic ===
    ${ats_power_Analog_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied end of topic ===
    ${ats_power_Analog_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_PowerSettingsApplied_start}    end=${ats_power_Analog_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Analog_PowerSettingsApplied_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_PowerSettingsApplied_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied end of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_V_LimitsSettingsApplied_start}    end=${ats_power_Analog_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Analog_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_I_LimitsSettingsApplied_start}    end=${ats_power_Aux_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Aux_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied start of topic ===
    ${ats_power_Aux_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied end of topic ===
    ${ats_power_Aux_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_PowerSettingsApplied_start}    end=${ats_power_Aux_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Aux_PowerSettingsApplied_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_PowerSettingsApplied_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied end of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_V_LimitsSettingsApplied_start}    end=${ats_power_Aux_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Aux_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_I_LimitsSettingsApplied_start}    end=${ats_power_ClkHigh_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_V_LimitsSettingsApplied_start}    end=${ats_power_ClkHigh_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_I_LimitsSettingsApplied_start}    end=${ats_power_ClkLow_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_V_LimitsSettingsApplied_start}    end=${ats_power_ClkLow_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied start of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied end of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClockHigh_PowerSettingsApplied_start}    end=${ats_power_ClockHigh_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_ClockHigh_PowerSettingsApplied_list}
    Should Contain    ${ats_power_ClockHigh_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClockHigh_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied end of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied start of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied end of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClockLow_PowerSettingsApplied_start}    end=${ats_power_ClockLow_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_ClockLow_PowerSettingsApplied_list}
    Should Contain    ${ats_power_ClockLow_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClockLow_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied start of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_I_LimitsSettingsApplied_start}    end=${ats_power_DPHI_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied start of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_PowerSettingsApplied_start}    end=${ats_power_DPHI_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_PowerSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_PowerSettingsApplied_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_PowerSettingsApplied_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied start of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_V_LimitsSettingsApplied_start}    end=${ats_power_DPHI_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_I_LimitsSettingsApplied_start}    end=${ats_power_Digital_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Digital_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied start of topic ===
    ${ats_power_Digital_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied end of topic ===
    ${ats_power_Digital_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_PowerSettingsApplied_start}    end=${ats_power_Digital_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Digital_PowerSettingsApplied_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_PowerSettingsApplied_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied end of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_V_LimitsSettingsApplied_start}    end=${ats_power_Digital_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Digital_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_I_LimitsSettingsApplied_start}    end=${ats_power_Fan_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Fan_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied start of topic ===
    ${ats_power_Fan_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied end of topic ===
    ${ats_power_Fan_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_PowerSettingsApplied_start}    end=${ats_power_Fan_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Fan_PowerSettingsApplied_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_PowerSettingsApplied_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied end of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_V_LimitsSettingsApplied_start}    end=${ats_power_Fan_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Fan_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied start of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_I_LimitsSettingsApplied_start}    end=${ats_power_HVBias_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied start of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied end of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_PowerSettingsApplied_start}    end=${ats_power_HVBias_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_PowerSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_PowerSettingsApplied_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_PowerSettingsApplied_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied end of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied start of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_V_LimitsSettingsApplied_start}    end=${ats_power_HVBias_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_PowerSettingsApplied_start}    end=${ats_power_Hameg1_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg1_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg1_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg1_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_PowerSettingsApplied_start}    end=${ats_power_Hameg2_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg2_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg2_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg2_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_PowerSettingsApplied_start}    end=${ats_power_Hameg3_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg3_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg3_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg3_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied end of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied start of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Heartbeat_timersSettingsApplied_start}    end=${ats_power_Heartbeat_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Heartbeat_timersSettingsApplied_list}
    Should Contain    ${ats_power_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied start of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied end of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_PowerSettingsApplied_start}    end=${ats_power_Keithley_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Keithley_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Keithley_PowerSettingsApplied_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Keithley_PowerSettingsApplied_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied end of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_check_timersSettingsApplied_start}    end=${ats_power_Monitor_check_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_check_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_publish_timersSettingsApplied_start}    end=${ats_power_Monitor_publish_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_publish_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_update_timersSettingsApplied_start}    end=${ats_power_Monitor_update_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_update_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied start of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_I_LimitsSettingsApplied_start}    end=${ats_power_OD_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OD_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_PowerSettingsApplied start of topic ===
    ${ats_power_OD_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_PowerSettingsApplied end of topic ===
    ${ats_power_OD_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_PowerSettingsApplied_start}    end=${ats_power_OD_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_PowerSettingsApplied_list}
    Should Contain    ${ats_power_OD_PowerSettingsApplied_list}    === ATCamera_ats_power_OD_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_PowerSettingsApplied_list}    === ATCamera_ats_power_OD_PowerSettingsApplied end of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied start of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_V_LimitsSettingsApplied_start}    end=${ats_power_OD_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OD_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied start of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_I_LimitsSettingsApplied_start}    end=${ats_power_OTM_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OTM_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied start of topic ===
    ${ats_power_OTM_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied end of topic ===
    ${ats_power_OTM_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_PowerSettingsApplied_start}    end=${ats_power_OTM_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_PowerSettingsApplied_list}
    Should Contain    ${ats_power_OTM_PowerSettingsApplied_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_PowerSettingsApplied_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied end of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied start of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_V_LimitsSettingsApplied_start}    end=${ats_power_OTM_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OTM_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Power_state_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied start of topic ===
    ${ats_power_Power_state_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied end of topic ===
    ${ats_power_Power_state_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Power_state_timersSettingsApplied_start}    end=${ats_power_Power_state_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Power_state_timersSettingsApplied_list}
    Should Contain    ${ats_power_Power_state_timersSettingsApplied_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Power_state_timersSettingsApplied_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied end of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied start of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_RuntimeInfo_timersSettingsApplied_start}    end=${ats_power_RuntimeInfo_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_RuntimeInfo_timersSettingsApplied_list}
    Should Contain    ${ats_power_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_power_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_SchedulersSettingsApplied start of topic ===
    ${ats_power_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_SchedulersSettingsApplied end of topic ===
    ${ats_power_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_SchedulersSettingsApplied_start}    end=${ats_power_SchedulersSettingsApplied_end + 1}
    Log Many    ${ats_power_SchedulersSettingsApplied_list}
    Should Contain    ${ats_power_SchedulersSettingsApplied_list}    === ATCamera_ats_power_SchedulersSettingsApplied start of topic ===
    Should Contain    ${ats_power_SchedulersSettingsApplied_list}    === ATCamera_ats_power_SchedulersSettingsApplied end of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied start of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_AgentMonitorService_timersSettingsApplied_start}    end=${ats_AgentMonitorService_timersSettingsApplied_end + 1}
    Log Many    ${ats_AgentMonitorService_timersSettingsApplied_list}
    Should Contain    ${ats_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied start of topic ===
    Should Contain    ${ats_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied start of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied end of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DeviceSettingsApplied_start}    end=${ats_CryoCon_DeviceSettingsApplied_end + 1}
    Log Many    ${ats_CryoCon_DeviceSettingsApplied_list}
    Should Contain    ${ats_CryoCon_DeviceSettingsApplied_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied start of topic ===
    Should Contain    ${ats_CryoCon_DeviceSettingsApplied_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied end of topic ===
    ${ats_Heartbeat_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied start of topic ===
    ${ats_Heartbeat_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_Heartbeat_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Heartbeat_timersSettingsApplied_start}    end=${ats_Heartbeat_timersSettingsApplied_end + 1}
    Log Many    ${ats_Heartbeat_timersSettingsApplied_list}
    Should Contain    ${ats_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_Monitor_check_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied start of topic ===
    ${ats_Monitor_check_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_Monitor_check_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_check_timersSettingsApplied_start}    end=${ats_Monitor_check_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_check_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied start of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_publish_timersSettingsApplied_start}    end=${ats_Monitor_publish_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_publish_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_Monitor_update_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied start of topic ===
    ${ats_Monitor_update_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_Monitor_update_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_update_timersSettingsApplied_start}    end=${ats_Monitor_update_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_update_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied start of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_RuntimeInfo_timersSettingsApplied_start}    end=${ats_RuntimeInfo_timersSettingsApplied_end + 1}
    Log Many    ${ats_RuntimeInfo_timersSettingsApplied_list}
    Should Contain    ${ats_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied start of topic ===
    Should Contain    ${ats_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_SchedulersSettingsApplied start of topic ===
    ${ats_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_SchedulersSettingsApplied end of topic ===
    ${ats_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_SchedulersSettingsApplied_start}    end=${ats_SchedulersSettingsApplied_end + 1}
    Log Many    ${ats_SchedulersSettingsApplied_list}
    Should Contain    ${ats_SchedulersSettingsApplied_list}    === ATCamera_ats_SchedulersSettingsApplied start of topic ===
    Should Contain    ${ats_SchedulersSettingsApplied_list}    === ATCamera_ats_SchedulersSettingsApplied end of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied start of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied end of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCDSetPoint_LimitsSettingsApplied_start}    end=${ats_TempCCDSetPoint_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied end of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied start of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied end of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCD_LimitsSettingsApplied_start}    end=${ats_TempCCD_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCCD_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCCD_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCCD_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied end of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied start of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied end of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempColdPlate_LimitsSettingsApplied_start}    end=${ats_TempColdPlate_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempColdPlate_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempColdPlate_LimitsSettingsApplied_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempColdPlate_LimitsSettingsApplied_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied end of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied start of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied end of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCryoHead_LimitsSettingsApplied_start}    end=${ats_TempCryoHead_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCryoHead_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCryoHead_LimitsSettingsApplied_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCryoHead_LimitsSettingsApplied_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied end of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied start of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied end of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Vacuum_LimitsSettingsApplied_start}    end=${ats_Vacuum_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_Vacuum_LimitsSettingsApplied_list}
    Should Contain    ${ats_Vacuum_LimitsSettingsApplied_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_Vacuum_LimitsSettingsApplied_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === ATCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === ATCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === ATCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === ATCamera_shutterBladeMotionProfile end of topic ===
    ${imageStored_start}=    Get Index From List    ${full_list}    === ATCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === ATCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === ATCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === ATCamera_imageStored end of topic ===
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === ATCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === ATCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === ATCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === ATCamera_fitsFilesWritten end of topic ===
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === ATCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === ATCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === ATCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === ATCamera_fileCommandExecution end of topic ===
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === ATCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === ATCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === ATCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === ATCamera_imageVisualization end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ATCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ATCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === ATCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ATCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === ATCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === ATCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === ATCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ATCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === ATCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === ATCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === ATCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === ATCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === ATCamera_authList start of topic ===
    Should Contain    ${authList_list}    === ATCamera_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === ATCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ATCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === ATCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === ATCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ATCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ATCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === ATCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ATCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === ATCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === ATCamera_summaryState end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === ATCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === ATCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === ATCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === ATCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === ATCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === ATCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === ATCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === ATCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === ATCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === ATCamera_imageReadinessDetailedState end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === ATCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === ATCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === ATCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === ATCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === ATCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === ATCamera_startShutterClose end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === ATCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === ATCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === ATCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === ATCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === ATCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === ATCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === ATCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === ATCamera_endOfImageTelemetry end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === ATCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === ATCamera_calibrationDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === ATCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === ATCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === ATCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === ATCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === ATCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === ATCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === ATCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === ATCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === ATCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === ATCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === ATCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === ATCamera_prepareToTakeImage end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === ATCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === ATCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === ATCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === ATCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === ATCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === ATCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === ATCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === ATCamera_startIntegration end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === ATCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === ATCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === ATCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === ATCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === ATCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === ATCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === ATCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === ATCamera_raftsDetailedState end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === ATCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === ATCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === ATCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === ATCamera_startReadout end of topic ===
    ${shutterMotionProfile_start}=    Get Index From List    ${full_list}    === ATCamera_shutterMotionProfile start of topic ===
    ${shutterMotionProfile_end}=    Get Index From List    ${full_list}    === ATCamera_shutterMotionProfile end of topic ===
    ${shutterMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterMotionProfile_start}    end=${shutterMotionProfile_end + 1}
    Log Many    ${shutterMotionProfile_list}
    Should Contain    ${shutterMotionProfile_list}    === ATCamera_shutterMotionProfile start of topic ===
    Should Contain    ${shutterMotionProfile_list}    === ATCamera_shutterMotionProfile end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === ATCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === ATCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === ATCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === ATCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === ATCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === ATCamera_focalPlaneSummaryInfo end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === ATCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === ATCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === ATCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === ATCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === ATCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === ATCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === ATCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === ATCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === ATCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === ATCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied start of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_power_AgentMonitorService_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_AgentMonitorService_timersSettingsApplied_start}    end=${ats_power_AgentMonitorService_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_AgentMonitorService_timersSettingsApplied_list}
    Should Contain    ${ats_power_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_power_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_I_LimitsSettingsApplied_start}    end=${ats_power_Analog_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Analog_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied start of topic ===
    ${ats_power_Analog_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied end of topic ===
    ${ats_power_Analog_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_PowerSettingsApplied_start}    end=${ats_power_Analog_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Analog_PowerSettingsApplied_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_PowerSettingsApplied_list}    === ATCamera_ats_power_Analog_PowerSettingsApplied end of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Analog_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_V_LimitsSettingsApplied_start}    end=${ats_power_Analog_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Analog_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Analog_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Analog_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Analog_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_I_LimitsSettingsApplied_start}    end=${ats_power_Aux_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Aux_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied start of topic ===
    ${ats_power_Aux_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied end of topic ===
    ${ats_power_Aux_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_PowerSettingsApplied_start}    end=${ats_power_Aux_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Aux_PowerSettingsApplied_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_PowerSettingsApplied_list}    === ATCamera_ats_power_Aux_PowerSettingsApplied end of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Aux_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_V_LimitsSettingsApplied_start}    end=${ats_power_Aux_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Aux_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Aux_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Aux_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Aux_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_I_LimitsSettingsApplied_start}    end=${ats_power_ClkHigh_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkHigh_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_V_LimitsSettingsApplied_start}    end=${ats_power_ClkHigh_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkHigh_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkHigh_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_I_LimitsSettingsApplied_start}    end=${ats_power_ClkLow_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkLow_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_I_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied start of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_V_LimitsSettingsApplied_start}    end=${ats_power_ClkLow_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClkLow_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_ClkLow_V_LimitsSettingsApplied end of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied start of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied end of topic ===
    ${ats_power_ClockHigh_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClockHigh_PowerSettingsApplied_start}    end=${ats_power_ClockHigh_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_ClockHigh_PowerSettingsApplied_list}
    Should Contain    ${ats_power_ClockHigh_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClockHigh_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockHigh_PowerSettingsApplied end of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied start of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied end of topic ===
    ${ats_power_ClockLow_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClockLow_PowerSettingsApplied_start}    end=${ats_power_ClockLow_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_ClockLow_PowerSettingsApplied_list}
    Should Contain    ${ats_power_ClockLow_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_ClockLow_PowerSettingsApplied_list}    === ATCamera_ats_power_ClockLow_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied start of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_I_LimitsSettingsApplied_start}    end=${ats_power_DPHI_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_I_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied start of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_PowerSettingsApplied_start}    end=${ats_power_DPHI_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_PowerSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_PowerSettingsApplied_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_PowerSettingsApplied_list}    === ATCamera_ats_power_DPHI_PowerSettingsApplied end of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied start of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied end of topic ===
    ${ats_power_DPHI_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_V_LimitsSettingsApplied_start}    end=${ats_power_DPHI_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_DPHI_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_DPHI_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_DPHI_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_DPHI_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_I_LimitsSettingsApplied_start}    end=${ats_power_Digital_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Digital_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied start of topic ===
    ${ats_power_Digital_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied end of topic ===
    ${ats_power_Digital_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_PowerSettingsApplied_start}    end=${ats_power_Digital_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Digital_PowerSettingsApplied_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_PowerSettingsApplied_list}    === ATCamera_ats_power_Digital_PowerSettingsApplied end of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Digital_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_V_LimitsSettingsApplied_start}    end=${ats_power_Digital_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Digital_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Digital_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Digital_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Digital_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied start of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_I_LimitsSettingsApplied_start}    end=${ats_power_Fan_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Fan_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_I_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied start of topic ===
    ${ats_power_Fan_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied end of topic ===
    ${ats_power_Fan_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_PowerSettingsApplied_start}    end=${ats_power_Fan_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Fan_PowerSettingsApplied_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_PowerSettingsApplied_list}    === ATCamera_ats_power_Fan_PowerSettingsApplied end of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied start of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Fan_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_V_LimitsSettingsApplied_start}    end=${ats_power_Fan_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_Fan_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_Fan_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_Fan_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_Fan_V_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied start of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_I_LimitsSettingsApplied_start}    end=${ats_power_HVBias_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_I_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied start of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied end of topic ===
    ${ats_power_HVBias_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_PowerSettingsApplied_start}    end=${ats_power_HVBias_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_PowerSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_PowerSettingsApplied_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_PowerSettingsApplied_list}    === ATCamera_ats_power_HVBias_PowerSettingsApplied end of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied start of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied end of topic ===
    ${ats_power_HVBias_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_V_LimitsSettingsApplied_start}    end=${ats_power_HVBias_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_HVBias_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_HVBias_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_HVBias_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_HVBias_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg1_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_PowerSettingsApplied_start}    end=${ats_power_Hameg1_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg1_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg1_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg1_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg1_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg2_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_PowerSettingsApplied_start}    end=${ats_power_Hameg2_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg2_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg2_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg2_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg2_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied start of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied end of topic ===
    ${ats_power_Hameg3_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_PowerSettingsApplied_start}    end=${ats_power_Hameg3_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Hameg3_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Hameg3_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Hameg3_PowerSettingsApplied_list}    === ATCamera_ats_power_Hameg3_PowerSettingsApplied end of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied start of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_power_Heartbeat_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Heartbeat_timersSettingsApplied_start}    end=${ats_power_Heartbeat_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Heartbeat_timersSettingsApplied_list}
    Should Contain    ${ats_power_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_power_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied start of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied end of topic ===
    ${ats_power_Keithley_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_PowerSettingsApplied_start}    end=${ats_power_Keithley_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_Keithley_PowerSettingsApplied_list}
    Should Contain    ${ats_power_Keithley_PowerSettingsApplied_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_Keithley_PowerSettingsApplied_list}    === ATCamera_ats_power_Keithley_PowerSettingsApplied end of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_check_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_check_timersSettingsApplied_start}    end=${ats_power_Monitor_check_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_check_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_publish_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_publish_timersSettingsApplied_start}    end=${ats_power_Monitor_publish_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_publish_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied start of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_power_Monitor_update_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Monitor_update_timersSettingsApplied_start}    end=${ats_power_Monitor_update_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Monitor_update_timersSettingsApplied_list}
    Should Contain    ${ats_power_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_power_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied start of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_I_LimitsSettingsApplied_start}    end=${ats_power_OD_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OD_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_PowerSettingsApplied start of topic ===
    ${ats_power_OD_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_PowerSettingsApplied end of topic ===
    ${ats_power_OD_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_PowerSettingsApplied_start}    end=${ats_power_OD_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_PowerSettingsApplied_list}
    Should Contain    ${ats_power_OD_PowerSettingsApplied_list}    === ATCamera_ats_power_OD_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_PowerSettingsApplied_list}    === ATCamera_ats_power_OD_PowerSettingsApplied end of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied start of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OD_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_V_LimitsSettingsApplied_start}    end=${ats_power_OD_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OD_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OD_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OD_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OD_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied start of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_I_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_I_LimitsSettingsApplied_start}    end=${ats_power_OTM_I_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_I_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OTM_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_I_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_I_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied start of topic ===
    ${ats_power_OTM_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied end of topic ===
    ${ats_power_OTM_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_PowerSettingsApplied_start}    end=${ats_power_OTM_PowerSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_PowerSettingsApplied_list}
    Should Contain    ${ats_power_OTM_PowerSettingsApplied_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_PowerSettingsApplied_list}    === ATCamera_ats_power_OTM_PowerSettingsApplied end of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied start of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied end of topic ===
    ${ats_power_OTM_V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_V_LimitsSettingsApplied_start}    end=${ats_power_OTM_V_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_power_OTM_V_LimitsSettingsApplied_list}
    Should Contain    ${ats_power_OTM_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_power_OTM_V_LimitsSettingsApplied_list}    === ATCamera_ats_power_OTM_V_LimitsSettingsApplied end of topic ===
    ${ats_power_Power_state_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied start of topic ===
    ${ats_power_Power_state_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied end of topic ===
    ${ats_power_Power_state_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_Power_state_timersSettingsApplied_start}    end=${ats_power_Power_state_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_Power_state_timersSettingsApplied_list}
    Should Contain    ${ats_power_Power_state_timersSettingsApplied_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_Power_state_timersSettingsApplied_list}    === ATCamera_ats_power_Power_state_timersSettingsApplied end of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied start of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_power_RuntimeInfo_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_RuntimeInfo_timersSettingsApplied_start}    end=${ats_power_RuntimeInfo_timersSettingsApplied_end + 1}
    Log Many    ${ats_power_RuntimeInfo_timersSettingsApplied_list}
    Should Contain    ${ats_power_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied start of topic ===
    Should Contain    ${ats_power_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_power_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_power_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_SchedulersSettingsApplied start of topic ===
    ${ats_power_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_SchedulersSettingsApplied end of topic ===
    ${ats_power_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_power_SchedulersSettingsApplied_start}    end=${ats_power_SchedulersSettingsApplied_end + 1}
    Log Many    ${ats_power_SchedulersSettingsApplied_list}
    Should Contain    ${ats_power_SchedulersSettingsApplied_list}    === ATCamera_ats_power_SchedulersSettingsApplied start of topic ===
    Should Contain    ${ats_power_SchedulersSettingsApplied_list}    === ATCamera_ats_power_SchedulersSettingsApplied end of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied start of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_AgentMonitorService_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_AgentMonitorService_timersSettingsApplied_start}    end=${ats_AgentMonitorService_timersSettingsApplied_end + 1}
    Log Many    ${ats_AgentMonitorService_timersSettingsApplied_list}
    Should Contain    ${ats_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied start of topic ===
    Should Contain    ${ats_AgentMonitorService_timersSettingsApplied_list}    === ATCamera_ats_AgentMonitorService_timersSettingsApplied end of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied start of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied end of topic ===
    ${ats_CryoCon_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DeviceSettingsApplied_start}    end=${ats_CryoCon_DeviceSettingsApplied_end + 1}
    Log Many    ${ats_CryoCon_DeviceSettingsApplied_list}
    Should Contain    ${ats_CryoCon_DeviceSettingsApplied_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied start of topic ===
    Should Contain    ${ats_CryoCon_DeviceSettingsApplied_list}    === ATCamera_ats_CryoCon_DeviceSettingsApplied end of topic ===
    ${ats_Heartbeat_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied start of topic ===
    ${ats_Heartbeat_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_Heartbeat_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Heartbeat_timersSettingsApplied_start}    end=${ats_Heartbeat_timersSettingsApplied_end + 1}
    Log Many    ${ats_Heartbeat_timersSettingsApplied_list}
    Should Contain    ${ats_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Heartbeat_timersSettingsApplied_list}    === ATCamera_ats_Heartbeat_timersSettingsApplied end of topic ===
    ${ats_Monitor_check_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied start of topic ===
    ${ats_Monitor_check_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_Monitor_check_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_check_timersSettingsApplied_start}    end=${ats_Monitor_check_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_check_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_check_timersSettingsApplied_list}    === ATCamera_ats_Monitor_check_timersSettingsApplied end of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied start of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_Monitor_publish_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_publish_timersSettingsApplied_start}    end=${ats_Monitor_publish_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_publish_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_publish_timersSettingsApplied_list}    === ATCamera_ats_Monitor_publish_timersSettingsApplied end of topic ===
    ${ats_Monitor_update_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied start of topic ===
    ${ats_Monitor_update_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_Monitor_update_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Monitor_update_timersSettingsApplied_start}    end=${ats_Monitor_update_timersSettingsApplied_end + 1}
    Log Many    ${ats_Monitor_update_timersSettingsApplied_list}
    Should Contain    ${ats_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied start of topic ===
    Should Contain    ${ats_Monitor_update_timersSettingsApplied_list}    === ATCamera_ats_Monitor_update_timersSettingsApplied end of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied start of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_RuntimeInfo_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_RuntimeInfo_timersSettingsApplied_start}    end=${ats_RuntimeInfo_timersSettingsApplied_end + 1}
    Log Many    ${ats_RuntimeInfo_timersSettingsApplied_list}
    Should Contain    ${ats_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied start of topic ===
    Should Contain    ${ats_RuntimeInfo_timersSettingsApplied_list}    === ATCamera_ats_RuntimeInfo_timersSettingsApplied end of topic ===
    ${ats_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_SchedulersSettingsApplied start of topic ===
    ${ats_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_SchedulersSettingsApplied end of topic ===
    ${ats_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_SchedulersSettingsApplied_start}    end=${ats_SchedulersSettingsApplied_end + 1}
    Log Many    ${ats_SchedulersSettingsApplied_list}
    Should Contain    ${ats_SchedulersSettingsApplied_list}    === ATCamera_ats_SchedulersSettingsApplied start of topic ===
    Should Contain    ${ats_SchedulersSettingsApplied_list}    === ATCamera_ats_SchedulersSettingsApplied end of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied start of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied end of topic ===
    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCDSetPoint_LimitsSettingsApplied_start}    end=${ats_TempCCDSetPoint_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCCDSetPoint_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCDSetPoint_LimitsSettingsApplied end of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied start of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied end of topic ===
    ${ats_TempCCD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCD_LimitsSettingsApplied_start}    end=${ats_TempCCD_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCCD_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCCD_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCCD_LimitsSettingsApplied_list}    === ATCamera_ats_TempCCD_LimitsSettingsApplied end of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied start of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied end of topic ===
    ${ats_TempColdPlate_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempColdPlate_LimitsSettingsApplied_start}    end=${ats_TempColdPlate_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempColdPlate_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempColdPlate_LimitsSettingsApplied_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempColdPlate_LimitsSettingsApplied_list}    === ATCamera_ats_TempColdPlate_LimitsSettingsApplied end of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied start of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied end of topic ===
    ${ats_TempCryoHead_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_TempCryoHead_LimitsSettingsApplied_start}    end=${ats_TempCryoHead_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_TempCryoHead_LimitsSettingsApplied_list}
    Should Contain    ${ats_TempCryoHead_LimitsSettingsApplied_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_TempCryoHead_LimitsSettingsApplied_list}    === ATCamera_ats_TempCryoHead_LimitsSettingsApplied end of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied start of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied end of topic ===
    ${ats_Vacuum_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${ats_Vacuum_LimitsSettingsApplied_start}    end=${ats_Vacuum_LimitsSettingsApplied_end + 1}
    Log Many    ${ats_Vacuum_LimitsSettingsApplied_list}
    Should Contain    ${ats_Vacuum_LimitsSettingsApplied_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied start of topic ===
    Should Contain    ${ats_Vacuum_LimitsSettingsApplied_list}    === ATCamera_ats_Vacuum_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === ATCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === ATCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === ATCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === ATCamera_shutterBladeMotionProfile end of topic ===
    ${imageStored_start}=    Get Index From List    ${full_list}    === ATCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === ATCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === ATCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === ATCamera_imageStored end of topic ===
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === ATCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === ATCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === ATCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === ATCamera_fitsFilesWritten end of topic ===
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === ATCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === ATCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === ATCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === ATCamera_fileCommandExecution end of topic ===
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === ATCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === ATCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === ATCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === ATCamera_imageVisualization end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ATCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ATCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === ATCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ATCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === ATCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === ATCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === ATCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ATCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === ATCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === ATCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === ATCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === ATCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === ATCamera_authList start of topic ===
    Should Contain    ${authList_list}    === ATCamera_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === ATCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ATCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === ATCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === ATCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ATCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ATCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === ATCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ATCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === ATCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === ATCamera_summaryState end of topic ===
