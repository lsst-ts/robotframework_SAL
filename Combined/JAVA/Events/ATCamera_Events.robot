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
    ${focalPlaneHardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied start of topic ===
    ${focalPlaneHardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied end of topic ===
    ${focalPlaneHardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneHardwareIdSettingsApplied_start}    end=${focalPlaneHardwareIdSettingsApplied_end + 1}
    Log Many    ${focalPlaneHardwareIdSettingsApplied_list}
    Should Contain    ${focalPlaneHardwareIdSettingsApplied_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied start of topic ===
    Should Contain    ${focalPlaneHardwareIdSettingsApplied_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied start of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlStatusSettingsApplied_start}    end=${focalPlaneRaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focalPlaneRaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied start of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlSettingsApplied_start}    end=${focalPlaneRaftTempControlSettingsApplied_end + 1}
    Log Many    ${focalPlaneRaftTempControlSettingsApplied_list}
    Should Contain    ${focalPlaneRaftTempControlSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRaftTempControlSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied end of topic ===
    ${focalPlaneDAQSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneDAQSettingsApplied start of topic ===
    ${focalPlaneDAQSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneDAQSettingsApplied end of topic ===
    ${focalPlaneDAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneDAQSettingsApplied_start}    end=${focalPlaneDAQSettingsApplied_end + 1}
    Log Many    ${focalPlaneDAQSettingsApplied_list}
    Should Contain    ${focalPlaneDAQSettingsApplied_list}    === ATCamera_focalPlaneDAQSettingsApplied start of topic ===
    Should Contain    ${focalPlaneDAQSettingsApplied_list}    === ATCamera_focalPlaneDAQSettingsApplied end of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied start of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied end of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSequencerConfigSettingsApplied_start}    end=${focalPlaneSequencerConfigSettingsApplied_end + 1}
    Log Many    ${focalPlaneSequencerConfigSettingsApplied_list}
    Should Contain    ${focalPlaneSequencerConfigSettingsApplied_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied start of topic ===
    Should Contain    ${focalPlaneSequencerConfigSettingsApplied_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied end of topic ===
    ${focalPlaneRebRaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied start of topic ===
    ${focalPlaneRebRaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied end of topic ===
    ${focalPlaneRebRaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsSettingsApplied_start}    end=${focalPlaneRebRaftsSettingsApplied_end + 1}
    Log Many    ${focalPlaneRebRaftsSettingsApplied_list}
    Should Contain    ${focalPlaneRebRaftsSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRebRaftsSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied end of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied start of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied end of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsPowerSettingsApplied_start}    end=${focalPlaneRebRaftsPowerSettingsApplied_end + 1}
    Log Many    ${focalPlaneRebRaftsPowerSettingsApplied_list}
    Should Contain    ${focalPlaneRebRaftsPowerSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRebRaftsPowerSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied end of topic ===
    ${daq_monitorSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitorSettingsApplied start of topic ===
    ${daq_monitorSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitorSettingsApplied end of topic ===
    ${daq_monitorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitorSettingsApplied_start}    end=${daq_monitorSettingsApplied_end + 1}
    Log Many    ${daq_monitorSettingsApplied_list}
    Should Contain    ${daq_monitorSettingsApplied_list}    === ATCamera_daq_monitorSettingsApplied start of topic ===
    Should Contain    ${daq_monitorSettingsApplied_list}    === ATCamera_daq_monitorSettingsApplied end of topic ===
    ${daq_monitor_StatsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StatsSettingsApplied start of topic ===
    ${daq_monitor_StatsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StatsSettingsApplied end of topic ===
    ${daq_monitor_StatsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StatsSettingsApplied_start}    end=${daq_monitor_StatsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StatsSettingsApplied_list}
    Should Contain    ${daq_monitor_StatsSettingsApplied_list}    === ATCamera_daq_monitor_StatsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StatsSettingsApplied_list}    === ATCamera_daq_monitor_StatsSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
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
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ATCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ATCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === ATCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === ATCamera_settingVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === ATCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ATCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === ATCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === ATCamera_errorCode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === ATCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ATCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === ATCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === ATCamera_summaryState end of topic ===
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ATCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ATCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === ATCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === ATCamera_appliedSettingsMatchStart end of topic ===
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
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === ATCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === ATCamera_settingsApplied end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ATCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ATCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ATCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ATCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === ATCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === ATCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === ATCamera_authList start of topic ===
    Should Contain    ${authList_list}    === ATCamera_authList end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable end of topic ===

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
    ${focalPlaneHardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied start of topic ===
    ${focalPlaneHardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied end of topic ===
    ${focalPlaneHardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneHardwareIdSettingsApplied_start}    end=${focalPlaneHardwareIdSettingsApplied_end + 1}
    Log Many    ${focalPlaneHardwareIdSettingsApplied_list}
    Should Contain    ${focalPlaneHardwareIdSettingsApplied_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied start of topic ===
    Should Contain    ${focalPlaneHardwareIdSettingsApplied_list}    === ATCamera_focalPlaneHardwareIdSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied start of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlStatusSettingsApplied_start}    end=${focalPlaneRaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focalPlaneRaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRaftTempControlStatusSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlStatusSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied start of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied end of topic ===
    ${focalPlaneRaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRaftTempControlSettingsApplied_start}    end=${focalPlaneRaftTempControlSettingsApplied_end + 1}
    Log Many    ${focalPlaneRaftTempControlSettingsApplied_list}
    Should Contain    ${focalPlaneRaftTempControlSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRaftTempControlSettingsApplied_list}    === ATCamera_focalPlaneRaftTempControlSettingsApplied end of topic ===
    ${focalPlaneDAQSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneDAQSettingsApplied start of topic ===
    ${focalPlaneDAQSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneDAQSettingsApplied end of topic ===
    ${focalPlaneDAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneDAQSettingsApplied_start}    end=${focalPlaneDAQSettingsApplied_end + 1}
    Log Many    ${focalPlaneDAQSettingsApplied_list}
    Should Contain    ${focalPlaneDAQSettingsApplied_list}    === ATCamera_focalPlaneDAQSettingsApplied start of topic ===
    Should Contain    ${focalPlaneDAQSettingsApplied_list}    === ATCamera_focalPlaneDAQSettingsApplied end of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied start of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied end of topic ===
    ${focalPlaneSequencerConfigSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSequencerConfigSettingsApplied_start}    end=${focalPlaneSequencerConfigSettingsApplied_end + 1}
    Log Many    ${focalPlaneSequencerConfigSettingsApplied_list}
    Should Contain    ${focalPlaneSequencerConfigSettingsApplied_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied start of topic ===
    Should Contain    ${focalPlaneSequencerConfigSettingsApplied_list}    === ATCamera_focalPlaneSequencerConfigSettingsApplied end of topic ===
    ${focalPlaneRebRaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied start of topic ===
    ${focalPlaneRebRaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied end of topic ===
    ${focalPlaneRebRaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsSettingsApplied_start}    end=${focalPlaneRebRaftsSettingsApplied_end + 1}
    Log Many    ${focalPlaneRebRaftsSettingsApplied_list}
    Should Contain    ${focalPlaneRebRaftsSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRebRaftsSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsSettingsApplied end of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied start of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied end of topic ===
    ${focalPlaneRebRaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focalPlaneRebRaftsPowerSettingsApplied_start}    end=${focalPlaneRebRaftsPowerSettingsApplied_end + 1}
    Log Many    ${focalPlaneRebRaftsPowerSettingsApplied_list}
    Should Contain    ${focalPlaneRebRaftsPowerSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focalPlaneRebRaftsPowerSettingsApplied_list}    === ATCamera_focalPlaneRebRaftsPowerSettingsApplied end of topic ===
    ${daq_monitorSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitorSettingsApplied start of topic ===
    ${daq_monitorSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitorSettingsApplied end of topic ===
    ${daq_monitorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitorSettingsApplied_start}    end=${daq_monitorSettingsApplied_end + 1}
    Log Many    ${daq_monitorSettingsApplied_list}
    Should Contain    ${daq_monitorSettingsApplied_list}    === ATCamera_daq_monitorSettingsApplied start of topic ===
    Should Contain    ${daq_monitorSettingsApplied_list}    === ATCamera_daq_monitorSettingsApplied end of topic ===
    ${daq_monitor_StatsSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StatsSettingsApplied start of topic ===
    ${daq_monitor_StatsSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StatsSettingsApplied end of topic ===
    ${daq_monitor_StatsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StatsSettingsApplied_start}    end=${daq_monitor_StatsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StatsSettingsApplied_list}
    Should Contain    ${daq_monitor_StatsSettingsApplied_list}    === ATCamera_daq_monitor_StatsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StatsSettingsApplied_list}    === ATCamera_daq_monitor_StatsSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === ATCamera_daq_monitor_StoreSettingsApplied end of topic ===
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
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ATCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ATCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === ATCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === ATCamera_settingVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === ATCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ATCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === ATCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === ATCamera_errorCode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === ATCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ATCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === ATCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === ATCamera_summaryState end of topic ===
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ATCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ATCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === ATCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === ATCamera_appliedSettingsMatchStart end of topic ===
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
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === ATCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === ATCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === ATCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === ATCamera_settingsApplied end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ATCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ATCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === ATCamera_simulationMode end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ATCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === ATCamera_softwareVersions end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ATCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ATCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === ATCamera_heartbeat end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === ATCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === ATCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === ATCamera_authList start of topic ===
    Should Contain    ${authList_list}    === ATCamera_authList end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === ATCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === ATCamera_largeFileObjectAvailable end of topic ===
