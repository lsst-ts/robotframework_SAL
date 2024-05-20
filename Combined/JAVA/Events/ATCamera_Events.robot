*** Settings ***
Documentation    ATCamera_Events communications tests.
Force Tags    messaging    java    atcamera    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
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
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Should Be Equal    ${loggerOutput.returncode}   ${NONE}
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
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    Should Be Equal    ${senderOutput.returncode}   ${NONE}
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
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
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === ATCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === ATCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === ATCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === ATCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === ATCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === ATCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration start of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration end of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_I_LimitsConfiguration_start}    end=${ats_power_Analog_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Analog_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Analog_I_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Analog_I_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration end of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration start of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration end of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_V_LimitsConfiguration_start}    end=${ats_power_Analog_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Analog_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Analog_V_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Analog_V_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration end of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration start of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration end of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_I_LimitsConfiguration_start}    end=${ats_power_Aux_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Aux_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Aux_I_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Aux_I_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration end of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration start of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration end of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_V_LimitsConfiguration_start}    end=${ats_power_Aux_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Aux_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Aux_V_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Aux_V_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration start of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_I_LimitsConfiguration_start}    end=${ats_power_ClkHigh_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkHigh_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkHigh_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkHigh_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration start of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_V_LimitsConfiguration_start}    end=${ats_power_ClkHigh_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkHigh_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkHigh_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkHigh_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration start of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_I_LimitsConfiguration_start}    end=${ats_power_ClkLow_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkLow_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkLow_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkLow_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration start of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_V_LimitsConfiguration_start}    end=${ats_power_ClkLow_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkLow_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkLow_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkLow_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration start of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_I_LimitsConfiguration_start}    end=${ats_power_DPHI_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_DPHI_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_DPHI_I_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_DPHI_I_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration start of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_V_LimitsConfiguration_start}    end=${ats_power_DPHI_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_DPHI_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_DPHI_V_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_DPHI_V_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration end of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration start of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration end of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_I_LimitsConfiguration_start}    end=${ats_power_Digital_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Digital_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Digital_I_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Digital_I_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration end of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration start of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration end of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_V_LimitsConfiguration_start}    end=${ats_power_Digital_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Digital_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Digital_V_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Digital_V_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration end of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration start of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration end of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_I_LimitsConfiguration_start}    end=${ats_power_Fan_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Fan_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Fan_I_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Fan_I_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration end of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration start of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration end of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_V_LimitsConfiguration_start}    end=${ats_power_Fan_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Fan_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Fan_V_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Fan_V_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration start of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_I_LimitsConfiguration_start}    end=${ats_power_HVBias_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_HVBias_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_HVBias_I_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_HVBias_I_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration start of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_V_LimitsConfiguration_start}    end=${ats_power_HVBias_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_HVBias_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_HVBias_V_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_HVBias_V_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration end of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration start of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration end of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_DevicesConfiguration_start}    end=${ats_power_Hameg1_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg1_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg1_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg1_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration end of topic ===
    ${ats_power_Hameg1_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration start of topic ===
    ${ats_power_Hameg1_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration end of topic ===
    ${ats_power_Hameg1_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_PowerConfiguration_start}    end=${ats_power_Hameg1_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg1_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg1_PowerConfiguration_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg1_PowerConfiguration_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration end of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration start of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration end of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_DevicesConfiguration_start}    end=${ats_power_Hameg2_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg2_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg2_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg2_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration end of topic ===
    ${ats_power_Hameg2_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration start of topic ===
    ${ats_power_Hameg2_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration end of topic ===
    ${ats_power_Hameg2_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_PowerConfiguration_start}    end=${ats_power_Hameg2_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg2_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg2_PowerConfiguration_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg2_PowerConfiguration_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration end of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration start of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration end of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_DevicesConfiguration_start}    end=${ats_power_Hameg3_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg3_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg3_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg3_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration end of topic ===
    ${ats_power_Hameg3_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration start of topic ===
    ${ats_power_Hameg3_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration end of topic ===
    ${ats_power_Hameg3_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_PowerConfiguration_start}    end=${ats_power_Hameg3_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg3_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg3_PowerConfiguration_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg3_PowerConfiguration_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration end of topic ===
    ${ats_power_Keithley_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration start of topic ===
    ${ats_power_Keithley_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration end of topic ===
    ${ats_power_Keithley_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_DevicesConfiguration_start}    end=${ats_power_Keithley_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Keithley_DevicesConfiguration_list}
    Should Contain    ${ats_power_Keithley_DevicesConfiguration_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Keithley_DevicesConfiguration_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration end of topic ===
    ${ats_power_Keithley_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerConfiguration start of topic ===
    ${ats_power_Keithley_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerConfiguration end of topic ===
    ${ats_power_Keithley_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_PowerConfiguration_start}    end=${ats_power_Keithley_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Keithley_PowerConfiguration_list}
    Should Contain    ${ats_power_Keithley_PowerConfiguration_list}    === ATCamera_ats_power_Keithley_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Keithley_PowerConfiguration_list}    === ATCamera_ats_power_Keithley_PowerConfiguration end of topic ===
    ${ats_power_OD_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration start of topic ===
    ${ats_power_OD_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration end of topic ===
    ${ats_power_OD_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_I_LimitsConfiguration_start}    end=${ats_power_OD_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OD_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_OD_I_LimitsConfiguration_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OD_I_LimitsConfiguration_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration end of topic ===
    ${ats_power_OD_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration start of topic ===
    ${ats_power_OD_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration end of topic ===
    ${ats_power_OD_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_V_LimitsConfiguration_start}    end=${ats_power_OD_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OD_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_OD_V_LimitsConfiguration_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OD_V_LimitsConfiguration_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration end of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration start of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration end of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_I_LimitsConfiguration_start}    end=${ats_power_OTM_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OTM_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_OTM_I_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OTM_I_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration end of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration start of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration end of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_V_LimitsConfiguration_start}    end=${ats_power_OTM_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OTM_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_OTM_V_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OTM_V_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration end of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration start of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_PeriodicTasks_GeneralConfiguration_start}    end=${ats_power_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${ats_power_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${ats_power_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${ats_power_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration start of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_PeriodicTasks_timersConfiguration_start}    end=${ats_power_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${ats_power_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${ats_power_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${ats_power_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_CryoCon_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceConfiguration start of topic ===
    ${ats_CryoCon_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceConfiguration end of topic ===
    ${ats_CryoCon_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DeviceConfiguration_start}    end=${ats_CryoCon_DeviceConfiguration_end + 1}
    Log Many    ${ats_CryoCon_DeviceConfiguration_list}
    Should Contain    ${ats_CryoCon_DeviceConfiguration_list}    === ATCamera_ats_CryoCon_DeviceConfiguration start of topic ===
    Should Contain    ${ats_CryoCon_DeviceConfiguration_list}    === ATCamera_ats_CryoCon_DeviceConfiguration end of topic ===
    ${ats_CryoCon_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DevicesConfiguration start of topic ===
    ${ats_CryoCon_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DevicesConfiguration end of topic ===
    ${ats_CryoCon_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DevicesConfiguration_start}    end=${ats_CryoCon_DevicesConfiguration_end + 1}
    Log Many    ${ats_CryoCon_DevicesConfiguration_list}
    Should Contain    ${ats_CryoCon_DevicesConfiguration_list}    === ATCamera_ats_CryoCon_DevicesConfiguration start of topic ===
    Should Contain    ${ats_CryoCon_DevicesConfiguration_list}    === ATCamera_ats_CryoCon_DevicesConfiguration end of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration start of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_PeriodicTasks_GeneralConfiguration_start}    end=${ats_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${ats_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${ats_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${ats_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration start of topic ===
    ${ats_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_PeriodicTasks_timersConfiguration_start}    end=${ats_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${ats_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${ats_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${ats_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration start of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration end of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Pfeiffer_DeviceConfiguration_start}    end=${ats_Pfeiffer_DeviceConfiguration_end + 1}
    Log Many    ${ats_Pfeiffer_DeviceConfiguration_list}
    Should Contain    ${ats_Pfeiffer_DeviceConfiguration_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration start of topic ===
    Should Contain    ${ats_Pfeiffer_DeviceConfiguration_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration end of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration start of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration end of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Pfeiffer_DevicesConfiguration_start}    end=${ats_Pfeiffer_DevicesConfiguration_end + 1}
    Log Many    ${ats_Pfeiffer_DevicesConfiguration_list}
    Should Contain    ${ats_Pfeiffer_DevicesConfiguration_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration start of topic ===
    Should Contain    ${ats_Pfeiffer_DevicesConfiguration_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration end of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration start of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration end of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCDSetPoint_LimitsConfiguration_start}    end=${ats_TempCCDSetPoint_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCCDSetPoint_LimitsConfiguration_list}
    Should Contain    ${ats_TempCCDSetPoint_LimitsConfiguration_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCCDSetPoint_LimitsConfiguration_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration end of topic ===
    ${ats_TempCCD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsConfiguration start of topic ===
    ${ats_TempCCD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsConfiguration end of topic ===
    ${ats_TempCCD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCD_LimitsConfiguration_start}    end=${ats_TempCCD_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCCD_LimitsConfiguration_list}
    Should Contain    ${ats_TempCCD_LimitsConfiguration_list}    === ATCamera_ats_TempCCD_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCCD_LimitsConfiguration_list}    === ATCamera_ats_TempCCD_LimitsConfiguration end of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration start of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration end of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempColdPlate_LimitsConfiguration_start}    end=${ats_TempColdPlate_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempColdPlate_LimitsConfiguration_list}
    Should Contain    ${ats_TempColdPlate_LimitsConfiguration_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempColdPlate_LimitsConfiguration_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration end of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration start of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration end of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCryoHead_LimitsConfiguration_start}    end=${ats_TempCryoHead_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCryoHead_LimitsConfiguration_list}
    Should Contain    ${ats_TempCryoHead_LimitsConfiguration_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCryoHead_LimitsConfiguration_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration end of topic ===
    ${ats_Vacuum_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsConfiguration start of topic ===
    ${ats_Vacuum_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsConfiguration end of topic ===
    ${ats_Vacuum_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Vacuum_LimitsConfiguration_start}    end=${ats_Vacuum_LimitsConfiguration_end + 1}
    Log Many    ${ats_Vacuum_LimitsConfiguration_list}
    Should Contain    ${ats_Vacuum_LimitsConfiguration_list}    === ATCamera_ats_Vacuum_LimitsConfiguration start of topic ===
    Should Contain    ${ats_Vacuum_LimitsConfiguration_list}    === ATCamera_ats_Vacuum_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_DevicesConfiguration_start}    end=${bonn_shutter_Device_DevicesConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_DevicesConfiguration_list}
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralConfiguration_start}    end=${bonn_shutter_Device_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsConfiguration_start}    end=${bonn_shutter_Device_LimitsConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsConfiguration_list}
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_GeneralConfiguration start of topic ===
    ${bonn_shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralConfiguration_start}    end=${bonn_shutter_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === ATCamera_bonn_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === ATCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}    end=${bonn_shutter_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersConfiguration_start}    end=${bonn_shutter_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
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
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === ATCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === ATCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === ATCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === ATCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === ATCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === ATCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === ATCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === ATCamera_alertRaised end of topic ===
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
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === ATCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === ATCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === ATCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === ATCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === ATCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === ATCamera_configurationsAvailable end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
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
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === ATCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === ATCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === ATCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === ATCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === ATCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === ATCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === ATCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === ATCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === ATCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === ATCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === ATCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === ATCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === ATCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === ATCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === ATCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === ATCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === ATCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === ATCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === ATCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === ATCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === ATCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === ATCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === ATCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === ATCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration start of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration end of topic ===
    ${ats_power_Analog_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_I_LimitsConfiguration_start}    end=${ats_power_Analog_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Analog_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Analog_I_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Analog_I_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_I_LimitsConfiguration end of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration start of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration end of topic ===
    ${ats_power_Analog_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Analog_V_LimitsConfiguration_start}    end=${ats_power_Analog_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Analog_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Analog_V_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Analog_V_LimitsConfiguration_list}    === ATCamera_ats_power_Analog_V_LimitsConfiguration end of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration start of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration end of topic ===
    ${ats_power_Aux_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_I_LimitsConfiguration_start}    end=${ats_power_Aux_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Aux_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Aux_I_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Aux_I_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_I_LimitsConfiguration end of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration start of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration end of topic ===
    ${ats_power_Aux_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Aux_V_LimitsConfiguration_start}    end=${ats_power_Aux_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Aux_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Aux_V_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Aux_V_LimitsConfiguration_list}    === ATCamera_ats_power_Aux_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration start of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_I_LimitsConfiguration_start}    end=${ats_power_ClkHigh_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkHigh_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkHigh_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkHigh_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration start of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkHigh_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkHigh_V_LimitsConfiguration_start}    end=${ats_power_ClkHigh_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkHigh_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkHigh_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkHigh_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkHigh_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration start of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_I_LimitsConfiguration_start}    end=${ats_power_ClkLow_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkLow_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkLow_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkLow_I_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_I_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration start of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration end of topic ===
    ${ats_power_ClkLow_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_ClkLow_V_LimitsConfiguration_start}    end=${ats_power_ClkLow_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_ClkLow_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_ClkLow_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_ClkLow_V_LimitsConfiguration_list}    === ATCamera_ats_power_ClkLow_V_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration start of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_I_LimitsConfiguration_start}    end=${ats_power_DPHI_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_DPHI_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_DPHI_I_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_DPHI_I_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_I_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration start of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration end of topic ===
    ${ats_power_DPHI_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_DPHI_V_LimitsConfiguration_start}    end=${ats_power_DPHI_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_DPHI_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_DPHI_V_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_DPHI_V_LimitsConfiguration_list}    === ATCamera_ats_power_DPHI_V_LimitsConfiguration end of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration start of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration end of topic ===
    ${ats_power_Digital_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_I_LimitsConfiguration_start}    end=${ats_power_Digital_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Digital_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Digital_I_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Digital_I_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_I_LimitsConfiguration end of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration start of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration end of topic ===
    ${ats_power_Digital_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Digital_V_LimitsConfiguration_start}    end=${ats_power_Digital_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Digital_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Digital_V_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Digital_V_LimitsConfiguration_list}    === ATCamera_ats_power_Digital_V_LimitsConfiguration end of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration start of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration end of topic ===
    ${ats_power_Fan_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_I_LimitsConfiguration_start}    end=${ats_power_Fan_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Fan_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_Fan_I_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Fan_I_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_I_LimitsConfiguration end of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration start of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration end of topic ===
    ${ats_power_Fan_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Fan_V_LimitsConfiguration_start}    end=${ats_power_Fan_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_Fan_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_Fan_V_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_Fan_V_LimitsConfiguration_list}    === ATCamera_ats_power_Fan_V_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration start of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_I_LimitsConfiguration_start}    end=${ats_power_HVBias_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_HVBias_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_HVBias_I_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_HVBias_I_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_I_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration start of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration end of topic ===
    ${ats_power_HVBias_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_HVBias_V_LimitsConfiguration_start}    end=${ats_power_HVBias_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_HVBias_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_HVBias_V_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_HVBias_V_LimitsConfiguration_list}    === ATCamera_ats_power_HVBias_V_LimitsConfiguration end of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration start of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration end of topic ===
    ${ats_power_Hameg1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_DevicesConfiguration_start}    end=${ats_power_Hameg1_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg1_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg1_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg1_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg1_DevicesConfiguration end of topic ===
    ${ats_power_Hameg1_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration start of topic ===
    ${ats_power_Hameg1_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration end of topic ===
    ${ats_power_Hameg1_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg1_PowerConfiguration_start}    end=${ats_power_Hameg1_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg1_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg1_PowerConfiguration_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg1_PowerConfiguration_list}    === ATCamera_ats_power_Hameg1_PowerConfiguration end of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration start of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration end of topic ===
    ${ats_power_Hameg2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_DevicesConfiguration_start}    end=${ats_power_Hameg2_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg2_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg2_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg2_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg2_DevicesConfiguration end of topic ===
    ${ats_power_Hameg2_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration start of topic ===
    ${ats_power_Hameg2_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration end of topic ===
    ${ats_power_Hameg2_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg2_PowerConfiguration_start}    end=${ats_power_Hameg2_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg2_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg2_PowerConfiguration_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg2_PowerConfiguration_list}    === ATCamera_ats_power_Hameg2_PowerConfiguration end of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration start of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration end of topic ===
    ${ats_power_Hameg3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_DevicesConfiguration_start}    end=${ats_power_Hameg3_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Hameg3_DevicesConfiguration_list}
    Should Contain    ${ats_power_Hameg3_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg3_DevicesConfiguration_list}    === ATCamera_ats_power_Hameg3_DevicesConfiguration end of topic ===
    ${ats_power_Hameg3_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration start of topic ===
    ${ats_power_Hameg3_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration end of topic ===
    ${ats_power_Hameg3_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Hameg3_PowerConfiguration_start}    end=${ats_power_Hameg3_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Hameg3_PowerConfiguration_list}
    Should Contain    ${ats_power_Hameg3_PowerConfiguration_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Hameg3_PowerConfiguration_list}    === ATCamera_ats_power_Hameg3_PowerConfiguration end of topic ===
    ${ats_power_Keithley_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration start of topic ===
    ${ats_power_Keithley_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration end of topic ===
    ${ats_power_Keithley_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_DevicesConfiguration_start}    end=${ats_power_Keithley_DevicesConfiguration_end + 1}
    Log Many    ${ats_power_Keithley_DevicesConfiguration_list}
    Should Contain    ${ats_power_Keithley_DevicesConfiguration_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration start of topic ===
    Should Contain    ${ats_power_Keithley_DevicesConfiguration_list}    === ATCamera_ats_power_Keithley_DevicesConfiguration end of topic ===
    ${ats_power_Keithley_PowerConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerConfiguration start of topic ===
    ${ats_power_Keithley_PowerConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_Keithley_PowerConfiguration end of topic ===
    ${ats_power_Keithley_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_Keithley_PowerConfiguration_start}    end=${ats_power_Keithley_PowerConfiguration_end + 1}
    Log Many    ${ats_power_Keithley_PowerConfiguration_list}
    Should Contain    ${ats_power_Keithley_PowerConfiguration_list}    === ATCamera_ats_power_Keithley_PowerConfiguration start of topic ===
    Should Contain    ${ats_power_Keithley_PowerConfiguration_list}    === ATCamera_ats_power_Keithley_PowerConfiguration end of topic ===
    ${ats_power_OD_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration start of topic ===
    ${ats_power_OD_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration end of topic ===
    ${ats_power_OD_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_I_LimitsConfiguration_start}    end=${ats_power_OD_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OD_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_OD_I_LimitsConfiguration_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OD_I_LimitsConfiguration_list}    === ATCamera_ats_power_OD_I_LimitsConfiguration end of topic ===
    ${ats_power_OD_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration start of topic ===
    ${ats_power_OD_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration end of topic ===
    ${ats_power_OD_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OD_V_LimitsConfiguration_start}    end=${ats_power_OD_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OD_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_OD_V_LimitsConfiguration_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OD_V_LimitsConfiguration_list}    === ATCamera_ats_power_OD_V_LimitsConfiguration end of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration start of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration end of topic ===
    ${ats_power_OTM_I_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_I_LimitsConfiguration_start}    end=${ats_power_OTM_I_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OTM_I_LimitsConfiguration_list}
    Should Contain    ${ats_power_OTM_I_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OTM_I_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_I_LimitsConfiguration end of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration start of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration end of topic ===
    ${ats_power_OTM_V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_OTM_V_LimitsConfiguration_start}    end=${ats_power_OTM_V_LimitsConfiguration_end + 1}
    Log Many    ${ats_power_OTM_V_LimitsConfiguration_list}
    Should Contain    ${ats_power_OTM_V_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration start of topic ===
    Should Contain    ${ats_power_OTM_V_LimitsConfiguration_list}    === ATCamera_ats_power_OTM_V_LimitsConfiguration end of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration start of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_power_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_PeriodicTasks_GeneralConfiguration_start}    end=${ats_power_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${ats_power_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${ats_power_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${ats_power_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration start of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_power_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_power_PeriodicTasks_timersConfiguration_start}    end=${ats_power_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${ats_power_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${ats_power_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${ats_power_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_power_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_CryoCon_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceConfiguration start of topic ===
    ${ats_CryoCon_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DeviceConfiguration end of topic ===
    ${ats_CryoCon_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DeviceConfiguration_start}    end=${ats_CryoCon_DeviceConfiguration_end + 1}
    Log Many    ${ats_CryoCon_DeviceConfiguration_list}
    Should Contain    ${ats_CryoCon_DeviceConfiguration_list}    === ATCamera_ats_CryoCon_DeviceConfiguration start of topic ===
    Should Contain    ${ats_CryoCon_DeviceConfiguration_list}    === ATCamera_ats_CryoCon_DeviceConfiguration end of topic ===
    ${ats_CryoCon_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DevicesConfiguration start of topic ===
    ${ats_CryoCon_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_CryoCon_DevicesConfiguration end of topic ===
    ${ats_CryoCon_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_CryoCon_DevicesConfiguration_start}    end=${ats_CryoCon_DevicesConfiguration_end + 1}
    Log Many    ${ats_CryoCon_DevicesConfiguration_list}
    Should Contain    ${ats_CryoCon_DevicesConfiguration_list}    === ATCamera_ats_CryoCon_DevicesConfiguration start of topic ===
    Should Contain    ${ats_CryoCon_DevicesConfiguration_list}    === ATCamera_ats_CryoCon_DevicesConfiguration end of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration start of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_PeriodicTasks_GeneralConfiguration_start}    end=${ats_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${ats_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${ats_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${ats_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_ats_PeriodicTasks_GeneralConfiguration end of topic ===
    ${ats_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration start of topic ===
    ${ats_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_PeriodicTasks_timersConfiguration_start}    end=${ats_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${ats_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${ats_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${ats_PeriodicTasks_timersConfiguration_list}    === ATCamera_ats_PeriodicTasks_timersConfiguration end of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration start of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration end of topic ===
    ${ats_Pfeiffer_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Pfeiffer_DeviceConfiguration_start}    end=${ats_Pfeiffer_DeviceConfiguration_end + 1}
    Log Many    ${ats_Pfeiffer_DeviceConfiguration_list}
    Should Contain    ${ats_Pfeiffer_DeviceConfiguration_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration start of topic ===
    Should Contain    ${ats_Pfeiffer_DeviceConfiguration_list}    === ATCamera_ats_Pfeiffer_DeviceConfiguration end of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration start of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration end of topic ===
    ${ats_Pfeiffer_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Pfeiffer_DevicesConfiguration_start}    end=${ats_Pfeiffer_DevicesConfiguration_end + 1}
    Log Many    ${ats_Pfeiffer_DevicesConfiguration_list}
    Should Contain    ${ats_Pfeiffer_DevicesConfiguration_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration start of topic ===
    Should Contain    ${ats_Pfeiffer_DevicesConfiguration_list}    === ATCamera_ats_Pfeiffer_DevicesConfiguration end of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration start of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration end of topic ===
    ${ats_TempCCDSetPoint_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCDSetPoint_LimitsConfiguration_start}    end=${ats_TempCCDSetPoint_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCCDSetPoint_LimitsConfiguration_list}
    Should Contain    ${ats_TempCCDSetPoint_LimitsConfiguration_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCCDSetPoint_LimitsConfiguration_list}    === ATCamera_ats_TempCCDSetPoint_LimitsConfiguration end of topic ===
    ${ats_TempCCD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsConfiguration start of topic ===
    ${ats_TempCCD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCCD_LimitsConfiguration end of topic ===
    ${ats_TempCCD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCCD_LimitsConfiguration_start}    end=${ats_TempCCD_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCCD_LimitsConfiguration_list}
    Should Contain    ${ats_TempCCD_LimitsConfiguration_list}    === ATCamera_ats_TempCCD_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCCD_LimitsConfiguration_list}    === ATCamera_ats_TempCCD_LimitsConfiguration end of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration start of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration end of topic ===
    ${ats_TempColdPlate_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempColdPlate_LimitsConfiguration_start}    end=${ats_TempColdPlate_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempColdPlate_LimitsConfiguration_list}
    Should Contain    ${ats_TempColdPlate_LimitsConfiguration_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempColdPlate_LimitsConfiguration_list}    === ATCamera_ats_TempColdPlate_LimitsConfiguration end of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration start of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration end of topic ===
    ${ats_TempCryoHead_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_TempCryoHead_LimitsConfiguration_start}    end=${ats_TempCryoHead_LimitsConfiguration_end + 1}
    Log Many    ${ats_TempCryoHead_LimitsConfiguration_list}
    Should Contain    ${ats_TempCryoHead_LimitsConfiguration_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration start of topic ===
    Should Contain    ${ats_TempCryoHead_LimitsConfiguration_list}    === ATCamera_ats_TempCryoHead_LimitsConfiguration end of topic ===
    ${ats_Vacuum_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsConfiguration start of topic ===
    ${ats_Vacuum_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_ats_Vacuum_LimitsConfiguration end of topic ===
    ${ats_Vacuum_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${ats_Vacuum_LimitsConfiguration_start}    end=${ats_Vacuum_LimitsConfiguration_end + 1}
    Log Many    ${ats_Vacuum_LimitsConfiguration_list}
    Should Contain    ${ats_Vacuum_LimitsConfiguration_list}    === ATCamera_ats_Vacuum_LimitsConfiguration start of topic ===
    Should Contain    ${ats_Vacuum_LimitsConfiguration_list}    === ATCamera_ats_Vacuum_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_DevicesConfiguration_start}    end=${bonn_shutter_Device_DevicesConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_DevicesConfiguration_list}
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === ATCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralConfiguration_start}    end=${bonn_shutter_Device_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === ATCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsConfiguration_start}    end=${bonn_shutter_Device_LimitsConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsConfiguration_list}
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === ATCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_GeneralConfiguration start of topic ===
    ${bonn_shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralConfiguration_start}    end=${bonn_shutter_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === ATCamera_bonn_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === ATCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}    end=${bonn_shutter_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersConfiguration_start}    end=${bonn_shutter_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === ATCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === ATCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === ATCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === ATCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === ATCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === ATCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === ATCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === ATCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
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
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === ATCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === ATCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === ATCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === ATCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === ATCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === ATCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === ATCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === ATCamera_alertRaised end of topic ===
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
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === ATCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === ATCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === ATCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === ATCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === ATCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === ATCamera_configurationsAvailable end of topic ===
