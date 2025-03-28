*** Settings ***
Documentation    CCCamera_Events communications tests.
Force Tags    messaging    java    cccamera    
Suite Setup    Log Many    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
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
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Should Be Equal    ${loggerOutput.returncode}   ${NONE}
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
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    Should Be Equal    ${senderOutput.returncode}   ${NONE}
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
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
    ${fcs_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_GeneralConfiguration start of topic ===
    ${fcs_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_GeneralConfiguration end of topic ===
    ${fcs_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_GeneralConfiguration_start}    end=${fcs_GeneralConfiguration_end + 1}
    Log Many    ${fcs_GeneralConfiguration_list}
    Should Contain    ${fcs_GeneralConfiguration_list}    === CCCamera_fcs_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_GeneralConfiguration_list}    === CCCamera_fcs_GeneralConfiguration end of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration start of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration end of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_DevicesConfiguration_start}    end=${fcs_LinearEncoder_DevicesConfiguration_end + 1}
    Log Many    ${fcs_LinearEncoder_DevicesConfiguration_list}
    Should Contain    ${fcs_LinearEncoder_DevicesConfiguration_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_LinearEncoder_DevicesConfiguration_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration end of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration start of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration end of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_GeneralConfiguration_start}    end=${fcs_LinearEncoder_GeneralConfiguration_end + 1}
    Log Many    ${fcs_LinearEncoder_GeneralConfiguration_list}
    Should Contain    ${fcs_LinearEncoder_GeneralConfiguration_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_LinearEncoder_GeneralConfiguration_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_GeneralConfiguration_start}    end=${fcs_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersConfiguration_start}    end=${fcs_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration start of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration end of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_DevicesConfiguration_start}    end=${fcs_StepperMotor_DevicesConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_DevicesConfiguration_list}
    Should Contain    ${fcs_StepperMotor_DevicesConfiguration_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_DevicesConfiguration_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration end of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration start of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration end of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_GeneralConfiguration_start}    end=${fcs_StepperMotor_GeneralConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_GeneralConfiguration_list}
    Should Contain    ${fcs_StepperMotor_GeneralConfiguration_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_GeneralConfiguration_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration end of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration start of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration end of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsConfiguration_start}    end=${fcs_StepperMotor_LimitsConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsConfiguration_list}
    Should Contain    ${fcs_StepperMotor_LimitsConfiguration_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsConfiguration_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration end of topic ===
    ${fcs_StepperMotor_MotorConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration start of topic ===
    ${fcs_StepperMotor_MotorConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration end of topic ===
    ${fcs_StepperMotor_MotorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorConfiguration_start}    end=${fcs_StepperMotor_MotorConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_MotorConfiguration_list}
    Should Contain    ${fcs_StepperMotor_MotorConfiguration_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorConfiguration_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_DevicesConfiguration_start}    end=${bonn_shutter_Device_DevicesConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_DevicesConfiguration_list}
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralConfiguration_start}    end=${bonn_shutter_Device_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsConfiguration_start}    end=${bonn_shutter_Device_LimitsConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsConfiguration_list}
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralConfiguration start of topic ===
    ${bonn_shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralConfiguration_start}    end=${bonn_shutter_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === CCCamera_bonn_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === CCCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}    end=${bonn_shutter_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersConfiguration_start}    end=${bonn_shutter_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === CCCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === CCCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === CCCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === CCCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManager_GeneralConfiguration_start}    end=${rebpower_EmergencyResponseManager_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_GeneralConfiguration start of topic ===
    ${rebpower_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_GeneralConfiguration_start}    end=${rebpower_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_GeneralConfiguration_list}
    Should Contain    ${rebpower_GeneralConfiguration_list}    === CCCamera_rebpower_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_GeneralConfiguration_list}    === CCCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_GeneralConfiguration_start}    end=${rebpower_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_LimitsConfiguration_start}    end=${rebpower_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    ${rebpower_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_GeneralConfiguration_start}    end=${rebpower_Reb_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Reb_GeneralConfiguration_list}
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === CCCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === CCCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === CCCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === CCCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    ${rebpower_Rebps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_DevicesConfiguration_start}    end=${rebpower_Rebps_DevicesConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_DevicesConfiguration_list}
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    ${rebpower_Rebps_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_GeneralConfiguration_start}    end=${rebpower_Rebps_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_GeneralConfiguration_list}
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    ${rebpower_Rebps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsConfiguration_start}    end=${rebpower_Rebps_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_LimitsConfiguration_list}
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    ${rebpower_Rebps_PowerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerConfiguration_start}    end=${rebpower_Rebps_PowerConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_PowerConfiguration_list}
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === CCCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === CCCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_buildConfiguration start of topic ===
    ${rebpower_Rebps_buildConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_buildConfiguration_start}    end=${rebpower_Rebps_buildConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_buildConfiguration_list}
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === CCCamera_rebpower_Rebps_buildConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === CCCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${vacuum_Cold1_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration start of topic ===
    ${vacuum_Cold1_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration end of topic ===
    ${vacuum_Cold1_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconConfiguration_start}    end=${vacuum_Cold1_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cold1_CryoconConfiguration_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconConfiguration_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration end of topic ===
    ${vacuum_Cold1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration start of topic ===
    ${vacuum_Cold1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration end of topic ===
    ${vacuum_Cold1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_DevicesConfiguration_start}    end=${vacuum_Cold1_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cold1_DevicesConfiguration_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_DevicesConfiguration_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration end of topic ===
    ${vacuum_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration start of topic ===
    ${vacuum_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration end of topic ===
    ${vacuum_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsConfiguration_start}    end=${vacuum_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cold1_LimitsConfiguration_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsConfiguration_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration end of topic ===
    ${vacuum_Cold2_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration start of topic ===
    ${vacuum_Cold2_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration end of topic ===
    ${vacuum_Cold2_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconConfiguration_start}    end=${vacuum_Cold2_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cold2_CryoconConfiguration_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconConfiguration_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration end of topic ===
    ${vacuum_Cold2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration start of topic ===
    ${vacuum_Cold2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration end of topic ===
    ${vacuum_Cold2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_DevicesConfiguration_start}    end=${vacuum_Cold2_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cold2_DevicesConfiguration_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_DevicesConfiguration_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration end of topic ===
    ${vacuum_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration start of topic ===
    ${vacuum_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration end of topic ===
    ${vacuum_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsConfiguration_start}    end=${vacuum_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cold2_LimitsConfiguration_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsConfiguration_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration start of topic ===
    ${vacuum_Cryo_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration end of topic ===
    ${vacuum_Cryo_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconConfiguration_start}    end=${vacuum_Cryo_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cryo_CryoconConfiguration_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconConfiguration_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration end of topic ===
    ${vacuum_Cryo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration start of topic ===
    ${vacuum_Cryo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_DevicesConfiguration_start}    end=${vacuum_Cryo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cryo_DevicesConfiguration_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_DevicesConfiguration_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    ${vacuum_Cryo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsConfiguration_start}    end=${vacuum_Cryo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    ${vacuum_IonPumps_CryoConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoConfiguration_start}    end=${vacuum_IonPumps_CryoConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_CryoConfiguration_list}
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_DevicesConfiguration_start}    end=${vacuum_IonPumps_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_DevicesConfiguration_list}
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration start of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsConfiguration_start}    end=${vacuum_IonPumps_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsConfiguration_list}
    Should Contain    ${vacuum_IonPumps_LimitsConfiguration_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsConfiguration_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_GeneralConfiguration_start}    end=${vacuum_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersConfiguration_start}    end=${vacuum_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_Rtds_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration start of topic ===
    ${vacuum_Rtds_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration end of topic ===
    ${vacuum_Rtds_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceConfiguration_start}    end=${vacuum_Rtds_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_DeviceConfiguration_list}
    Should Contain    ${vacuum_Rtds_DeviceConfiguration_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceConfiguration_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration end of topic ===
    ${vacuum_Rtds_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration start of topic ===
    ${vacuum_Rtds_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration end of topic ===
    ${vacuum_Rtds_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DevicesConfiguration_start}    end=${vacuum_Rtds_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_DevicesConfiguration_list}
    Should Contain    ${vacuum_Rtds_DevicesConfiguration_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_DevicesConfiguration_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration end of topic ===
    ${vacuum_Rtds_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration start of topic ===
    ${vacuum_Rtds_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration end of topic ===
    ${vacuum_Rtds_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsConfiguration_start}    end=${vacuum_Rtds_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_LimitsConfiguration_list}
    Should Contain    ${vacuum_Rtds_LimitsConfiguration_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsConfiguration_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration start of topic ===
    ${vacuum_Turbo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration end of topic ===
    ${vacuum_Turbo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_DevicesConfiguration_start}    end=${vacuum_Turbo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Turbo_DevicesConfiguration_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_DevicesConfiguration_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration end of topic ===
    ${vacuum_Turbo_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration start of topic ===
    ${vacuum_Turbo_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration end of topic ===
    ${vacuum_Turbo_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_GeneralConfiguration_start}    end=${vacuum_Turbo_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_GeneralConfiguration_list}
    Should Contain    ${vacuum_Turbo_GeneralConfiguration_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_GeneralConfiguration_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration end of topic ===
    ${vacuum_Turbo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration start of topic ===
    ${vacuum_Turbo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsConfiguration_start}    end=${vacuum_Turbo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Turbo_LimitsConfiguration_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsConfiguration_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_buildConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_buildConfiguration start of topic ===
    ${vacuum_Turbo_buildConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_buildConfiguration end of topic ===
    ${vacuum_Turbo_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_buildConfiguration_start}    end=${vacuum_Turbo_buildConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_buildConfiguration_list}
    Should Contain    ${vacuum_Turbo_buildConfiguration_list}    === CCCamera_vacuum_Turbo_buildConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_buildConfiguration_list}    === CCCamera_vacuum_Turbo_buildConfiguration end of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration start of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration end of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoConfiguration_start}    end=${vacuum_VQMonitor_CryoConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_CryoConfiguration_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoConfiguration_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration end of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration start of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration end of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_DevicesConfiguration_start}    end=${vacuum_VQMonitor_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_DevicesConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_DevicesConfiguration_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_DevicesConfiguration_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration end of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration start of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration end of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsConfiguration_start}    end=${vacuum_VQMonitor_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_LimitsConfiguration_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsConfiguration_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceConfiguration_start}    end=${vacuum_VacPluto_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DevicesConfiguration_start}    end=${vacuum_VacPluto_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DevicesConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacuumConfiguration start of topic ===
    ${vacuum_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacuumConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacuumConfiguration_start}    end=${vacuum_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_VacuumConfiguration_list}
    Should Contain    ${vacuum_VacuumConfiguration_list}    === CCCamera_vacuum_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_VacuumConfiguration_list}    === CCCamera_vacuum_VacuumConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    ${quadbox_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_DevicesConfiguration_start}    end=${quadbox_BFR_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_BFR_DevicesConfiguration_list}
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === CCCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === CCCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    ${quadbox_BFR_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsConfiguration_start}    end=${quadbox_BFR_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_BFR_LimitsConfiguration_list}
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === CCCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === CCCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    ${quadbox_BFR_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxConfiguration_start}    end=${quadbox_BFR_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_BFR_QuadboxConfiguration_list}
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_DevicesConfiguration_start}    end=${quadbox_PDU_24VC_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsConfiguration_start}    end=${quadbox_PDU_24VC_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxConfiguration_start}    end=${quadbox_PDU_24VC_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_DevicesConfiguration_start}    end=${quadbox_PDU_24VD_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsConfiguration_start}    end=${quadbox_PDU_24VD_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxConfiguration_start}    end=${quadbox_PDU_24VD_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_DevicesConfiguration_start}    end=${quadbox_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsConfiguration_start}    end=${quadbox_PDU_48V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxConfiguration_start}    end=${quadbox_PDU_48V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_DevicesConfiguration_start}    end=${quadbox_PDU_5V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsConfiguration_start}    end=${quadbox_PDU_5V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxConfiguration_start}    end=${quadbox_PDU_5V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_GeneralConfiguration_start}    end=${quadbox_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration start of topic ===
    ${focal_plane_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration end of topic ===
    ${focal_plane_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_GeneralConfiguration_start}    end=${focal_plane_Reb_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_GeneralConfiguration_list}
    Should Contain    ${focal_plane_Reb_GeneralConfiguration_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_GeneralConfiguration_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === CCCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === CCCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    ${focal_plane_Segment_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsConfiguration_start}    end=${focal_plane_Segment_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Segment_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_GeneralConfiguration_start}    end=${mpm_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_timersConfiguration_start}    end=${mpm_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    ${mpm_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DeviceConfiguration_start}    end=${mpm_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DeviceConfiguration_list}
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === CCCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === CCCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    ${mpm_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DevicesConfiguration_start}    end=${mpm_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DevicesConfiguration_list}
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === CCCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === CCCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_DeviceConfiguration_start}    end=${pathfinder_refrig_Cold1_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_DevicesConfiguration_start}    end=${pathfinder_refrig_Cold1_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_LimitsConfiguration_start}    end=${pathfinder_refrig_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_PicConfiguration_start}    end=${pathfinder_refrig_Cold1_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_DeviceConfiguration_start}    end=${pathfinder_refrig_Cold2_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_DevicesConfiguration_start}    end=${pathfinder_refrig_Cold2_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_LimitsConfiguration_start}    end=${pathfinder_refrig_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_PicConfiguration_start}    end=${pathfinder_refrig_Cold2_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration end of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration start of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_start}    end=${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CoolMaq20_DeviceConfiguration_start}    end=${pathfinder_refrig_CoolMaq20_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CoolMaq20_DevicesConfiguration_start}    end=${pathfinder_refrig_CoolMaq20_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo1_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo2_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_PicConfiguration_start}    end=${pathfinder_refrig_Cryo2_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo3_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_PicConfiguration_start}    end=${pathfinder_refrig_Cryo3_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo4_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo5_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo6_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_start}    end=${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_PicConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_timersConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration end of topic ===
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
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === CCCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === CCCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === CCCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === CCCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === CCCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === CCCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === CCCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === CCCamera_alertRaised end of topic ===
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
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
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
    ${fcs_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_GeneralConfiguration start of topic ===
    ${fcs_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_GeneralConfiguration end of topic ===
    ${fcs_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_GeneralConfiguration_start}    end=${fcs_GeneralConfiguration_end + 1}
    Log Many    ${fcs_GeneralConfiguration_list}
    Should Contain    ${fcs_GeneralConfiguration_list}    === CCCamera_fcs_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_GeneralConfiguration_list}    === CCCamera_fcs_GeneralConfiguration end of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration start of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration end of topic ===
    ${fcs_LinearEncoder_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_DevicesConfiguration_start}    end=${fcs_LinearEncoder_DevicesConfiguration_end + 1}
    Log Many    ${fcs_LinearEncoder_DevicesConfiguration_list}
    Should Contain    ${fcs_LinearEncoder_DevicesConfiguration_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_LinearEncoder_DevicesConfiguration_list}    === CCCamera_fcs_LinearEncoder_DevicesConfiguration end of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration start of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration end of topic ===
    ${fcs_LinearEncoder_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_GeneralConfiguration_start}    end=${fcs_LinearEncoder_GeneralConfiguration_end + 1}
    Log Many    ${fcs_LinearEncoder_GeneralConfiguration_list}
    Should Contain    ${fcs_LinearEncoder_GeneralConfiguration_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_LinearEncoder_GeneralConfiguration_list}    === CCCamera_fcs_LinearEncoder_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_GeneralConfiguration_start}    end=${fcs_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersConfiguration_start}    end=${fcs_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === CCCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration start of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration end of topic ===
    ${fcs_StepperMotor_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_DevicesConfiguration_start}    end=${fcs_StepperMotor_DevicesConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_DevicesConfiguration_list}
    Should Contain    ${fcs_StepperMotor_DevicesConfiguration_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_DevicesConfiguration_list}    === CCCamera_fcs_StepperMotor_DevicesConfiguration end of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration start of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration end of topic ===
    ${fcs_StepperMotor_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_GeneralConfiguration_start}    end=${fcs_StepperMotor_GeneralConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_GeneralConfiguration_list}
    Should Contain    ${fcs_StepperMotor_GeneralConfiguration_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_GeneralConfiguration_list}    === CCCamera_fcs_StepperMotor_GeneralConfiguration end of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration start of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration end of topic ===
    ${fcs_StepperMotor_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsConfiguration_start}    end=${fcs_StepperMotor_LimitsConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsConfiguration_list}
    Should Contain    ${fcs_StepperMotor_LimitsConfiguration_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsConfiguration_list}    === CCCamera_fcs_StepperMotor_LimitsConfiguration end of topic ===
    ${fcs_StepperMotor_MotorConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration start of topic ===
    ${fcs_StepperMotor_MotorConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration end of topic ===
    ${fcs_StepperMotor_MotorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorConfiguration_start}    end=${fcs_StepperMotor_MotorConfiguration_end + 1}
    Log Many    ${fcs_StepperMotor_MotorConfiguration_list}
    Should Contain    ${fcs_StepperMotor_MotorConfiguration_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorConfiguration_list}    === CCCamera_fcs_StepperMotor_MotorConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_DevicesConfiguration_start}    end=${bonn_shutter_Device_DevicesConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_DevicesConfiguration_list}
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_DevicesConfiguration_list}    === CCCamera_bonn_shutter_Device_DevicesConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralConfiguration_start}    end=${bonn_shutter_Device_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralConfiguration_list}    === CCCamera_bonn_shutter_Device_GeneralConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_Device_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsConfiguration_start}    end=${bonn_shutter_Device_LimitsConfiguration_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsConfiguration_list}
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsConfiguration_list}    === CCCamera_bonn_shutter_Device_LimitsConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralConfiguration start of topic ===
    ${bonn_shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralConfiguration_start}    end=${bonn_shutter_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === CCCamera_bonn_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_GeneralConfiguration_list}    === CCCamera_bonn_shutter_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_GeneralConfiguration_start}    end=${bonn_shutter_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_GeneralConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersConfiguration_start}    end=${bonn_shutter_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersConfiguration_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === CCCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === CCCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === CCCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === CCCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === CCCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === CCCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === CCCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === CCCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManager_GeneralConfiguration_start}    end=${rebpower_EmergencyResponseManager_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === CCCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_GeneralConfiguration start of topic ===
    ${rebpower_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_GeneralConfiguration_start}    end=${rebpower_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_GeneralConfiguration_list}
    Should Contain    ${rebpower_GeneralConfiguration_list}    === CCCamera_rebpower_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_GeneralConfiguration_list}    === CCCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_GeneralConfiguration_start}    end=${rebpower_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === CCCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_LimitsConfiguration_start}    end=${rebpower_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === CCCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    ${rebpower_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_GeneralConfiguration_start}    end=${rebpower_Reb_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Reb_GeneralConfiguration_list}
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === CCCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === CCCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === CCCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === CCCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    ${rebpower_Rebps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_DevicesConfiguration_start}    end=${rebpower_Rebps_DevicesConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_DevicesConfiguration_list}
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === CCCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    ${rebpower_Rebps_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_GeneralConfiguration_start}    end=${rebpower_Rebps_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_GeneralConfiguration_list}
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === CCCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    ${rebpower_Rebps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsConfiguration_start}    end=${rebpower_Rebps_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_LimitsConfiguration_list}
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === CCCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    ${rebpower_Rebps_PowerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerConfiguration_start}    end=${rebpower_Rebps_PowerConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_PowerConfiguration_list}
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === CCCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === CCCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_buildConfiguration start of topic ===
    ${rebpower_Rebps_buildConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_buildConfiguration_start}    end=${rebpower_Rebps_buildConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_buildConfiguration_list}
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === CCCamera_rebpower_Rebps_buildConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === CCCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${vacuum_Cold1_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration start of topic ===
    ${vacuum_Cold1_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration end of topic ===
    ${vacuum_Cold1_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconConfiguration_start}    end=${vacuum_Cold1_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cold1_CryoconConfiguration_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconConfiguration_list}    === CCCamera_vacuum_Cold1_CryoconConfiguration end of topic ===
    ${vacuum_Cold1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration start of topic ===
    ${vacuum_Cold1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration end of topic ===
    ${vacuum_Cold1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_DevicesConfiguration_start}    end=${vacuum_Cold1_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cold1_DevicesConfiguration_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_DevicesConfiguration_list}    === CCCamera_vacuum_Cold1_DevicesConfiguration end of topic ===
    ${vacuum_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration start of topic ===
    ${vacuum_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration end of topic ===
    ${vacuum_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsConfiguration_start}    end=${vacuum_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cold1_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cold1_LimitsConfiguration_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsConfiguration_list}    === CCCamera_vacuum_Cold1_LimitsConfiguration end of topic ===
    ${vacuum_Cold2_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration start of topic ===
    ${vacuum_Cold2_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration end of topic ===
    ${vacuum_Cold2_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconConfiguration_start}    end=${vacuum_Cold2_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cold2_CryoconConfiguration_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconConfiguration_list}    === CCCamera_vacuum_Cold2_CryoconConfiguration end of topic ===
    ${vacuum_Cold2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration start of topic ===
    ${vacuum_Cold2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration end of topic ===
    ${vacuum_Cold2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_DevicesConfiguration_start}    end=${vacuum_Cold2_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cold2_DevicesConfiguration_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_DevicesConfiguration_list}    === CCCamera_vacuum_Cold2_DevicesConfiguration end of topic ===
    ${vacuum_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration start of topic ===
    ${vacuum_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration end of topic ===
    ${vacuum_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsConfiguration_start}    end=${vacuum_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cold2_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cold2_LimitsConfiguration_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsConfiguration_list}    === CCCamera_vacuum_Cold2_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_CryoconConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration start of topic ===
    ${vacuum_Cryo_CryoconConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration end of topic ===
    ${vacuum_Cryo_CryoconConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconConfiguration_start}    end=${vacuum_Cryo_CryoconConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_CryoconConfiguration_list}
    Should Contain    ${vacuum_Cryo_CryoconConfiguration_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconConfiguration_list}    === CCCamera_vacuum_Cryo_CryoconConfiguration end of topic ===
    ${vacuum_Cryo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration start of topic ===
    ${vacuum_Cryo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_DevicesConfiguration_start}    end=${vacuum_Cryo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Cryo_DevicesConfiguration_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_DevicesConfiguration_list}    === CCCamera_vacuum_Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    ${vacuum_Cryo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsConfiguration_start}    end=${vacuum_Cryo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === CCCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    ${vacuum_IonPumps_CryoConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoConfiguration_start}    end=${vacuum_IonPumps_CryoConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_CryoConfiguration_list}
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === CCCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_DevicesConfiguration_start}    end=${vacuum_IonPumps_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_DevicesConfiguration_list}
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === CCCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration start of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsConfiguration_start}    end=${vacuum_IonPumps_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsConfiguration_list}
    Should Contain    ${vacuum_IonPumps_LimitsConfiguration_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsConfiguration_list}    === CCCamera_vacuum_IonPumps_LimitsConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_GeneralConfiguration_start}    end=${vacuum_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersConfiguration_start}    end=${vacuum_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === CCCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_Rtds_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration start of topic ===
    ${vacuum_Rtds_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration end of topic ===
    ${vacuum_Rtds_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceConfiguration_start}    end=${vacuum_Rtds_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_DeviceConfiguration_list}
    Should Contain    ${vacuum_Rtds_DeviceConfiguration_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceConfiguration_list}    === CCCamera_vacuum_Rtds_DeviceConfiguration end of topic ===
    ${vacuum_Rtds_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration start of topic ===
    ${vacuum_Rtds_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration end of topic ===
    ${vacuum_Rtds_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DevicesConfiguration_start}    end=${vacuum_Rtds_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_DevicesConfiguration_list}
    Should Contain    ${vacuum_Rtds_DevicesConfiguration_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_DevicesConfiguration_list}    === CCCamera_vacuum_Rtds_DevicesConfiguration end of topic ===
    ${vacuum_Rtds_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration start of topic ===
    ${vacuum_Rtds_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration end of topic ===
    ${vacuum_Rtds_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsConfiguration_start}    end=${vacuum_Rtds_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Rtds_LimitsConfiguration_list}
    Should Contain    ${vacuum_Rtds_LimitsConfiguration_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsConfiguration_list}    === CCCamera_vacuum_Rtds_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration start of topic ===
    ${vacuum_Turbo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration end of topic ===
    ${vacuum_Turbo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_DevicesConfiguration_start}    end=${vacuum_Turbo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Turbo_DevicesConfiguration_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_DevicesConfiguration_list}    === CCCamera_vacuum_Turbo_DevicesConfiguration end of topic ===
    ${vacuum_Turbo_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration start of topic ===
    ${vacuum_Turbo_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration end of topic ===
    ${vacuum_Turbo_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_GeneralConfiguration_start}    end=${vacuum_Turbo_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_GeneralConfiguration_list}
    Should Contain    ${vacuum_Turbo_GeneralConfiguration_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_GeneralConfiguration_list}    === CCCamera_vacuum_Turbo_GeneralConfiguration end of topic ===
    ${vacuum_Turbo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration start of topic ===
    ${vacuum_Turbo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsConfiguration_start}    end=${vacuum_Turbo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Turbo_LimitsConfiguration_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsConfiguration_list}    === CCCamera_vacuum_Turbo_LimitsConfiguration end of topic ===
    ${vacuum_Turbo_buildConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_buildConfiguration start of topic ===
    ${vacuum_Turbo_buildConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_buildConfiguration end of topic ===
    ${vacuum_Turbo_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_buildConfiguration_start}    end=${vacuum_Turbo_buildConfiguration_end + 1}
    Log Many    ${vacuum_Turbo_buildConfiguration_list}
    Should Contain    ${vacuum_Turbo_buildConfiguration_list}    === CCCamera_vacuum_Turbo_buildConfiguration start of topic ===
    Should Contain    ${vacuum_Turbo_buildConfiguration_list}    === CCCamera_vacuum_Turbo_buildConfiguration end of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration start of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration end of topic ===
    ${vacuum_VQMonitor_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoConfiguration_start}    end=${vacuum_VQMonitor_CryoConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_CryoConfiguration_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoConfiguration_list}    === CCCamera_vacuum_VQMonitor_CryoConfiguration end of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration start of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration end of topic ===
    ${vacuum_VQMonitor_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_DevicesConfiguration_start}    end=${vacuum_VQMonitor_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_DevicesConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_DevicesConfiguration_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_DevicesConfiguration_list}    === CCCamera_vacuum_VQMonitor_DevicesConfiguration end of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration start of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration end of topic ===
    ${vacuum_VQMonitor_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsConfiguration_start}    end=${vacuum_VQMonitor_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsConfiguration_list}
    Should Contain    ${vacuum_VQMonitor_LimitsConfiguration_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsConfiguration_list}    === CCCamera_vacuum_VQMonitor_LimitsConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceConfiguration_start}    end=${vacuum_VacPluto_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === CCCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DevicesConfiguration_start}    end=${vacuum_VacPluto_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DevicesConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === CCCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacuumConfiguration start of topic ===
    ${vacuum_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacuumConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacuumConfiguration_start}    end=${vacuum_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_VacuumConfiguration_list}
    Should Contain    ${vacuum_VacuumConfiguration_list}    === CCCamera_vacuum_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_VacuumConfiguration_list}    === CCCamera_vacuum_VacuumConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    ${quadbox_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_DevicesConfiguration_start}    end=${quadbox_BFR_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_BFR_DevicesConfiguration_list}
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === CCCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === CCCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    ${quadbox_BFR_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsConfiguration_start}    end=${quadbox_BFR_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_BFR_LimitsConfiguration_list}
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === CCCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === CCCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    ${quadbox_BFR_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxConfiguration_start}    end=${quadbox_BFR_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_BFR_QuadboxConfiguration_list}
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === CCCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_DevicesConfiguration_start}    end=${quadbox_PDU_24VC_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsConfiguration_start}    end=${quadbox_PDU_24VC_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxConfiguration_start}    end=${quadbox_PDU_24VC_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_DevicesConfiguration_start}    end=${quadbox_PDU_24VD_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsConfiguration_start}    end=${quadbox_PDU_24VD_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxConfiguration_start}    end=${quadbox_PDU_24VD_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_DevicesConfiguration_start}    end=${quadbox_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsConfiguration_start}    end=${quadbox_PDU_48V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxConfiguration_start}    end=${quadbox_PDU_48V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_DevicesConfiguration_start}    end=${quadbox_PDU_5V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === CCCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsConfiguration_start}    end=${quadbox_PDU_5V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === CCCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxConfiguration_start}    end=${quadbox_PDU_5V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === CCCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_GeneralConfiguration_start}    end=${quadbox_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === CCCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === CCCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === CCCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === CCCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === CCCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === CCCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === CCCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration start of topic ===
    ${focal_plane_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration end of topic ===
    ${focal_plane_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_GeneralConfiguration_start}    end=${focal_plane_Reb_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_GeneralConfiguration_list}
    Should Contain    ${focal_plane_Reb_GeneralConfiguration_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_GeneralConfiguration_list}    === CCCamera_focal_plane_Reb_GeneralConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === CCCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === CCCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === CCCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === CCCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === CCCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === CCCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    ${focal_plane_Segment_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsConfiguration_start}    end=${focal_plane_Segment_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Segment_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === CCCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === CCCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === CCCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === CCCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === CCCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === CCCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === CCCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === CCCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === CCCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_GeneralConfiguration_start}    end=${mpm_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_timersConfiguration_start}    end=${mpm_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === CCCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    ${mpm_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DeviceConfiguration_start}    end=${mpm_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DeviceConfiguration_list}
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === CCCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === CCCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    ${mpm_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DevicesConfiguration_start}    end=${mpm_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DevicesConfiguration_list}
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === CCCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === CCCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_DeviceConfiguration_start}    end=${pathfinder_refrig_Cold1_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_DevicesConfiguration_start}    end=${pathfinder_refrig_Cold1_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_LimitsConfiguration_start}    end=${pathfinder_refrig_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold1_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold1_PicConfiguration_start}    end=${pathfinder_refrig_Cold1_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold1_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold1_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold1_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold1_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_DeviceConfiguration_start}    end=${pathfinder_refrig_Cold2_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_DevicesConfiguration_start}    end=${pathfinder_refrig_Cold2_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_LimitsConfiguration_start}    end=${pathfinder_refrig_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cold2_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cold2_PicConfiguration_start}    end=${pathfinder_refrig_Cold2_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cold2_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cold2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cold2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cold2_PicConfiguration end of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration start of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_start}    end=${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CoolMaq20_DeviceConfiguration_start}    end=${pathfinder_refrig_CoolMaq20_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CoolMaq20_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CoolMaq20_DevicesConfiguration_start}    end=${pathfinder_refrig_CoolMaq20_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CoolMaq20_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_CoolMaq20_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo1_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo1_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo1_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo2_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo2_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo2_PicConfiguration_start}    end=${pathfinder_refrig_Cryo2_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo2_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo2_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo2_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo3_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration start of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo3_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo3_PicConfiguration_start}    end=${pathfinder_refrig_Cryo3_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo3_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo3_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo3_PicConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo3_PicConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo4_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo4_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo4_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo5_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo5_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo5_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_DeviceConfiguration_start}    end=${pathfinder_refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_DeviceConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_DevicesConfiguration_start}    end=${pathfinder_refrig_Cryo6_DevicesConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_DevicesConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_Cryo6_LimitsConfiguration_start}    end=${pathfinder_refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_Cryo6_LimitsConfiguration_list}    === CCCamera_pathfinder_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_start}    end=${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration_list}    === CCCamera_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_GeneralConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_PicConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_PicConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_PicConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${pathfinder_refrig_PeriodicTasks_timersConfiguration_start}    end=${pathfinder_refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${pathfinder_refrig_PeriodicTasks_timersConfiguration_list}    === CCCamera_pathfinder_refrig_PeriodicTasks_timersConfiguration end of topic ===
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
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === CCCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === CCCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === CCCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === CCCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === CCCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === CCCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === CCCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === CCCamera_alertRaised end of topic ===
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
