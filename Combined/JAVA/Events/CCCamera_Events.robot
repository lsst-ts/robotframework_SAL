*** Settings ***
Documentation    CCCamera_Events communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCCamera
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
        Exit For Loop If     'CCCamera all loggers ready' in $loggerOutput
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
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === CCCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === CCCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === CCCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === CCCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === CCCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === CCCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter end of topic ===
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose end of topic ===
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel end of topic ===
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter end of topic ===
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured end of topic ===
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === CCCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === CCCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration end of topic ===
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage end of topic ===
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState end of topic ===
    ${availableFilters_start}=    Get Index From List    ${full_list}    === CCCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === CCCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === CCCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === CCCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === CCCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === CCCamera_startReadout end of topic ===
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${fcsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied start of topic ===
    ${fcsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcsSettingsApplied_start}    end=${fcsSettingsApplied_end + 1}
    Log Many    ${fcsSettingsApplied_list}
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied start of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    ${fcs_LinearEncoderSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoderSettingsApplied_start}    end=${fcs_LinearEncoderSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoderSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_LimitsSettingsApplied_start}    end=${fcs_LinearEncoder_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoder_LimitsSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    ${fcs_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasksSettingsApplied_start}    end=${fcs_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasksSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersSettingsApplied_start}    end=${fcs_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    ${fcs_StepperMotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotorSettingsApplied_start}    end=${fcs_StepperMotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsSettingsApplied_start}    end=${fcs_StepperMotor_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorSettingsApplied_start}    end=${fcs_StepperMotor_MotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_MotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralSettingsApplied_start}    end=${bonn_shutter_Device_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsSettingsApplied_start}    end=${bonn_shutter_Device_LimitsSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralSettingsApplied_start}    end=${bonn_shutter_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconSettingsApplied_start}    end=${vacuum_Cold1_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsSettingsApplied_start}    end=${vacuum_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconSettingsApplied_start}    end=${vacuum_Cold2_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsSettingsApplied_start}    end=${vacuum_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconSettingsApplied_start}    end=${vacuum_Cryo_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsSettingsApplied_start}    end=${vacuum_Cryo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoSettingsApplied_start}    end=${vacuum_IonPumps_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_CryoSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsSettingsApplied_start}    end=${vacuum_IonPumps_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasksSettingsApplied_start}    end=${vacuum_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasksSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersSettingsApplied_start}    end=${vacuum_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceSettingsApplied_start}    end=${vacuum_Rtds_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsSettingsApplied_start}    end=${vacuum_Rtds_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    ${vacuum_TurboSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSettingsApplied_start}    end=${vacuum_TurboSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSettingsApplied_list}
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsSettingsApplied_start}    end=${vacuum_Turbo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Turbo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoSettingsApplied_start}    end=${vacuum_VQMonitor_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsSettingsApplied_start}    end=${vacuum_VQMonitor_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceSettingsApplied_start}    end=${vacuum_VacPluto_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${imageStored_start}=    Get Index From List    ${full_list}    === CCCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === CCCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === CCCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === CCCamera_imageStored end of topic ===
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution end of topic ===
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === CCCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === CCCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === CCCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === CCCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === CCCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCCamera_authList start of topic ===
    Should Contain    ${authList_list}    === CCCamera_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCCamera_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === CCCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === CCCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === CCCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === CCCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === CCCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === CCCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === CCCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === CCCamera_configurationsAvailable end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCCamera all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === CCCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === CCCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === CCCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === CCCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === CCCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === CCCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter end of topic ===
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose end of topic ===
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel end of topic ===
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter end of topic ===
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured end of topic ===
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === CCCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === CCCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration end of topic ===
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage end of topic ===
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState end of topic ===
    ${availableFilters_start}=    Get Index From List    ${full_list}    === CCCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === CCCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === CCCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === CCCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === CCCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === CCCamera_startReadout end of topic ===
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${fcsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied start of topic ===
    ${fcsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcsSettingsApplied_start}    end=${fcsSettingsApplied_end + 1}
    Log Many    ${fcsSettingsApplied_list}
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied start of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    ${fcs_LinearEncoderSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoderSettingsApplied_start}    end=${fcs_LinearEncoderSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoderSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_LimitsSettingsApplied_start}    end=${fcs_LinearEncoder_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoder_LimitsSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    ${fcs_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasksSettingsApplied_start}    end=${fcs_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasksSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersSettingsApplied_start}    end=${fcs_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    ${fcs_StepperMotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotorSettingsApplied_start}    end=${fcs_StepperMotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsSettingsApplied_start}    end=${fcs_StepperMotor_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorSettingsApplied_start}    end=${fcs_StepperMotor_MotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_MotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralSettingsApplied_start}    end=${bonn_shutter_Device_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsSettingsApplied_start}    end=${bonn_shutter_Device_LimitsSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralSettingsApplied_start}    end=${bonn_shutter_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconSettingsApplied_start}    end=${vacuum_Cold1_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsSettingsApplied_start}    end=${vacuum_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconSettingsApplied_start}    end=${vacuum_Cold2_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsSettingsApplied_start}    end=${vacuum_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconSettingsApplied_start}    end=${vacuum_Cryo_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsSettingsApplied_start}    end=${vacuum_Cryo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoSettingsApplied_start}    end=${vacuum_IonPumps_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_CryoSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsSettingsApplied_start}    end=${vacuum_IonPumps_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasksSettingsApplied_start}    end=${vacuum_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasksSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersSettingsApplied_start}    end=${vacuum_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceSettingsApplied_start}    end=${vacuum_Rtds_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsSettingsApplied_start}    end=${vacuum_Rtds_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    ${vacuum_TurboSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSettingsApplied_start}    end=${vacuum_TurboSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSettingsApplied_list}
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsSettingsApplied_start}    end=${vacuum_Turbo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Turbo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoSettingsApplied_start}    end=${vacuum_VQMonitor_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsSettingsApplied_start}    end=${vacuum_VQMonitor_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceSettingsApplied_start}    end=${vacuum_VacPluto_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${imageStored_start}=    Get Index From List    ${full_list}    === CCCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === CCCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === CCCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === CCCamera_imageStored end of topic ===
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution end of topic ===
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === CCCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === CCCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === CCCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === CCCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === CCCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCCamera_authList start of topic ===
    Should Contain    ${authList_list}    === CCCamera_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCCamera_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === CCCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === CCCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === CCCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === CCCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === CCCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === CCCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === CCCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === CCCamera_configurationsAvailable end of topic ===
