*** Settings ***
Documentation    MTCamera_Events communications tests.
Force Tags    messaging    java    mtcamera    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
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
        Exit For Loop If     'MTCamera all loggers ready' in $loggerOutput
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
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === MTCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === MTCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === MTCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === MTCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === MTCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === MTCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter end of topic ===
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose end of topic ===
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel end of topic ===
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter end of topic ===
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured end of topic ===
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === MTCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === MTCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration end of topic ===
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage end of topic ===
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState end of topic ===
    ${availableFilters_start}=    Get Index From List    ${full_list}    === MTCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === MTCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === MTCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === MTCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === MTCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === MTCamera_startReadout end of topic ===
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${quadbox_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    ${quadbox_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_DevicesConfiguration_start}    end=${quadbox_BFR_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_BFR_DevicesConfiguration_list}
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === MTCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === MTCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    ${quadbox_BFR_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsConfiguration_start}    end=${quadbox_BFR_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_BFR_LimitsConfiguration_list}
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === MTCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === MTCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    ${quadbox_BFR_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxConfiguration_start}    end=${quadbox_BFR_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_BFR_QuadboxConfiguration_list}
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration start of topic ===
    ${quadbox_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration end of topic ===
    ${quadbox_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_Maq20_DeviceConfiguration_start}    end=${quadbox_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${quadbox_Maq20_DeviceConfiguration_list}
    Should Contain    ${quadbox_Maq20_DeviceConfiguration_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${quadbox_Maq20_DeviceConfiguration_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration end of topic ===
    ${quadbox_Maq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration start of topic ===
    ${quadbox_Maq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration end of topic ===
    ${quadbox_Maq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_Maq20_DevicesConfiguration_start}    end=${quadbox_Maq20_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_Maq20_DevicesConfiguration_list}
    Should Contain    ${quadbox_Maq20_DevicesConfiguration_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_Maq20_DevicesConfiguration_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_DevicesConfiguration_start}    end=${quadbox_PDU_24VC_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsConfiguration_start}    end=${quadbox_PDU_24VC_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxConfiguration_start}    end=${quadbox_PDU_24VC_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_DevicesConfiguration_start}    end=${quadbox_PDU_24VD_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsConfiguration_start}    end=${quadbox_PDU_24VD_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxConfiguration_start}    end=${quadbox_PDU_24VD_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_DevicesConfiguration_start}    end=${quadbox_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsConfiguration_start}    end=${quadbox_PDU_48V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxConfiguration_start}    end=${quadbox_PDU_48V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_DevicesConfiguration_start}    end=${quadbox_PDU_5V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsConfiguration_start}    end=${quadbox_PDU_5V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxConfiguration_start}    end=${quadbox_PDU_5V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_GeneralConfiguration_start}    end=${quadbox_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_DevicesConfiguration_start}    end=${quadbox_REB_Bulk_PS_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_LimitsConfiguration_start}    end=${quadbox_REB_Bulk_PS_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxConfiguration_start}    end=${quadbox_REB_Bulk_PS_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManager_GeneralConfiguration_start}    end=${rebpower_EmergencyResponseManager_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_GeneralConfiguration start of topic ===
    ${rebpower_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_GeneralConfiguration_start}    end=${rebpower_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_GeneralConfiguration_list}
    Should Contain    ${rebpower_GeneralConfiguration_list}    === MTCamera_rebpower_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_GeneralConfiguration_list}    === MTCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_GeneralConfiguration_start}    end=${rebpower_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_Power_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Power_timersConfiguration start of topic ===
    ${rebpower_Power_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Power_timersConfiguration end of topic ===
    ${rebpower_Power_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Power_timersConfiguration_start}    end=${rebpower_Power_timersConfiguration_end + 1}
    Log Many    ${rebpower_Power_timersConfiguration_list}
    Should Contain    ${rebpower_Power_timersConfiguration_list}    === MTCamera_rebpower_Power_timersConfiguration start of topic ===
    Should Contain    ${rebpower_Power_timersConfiguration_list}    === MTCamera_rebpower_Power_timersConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_LimitsConfiguration_start}    end=${rebpower_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    ${rebpower_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_GeneralConfiguration_start}    end=${rebpower_Reb_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Reb_GeneralConfiguration_list}
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === MTCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === MTCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    ${rebpower_Rebps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_DevicesConfiguration_start}    end=${rebpower_Rebps_DevicesConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_DevicesConfiguration_list}
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    ${rebpower_Rebps_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_GeneralConfiguration_start}    end=${rebpower_Rebps_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_GeneralConfiguration_list}
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    ${rebpower_Rebps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsConfiguration_start}    end=${rebpower_Rebps_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_LimitsConfiguration_list}
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    ${rebpower_Rebps_PowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerConfiguration_start}    end=${rebpower_Rebps_PowerConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_PowerConfiguration_list}
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === MTCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === MTCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_buildConfiguration start of topic ===
    ${rebpower_Rebps_buildConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_buildConfiguration_start}    end=${rebpower_Rebps_buildConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_buildConfiguration_list}
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === MTCamera_rebpower_Rebps_buildConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === MTCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${hex_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsConfiguration start of topic ===
    ${hex_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsConfiguration end of topic ===
    ${hex_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_LimitsConfiguration_start}    end=${hex_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cold1_LimitsConfiguration_list}
    Should Contain    ${hex_Cold1_LimitsConfiguration_list}    === MTCamera_hex_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cold1_LimitsConfiguration_list}    === MTCamera_hex_Cold1_LimitsConfiguration end of topic ===
    ${hex_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsConfiguration start of topic ===
    ${hex_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsConfiguration end of topic ===
    ${hex_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_LimitsConfiguration_start}    end=${hex_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cold2_LimitsConfiguration_list}
    Should Contain    ${hex_Cold2_LimitsConfiguration_list}    === MTCamera_hex_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cold2_LimitsConfiguration_list}    === MTCamera_hex_Cold2_LimitsConfiguration end of topic ===
    ${hex_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsConfiguration start of topic ===
    ${hex_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsConfiguration end of topic ===
    ${hex_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_LimitsConfiguration_start}    end=${hex_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo1_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo1_LimitsConfiguration_list}    === MTCamera_hex_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo1_LimitsConfiguration_list}    === MTCamera_hex_Cryo1_LimitsConfiguration end of topic ===
    ${hex_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsConfiguration start of topic ===
    ${hex_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsConfiguration end of topic ===
    ${hex_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_LimitsConfiguration_start}    end=${hex_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo2_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo2_LimitsConfiguration_list}    === MTCamera_hex_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo2_LimitsConfiguration_list}    === MTCamera_hex_Cryo2_LimitsConfiguration end of topic ===
    ${hex_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsConfiguration start of topic ===
    ${hex_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsConfiguration end of topic ===
    ${hex_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_LimitsConfiguration_start}    end=${hex_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo3_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo3_LimitsConfiguration_list}    === MTCamera_hex_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo3_LimitsConfiguration_list}    === MTCamera_hex_Cryo3_LimitsConfiguration end of topic ===
    ${hex_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsConfiguration start of topic ===
    ${hex_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsConfiguration end of topic ===
    ${hex_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_LimitsConfiguration_start}    end=${hex_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo4_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo4_LimitsConfiguration_list}    === MTCamera_hex_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo4_LimitsConfiguration_list}    === MTCamera_hex_Cryo4_LimitsConfiguration end of topic ===
    ${hex_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsConfiguration start of topic ===
    ${hex_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsConfiguration end of topic ===
    ${hex_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_LimitsConfiguration_start}    end=${hex_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo5_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo5_LimitsConfiguration_list}    === MTCamera_hex_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo5_LimitsConfiguration_list}    === MTCamera_hex_Cryo5_LimitsConfiguration end of topic ===
    ${hex_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsConfiguration start of topic ===
    ${hex_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsConfiguration end of topic ===
    ${hex_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_LimitsConfiguration_start}    end=${hex_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo6_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo6_LimitsConfiguration_list}    === MTCamera_hex_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo6_LimitsConfiguration_list}    === MTCamera_hex_Cryo6_LimitsConfiguration end of topic ===
    ${hex_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_GeneralConfiguration start of topic ===
    ${hex_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_GeneralConfiguration end of topic ===
    ${hex_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_GeneralConfiguration_start}    end=${hex_GeneralConfiguration_end + 1}
    Log Many    ${hex_GeneralConfiguration_list}
    Should Contain    ${hex_GeneralConfiguration_list}    === MTCamera_hex_GeneralConfiguration start of topic ===
    Should Contain    ${hex_GeneralConfiguration_list}    === MTCamera_hex_GeneralConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    ${hex_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceConfiguration_start}    end=${hex_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DevicesConfiguration start of topic ===
    ${hex_Maq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DevicesConfiguration end of topic ===
    ${hex_Maq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DevicesConfiguration_start}    end=${hex_Maq20_DevicesConfiguration_end + 1}
    Log Many    ${hex_Maq20_DevicesConfiguration_list}
    Should Contain    ${hex_Maq20_DevicesConfiguration_list}    === MTCamera_hex_Maq20_DevicesConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DevicesConfiguration_list}    === MTCamera_hex_Maq20_DevicesConfiguration end of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration start of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration end of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_GeneralConfiguration_start}    end=${hex_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    ${hex_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersConfiguration_start}    end=${hex_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration start of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration end of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_StatusAggregator_GeneralConfiguration_start}    end=${hex_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${hex_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${hex_StatusAggregator_GeneralConfiguration_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${hex_StatusAggregator_GeneralConfiguration_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceConfiguration_start}    end=${refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration start of topic ===
    ${refrig_Cryo1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${refrig_Cryo1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DevicesConfiguration_start}    end=${refrig_Cryo1_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo1_DevicesConfiguration_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DevicesConfiguration_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsConfiguration_start}    end=${refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceConfiguration_start}    end=${refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration start of topic ===
    ${refrig_Cryo2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${refrig_Cryo2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DevicesConfiguration_start}    end=${refrig_Cryo2_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo2_DevicesConfiguration_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DevicesConfiguration_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsConfiguration_start}    end=${refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceConfiguration_start}    end=${refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration start of topic ===
    ${refrig_Cryo3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${refrig_Cryo3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DevicesConfiguration_start}    end=${refrig_Cryo3_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo3_DevicesConfiguration_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DevicesConfiguration_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsConfiguration_start}    end=${refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_PicConfiguration start of topic ===
    ${refrig_Cryo3_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_PicConfiguration end of topic ===
    ${refrig_Cryo3_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_PicConfiguration_start}    end=${refrig_Cryo3_PicConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_PicConfiguration_list}
    Should Contain    ${refrig_Cryo3_PicConfiguration_list}    === MTCamera_refrig_Cryo3_PicConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_PicConfiguration_list}    === MTCamera_refrig_Cryo3_PicConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceConfiguration_start}    end=${refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration start of topic ===
    ${refrig_Cryo4_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${refrig_Cryo4_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DevicesConfiguration_start}    end=${refrig_Cryo4_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo4_DevicesConfiguration_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DevicesConfiguration_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsConfiguration_start}    end=${refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceConfiguration_start}    end=${refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration start of topic ===
    ${refrig_Cryo5_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${refrig_Cryo5_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DevicesConfiguration_start}    end=${refrig_Cryo5_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo5_DevicesConfiguration_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DevicesConfiguration_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsConfiguration_start}    end=${refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_PicConfiguration start of topic ===
    ${refrig_Cryo5_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_PicConfiguration end of topic ===
    ${refrig_Cryo5_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_PicConfiguration_start}    end=${refrig_Cryo5_PicConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_PicConfiguration_list}
    Should Contain    ${refrig_Cryo5_PicConfiguration_list}    === MTCamera_refrig_Cryo5_PicConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_PicConfiguration_list}    === MTCamera_refrig_Cryo5_PicConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceConfiguration_start}    end=${refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration start of topic ===
    ${refrig_Cryo6_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${refrig_Cryo6_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DevicesConfiguration_start}    end=${refrig_Cryo6_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo6_DevicesConfiguration_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DevicesConfiguration_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsConfiguration_start}    end=${refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_CryoCompLimits_CompLimitsConfiguration_start}    end=${refrig_CryoCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_GeneralConfiguration_start}    end=${refrig_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration start of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_PicConfiguration_start}    end=${refrig_PeriodicTasks_PicConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_PicConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_PicConfiguration_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_PicConfiguration_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersConfiguration_start}    end=${refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_Cip_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip_LimitsConfiguration start of topic ===
    ${vacuum_Cip_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip_LimitsConfiguration end of topic ===
    ${vacuum_Cip_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cip_LimitsConfiguration_start}    end=${vacuum_Cip_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cip_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cip_LimitsConfiguration_list}    === MTCamera_vacuum_Cip_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cip_LimitsConfiguration_list}    === MTCamera_vacuum_Cip_LimitsConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoFlineGauge_CryoConfiguration_start}    end=${vacuum_CryoFlineGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoFlineGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoFlineGauge_DevicesConfiguration_start}    end=${vacuum_CryoFlineGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboGauge_CryoConfiguration_start}    end=${vacuum_CryoTurboGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboGauge_DevicesConfiguration_start}    end=${vacuum_CryoTurboGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration start of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboPump_DevicesConfiguration_start}    end=${vacuum_CryoTurboPump_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboPump_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration start of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboPump_GeneralConfiguration_start}    end=${vacuum_CryoTurboPump_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboPump_GeneralConfiguration_list}
    Should Contain    ${vacuum_CryoTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGauge_CryoConfiguration_start}    end=${vacuum_CryoVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGauge_DevicesConfiguration_start}    end=${vacuum_CryoVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    ${vacuum_Cryo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsConfiguration_start}    end=${vacuum_Cryo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_HX_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX_LimitsConfiguration start of topic ===
    ${vacuum_HX_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX_LimitsConfiguration end of topic ===
    ${vacuum_HX_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HX_LimitsConfiguration_start}    end=${vacuum_HX_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_HX_LimitsConfiguration_list}
    Should Contain    ${vacuum_HX_LimitsConfiguration_list}    === MTCamera_vacuum_HX_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_HX_LimitsConfiguration_list}    === MTCamera_vacuum_HX_LimitsConfiguration end of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration start of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexFlineGauge_CryoConfiguration_start}    end=${vacuum_HexFlineGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexFlineGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexFlineGauge_DevicesConfiguration_start}    end=${vacuum_HexFlineGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexFlineGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration start of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboGauge_CryoConfiguration_start}    end=${vacuum_HexTurboGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboGauge_DevicesConfiguration_start}    end=${vacuum_HexTurboGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration start of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboPump_DevicesConfiguration_start}    end=${vacuum_HexTurboPump_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboPump_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration start of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboPump_GeneralConfiguration_start}    end=${vacuum_HexTurboPump_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboPump_GeneralConfiguration_list}
    Should Contain    ${vacuum_HexTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration start of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration end of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexVacGauge_CryoConfiguration_start}    end=${vacuum_HexVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration end of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexVacGauge_DevicesConfiguration_start}    end=${vacuum_HexVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Hip_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip_LimitsConfiguration start of topic ===
    ${vacuum_Hip_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip_LimitsConfiguration end of topic ===
    ${vacuum_Hip_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hip_LimitsConfiguration_start}    end=${vacuum_Hip_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Hip_LimitsConfiguration_list}
    Should Contain    ${vacuum_Hip_LimitsConfiguration_list}    === MTCamera_vacuum_Hip_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Hip_LimitsConfiguration_list}    === MTCamera_vacuum_Hip_LimitsConfiguration end of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration start of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration end of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_InstVacGauge_CryoConfiguration_start}    end=${vacuum_InstVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_InstVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_InstVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_InstVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration end of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_InstVacGauge_DevicesConfiguration_start}    end=${vacuum_InstVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_InstVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_InstVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_InstVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Inst_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst_LimitsConfiguration start of topic ===
    ${vacuum_Inst_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst_LimitsConfiguration end of topic ===
    ${vacuum_Inst_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Inst_LimitsConfiguration_start}    end=${vacuum_Inst_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Inst_LimitsConfiguration_list}
    Should Contain    ${vacuum_Inst_LimitsConfiguration_list}    === MTCamera_vacuum_Inst_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Inst_LimitsConfiguration_list}    === MTCamera_vacuum_Inst_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    ${vacuum_IonPumps_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoConfiguration_start}    end=${vacuum_IonPumps_CryoConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_CryoConfiguration_list}
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_DevicesConfiguration_start}    end=${vacuum_IonPumps_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_DevicesConfiguration_list}
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration start of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Cryo_DeviceConfiguration_start}    end=${vacuum_Maq20Cryo_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Cryo_DeviceConfiguration_list}
    Should Contain    ${vacuum_Maq20Cryo_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Cryo_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration start of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Cryo_DevicesConfiguration_start}    end=${vacuum_Maq20Cryo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Cryo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Maq20Cryo_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Cryo_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration start of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Ut_DeviceConfiguration_start}    end=${vacuum_Maq20Ut_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Ut_DeviceConfiguration_list}
    Should Contain    ${vacuum_Maq20Ut_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Ut_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration start of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Ut_DevicesConfiguration_start}    end=${vacuum_Maq20Ut_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Ut_DevicesConfiguration_list}
    Should Contain    ${vacuum_Maq20Ut_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Ut_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration end of topic ===
    ${vacuum_PDU_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_DevicesConfiguration start of topic ===
    ${vacuum_PDU_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_DevicesConfiguration end of topic ===
    ${vacuum_PDU_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PDU_DevicesConfiguration_start}    end=${vacuum_PDU_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_PDU_DevicesConfiguration_list}
    Should Contain    ${vacuum_PDU_DevicesConfiguration_list}    === MTCamera_vacuum_PDU_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_PDU_DevicesConfiguration_list}    === MTCamera_vacuum_PDU_DevicesConfiguration end of topic ===
    ${vacuum_PDU_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_VacuumConfiguration start of topic ===
    ${vacuum_PDU_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_VacuumConfiguration end of topic ===
    ${vacuum_PDU_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PDU_VacuumConfiguration_start}    end=${vacuum_PDU_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_PDU_VacuumConfiguration_list}
    Should Contain    ${vacuum_PDU_VacuumConfiguration_list}    === MTCamera_vacuum_PDU_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_PDU_VacuumConfiguration_list}    === MTCamera_vacuum_PDU_VacuumConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_GeneralConfiguration_start}    end=${vacuum_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersConfiguration_start}    end=${vacuum_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PumpCart_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration start of topic ===
    ${vacuum_PumpCart_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration end of topic ===
    ${vacuum_PumpCart_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PumpCart_CryoConfiguration_start}    end=${vacuum_PumpCart_CryoConfiguration_end + 1}
    Log Many    ${vacuum_PumpCart_CryoConfiguration_list}
    Should Contain    ${vacuum_PumpCart_CryoConfiguration_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_PumpCart_CryoConfiguration_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration end of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration start of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration end of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PumpCart_DevicesConfiguration_start}    end=${vacuum_PumpCart_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_PumpCart_DevicesConfiguration_list}
    Should Contain    ${vacuum_PumpCart_DevicesConfiguration_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_PumpCart_DevicesConfiguration_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceConfiguration_start}    end=${vacuum_VacPluto_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DevicesConfiguration_start}    end=${vacuum_VacPluto_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DevicesConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacuumConfiguration start of topic ===
    ${vacuum_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacuumConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacuumConfiguration_start}    end=${vacuum_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_VacuumConfiguration_list}
    Should Contain    ${vacuum_VacuumConfiguration_list}    === MTCamera_vacuum_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_VacuumConfiguration_list}    === MTCamera_vacuum_VacuumConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === MTCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === MTCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === MTCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === MTCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    ${focal_plane_Segment_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsConfiguration_start}    end=${focal_plane_Segment_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Segment_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_03_LimitsConfiguration_start}    end=${mpm_CLP_RTD_03_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_03_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_03_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_03_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_05_LimitsConfiguration_start}    end=${mpm_CLP_RTD_05_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_05_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_05_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_05_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_50_LimitsConfiguration_start}    end=${mpm_CLP_RTD_50_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_50_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_50_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_50_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_55_LimitsConfiguration_start}    end=${mpm_CLP_RTD_55_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_55_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_55_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_55_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_12_LimitsConfiguration_start}    end=${mpm_CYP_RTD_12_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_12_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_12_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_12_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_14_LimitsConfiguration_start}    end=${mpm_CYP_RTD_14_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_14_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_14_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_14_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_31_LimitsConfiguration_start}    end=${mpm_CYP_RTD_31_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_31_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_31_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_31_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_43_LimitsConfiguration_start}    end=${mpm_CYP_RTD_43_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_43_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_43_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_43_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_GeneralConfiguration_start}    end=${mpm_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_timersConfiguration_start}    end=${mpm_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    ${mpm_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DeviceConfiguration_start}    end=${mpm_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DeviceConfiguration_list}
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === MTCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === MTCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    ${mpm_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DevicesConfiguration_start}    end=${mpm_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DevicesConfiguration_list}
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === MTCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === MTCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${fcs_Autochanger_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration start of topic ===
    ${fcs_Autochanger_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration end of topic ===
    ${fcs_Autochanger_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_LimitsConfiguration_start}    end=${fcs_Autochanger_LimitsConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_LimitsConfiguration_list}
    Should Contain    ${fcs_Autochanger_LimitsConfiguration_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_LimitsConfiguration_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration end of topic ===
    ${fcs_Autochanger_autochangerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration start of topic ===
    ${fcs_Autochanger_autochangerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration end of topic ===
    ${fcs_Autochanger_autochangerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_autochangerConfiguration_start}    end=${fcs_Autochanger_autochangerConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_autochangerConfiguration_list}
    Should Contain    ${fcs_Autochanger_autochangerConfiguration_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_autochangerConfiguration_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration end of topic ===
    ${fcs_Autochanger_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_readRateConfiguration start of topic ===
    ${fcs_Autochanger_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_readRateConfiguration end of topic ===
    ${fcs_Autochanger_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_readRateConfiguration_start}    end=${fcs_Autochanger_readRateConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_readRateConfiguration_list}
    Should Contain    ${fcs_Autochanger_readRateConfiguration_list}    === MTCamera_fcs_Autochanger_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_readRateConfiguration_list}    === MTCamera_fcs_Autochanger_readRateConfiguration end of topic ===
    ${fcs_Autochanger_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_sensorConfiguration start of topic ===
    ${fcs_Autochanger_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_sensorConfiguration end of topic ===
    ${fcs_Autochanger_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_sensorConfiguration_start}    end=${fcs_Autochanger_sensorConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_sensorConfiguration_list}
    Should Contain    ${fcs_Autochanger_sensorConfiguration_list}    === MTCamera_fcs_Autochanger_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_sensorConfiguration_list}    === MTCamera_fcs_Autochanger_sensorConfiguration end of topic ===
    ${fcs_Canbus0_canbusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_canbusConfiguration start of topic ===
    ${fcs_Canbus0_canbusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_canbusConfiguration end of topic ===
    ${fcs_Canbus0_canbusConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_canbusConfiguration_start}    end=${fcs_Canbus0_canbusConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_canbusConfiguration_list}
    Should Contain    ${fcs_Canbus0_canbusConfiguration_list}    === MTCamera_fcs_Canbus0_canbusConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_canbusConfiguration_list}    === MTCamera_fcs_Canbus0_canbusConfiguration end of topic ===
    ${fcs_Canbus0_controllerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_controllerConfiguration start of topic ===
    ${fcs_Canbus0_controllerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_controllerConfiguration end of topic ===
    ${fcs_Canbus0_controllerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_controllerConfiguration_start}    end=${fcs_Canbus0_controllerConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_controllerConfiguration_list}
    Should Contain    ${fcs_Canbus0_controllerConfiguration_list}    === MTCamera_fcs_Canbus0_controllerConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_controllerConfiguration_list}    === MTCamera_fcs_Canbus0_controllerConfiguration end of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration start of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration end of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_nodeIDConfiguration_start}    end=${fcs_Canbus0_nodeIDConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_nodeIDConfiguration_list}
    Should Contain    ${fcs_Canbus0_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration end of topic ===
    ${fcs_Canbus0_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_sensorConfiguration start of topic ===
    ${fcs_Canbus0_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_sensorConfiguration end of topic ===
    ${fcs_Canbus0_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_sensorConfiguration_start}    end=${fcs_Canbus0_sensorConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_sensorConfiguration_list}
    Should Contain    ${fcs_Canbus0_sensorConfiguration_list}    === MTCamera_fcs_Canbus0_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_sensorConfiguration_list}    === MTCamera_fcs_Canbus0_sensorConfiguration end of topic ===
    ${fcs_Canbus0_serialNBConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration start of topic ===
    ${fcs_Canbus0_serialNBConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration end of topic ===
    ${fcs_Canbus0_serialNBConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_serialNBConfiguration_start}    end=${fcs_Canbus0_serialNBConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_serialNBConfiguration_list}
    Should Contain    ${fcs_Canbus0_serialNBConfiguration_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_serialNBConfiguration_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration end of topic ===
    ${fcs_Canbus1_canbusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_canbusConfiguration start of topic ===
    ${fcs_Canbus1_canbusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_canbusConfiguration end of topic ===
    ${fcs_Canbus1_canbusConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_canbusConfiguration_start}    end=${fcs_Canbus1_canbusConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_canbusConfiguration_list}
    Should Contain    ${fcs_Canbus1_canbusConfiguration_list}    === MTCamera_fcs_Canbus1_canbusConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_canbusConfiguration_list}    === MTCamera_fcs_Canbus1_canbusConfiguration end of topic ===
    ${fcs_Canbus1_controllerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_controllerConfiguration start of topic ===
    ${fcs_Canbus1_controllerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_controllerConfiguration end of topic ===
    ${fcs_Canbus1_controllerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_controllerConfiguration_start}    end=${fcs_Canbus1_controllerConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_controllerConfiguration_list}
    Should Contain    ${fcs_Canbus1_controllerConfiguration_list}    === MTCamera_fcs_Canbus1_controllerConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_controllerConfiguration_list}    === MTCamera_fcs_Canbus1_controllerConfiguration end of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration start of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration end of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_nodeIDConfiguration_start}    end=${fcs_Canbus1_nodeIDConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_nodeIDConfiguration_list}
    Should Contain    ${fcs_Canbus1_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration end of topic ===
    ${fcs_Canbus1_serialNBConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration start of topic ===
    ${fcs_Canbus1_serialNBConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration end of topic ===
    ${fcs_Canbus1_serialNBConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_serialNBConfiguration_start}    end=${fcs_Canbus1_serialNBConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_serialNBConfiguration_list}
    Should Contain    ${fcs_Canbus1_serialNBConfiguration_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_serialNBConfiguration_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration end of topic ===
    ${fcs_Carousel_carouselConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_carouselConfiguration start of topic ===
    ${fcs_Carousel_carouselConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_carouselConfiguration end of topic ===
    ${fcs_Carousel_carouselConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_carouselConfiguration_start}    end=${fcs_Carousel_carouselConfiguration_end + 1}
    Log Many    ${fcs_Carousel_carouselConfiguration_list}
    Should Contain    ${fcs_Carousel_carouselConfiguration_list}    === MTCamera_fcs_Carousel_carouselConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_carouselConfiguration_list}    === MTCamera_fcs_Carousel_carouselConfiguration end of topic ===
    ${fcs_Carousel_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_readRateConfiguration start of topic ===
    ${fcs_Carousel_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_readRateConfiguration end of topic ===
    ${fcs_Carousel_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_readRateConfiguration_start}    end=${fcs_Carousel_readRateConfiguration_end + 1}
    Log Many    ${fcs_Carousel_readRateConfiguration_list}
    Should Contain    ${fcs_Carousel_readRateConfiguration_list}    === MTCamera_fcs_Carousel_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_readRateConfiguration_list}    === MTCamera_fcs_Carousel_readRateConfiguration end of topic ===
    ${fcs_Carousel_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_sensorConfiguration start of topic ===
    ${fcs_Carousel_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_sensorConfiguration end of topic ===
    ${fcs_Carousel_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_sensorConfiguration_start}    end=${fcs_Carousel_sensorConfiguration_end + 1}
    Log Many    ${fcs_Carousel_sensorConfiguration_list}
    Should Contain    ${fcs_Carousel_sensorConfiguration_list}    === MTCamera_fcs_Carousel_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_sensorConfiguration_list}    === MTCamera_fcs_Carousel_sensorConfiguration end of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration start of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration end of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_FilterIdentificator_sensorConfiguration_start}    end=${fcs_FilterIdentificator_sensorConfiguration_end + 1}
    Log Many    ${fcs_FilterIdentificator_sensorConfiguration_list}
    Should Contain    ${fcs_FilterIdentificator_sensorConfiguration_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration start of topic ===
    Should Contain    ${fcs_FilterIdentificator_sensorConfiguration_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration end of topic ===
    ${fcs_FilterManager_filterConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterManager_filterConfiguration start of topic ===
    ${fcs_FilterManager_filterConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterManager_filterConfiguration end of topic ===
    ${fcs_FilterManager_filterConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_FilterManager_filterConfiguration_start}    end=${fcs_FilterManager_filterConfiguration_end + 1}
    Log Many    ${fcs_FilterManager_filterConfiguration_list}
    Should Contain    ${fcs_FilterManager_filterConfiguration_list}    === MTCamera_fcs_FilterManager_filterConfiguration start of topic ===
    Should Contain    ${fcs_FilterManager_filterConfiguration_list}    === MTCamera_fcs_FilterManager_filterConfiguration end of topic ===
    ${fcs_Loader_loaderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_loaderConfiguration start of topic ===
    ${fcs_Loader_loaderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_loaderConfiguration end of topic ===
    ${fcs_Loader_loaderConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_loaderConfiguration_start}    end=${fcs_Loader_loaderConfiguration_end + 1}
    Log Many    ${fcs_Loader_loaderConfiguration_list}
    Should Contain    ${fcs_Loader_loaderConfiguration_list}    === MTCamera_fcs_Loader_loaderConfiguration start of topic ===
    Should Contain    ${fcs_Loader_loaderConfiguration_list}    === MTCamera_fcs_Loader_loaderConfiguration end of topic ===
    ${fcs_Loader_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_readRateConfiguration start of topic ===
    ${fcs_Loader_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_readRateConfiguration end of topic ===
    ${fcs_Loader_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_readRateConfiguration_start}    end=${fcs_Loader_readRateConfiguration_end + 1}
    Log Many    ${fcs_Loader_readRateConfiguration_list}
    Should Contain    ${fcs_Loader_readRateConfiguration_list}    === MTCamera_fcs_Loader_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Loader_readRateConfiguration_list}    === MTCamera_fcs_Loader_readRateConfiguration end of topic ===
    ${fcs_Loader_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_sensorConfiguration start of topic ===
    ${fcs_Loader_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_sensorConfiguration end of topic ===
    ${fcs_Loader_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_sensorConfiguration_start}    end=${fcs_Loader_sensorConfiguration_end + 1}
    Log Many    ${fcs_Loader_sensorConfiguration_list}
    Should Contain    ${fcs_Loader_sensorConfiguration_list}    === MTCamera_fcs_Loader_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Loader_sensorConfiguration_list}    === MTCamera_fcs_Loader_sensorConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_GeneralConfiguration_start}    end=${fcs_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersConfiguration_start}    end=${fcs_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_Seneca1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration start of topic ===
    ${fcs_Seneca1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration end of topic ===
    ${fcs_Seneca1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Seneca1_DevicesConfiguration_start}    end=${fcs_Seneca1_DevicesConfiguration_end + 1}
    Log Many    ${fcs_Seneca1_DevicesConfiguration_list}
    Should Contain    ${fcs_Seneca1_DevicesConfiguration_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_Seneca1_DevicesConfiguration_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration end of topic ===
    ${fcs_Seneca2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration start of topic ===
    ${fcs_Seneca2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration end of topic ===
    ${fcs_Seneca2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Seneca2_DevicesConfiguration_start}    end=${fcs_Seneca2_DevicesConfiguration_end + 1}
    Log Many    ${fcs_Seneca2_DevicesConfiguration_list}
    Should Contain    ${fcs_Seneca2_DevicesConfiguration_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_Seneca2_DevicesConfiguration_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration end of topic ===
    ${shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_GeneralConfiguration start of topic ===
    ${shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_GeneralConfiguration end of topic ===
    ${shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${shutter_GeneralConfiguration_start}    end=${shutter_GeneralConfiguration_end + 1}
    Log Many    ${shutter_GeneralConfiguration_list}
    Should Contain    ${shutter_GeneralConfiguration_list}    === MTCamera_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${shutter_GeneralConfiguration_list}    === MTCamera_shutter_GeneralConfiguration end of topic ===
    ${shutter_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_timersConfiguration start of topic ===
    ${shutter_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_timersConfiguration end of topic ===
    ${shutter_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${shutter_timersConfiguration_start}    end=${shutter_timersConfiguration_end + 1}
    Log Many    ${shutter_timersConfiguration_list}
    Should Contain    ${shutter_timersConfiguration_list}    === MTCamera_shutter_timersConfiguration start of topic ===
    Should Contain    ${shutter_timersConfiguration_list}    === MTCamera_shutter_timersConfiguration end of topic ===
    ${chiller_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_DeviceConfiguration start of topic ===
    ${chiller_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_DeviceConfiguration end of topic ===
    ${chiller_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_DeviceConfiguration_start}    end=${chiller_DeviceConfiguration_end + 1}
    Log Many    ${chiller_DeviceConfiguration_list}
    Should Contain    ${chiller_DeviceConfiguration_list}    === MTCamera_chiller_DeviceConfiguration start of topic ===
    Should Contain    ${chiller_DeviceConfiguration_list}    === MTCamera_chiller_DeviceConfiguration end of topic ===
    ${chiller_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_DevicesConfiguration start of topic ===
    ${chiller_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_DevicesConfiguration end of topic ===
    ${chiller_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_DevicesConfiguration_start}    end=${chiller_DevicesConfiguration_end + 1}
    Log Many    ${chiller_DevicesConfiguration_list}
    Should Contain    ${chiller_DevicesConfiguration_list}    === MTCamera_chiller_DevicesConfiguration start of topic ===
    Should Contain    ${chiller_DevicesConfiguration_list}    === MTCamera_chiller_DevicesConfiguration end of topic ===
    ${chiller_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_GeneralConfiguration start of topic ===
    ${chiller_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_GeneralConfiguration end of topic ===
    ${chiller_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_GeneralConfiguration_start}    end=${chiller_GeneralConfiguration_end + 1}
    Log Many    ${chiller_GeneralConfiguration_list}
    Should Contain    ${chiller_GeneralConfiguration_list}    === MTCamera_chiller_GeneralConfiguration start of topic ===
    Should Contain    ${chiller_GeneralConfiguration_list}    === MTCamera_chiller_GeneralConfiguration end of topic ===
    ${chiller_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_LimitsConfiguration start of topic ===
    ${chiller_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_LimitsConfiguration end of topic ===
    ${chiller_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_LimitsConfiguration_start}    end=${chiller_LimitsConfiguration_end + 1}
    Log Many    ${chiller_LimitsConfiguration_list}
    Should Contain    ${chiller_LimitsConfiguration_list}    === MTCamera_chiller_LimitsConfiguration start of topic ===
    Should Contain    ${chiller_LimitsConfiguration_list}    === MTCamera_chiller_LimitsConfiguration end of topic ===
    ${chiller_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_timersConfiguration start of topic ===
    ${chiller_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_timersConfiguration end of topic ===
    ${chiller_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_timersConfiguration_start}    end=${chiller_timersConfiguration_end + 1}
    Log Many    ${chiller_timersConfiguration_list}
    Should Contain    ${chiller_timersConfiguration_list}    === MTCamera_chiller_timersConfiguration start of topic ===
    Should Contain    ${chiller_timersConfiguration_list}    === MTCamera_chiller_timersConfiguration end of topic ===
    ${thermal_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_DeviceConfiguration start of topic ===
    ${thermal_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_DeviceConfiguration end of topic ===
    ${thermal_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_DeviceConfiguration_start}    end=${thermal_DeviceConfiguration_end + 1}
    Log Many    ${thermal_DeviceConfiguration_list}
    Should Contain    ${thermal_DeviceConfiguration_list}    === MTCamera_thermal_DeviceConfiguration start of topic ===
    Should Contain    ${thermal_DeviceConfiguration_list}    === MTCamera_thermal_DeviceConfiguration end of topic ===
    ${thermal_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_DevicesConfiguration start of topic ===
    ${thermal_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_DevicesConfiguration end of topic ===
    ${thermal_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_DevicesConfiguration_start}    end=${thermal_DevicesConfiguration_end + 1}
    Log Many    ${thermal_DevicesConfiguration_list}
    Should Contain    ${thermal_DevicesConfiguration_list}    === MTCamera_thermal_DevicesConfiguration start of topic ===
    Should Contain    ${thermal_DevicesConfiguration_list}    === MTCamera_thermal_DevicesConfiguration end of topic ===
    ${thermal_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_GeneralConfiguration start of topic ===
    ${thermal_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_GeneralConfiguration end of topic ===
    ${thermal_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_GeneralConfiguration_start}    end=${thermal_GeneralConfiguration_end + 1}
    Log Many    ${thermal_GeneralConfiguration_list}
    Should Contain    ${thermal_GeneralConfiguration_list}    === MTCamera_thermal_GeneralConfiguration start of topic ===
    Should Contain    ${thermal_GeneralConfiguration_list}    === MTCamera_thermal_GeneralConfiguration end of topic ===
    ${thermal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_LimitsConfiguration start of topic ===
    ${thermal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_LimitsConfiguration end of topic ===
    ${thermal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_LimitsConfiguration_start}    end=${thermal_LimitsConfiguration_end + 1}
    Log Many    ${thermal_LimitsConfiguration_list}
    Should Contain    ${thermal_LimitsConfiguration_list}    === MTCamera_thermal_LimitsConfiguration start of topic ===
    Should Contain    ${thermal_LimitsConfiguration_list}    === MTCamera_thermal_LimitsConfiguration end of topic ===
    ${thermal_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_PicConfiguration start of topic ===
    ${thermal_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_PicConfiguration end of topic ===
    ${thermal_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_PicConfiguration_start}    end=${thermal_PicConfiguration_end + 1}
    Log Many    ${thermal_PicConfiguration_list}
    Should Contain    ${thermal_PicConfiguration_list}    === MTCamera_thermal_PicConfiguration start of topic ===
    Should Contain    ${thermal_PicConfiguration_list}    === MTCamera_thermal_PicConfiguration end of topic ===
    ${thermal_RefrigConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_RefrigConfiguration start of topic ===
    ${thermal_RefrigConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_RefrigConfiguration end of topic ===
    ${thermal_RefrigConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_RefrigConfiguration_start}    end=${thermal_RefrigConfiguration_end + 1}
    Log Many    ${thermal_RefrigConfiguration_list}
    Should Contain    ${thermal_RefrigConfiguration_list}    === MTCamera_thermal_RefrigConfiguration start of topic ===
    Should Contain    ${thermal_RefrigConfiguration_list}    === MTCamera_thermal_RefrigConfiguration end of topic ===
    ${thermal_ThermalLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_ThermalLimitsConfiguration start of topic ===
    ${thermal_ThermalLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_ThermalLimitsConfiguration end of topic ===
    ${thermal_ThermalLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_ThermalLimitsConfiguration_start}    end=${thermal_ThermalLimitsConfiguration_end + 1}
    Log Many    ${thermal_ThermalLimitsConfiguration_list}
    Should Contain    ${thermal_ThermalLimitsConfiguration_list}    === MTCamera_thermal_ThermalLimitsConfiguration start of topic ===
    Should Contain    ${thermal_ThermalLimitsConfiguration_list}    === MTCamera_thermal_ThermalLimitsConfiguration end of topic ===
    ${thermal_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_timersConfiguration start of topic ===
    ${thermal_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_timersConfiguration end of topic ===
    ${thermal_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_timersConfiguration_start}    end=${thermal_timersConfiguration_end + 1}
    Log Many    ${thermal_timersConfiguration_list}
    Should Contain    ${thermal_timersConfiguration_list}    === MTCamera_thermal_timersConfiguration start of topic ===
    Should Contain    ${thermal_timersConfiguration_list}    === MTCamera_thermal_timersConfiguration end of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration start of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration end of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BFR_DevicesConfiguration_start}    end=${utiltrunk_BFR_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_BFR_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_BFR_DevicesConfiguration_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_BFR_DevicesConfiguration_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration end of topic ===
    ${utiltrunk_BFR_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration start of topic ===
    ${utiltrunk_BFR_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration end of topic ===
    ${utiltrunk_BFR_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BFR_UtilConfiguration_start}    end=${utiltrunk_BFR_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_BFR_UtilConfiguration_list}
    Should Contain    ${utiltrunk_BFR_UtilConfiguration_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_BFR_UtilConfiguration_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BodyMaq20_DeviceConfiguration_start}    end=${utiltrunk_BodyMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BodyMaq20_DevicesConfiguration_start}    end=${utiltrunk_BodyMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_start}    end=${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_AverageTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_AverageTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_CryoMaq20_DeviceConfiguration_start}    end=${utiltrunk_CryoMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_CryoMaq20_DevicesConfiguration_start}    end=${utiltrunk_CryoMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration start of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPCFan_PicConfiguration_start}    end=${utiltrunk_MPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_MPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_start}    end=${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_MPC_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_MPC_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_Humidity_LimitsConfiguration_start}    end=${utiltrunk_MPC_Humidity_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_RetnPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_RetnPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_start}    end=${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_SplyPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_SplyPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_MPC_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration start of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration end of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PDU_48V_DevicesConfiguration_start}    end=${utiltrunk_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_PDU_48V_DevicesConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_PDU_48V_DevicesConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration end of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration start of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration end of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PDU_48V_UtilConfiguration_start}    end=${utiltrunk_PDU_48V_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_PDU_48V_UtilConfiguration_list}
    Should Contain    ${utiltrunk_PDU_48V_UtilConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_PDU_48V_UtilConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_start}    end=${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration end of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration start of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration end of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Pluto_DeviceConfiguration_start}    end=${utiltrunk_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_Pluto_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_Pluto_DeviceConfiguration_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_Pluto_DeviceConfiguration_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration end of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration start of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration end of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Pluto_DevicesConfiguration_start}    end=${utiltrunk_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_Pluto_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_Pluto_DevicesConfiguration_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_Pluto_DevicesConfiguration_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration end of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration start of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration end of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Telescope_DevicesConfiguration_start}    end=${utiltrunk_Telescope_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_Telescope_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_Telescope_DevicesConfiguration_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_Telescope_DevicesConfiguration_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration end of topic ===
    ${utiltrunk_UTFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration start of topic ===
    ${utiltrunk_UTFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_UTFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UTFan_PicConfiguration_start}    end=${utiltrunk_UTFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_UTFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_AverageTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_AverageTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanInletTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_FanInletTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_UT_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_UT_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_UT_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_start}    end=${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_start}    end=${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtMaq20_DeviceConfiguration_start}    end=${utiltrunk_UtMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_UtMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_UtMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtMaq20_DevicesConfiguration_start}    end=${utiltrunk_UtMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_UtMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_UtMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtilConfiguration start of topic ===
    ${utiltrunk_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtilConfiguration end of topic ===
    ${utiltrunk_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtilConfiguration_start}    end=${utiltrunk_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_UtilConfiguration_list}
    Should Contain    ${utiltrunk_UtilConfiguration_list}    === MTCamera_utiltrunk_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtilConfiguration_list}    === MTCamera_utiltrunk_UtilConfiguration end of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration start of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPCFan_PicConfiguration_start}    end=${utiltrunk_VPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_VPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration start of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration end of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPCHtrs_VpcConfiguration_start}    end=${utiltrunk_VPCHtrs_VpcConfiguration_end + 1}
    Log Many    ${utiltrunk_VPCHtrs_VpcConfiguration_list}
    Should Contain    ${utiltrunk_VPCHtrs_VpcConfiguration_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPCHtrs_VpcConfiguration_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_VPC_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_VPC_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_start}    end=${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_Humidity_LimitsConfiguration_start}    end=${utiltrunk_VPC_Humidity_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_RetnPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_RetnPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_VPC_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration end of topic ===
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === MTCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === MTCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === MTCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === MTCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === MTCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === MTCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === MTCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === MTCamera_alertRaised end of topic ===
    ${filterChangerPowerStatus_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerPowerStatus start of topic ===
    ${filterChangerPowerStatus_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerPowerStatus end of topic ===
    ${filterChangerPowerStatus_list}=    Get Slice From List    ${full_list}    start=${filterChangerPowerStatus_start}    end=${filterChangerPowerStatus_end + 1}
    Log Many    ${filterChangerPowerStatus_list}
    Should Contain    ${filterChangerPowerStatus_list}    === MTCamera_filterChangerPowerStatus start of topic ===
    Should Contain    ${filterChangerPowerStatus_list}    === MTCamera_filterChangerPowerStatus end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTCamera_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === MTCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === MTCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === MTCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === MTCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === MTCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === MTCamera_configurationsAvailable end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end + 1}
    Log Many    ${offlineDetailedState_list}
    Should Contain    ${offlineDetailedState_list}    === MTCamera_offlineDetailedState start of topic ===
    Should Contain    ${offlineDetailedState_list}    === MTCamera_offlineDetailedState end of topic ===
    ${endReadout_start}=    Get Index From List    ${full_list}    === MTCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === MTCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === MTCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === MTCamera_endReadout end of topic ===
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage end of topic ===
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter end of topic ===
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter end of topic ===
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose end of topic ===
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose end of topic ===
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter end of topic ===
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel end of topic ===
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter end of topic ===
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState end of topic ===
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage end of topic ===
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState end of topic ===
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured end of topic ===
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter end of topic ===
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen end of topic ===
    ${startIntegration_start}=    Get Index From List    ${full_list}    === MTCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === MTCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration end of topic ===
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage end of topic ===
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter end of topic ===
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen end of topic ===
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState end of topic ===
    ${availableFilters_start}=    Get Index From List    ${full_list}    === MTCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === MTCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters end of topic ===
    ${startReadout_start}=    Get Index From List    ${full_list}    === MTCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === MTCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === MTCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === MTCamera_startReadout end of topic ===
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel end of topic ===
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${quadbox_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    ${quadbox_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_DevicesConfiguration_start}    end=${quadbox_BFR_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_BFR_DevicesConfiguration_list}
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === MTCamera_quadbox_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_DevicesConfiguration_list}    === MTCamera_quadbox_BFR_DevicesConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    ${quadbox_BFR_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsConfiguration_start}    end=${quadbox_BFR_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_BFR_LimitsConfiguration_list}
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === MTCamera_quadbox_BFR_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_LimitsConfiguration_list}    === MTCamera_quadbox_BFR_LimitsConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    ${quadbox_BFR_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_BFR_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxConfiguration_start}    end=${quadbox_BFR_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_BFR_QuadboxConfiguration_list}
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxConfiguration_list}    === MTCamera_quadbox_BFR_QuadboxConfiguration end of topic ===
    ${quadbox_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration start of topic ===
    ${quadbox_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration end of topic ===
    ${quadbox_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_Maq20_DeviceConfiguration_start}    end=${quadbox_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${quadbox_Maq20_DeviceConfiguration_list}
    Should Contain    ${quadbox_Maq20_DeviceConfiguration_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${quadbox_Maq20_DeviceConfiguration_list}    === MTCamera_quadbox_Maq20_DeviceConfiguration end of topic ===
    ${quadbox_Maq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration start of topic ===
    ${quadbox_Maq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration end of topic ===
    ${quadbox_Maq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_Maq20_DevicesConfiguration_start}    end=${quadbox_Maq20_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_Maq20_DevicesConfiguration_list}
    Should Contain    ${quadbox_Maq20_DevicesConfiguration_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_Maq20_DevicesConfiguration_list}    === MTCamera_quadbox_Maq20_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_DevicesConfiguration_start}    end=${quadbox_PDU_24VC_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VC_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsConfiguration_start}    end=${quadbox_PDU_24VC_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VC_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VC_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxConfiguration_start}    end=${quadbox_PDU_24VC_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VC_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_DevicesConfiguration_start}    end=${quadbox_PDU_24VD_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_24VD_DevicesConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsConfiguration_start}    end=${quadbox_PDU_24VD_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_24VD_LimitsConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_24VD_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxConfiguration_start}    end=${quadbox_PDU_24VD_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_24VD_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_DevicesConfiguration_start}    end=${quadbox_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_48V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsConfiguration_start}    end=${quadbox_PDU_48V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_48V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_48V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxConfiguration_start}    end=${quadbox_PDU_48V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_48V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_DevicesConfiguration_start}    end=${quadbox_PDU_5V_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_DevicesConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_DevicesConfiguration_list}    === MTCamera_quadbox_PDU_5V_DevicesConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsConfiguration_start}    end=${quadbox_PDU_5V_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsConfiguration_list}    === MTCamera_quadbox_PDU_5V_LimitsConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PDU_5V_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxConfiguration_start}    end=${quadbox_PDU_5V_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxConfiguration_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxConfiguration_list}    === MTCamera_quadbox_PDU_5V_QuadboxConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_GeneralConfiguration_start}    end=${quadbox_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_GeneralConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_DevicesConfiguration_start}    end=${quadbox_REB_Bulk_PS_DevicesConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_DevicesConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_DevicesConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_LimitsConfiguration_start}    end=${quadbox_REB_Bulk_PS_LimitsConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxConfiguration_start}    end=${quadbox_REB_Bulk_PS_QuadboxConfiguration_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxConfiguration_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManager_GeneralConfiguration_start}    end=${rebpower_EmergencyResponseManager_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManager_GeneralConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManager_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_GeneralConfiguration start of topic ===
    ${rebpower_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_GeneralConfiguration_start}    end=${rebpower_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_GeneralConfiguration_list}
    Should Contain    ${rebpower_GeneralConfiguration_list}    === MTCamera_rebpower_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_GeneralConfiguration_list}    === MTCamera_rebpower_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_GeneralConfiguration_start}    end=${rebpower_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_GeneralConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_Power_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Power_timersConfiguration start of topic ===
    ${rebpower_Power_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Power_timersConfiguration end of topic ===
    ${rebpower_Power_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Power_timersConfiguration_start}    end=${rebpower_Power_timersConfiguration_end + 1}
    Log Many    ${rebpower_Power_timersConfiguration_list}
    Should Contain    ${rebpower_Power_timersConfiguration_list}    === MTCamera_rebpower_Power_timersConfiguration start of topic ===
    Should Contain    ${rebpower_Power_timersConfiguration_list}    === MTCamera_rebpower_Power_timersConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_LimitsConfiguration_start}    end=${rebpower_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_RebTotalPower_LimitsConfiguration_list}    === MTCamera_rebpower_RebTotalPower_LimitsConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    ${rebpower_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_GeneralConfiguration_start}    end=${rebpower_Reb_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Reb_GeneralConfiguration_list}
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === MTCamera_rebpower_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_GeneralConfiguration_list}    === MTCamera_rebpower_Reb_GeneralConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    ${rebpower_Rebps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_DevicesConfiguration_start}    end=${rebpower_Rebps_DevicesConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_DevicesConfiguration_list}
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_DevicesConfiguration_list}    === MTCamera_rebpower_Rebps_DevicesConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    ${rebpower_Rebps_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_GeneralConfiguration_start}    end=${rebpower_Rebps_GeneralConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_GeneralConfiguration_list}
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_GeneralConfiguration_list}    === MTCamera_rebpower_Rebps_GeneralConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    ${rebpower_Rebps_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsConfiguration_start}    end=${rebpower_Rebps_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_LimitsConfiguration_list}
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsConfiguration_list}    === MTCamera_rebpower_Rebps_LimitsConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    ${rebpower_Rebps_PowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_PowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerConfiguration_start}    end=${rebpower_Rebps_PowerConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_PowerConfiguration_list}
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === MTCamera_rebpower_Rebps_PowerConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_PowerConfiguration_list}    === MTCamera_rebpower_Rebps_PowerConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_buildConfiguration start of topic ===
    ${rebpower_Rebps_buildConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${rebpower_Rebps_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_buildConfiguration_start}    end=${rebpower_Rebps_buildConfiguration_end + 1}
    Log Many    ${rebpower_Rebps_buildConfiguration_list}
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === MTCamera_rebpower_Rebps_buildConfiguration start of topic ===
    Should Contain    ${rebpower_Rebps_buildConfiguration_list}    === MTCamera_rebpower_Rebps_buildConfiguration end of topic ===
    ${hex_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsConfiguration start of topic ===
    ${hex_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsConfiguration end of topic ===
    ${hex_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_LimitsConfiguration_start}    end=${hex_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cold1_LimitsConfiguration_list}
    Should Contain    ${hex_Cold1_LimitsConfiguration_list}    === MTCamera_hex_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cold1_LimitsConfiguration_list}    === MTCamera_hex_Cold1_LimitsConfiguration end of topic ===
    ${hex_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsConfiguration start of topic ===
    ${hex_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsConfiguration end of topic ===
    ${hex_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_LimitsConfiguration_start}    end=${hex_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cold2_LimitsConfiguration_list}
    Should Contain    ${hex_Cold2_LimitsConfiguration_list}    === MTCamera_hex_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cold2_LimitsConfiguration_list}    === MTCamera_hex_Cold2_LimitsConfiguration end of topic ===
    ${hex_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsConfiguration start of topic ===
    ${hex_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsConfiguration end of topic ===
    ${hex_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_LimitsConfiguration_start}    end=${hex_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo1_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo1_LimitsConfiguration_list}    === MTCamera_hex_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo1_LimitsConfiguration_list}    === MTCamera_hex_Cryo1_LimitsConfiguration end of topic ===
    ${hex_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsConfiguration start of topic ===
    ${hex_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsConfiguration end of topic ===
    ${hex_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_LimitsConfiguration_start}    end=${hex_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo2_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo2_LimitsConfiguration_list}    === MTCamera_hex_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo2_LimitsConfiguration_list}    === MTCamera_hex_Cryo2_LimitsConfiguration end of topic ===
    ${hex_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsConfiguration start of topic ===
    ${hex_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsConfiguration end of topic ===
    ${hex_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_LimitsConfiguration_start}    end=${hex_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo3_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo3_LimitsConfiguration_list}    === MTCamera_hex_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo3_LimitsConfiguration_list}    === MTCamera_hex_Cryo3_LimitsConfiguration end of topic ===
    ${hex_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsConfiguration start of topic ===
    ${hex_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsConfiguration end of topic ===
    ${hex_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_LimitsConfiguration_start}    end=${hex_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo4_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo4_LimitsConfiguration_list}    === MTCamera_hex_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo4_LimitsConfiguration_list}    === MTCamera_hex_Cryo4_LimitsConfiguration end of topic ===
    ${hex_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsConfiguration start of topic ===
    ${hex_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsConfiguration end of topic ===
    ${hex_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_LimitsConfiguration_start}    end=${hex_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo5_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo5_LimitsConfiguration_list}    === MTCamera_hex_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo5_LimitsConfiguration_list}    === MTCamera_hex_Cryo5_LimitsConfiguration end of topic ===
    ${hex_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsConfiguration start of topic ===
    ${hex_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsConfiguration end of topic ===
    ${hex_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_LimitsConfiguration_start}    end=${hex_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${hex_Cryo6_LimitsConfiguration_list}
    Should Contain    ${hex_Cryo6_LimitsConfiguration_list}    === MTCamera_hex_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${hex_Cryo6_LimitsConfiguration_list}    === MTCamera_hex_Cryo6_LimitsConfiguration end of topic ===
    ${hex_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_GeneralConfiguration start of topic ===
    ${hex_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_GeneralConfiguration end of topic ===
    ${hex_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_GeneralConfiguration_start}    end=${hex_GeneralConfiguration_end + 1}
    Log Many    ${hex_GeneralConfiguration_list}
    Should Contain    ${hex_GeneralConfiguration_list}    === MTCamera_hex_GeneralConfiguration start of topic ===
    Should Contain    ${hex_GeneralConfiguration_list}    === MTCamera_hex_GeneralConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    ${hex_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceConfiguration_start}    end=${hex_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DevicesConfiguration start of topic ===
    ${hex_Maq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DevicesConfiguration end of topic ===
    ${hex_Maq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DevicesConfiguration_start}    end=${hex_Maq20_DevicesConfiguration_end + 1}
    Log Many    ${hex_Maq20_DevicesConfiguration_list}
    Should Contain    ${hex_Maq20_DevicesConfiguration_list}    === MTCamera_hex_Maq20_DevicesConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DevicesConfiguration_list}    === MTCamera_hex_Maq20_DevicesConfiguration end of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration start of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration end of topic ===
    ${hex_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_GeneralConfiguration_start}    end=${hex_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_hex_PeriodicTasks_GeneralConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    ${hex_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersConfiguration_start}    end=${hex_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration start of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration end of topic ===
    ${hex_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_StatusAggregator_GeneralConfiguration_start}    end=${hex_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${hex_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${hex_StatusAggregator_GeneralConfiguration_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${hex_StatusAggregator_GeneralConfiguration_list}    === MTCamera_hex_StatusAggregator_GeneralConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceConfiguration_start}    end=${refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration start of topic ===
    ${refrig_Cryo1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${refrig_Cryo1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DevicesConfiguration_start}    end=${refrig_Cryo1_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo1_DevicesConfiguration_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DevicesConfiguration_list}    === MTCamera_refrig_Cryo1_DevicesConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsConfiguration_start}    end=${refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceConfiguration_start}    end=${refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration start of topic ===
    ${refrig_Cryo2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${refrig_Cryo2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DevicesConfiguration_start}    end=${refrig_Cryo2_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo2_DevicesConfiguration_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DevicesConfiguration_list}    === MTCamera_refrig_Cryo2_DevicesConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsConfiguration_start}    end=${refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceConfiguration_start}    end=${refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration start of topic ===
    ${refrig_Cryo3_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${refrig_Cryo3_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DevicesConfiguration_start}    end=${refrig_Cryo3_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo3_DevicesConfiguration_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DevicesConfiguration_list}    === MTCamera_refrig_Cryo3_DevicesConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsConfiguration_start}    end=${refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_PicConfiguration start of topic ===
    ${refrig_Cryo3_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_PicConfiguration end of topic ===
    ${refrig_Cryo3_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_PicConfiguration_start}    end=${refrig_Cryo3_PicConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_PicConfiguration_list}
    Should Contain    ${refrig_Cryo3_PicConfiguration_list}    === MTCamera_refrig_Cryo3_PicConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_PicConfiguration_list}    === MTCamera_refrig_Cryo3_PicConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceConfiguration_start}    end=${refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration start of topic ===
    ${refrig_Cryo4_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${refrig_Cryo4_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DevicesConfiguration_start}    end=${refrig_Cryo4_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo4_DevicesConfiguration_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DevicesConfiguration_list}    === MTCamera_refrig_Cryo4_DevicesConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsConfiguration_start}    end=${refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceConfiguration_start}    end=${refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration start of topic ===
    ${refrig_Cryo5_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${refrig_Cryo5_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DevicesConfiguration_start}    end=${refrig_Cryo5_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo5_DevicesConfiguration_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DevicesConfiguration_list}    === MTCamera_refrig_Cryo5_DevicesConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsConfiguration_start}    end=${refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_PicConfiguration start of topic ===
    ${refrig_Cryo5_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_PicConfiguration end of topic ===
    ${refrig_Cryo5_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_PicConfiguration_start}    end=${refrig_Cryo5_PicConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_PicConfiguration_list}
    Should Contain    ${refrig_Cryo5_PicConfiguration_list}    === MTCamera_refrig_Cryo5_PicConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_PicConfiguration_list}    === MTCamera_refrig_Cryo5_PicConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceConfiguration_start}    end=${refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration start of topic ===
    ${refrig_Cryo6_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${refrig_Cryo6_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DevicesConfiguration_start}    end=${refrig_Cryo6_DevicesConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DevicesConfiguration_list}
    Should Contain    ${refrig_Cryo6_DevicesConfiguration_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DevicesConfiguration_list}    === MTCamera_refrig_Cryo6_DevicesConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsConfiguration_start}    end=${refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_CryoCompLimits_CompLimitsConfiguration_start}    end=${refrig_CryoCompLimits_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}
    Should Contain    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_CryoCompLimits_CompLimitsConfiguration_list}    === MTCamera_refrig_CryoCompLimits_CompLimitsConfiguration end of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${refrig_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_GeneralConfiguration_start}    end=${refrig_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_refrig_PeriodicTasks_GeneralConfiguration end of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration start of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${refrig_PeriodicTasks_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_PicConfiguration_start}    end=${refrig_PeriodicTasks_PicConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_PicConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_PicConfiguration_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_PicConfiguration_list}    === MTCamera_refrig_PeriodicTasks_PicConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersConfiguration_start}    end=${refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_Cip_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip_LimitsConfiguration start of topic ===
    ${vacuum_Cip_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip_LimitsConfiguration end of topic ===
    ${vacuum_Cip_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cip_LimitsConfiguration_start}    end=${vacuum_Cip_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cip_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cip_LimitsConfiguration_list}    === MTCamera_vacuum_Cip_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cip_LimitsConfiguration_list}    === MTCamera_vacuum_Cip_LimitsConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoFlineGauge_CryoConfiguration_start}    end=${vacuum_CryoFlineGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoFlineGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoFlineGauge_DevicesConfiguration_start}    end=${vacuum_CryoFlineGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboGauge_CryoConfiguration_start}    end=${vacuum_CryoTurboGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboGauge_DevicesConfiguration_start}    end=${vacuum_CryoTurboGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration start of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboPump_DevicesConfiguration_start}    end=${vacuum_CryoTurboPump_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboPump_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration start of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_CryoTurboPump_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoTurboPump_GeneralConfiguration_start}    end=${vacuum_CryoTurboPump_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_CryoTurboPump_GeneralConfiguration_list}
    Should Contain    ${vacuum_CryoTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_CryoTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_CryoTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration start of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGauge_CryoConfiguration_start}    end=${vacuum_CryoVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_CryoVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_CryoConfiguration end of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_CryoVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGauge_DevicesConfiguration_start}    end=${vacuum_CryoVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_CryoVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_CryoVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    ${vacuum_Cryo_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_Cryo_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsConfiguration_start}    end=${vacuum_Cryo_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Cryo_LimitsConfiguration_list}
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsConfiguration_list}    === MTCamera_vacuum_Cryo_LimitsConfiguration end of topic ===
    ${vacuum_HX_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX_LimitsConfiguration start of topic ===
    ${vacuum_HX_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX_LimitsConfiguration end of topic ===
    ${vacuum_HX_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HX_LimitsConfiguration_start}    end=${vacuum_HX_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_HX_LimitsConfiguration_list}
    Should Contain    ${vacuum_HX_LimitsConfiguration_list}    === MTCamera_vacuum_HX_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_HX_LimitsConfiguration_list}    === MTCamera_vacuum_HX_LimitsConfiguration end of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration start of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_HexFlineGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexFlineGauge_CryoConfiguration_start}    end=${vacuum_HexFlineGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexFlineGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexFlineGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_CryoConfiguration end of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexFlineGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexFlineGauge_DevicesConfiguration_start}    end=${vacuum_HexFlineGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexFlineGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexFlineGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexFlineGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration start of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_HexTurboGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboGauge_CryoConfiguration_start}    end=${vacuum_HexTurboGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_CryoConfiguration end of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboGauge_DevicesConfiguration_start}    end=${vacuum_HexTurboGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration start of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboPump_DevicesConfiguration_start}    end=${vacuum_HexTurboPump_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboPump_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboPump_DevicesConfiguration_list}    === MTCamera_vacuum_HexTurboPump_DevicesConfiguration end of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration start of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_HexTurboPump_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexTurboPump_GeneralConfiguration_start}    end=${vacuum_HexTurboPump_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_HexTurboPump_GeneralConfiguration_list}
    Should Contain    ${vacuum_HexTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_HexTurboPump_GeneralConfiguration_list}    === MTCamera_vacuum_HexTurboPump_GeneralConfiguration end of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration start of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration end of topic ===
    ${vacuum_HexVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexVacGauge_CryoConfiguration_start}    end=${vacuum_HexVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_HexVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_HexVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_HexVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_HexVacGauge_CryoConfiguration end of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_HexVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HexVacGauge_DevicesConfiguration_start}    end=${vacuum_HexVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_HexVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_HexVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_HexVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_HexVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Hip_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip_LimitsConfiguration start of topic ===
    ${vacuum_Hip_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip_LimitsConfiguration end of topic ===
    ${vacuum_Hip_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hip_LimitsConfiguration_start}    end=${vacuum_Hip_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Hip_LimitsConfiguration_list}
    Should Contain    ${vacuum_Hip_LimitsConfiguration_list}    === MTCamera_vacuum_Hip_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Hip_LimitsConfiguration_list}    === MTCamera_vacuum_Hip_LimitsConfiguration end of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration start of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration end of topic ===
    ${vacuum_InstVacGauge_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_InstVacGauge_CryoConfiguration_start}    end=${vacuum_InstVacGauge_CryoConfiguration_end + 1}
    Log Many    ${vacuum_InstVacGauge_CryoConfiguration_list}
    Should Contain    ${vacuum_InstVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_InstVacGauge_CryoConfiguration_list}    === MTCamera_vacuum_InstVacGauge_CryoConfiguration end of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration start of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_InstVacGauge_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_InstVacGauge_DevicesConfiguration_start}    end=${vacuum_InstVacGauge_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_InstVacGauge_DevicesConfiguration_list}
    Should Contain    ${vacuum_InstVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_InstVacGauge_DevicesConfiguration_list}    === MTCamera_vacuum_InstVacGauge_DevicesConfiguration end of topic ===
    ${vacuum_Inst_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst_LimitsConfiguration start of topic ===
    ${vacuum_Inst_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst_LimitsConfiguration end of topic ===
    ${vacuum_Inst_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Inst_LimitsConfiguration_start}    end=${vacuum_Inst_LimitsConfiguration_end + 1}
    Log Many    ${vacuum_Inst_LimitsConfiguration_list}
    Should Contain    ${vacuum_Inst_LimitsConfiguration_list}    === MTCamera_vacuum_Inst_LimitsConfiguration start of topic ===
    Should Contain    ${vacuum_Inst_LimitsConfiguration_list}    === MTCamera_vacuum_Inst_LimitsConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    ${vacuum_IonPumps_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoConfiguration_start}    end=${vacuum_IonPumps_CryoConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_CryoConfiguration_list}
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoConfiguration_list}    === MTCamera_vacuum_IonPumps_CryoConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_IonPumps_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_DevicesConfiguration_start}    end=${vacuum_IonPumps_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_IonPumps_DevicesConfiguration_list}
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumps_DevicesConfiguration_list}    === MTCamera_vacuum_IonPumps_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration start of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Cryo_DeviceConfiguration_start}    end=${vacuum_Maq20Cryo_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Cryo_DeviceConfiguration_list}
    Should Contain    ${vacuum_Maq20Cryo_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Cryo_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration start of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Cryo_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Cryo_DevicesConfiguration_start}    end=${vacuum_Maq20Cryo_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Cryo_DevicesConfiguration_list}
    Should Contain    ${vacuum_Maq20Cryo_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Cryo_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Cryo_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration start of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Ut_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Ut_DeviceConfiguration_start}    end=${vacuum_Maq20Ut_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Ut_DeviceConfiguration_list}
    Should Contain    ${vacuum_Maq20Ut_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Ut_DeviceConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DeviceConfiguration end of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration start of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration end of topic ===
    ${vacuum_Maq20Ut_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Maq20Ut_DevicesConfiguration_start}    end=${vacuum_Maq20Ut_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_Maq20Ut_DevicesConfiguration_list}
    Should Contain    ${vacuum_Maq20Ut_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_Maq20Ut_DevicesConfiguration_list}    === MTCamera_vacuum_Maq20Ut_DevicesConfiguration end of topic ===
    ${vacuum_PDU_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_DevicesConfiguration start of topic ===
    ${vacuum_PDU_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_DevicesConfiguration end of topic ===
    ${vacuum_PDU_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PDU_DevicesConfiguration_start}    end=${vacuum_PDU_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_PDU_DevicesConfiguration_list}
    Should Contain    ${vacuum_PDU_DevicesConfiguration_list}    === MTCamera_vacuum_PDU_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_PDU_DevicesConfiguration_list}    === MTCamera_vacuum_PDU_DevicesConfiguration end of topic ===
    ${vacuum_PDU_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_VacuumConfiguration start of topic ===
    ${vacuum_PDU_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PDU_VacuumConfiguration end of topic ===
    ${vacuum_PDU_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PDU_VacuumConfiguration_start}    end=${vacuum_PDU_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_PDU_VacuumConfiguration_list}
    Should Contain    ${vacuum_PDU_VacuumConfiguration_list}    === MTCamera_vacuum_PDU_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_PDU_VacuumConfiguration_list}    === MTCamera_vacuum_PDU_VacuumConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_GeneralConfiguration_start}    end=${vacuum_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_GeneralConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersConfiguration_start}    end=${vacuum_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersConfiguration_list}    === MTCamera_vacuum_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_PumpCart_CryoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration start of topic ===
    ${vacuum_PumpCart_CryoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration end of topic ===
    ${vacuum_PumpCart_CryoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PumpCart_CryoConfiguration_start}    end=${vacuum_PumpCart_CryoConfiguration_end + 1}
    Log Many    ${vacuum_PumpCart_CryoConfiguration_list}
    Should Contain    ${vacuum_PumpCart_CryoConfiguration_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration start of topic ===
    Should Contain    ${vacuum_PumpCart_CryoConfiguration_list}    === MTCamera_vacuum_PumpCart_CryoConfiguration end of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration start of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration end of topic ===
    ${vacuum_PumpCart_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_PumpCart_DevicesConfiguration_start}    end=${vacuum_PumpCart_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_PumpCart_DevicesConfiguration_list}
    Should Contain    ${vacuum_PumpCart_DevicesConfiguration_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_PumpCart_DevicesConfiguration_list}    === MTCamera_vacuum_PumpCart_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceConfiguration_start}    end=${vacuum_VacPluto_DeviceConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceConfiguration_list}    === MTCamera_vacuum_VacPluto_DeviceConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacPluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DevicesConfiguration_start}    end=${vacuum_VacPluto_DevicesConfiguration_end + 1}
    Log Many    ${vacuum_VacPluto_DevicesConfiguration_list}
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration start of topic ===
    Should Contain    ${vacuum_VacPluto_DevicesConfiguration_list}    === MTCamera_vacuum_VacPluto_DevicesConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacuumConfiguration start of topic ===
    ${vacuum_VacuumConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacuumConfiguration end of topic ===
    ${vacuum_VacuumConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacuumConfiguration_start}    end=${vacuum_VacuumConfiguration_end + 1}
    Log Many    ${vacuum_VacuumConfiguration_list}
    Should Contain    ${vacuum_VacuumConfiguration_list}    === MTCamera_vacuum_VacuumConfiguration start of topic ===
    Should Contain    ${vacuum_VacuumConfiguration_list}    === MTCamera_vacuum_VacuumConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_GeneralConfiguration_start}    end=${daq_monitor_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_GeneralConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersConfiguration_start}    end=${daq_monitor_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasks_timersConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_Stats_StatisticsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsConfiguration_start}    end=${daq_monitor_Stats_StatisticsConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsConfiguration_list}
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsConfiguration_list}    === MTCamera_daq_monitor_Stats_StatisticsConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    ${daq_monitor_Store_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_DevicesConfiguration_start}    end=${daq_monitor_Store_DevicesConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_DevicesConfiguration_list}
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_DevicesConfiguration_list}    === MTCamera_daq_monitor_Store_DevicesConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    ${daq_monitor_Store_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsConfiguration_start}    end=${daq_monitor_Store_LimitsConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_LimitsConfiguration_list}
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsConfiguration_list}    === MTCamera_daq_monitor_Store_LimitsConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    ${daq_monitor_Store_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${daq_monitor_Store_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreConfiguration_start}    end=${daq_monitor_Store_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_Store_StoreConfiguration_list}
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === MTCamera_daq_monitor_Store_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_Store_StoreConfiguration_list}    === MTCamera_daq_monitor_Store_StoreConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdConfiguration_start}    end=${focal_plane_Ccd_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Ccd_HardwareIdConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_Ccd_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsConfiguration_start}    end=${focal_plane_Ccd_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsConfiguration_list}    === MTCamera_focal_plane_Ccd_LimitsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseService_GeneralConfiguration_start}    end=${focal_plane_ImageDatabaseService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_ImageNameService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameService_GeneralConfiguration_start}    end=${focal_plane_ImageNameService_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameService_GeneralConfiguration_list}
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameService_GeneralConfiguration_list}    === MTCamera_focal_plane_ImageNameService_GeneralConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_MonitoringConfig_MonitoringConfiguration_start}    end=${focal_plane_MonitoringConfig_MonitoringConfiguration_end + 1}
    Log Many    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration start of topic ===
    Should Contain    ${focal_plane_MonitoringConfig_MonitoringConfiguration_list}    === MTCamera_focal_plane_MonitoringConfig_MonitoringConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_GeneralConfiguration_start}    end=${focal_plane_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_GeneralConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersConfiguration_start}    end=${focal_plane_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersConfiguration_list}    === MTCamera_focal_plane_PeriodicTasks_timersConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdConfiguration_start}    end=${focal_plane_Raft_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Raft_HardwareIdConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlConfiguration_start}    end=${focal_plane_Raft_RaftTempControlConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusConfiguration_start}    end=${focal_plane_Raft_RaftTempControlStatusConfiguration_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusConfiguration_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_RebTotalPower_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsConfiguration_start}    end=${focal_plane_RebTotalPower_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsConfiguration_list}    === MTCamera_focal_plane_RebTotalPower_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    ${focal_plane_Reb_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_DevicesConfiguration_start}    end=${focal_plane_Reb_DevicesConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_DevicesConfiguration_list}
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_DevicesConfiguration_list}    === MTCamera_focal_plane_Reb_DevicesConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_HardwareIdConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdConfiguration_start}    end=${focal_plane_Reb_HardwareIdConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdConfiguration_list}
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdConfiguration_list}    === MTCamera_focal_plane_Reb_HardwareIdConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    ${focal_plane_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsConfiguration_start}    end=${focal_plane_Reb_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsConfiguration_list}    === MTCamera_focal_plane_Reb_LimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsConfiguration_start}    end=${focal_plane_Reb_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsConfiguration_start}    end=${focal_plane_Reb_RaftsLimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsLimitsConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_RaftsPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerConfiguration_start}    end=${focal_plane_Reb_RaftsPowerConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerConfiguration_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerConfiguration_list}    === MTCamera_focal_plane_Reb_RaftsPowerConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersConfiguration start of topic ===
    ${focal_plane_Reb_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_Reb_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersConfiguration_start}    end=${focal_plane_Reb_timersConfiguration_end + 1}
    Log Many    ${focal_plane_Reb_timersConfiguration_list}
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === MTCamera_focal_plane_Reb_timersConfiguration start of topic ===
    Should Contain    ${focal_plane_Reb_timersConfiguration_list}    === MTCamera_focal_plane_Reb_timersConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_GeneralConfiguration_start}    end=${focal_plane_RebsAverageTemp6_GeneralConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_GeneralConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_GeneralConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_LimitsConfiguration_start}    end=${focal_plane_RebsAverageTemp6_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_LimitsConfiguration_list}    === MTCamera_focal_plane_RebsAverageTemp6_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    ${focal_plane_Segment_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_Segment_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsConfiguration_start}    end=${focal_plane_Segment_LimitsConfiguration_end + 1}
    Log Many    ${focal_plane_Segment_LimitsConfiguration_list}
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsConfiguration_list}    === MTCamera_focal_plane_Segment_LimitsConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQConfiguration_start}    end=${focal_plane_SequencerConfig_DAQConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_DAQConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_GuiderConfiguration_start}    end=${focal_plane_SequencerConfig_GuiderConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_GuiderConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_GuiderConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_GuiderConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_SequencerConfig_SequencerConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerConfiguration_start}    end=${focal_plane_SequencerConfig_SequencerConfiguration_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerConfiguration_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerConfiguration_list}    === MTCamera_focal_plane_SequencerConfig_SequencerConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationConfiguration_start}    end=${focal_plane_WebHooksConfig_VisualizationConfiguration_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationConfiguration_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    ${image_handling_FitsService_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_FitsService_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_FitsService_GeneralConfiguration_start}    end=${image_handling_FitsService_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_FitsService_GeneralConfiguration_list}
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_FitsService_GeneralConfiguration_list}    === MTCamera_image_handling_FitsService_GeneralConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_CommandsConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_CommandsConfiguration_start}    end=${image_handling_ImageHandler_CommandsConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_CommandsConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_CommandsConfiguration_list}    === MTCamera_image_handling_ImageHandler_CommandsConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_DAQConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_DAQConfiguration_start}    end=${image_handling_ImageHandler_DAQConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_DAQConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_DAQConfiguration_list}    === MTCamera_image_handling_ImageHandler_DAQConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_FitsHandlingConfiguration_start}    end=${image_handling_ImageHandler_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_FitsHandlingConfiguration_list}    === MTCamera_image_handling_ImageHandler_FitsHandlingConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_ImageHandler_GuiderConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_ImageHandler_GuiderConfiguration_start}    end=${image_handling_ImageHandler_GuiderConfiguration_end + 1}
    Log Many    ${image_handling_ImageHandler_GuiderConfiguration_list}
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration start of topic ===
    Should Contain    ${image_handling_ImageHandler_GuiderConfiguration_list}    === MTCamera_image_handling_ImageHandler_GuiderConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_GeneralConfiguration_start}    end=${image_handling_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_GeneralConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_PeriodicTasks_timersConfiguration_start}    end=${image_handling_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${image_handling_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${image_handling_PeriodicTasks_timersConfiguration_list}    === MTCamera_image_handling_PeriodicTasks_timersConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${image_handling_StatusAggregator_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_StatusAggregator_GeneralConfiguration_start}    end=${image_handling_StatusAggregator_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_StatusAggregator_GeneralConfiguration_list}
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_StatusAggregator_GeneralConfiguration_list}    === MTCamera_image_handling_StatusAggregator_GeneralConfiguration end of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_03_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_03_LimitsConfiguration_start}    end=${mpm_CLP_RTD_03_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_03_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_03_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_03_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_03_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_05_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_05_LimitsConfiguration_start}    end=${mpm_CLP_RTD_05_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_05_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_05_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_05_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_05_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_50_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_50_LimitsConfiguration_start}    end=${mpm_CLP_RTD_50_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_50_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_50_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_50_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_50_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration start of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration end of topic ===
    ${mpm_CLP_RTD_55_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_55_LimitsConfiguration_start}    end=${mpm_CLP_RTD_55_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CLP_RTD_55_LimitsConfiguration_list}
    Should Contain    ${mpm_CLP_RTD_55_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CLP_RTD_55_LimitsConfiguration_list}    === MTCamera_mpm_CLP_RTD_55_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_12_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_12_LimitsConfiguration_start}    end=${mpm_CYP_RTD_12_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_12_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_12_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_12_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_12_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_14_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_14_LimitsConfiguration_start}    end=${mpm_CYP_RTD_14_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_14_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_14_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_14_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_14_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_31_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_31_LimitsConfiguration_start}    end=${mpm_CYP_RTD_31_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_31_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_31_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_31_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_31_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration start of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration end of topic ===
    ${mpm_CYP_RTD_43_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_43_LimitsConfiguration_start}    end=${mpm_CYP_RTD_43_LimitsConfiguration_end + 1}
    Log Many    ${mpm_CYP_RTD_43_LimitsConfiguration_list}
    Should Contain    ${mpm_CYP_RTD_43_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration start of topic ===
    Should Contain    ${mpm_CYP_RTD_43_LimitsConfiguration_list}    === MTCamera_mpm_CYP_RTD_43_LimitsConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_GeneralConfiguration_start}    end=${mpm_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_mpm_PeriodicTasks_GeneralConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_PeriodicTasks_timersConfiguration_start}    end=${mpm_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${mpm_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${mpm_PeriodicTasks_timersConfiguration_list}    === MTCamera_mpm_PeriodicTasks_timersConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    ${mpm_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DeviceConfiguration_start}    end=${mpm_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DeviceConfiguration_list}
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === MTCamera_mpm_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DeviceConfiguration_list}    === MTCamera_mpm_Pluto_DeviceConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    ${mpm_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${mpm_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${mpm_Pluto_DevicesConfiguration_start}    end=${mpm_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${mpm_Pluto_DevicesConfiguration_list}
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === MTCamera_mpm_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${mpm_Pluto_DevicesConfiguration_list}    === MTCamera_mpm_Pluto_DevicesConfiguration end of topic ===
    ${fcs_Autochanger_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration start of topic ===
    ${fcs_Autochanger_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration end of topic ===
    ${fcs_Autochanger_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_LimitsConfiguration_start}    end=${fcs_Autochanger_LimitsConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_LimitsConfiguration_list}
    Should Contain    ${fcs_Autochanger_LimitsConfiguration_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_LimitsConfiguration_list}    === MTCamera_fcs_Autochanger_LimitsConfiguration end of topic ===
    ${fcs_Autochanger_autochangerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration start of topic ===
    ${fcs_Autochanger_autochangerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration end of topic ===
    ${fcs_Autochanger_autochangerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_autochangerConfiguration_start}    end=${fcs_Autochanger_autochangerConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_autochangerConfiguration_list}
    Should Contain    ${fcs_Autochanger_autochangerConfiguration_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_autochangerConfiguration_list}    === MTCamera_fcs_Autochanger_autochangerConfiguration end of topic ===
    ${fcs_Autochanger_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_readRateConfiguration start of topic ===
    ${fcs_Autochanger_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_readRateConfiguration end of topic ===
    ${fcs_Autochanger_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_readRateConfiguration_start}    end=${fcs_Autochanger_readRateConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_readRateConfiguration_list}
    Should Contain    ${fcs_Autochanger_readRateConfiguration_list}    === MTCamera_fcs_Autochanger_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_readRateConfiguration_list}    === MTCamera_fcs_Autochanger_readRateConfiguration end of topic ===
    ${fcs_Autochanger_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_sensorConfiguration start of topic ===
    ${fcs_Autochanger_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_sensorConfiguration end of topic ===
    ${fcs_Autochanger_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_sensorConfiguration_start}    end=${fcs_Autochanger_sensorConfiguration_end + 1}
    Log Many    ${fcs_Autochanger_sensorConfiguration_list}
    Should Contain    ${fcs_Autochanger_sensorConfiguration_list}    === MTCamera_fcs_Autochanger_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Autochanger_sensorConfiguration_list}    === MTCamera_fcs_Autochanger_sensorConfiguration end of topic ===
    ${fcs_Canbus0_canbusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_canbusConfiguration start of topic ===
    ${fcs_Canbus0_canbusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_canbusConfiguration end of topic ===
    ${fcs_Canbus0_canbusConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_canbusConfiguration_start}    end=${fcs_Canbus0_canbusConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_canbusConfiguration_list}
    Should Contain    ${fcs_Canbus0_canbusConfiguration_list}    === MTCamera_fcs_Canbus0_canbusConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_canbusConfiguration_list}    === MTCamera_fcs_Canbus0_canbusConfiguration end of topic ===
    ${fcs_Canbus0_controllerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_controllerConfiguration start of topic ===
    ${fcs_Canbus0_controllerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_controllerConfiguration end of topic ===
    ${fcs_Canbus0_controllerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_controllerConfiguration_start}    end=${fcs_Canbus0_controllerConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_controllerConfiguration_list}
    Should Contain    ${fcs_Canbus0_controllerConfiguration_list}    === MTCamera_fcs_Canbus0_controllerConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_controllerConfiguration_list}    === MTCamera_fcs_Canbus0_controllerConfiguration end of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration start of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration end of topic ===
    ${fcs_Canbus0_nodeIDConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_nodeIDConfiguration_start}    end=${fcs_Canbus0_nodeIDConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_nodeIDConfiguration_list}
    Should Contain    ${fcs_Canbus0_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus0_nodeIDConfiguration end of topic ===
    ${fcs_Canbus0_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_sensorConfiguration start of topic ===
    ${fcs_Canbus0_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_sensorConfiguration end of topic ===
    ${fcs_Canbus0_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_sensorConfiguration_start}    end=${fcs_Canbus0_sensorConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_sensorConfiguration_list}
    Should Contain    ${fcs_Canbus0_sensorConfiguration_list}    === MTCamera_fcs_Canbus0_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_sensorConfiguration_list}    === MTCamera_fcs_Canbus0_sensorConfiguration end of topic ===
    ${fcs_Canbus0_serialNBConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration start of topic ===
    ${fcs_Canbus0_serialNBConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration end of topic ===
    ${fcs_Canbus0_serialNBConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_serialNBConfiguration_start}    end=${fcs_Canbus0_serialNBConfiguration_end + 1}
    Log Many    ${fcs_Canbus0_serialNBConfiguration_list}
    Should Contain    ${fcs_Canbus0_serialNBConfiguration_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration start of topic ===
    Should Contain    ${fcs_Canbus0_serialNBConfiguration_list}    === MTCamera_fcs_Canbus0_serialNBConfiguration end of topic ===
    ${fcs_Canbus1_canbusConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_canbusConfiguration start of topic ===
    ${fcs_Canbus1_canbusConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_canbusConfiguration end of topic ===
    ${fcs_Canbus1_canbusConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_canbusConfiguration_start}    end=${fcs_Canbus1_canbusConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_canbusConfiguration_list}
    Should Contain    ${fcs_Canbus1_canbusConfiguration_list}    === MTCamera_fcs_Canbus1_canbusConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_canbusConfiguration_list}    === MTCamera_fcs_Canbus1_canbusConfiguration end of topic ===
    ${fcs_Canbus1_controllerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_controllerConfiguration start of topic ===
    ${fcs_Canbus1_controllerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_controllerConfiguration end of topic ===
    ${fcs_Canbus1_controllerConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_controllerConfiguration_start}    end=${fcs_Canbus1_controllerConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_controllerConfiguration_list}
    Should Contain    ${fcs_Canbus1_controllerConfiguration_list}    === MTCamera_fcs_Canbus1_controllerConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_controllerConfiguration_list}    === MTCamera_fcs_Canbus1_controllerConfiguration end of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration start of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration end of topic ===
    ${fcs_Canbus1_nodeIDConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_nodeIDConfiguration_start}    end=${fcs_Canbus1_nodeIDConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_nodeIDConfiguration_list}
    Should Contain    ${fcs_Canbus1_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_nodeIDConfiguration_list}    === MTCamera_fcs_Canbus1_nodeIDConfiguration end of topic ===
    ${fcs_Canbus1_serialNBConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration start of topic ===
    ${fcs_Canbus1_serialNBConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration end of topic ===
    ${fcs_Canbus1_serialNBConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_serialNBConfiguration_start}    end=${fcs_Canbus1_serialNBConfiguration_end + 1}
    Log Many    ${fcs_Canbus1_serialNBConfiguration_list}
    Should Contain    ${fcs_Canbus1_serialNBConfiguration_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration start of topic ===
    Should Contain    ${fcs_Canbus1_serialNBConfiguration_list}    === MTCamera_fcs_Canbus1_serialNBConfiguration end of topic ===
    ${fcs_Carousel_carouselConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_carouselConfiguration start of topic ===
    ${fcs_Carousel_carouselConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_carouselConfiguration end of topic ===
    ${fcs_Carousel_carouselConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_carouselConfiguration_start}    end=${fcs_Carousel_carouselConfiguration_end + 1}
    Log Many    ${fcs_Carousel_carouselConfiguration_list}
    Should Contain    ${fcs_Carousel_carouselConfiguration_list}    === MTCamera_fcs_Carousel_carouselConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_carouselConfiguration_list}    === MTCamera_fcs_Carousel_carouselConfiguration end of topic ===
    ${fcs_Carousel_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_readRateConfiguration start of topic ===
    ${fcs_Carousel_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_readRateConfiguration end of topic ===
    ${fcs_Carousel_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_readRateConfiguration_start}    end=${fcs_Carousel_readRateConfiguration_end + 1}
    Log Many    ${fcs_Carousel_readRateConfiguration_list}
    Should Contain    ${fcs_Carousel_readRateConfiguration_list}    === MTCamera_fcs_Carousel_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_readRateConfiguration_list}    === MTCamera_fcs_Carousel_readRateConfiguration end of topic ===
    ${fcs_Carousel_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_sensorConfiguration start of topic ===
    ${fcs_Carousel_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_sensorConfiguration end of topic ===
    ${fcs_Carousel_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_sensorConfiguration_start}    end=${fcs_Carousel_sensorConfiguration_end + 1}
    Log Many    ${fcs_Carousel_sensorConfiguration_list}
    Should Contain    ${fcs_Carousel_sensorConfiguration_list}    === MTCamera_fcs_Carousel_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Carousel_sensorConfiguration_list}    === MTCamera_fcs_Carousel_sensorConfiguration end of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration start of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration end of topic ===
    ${fcs_FilterIdentificator_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_FilterIdentificator_sensorConfiguration_start}    end=${fcs_FilterIdentificator_sensorConfiguration_end + 1}
    Log Many    ${fcs_FilterIdentificator_sensorConfiguration_list}
    Should Contain    ${fcs_FilterIdentificator_sensorConfiguration_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration start of topic ===
    Should Contain    ${fcs_FilterIdentificator_sensorConfiguration_list}    === MTCamera_fcs_FilterIdentificator_sensorConfiguration end of topic ===
    ${fcs_FilterManager_filterConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterManager_filterConfiguration start of topic ===
    ${fcs_FilterManager_filterConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_FilterManager_filterConfiguration end of topic ===
    ${fcs_FilterManager_filterConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_FilterManager_filterConfiguration_start}    end=${fcs_FilterManager_filterConfiguration_end + 1}
    Log Many    ${fcs_FilterManager_filterConfiguration_list}
    Should Contain    ${fcs_FilterManager_filterConfiguration_list}    === MTCamera_fcs_FilterManager_filterConfiguration start of topic ===
    Should Contain    ${fcs_FilterManager_filterConfiguration_list}    === MTCamera_fcs_FilterManager_filterConfiguration end of topic ===
    ${fcs_Loader_loaderConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_loaderConfiguration start of topic ===
    ${fcs_Loader_loaderConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_loaderConfiguration end of topic ===
    ${fcs_Loader_loaderConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_loaderConfiguration_start}    end=${fcs_Loader_loaderConfiguration_end + 1}
    Log Many    ${fcs_Loader_loaderConfiguration_list}
    Should Contain    ${fcs_Loader_loaderConfiguration_list}    === MTCamera_fcs_Loader_loaderConfiguration start of topic ===
    Should Contain    ${fcs_Loader_loaderConfiguration_list}    === MTCamera_fcs_Loader_loaderConfiguration end of topic ===
    ${fcs_Loader_readRateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_readRateConfiguration start of topic ===
    ${fcs_Loader_readRateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_readRateConfiguration end of topic ===
    ${fcs_Loader_readRateConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_readRateConfiguration_start}    end=${fcs_Loader_readRateConfiguration_end + 1}
    Log Many    ${fcs_Loader_readRateConfiguration_list}
    Should Contain    ${fcs_Loader_readRateConfiguration_list}    === MTCamera_fcs_Loader_readRateConfiguration start of topic ===
    Should Contain    ${fcs_Loader_readRateConfiguration_list}    === MTCamera_fcs_Loader_readRateConfiguration end of topic ===
    ${fcs_Loader_sensorConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_sensorConfiguration start of topic ===
    ${fcs_Loader_sensorConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_sensorConfiguration end of topic ===
    ${fcs_Loader_sensorConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_sensorConfiguration_start}    end=${fcs_Loader_sensorConfiguration_end + 1}
    Log Many    ${fcs_Loader_sensorConfiguration_list}
    Should Contain    ${fcs_Loader_sensorConfiguration_list}    === MTCamera_fcs_Loader_sensorConfiguration start of topic ===
    Should Contain    ${fcs_Loader_sensorConfiguration_list}    === MTCamera_fcs_Loader_sensorConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_GeneralConfiguration_start}    end=${fcs_PeriodicTasks_GeneralConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_GeneralConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_GeneralConfiguration_list}    === MTCamera_fcs_PeriodicTasks_GeneralConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersConfiguration_start}    end=${fcs_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersConfiguration_list}    === MTCamera_fcs_PeriodicTasks_timersConfiguration end of topic ===
    ${fcs_Seneca1_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration start of topic ===
    ${fcs_Seneca1_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration end of topic ===
    ${fcs_Seneca1_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Seneca1_DevicesConfiguration_start}    end=${fcs_Seneca1_DevicesConfiguration_end + 1}
    Log Many    ${fcs_Seneca1_DevicesConfiguration_list}
    Should Contain    ${fcs_Seneca1_DevicesConfiguration_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_Seneca1_DevicesConfiguration_list}    === MTCamera_fcs_Seneca1_DevicesConfiguration end of topic ===
    ${fcs_Seneca2_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration start of topic ===
    ${fcs_Seneca2_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration end of topic ===
    ${fcs_Seneca2_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${fcs_Seneca2_DevicesConfiguration_start}    end=${fcs_Seneca2_DevicesConfiguration_end + 1}
    Log Many    ${fcs_Seneca2_DevicesConfiguration_list}
    Should Contain    ${fcs_Seneca2_DevicesConfiguration_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration start of topic ===
    Should Contain    ${fcs_Seneca2_DevicesConfiguration_list}    === MTCamera_fcs_Seneca2_DevicesConfiguration end of topic ===
    ${shutter_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_GeneralConfiguration start of topic ===
    ${shutter_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_GeneralConfiguration end of topic ===
    ${shutter_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${shutter_GeneralConfiguration_start}    end=${shutter_GeneralConfiguration_end + 1}
    Log Many    ${shutter_GeneralConfiguration_list}
    Should Contain    ${shutter_GeneralConfiguration_list}    === MTCamera_shutter_GeneralConfiguration start of topic ===
    Should Contain    ${shutter_GeneralConfiguration_list}    === MTCamera_shutter_GeneralConfiguration end of topic ===
    ${shutter_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_timersConfiguration start of topic ===
    ${shutter_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_timersConfiguration end of topic ===
    ${shutter_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${shutter_timersConfiguration_start}    end=${shutter_timersConfiguration_end + 1}
    Log Many    ${shutter_timersConfiguration_list}
    Should Contain    ${shutter_timersConfiguration_list}    === MTCamera_shutter_timersConfiguration start of topic ===
    Should Contain    ${shutter_timersConfiguration_list}    === MTCamera_shutter_timersConfiguration end of topic ===
    ${chiller_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_DeviceConfiguration start of topic ===
    ${chiller_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_DeviceConfiguration end of topic ===
    ${chiller_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_DeviceConfiguration_start}    end=${chiller_DeviceConfiguration_end + 1}
    Log Many    ${chiller_DeviceConfiguration_list}
    Should Contain    ${chiller_DeviceConfiguration_list}    === MTCamera_chiller_DeviceConfiguration start of topic ===
    Should Contain    ${chiller_DeviceConfiguration_list}    === MTCamera_chiller_DeviceConfiguration end of topic ===
    ${chiller_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_DevicesConfiguration start of topic ===
    ${chiller_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_DevicesConfiguration end of topic ===
    ${chiller_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_DevicesConfiguration_start}    end=${chiller_DevicesConfiguration_end + 1}
    Log Many    ${chiller_DevicesConfiguration_list}
    Should Contain    ${chiller_DevicesConfiguration_list}    === MTCamera_chiller_DevicesConfiguration start of topic ===
    Should Contain    ${chiller_DevicesConfiguration_list}    === MTCamera_chiller_DevicesConfiguration end of topic ===
    ${chiller_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_GeneralConfiguration start of topic ===
    ${chiller_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_GeneralConfiguration end of topic ===
    ${chiller_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_GeneralConfiguration_start}    end=${chiller_GeneralConfiguration_end + 1}
    Log Many    ${chiller_GeneralConfiguration_list}
    Should Contain    ${chiller_GeneralConfiguration_list}    === MTCamera_chiller_GeneralConfiguration start of topic ===
    Should Contain    ${chiller_GeneralConfiguration_list}    === MTCamera_chiller_GeneralConfiguration end of topic ===
    ${chiller_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_LimitsConfiguration start of topic ===
    ${chiller_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_LimitsConfiguration end of topic ===
    ${chiller_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_LimitsConfiguration_start}    end=${chiller_LimitsConfiguration_end + 1}
    Log Many    ${chiller_LimitsConfiguration_list}
    Should Contain    ${chiller_LimitsConfiguration_list}    === MTCamera_chiller_LimitsConfiguration start of topic ===
    Should Contain    ${chiller_LimitsConfiguration_list}    === MTCamera_chiller_LimitsConfiguration end of topic ===
    ${chiller_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_timersConfiguration start of topic ===
    ${chiller_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_timersConfiguration end of topic ===
    ${chiller_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${chiller_timersConfiguration_start}    end=${chiller_timersConfiguration_end + 1}
    Log Many    ${chiller_timersConfiguration_list}
    Should Contain    ${chiller_timersConfiguration_list}    === MTCamera_chiller_timersConfiguration start of topic ===
    Should Contain    ${chiller_timersConfiguration_list}    === MTCamera_chiller_timersConfiguration end of topic ===
    ${thermal_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_DeviceConfiguration start of topic ===
    ${thermal_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_DeviceConfiguration end of topic ===
    ${thermal_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_DeviceConfiguration_start}    end=${thermal_DeviceConfiguration_end + 1}
    Log Many    ${thermal_DeviceConfiguration_list}
    Should Contain    ${thermal_DeviceConfiguration_list}    === MTCamera_thermal_DeviceConfiguration start of topic ===
    Should Contain    ${thermal_DeviceConfiguration_list}    === MTCamera_thermal_DeviceConfiguration end of topic ===
    ${thermal_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_DevicesConfiguration start of topic ===
    ${thermal_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_DevicesConfiguration end of topic ===
    ${thermal_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_DevicesConfiguration_start}    end=${thermal_DevicesConfiguration_end + 1}
    Log Many    ${thermal_DevicesConfiguration_list}
    Should Contain    ${thermal_DevicesConfiguration_list}    === MTCamera_thermal_DevicesConfiguration start of topic ===
    Should Contain    ${thermal_DevicesConfiguration_list}    === MTCamera_thermal_DevicesConfiguration end of topic ===
    ${thermal_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_GeneralConfiguration start of topic ===
    ${thermal_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_GeneralConfiguration end of topic ===
    ${thermal_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_GeneralConfiguration_start}    end=${thermal_GeneralConfiguration_end + 1}
    Log Many    ${thermal_GeneralConfiguration_list}
    Should Contain    ${thermal_GeneralConfiguration_list}    === MTCamera_thermal_GeneralConfiguration start of topic ===
    Should Contain    ${thermal_GeneralConfiguration_list}    === MTCamera_thermal_GeneralConfiguration end of topic ===
    ${thermal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_LimitsConfiguration start of topic ===
    ${thermal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_LimitsConfiguration end of topic ===
    ${thermal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_LimitsConfiguration_start}    end=${thermal_LimitsConfiguration_end + 1}
    Log Many    ${thermal_LimitsConfiguration_list}
    Should Contain    ${thermal_LimitsConfiguration_list}    === MTCamera_thermal_LimitsConfiguration start of topic ===
    Should Contain    ${thermal_LimitsConfiguration_list}    === MTCamera_thermal_LimitsConfiguration end of topic ===
    ${thermal_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_PicConfiguration start of topic ===
    ${thermal_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_PicConfiguration end of topic ===
    ${thermal_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_PicConfiguration_start}    end=${thermal_PicConfiguration_end + 1}
    Log Many    ${thermal_PicConfiguration_list}
    Should Contain    ${thermal_PicConfiguration_list}    === MTCamera_thermal_PicConfiguration start of topic ===
    Should Contain    ${thermal_PicConfiguration_list}    === MTCamera_thermal_PicConfiguration end of topic ===
    ${thermal_RefrigConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_RefrigConfiguration start of topic ===
    ${thermal_RefrigConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_RefrigConfiguration end of topic ===
    ${thermal_RefrigConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_RefrigConfiguration_start}    end=${thermal_RefrigConfiguration_end + 1}
    Log Many    ${thermal_RefrigConfiguration_list}
    Should Contain    ${thermal_RefrigConfiguration_list}    === MTCamera_thermal_RefrigConfiguration start of topic ===
    Should Contain    ${thermal_RefrigConfiguration_list}    === MTCamera_thermal_RefrigConfiguration end of topic ===
    ${thermal_ThermalLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_ThermalLimitsConfiguration start of topic ===
    ${thermal_ThermalLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_ThermalLimitsConfiguration end of topic ===
    ${thermal_ThermalLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_ThermalLimitsConfiguration_start}    end=${thermal_ThermalLimitsConfiguration_end + 1}
    Log Many    ${thermal_ThermalLimitsConfiguration_list}
    Should Contain    ${thermal_ThermalLimitsConfiguration_list}    === MTCamera_thermal_ThermalLimitsConfiguration start of topic ===
    Should Contain    ${thermal_ThermalLimitsConfiguration_list}    === MTCamera_thermal_ThermalLimitsConfiguration end of topic ===
    ${thermal_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_timersConfiguration start of topic ===
    ${thermal_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_timersConfiguration end of topic ===
    ${thermal_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${thermal_timersConfiguration_start}    end=${thermal_timersConfiguration_end + 1}
    Log Many    ${thermal_timersConfiguration_list}
    Should Contain    ${thermal_timersConfiguration_list}    === MTCamera_thermal_timersConfiguration start of topic ===
    Should Contain    ${thermal_timersConfiguration_list}    === MTCamera_thermal_timersConfiguration end of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration start of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration end of topic ===
    ${utiltrunk_BFR_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BFR_DevicesConfiguration_start}    end=${utiltrunk_BFR_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_BFR_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_BFR_DevicesConfiguration_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_BFR_DevicesConfiguration_list}    === MTCamera_utiltrunk_BFR_DevicesConfiguration end of topic ===
    ${utiltrunk_BFR_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration start of topic ===
    ${utiltrunk_BFR_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration end of topic ===
    ${utiltrunk_BFR_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BFR_UtilConfiguration_start}    end=${utiltrunk_BFR_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_BFR_UtilConfiguration_list}
    Should Contain    ${utiltrunk_BFR_UtilConfiguration_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_BFR_UtilConfiguration_list}    === MTCamera_utiltrunk_BFR_UtilConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BodyMaq20_DeviceConfiguration_start}    end=${utiltrunk_BodyMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_BodyMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_BodyMaq20_DevicesConfiguration_start}    end=${utiltrunk_BodyMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_BodyMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_BodyMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_start}    end=${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_AmbAirtemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AmbAirtemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_AverageTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_AverageTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L1XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L1YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2XMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2XPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2YMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_L2YPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_start}    end=${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_start}    end=${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_CryoMaq20_DeviceConfiguration_start}    end=${utiltrunk_CryoMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_CryoMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_CryoMaq20_DevicesConfiguration_start}    end=${utiltrunk_CryoMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_CryoMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_CryoMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration start of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_MPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPCFan_PicConfiguration_start}    end=${utiltrunk_MPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_MPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_start}    end=${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_start}    end=${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_MPC_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_MPC_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_Humidity_LimitsConfiguration_start}    end=${utiltrunk_MPC_Humidity_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_RetnPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_RetnPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_start}    end=${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_SplyPress_LimitsConfiguration_start}    end=${utiltrunk_MPC_SplyPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_MPC_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_MPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_MPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration start of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration end of topic ===
    ${utiltrunk_PDU_48V_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PDU_48V_DevicesConfiguration_start}    end=${utiltrunk_PDU_48V_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_PDU_48V_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_PDU_48V_DevicesConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_PDU_48V_DevicesConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_DevicesConfiguration end of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration start of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration end of topic ===
    ${utiltrunk_PDU_48V_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PDU_48V_UtilConfiguration_start}    end=${utiltrunk_PDU_48V_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_PDU_48V_UtilConfiguration_list}
    Should Contain    ${utiltrunk_PDU_48V_UtilConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_PDU_48V_UtilConfiguration_list}    === MTCamera_utiltrunk_PDU_48V_UtilConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_CryoMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_start}    end=${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_start}    end=${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UT_state_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UT_state_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration start of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration end of topic ===
    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_start}    end=${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_end + 1}
    Log Many    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}
    Should Contain    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration start of topic ===
    Should Contain    ${utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration_list}    === MTCamera_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration end of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration start of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration end of topic ===
    ${utiltrunk_Pluto_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Pluto_DeviceConfiguration_start}    end=${utiltrunk_Pluto_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_Pluto_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_Pluto_DeviceConfiguration_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_Pluto_DeviceConfiguration_list}    === MTCamera_utiltrunk_Pluto_DeviceConfiguration end of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration start of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration end of topic ===
    ${utiltrunk_Pluto_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Pluto_DevicesConfiguration_start}    end=${utiltrunk_Pluto_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_Pluto_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_Pluto_DevicesConfiguration_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_Pluto_DevicesConfiguration_list}    === MTCamera_utiltrunk_Pluto_DevicesConfiguration end of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration start of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration end of topic ===
    ${utiltrunk_Telescope_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Telescope_DevicesConfiguration_start}    end=${utiltrunk_Telescope_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_Telescope_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_Telescope_DevicesConfiguration_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_Telescope_DevicesConfiguration_list}    === MTCamera_utiltrunk_Telescope_DevicesConfiguration end of topic ===
    ${utiltrunk_UTFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration start of topic ===
    ${utiltrunk_UTFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_UTFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UTFan_PicConfiguration_start}    end=${utiltrunk_UTFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_UTFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_UTFan_PicConfiguration_list}    === MTCamera_utiltrunk_UTFan_PicConfiguration end of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_AverageTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_AverageTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_AverageTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_AverageTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolFlowRate_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolFlowRate_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolReturnPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolReturnPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_start}    end=${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_CoolSupplyPrs_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanInletTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_FanInletTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanInletTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanInletTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_UT_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_UT_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_MidXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_MidXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_TopXMinusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_start}    end=${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_TopXPlusTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_UT_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_start}    end=${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_W2Q1Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W2Q1Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration start of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_start}    end=${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_UT_W4Q3Temp_LimitsConfiguration_list}    === MTCamera_utiltrunk_UT_W4Q3Temp_LimitsConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration start of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtMaq20_DeviceConfiguration_start}    end=${utiltrunk_UtMaq20_DeviceConfiguration_end + 1}
    Log Many    ${utiltrunk_UtMaq20_DeviceConfiguration_list}
    Should Contain    ${utiltrunk_UtMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtMaq20_DeviceConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DeviceConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration start of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_UtMaq20_DevicesConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtMaq20_DevicesConfiguration_start}    end=${utiltrunk_UtMaq20_DevicesConfiguration_end + 1}
    Log Many    ${utiltrunk_UtMaq20_DevicesConfiguration_list}
    Should Contain    ${utiltrunk_UtMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtMaq20_DevicesConfiguration_list}    === MTCamera_utiltrunk_UtMaq20_DevicesConfiguration end of topic ===
    ${utiltrunk_UtilConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtilConfiguration start of topic ===
    ${utiltrunk_UtilConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UtilConfiguration end of topic ===
    ${utiltrunk_UtilConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UtilConfiguration_start}    end=${utiltrunk_UtilConfiguration_end + 1}
    Log Many    ${utiltrunk_UtilConfiguration_list}
    Should Contain    ${utiltrunk_UtilConfiguration_list}    === MTCamera_utiltrunk_UtilConfiguration start of topic ===
    Should Contain    ${utiltrunk_UtilConfiguration_list}    === MTCamera_utiltrunk_UtilConfiguration end of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration start of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_VPCFan_PicConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPCFan_PicConfiguration_start}    end=${utiltrunk_VPCFan_PicConfiguration_end + 1}
    Log Many    ${utiltrunk_VPCFan_PicConfiguration_list}
    Should Contain    ${utiltrunk_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPCFan_PicConfiguration_list}    === MTCamera_utiltrunk_VPCFan_PicConfiguration end of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration start of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration end of topic ===
    ${utiltrunk_VPCHtrs_VpcConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPCHtrs_VpcConfiguration_start}    end=${utiltrunk_VPCHtrs_VpcConfiguration_end + 1}
    Log Many    ${utiltrunk_VPCHtrs_VpcConfiguration_list}
    Should Contain    ${utiltrunk_VPCHtrs_VpcConfiguration_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPCHtrs_VpcConfiguration_list}    === MTCamera_utiltrunk_VPCHtrs_VpcConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_start}    end=${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_DeltaTempAct_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_FanRunTime_LimitsConfiguration_start}    end=${utiltrunk_VPC_FanRunTime_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_FanRunTime_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanRunTime_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_FanSpeed_LimitsConfiguration_start}    end=${utiltrunk_VPC_FanSpeed_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_FanSpeed_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_FanSpeed_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_start}    end=${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_HtrCurrent_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_HtrCurrent_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_Humidity_LimitsConfiguration_start}    end=${utiltrunk_VPC_Humidity_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_Humidity_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_Humidity_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_PreFiltPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_PreFiltPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_start}    end=${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_RetnAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_RetnPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_RetnPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_RetnPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_RetnPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyAirTemp_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyAirVel_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyAirVel_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_SplyPress_LimitsConfiguration_start}    end=${utiltrunk_VPC_SplyPress_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_SplyPress_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_SplyPress_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration start of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration end of topic ===
    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_ValvePosn_LimitsConfiguration_start}    end=${utiltrunk_VPC_ValvePosn_LimitsConfiguration_end + 1}
    Log Many    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}
    Should Contain    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration start of topic ===
    Should Contain    ${utiltrunk_VPC_ValvePosn_LimitsConfiguration_list}    === MTCamera_utiltrunk_VPC_ValvePosn_LimitsConfiguration end of topic ===
    ${summaryStatus_start}=    Get Index From List    ${full_list}    === MTCamera_summaryStatus start of topic ===
    ${summaryStatus_end}=    Get Index From List    ${full_list}    === MTCamera_summaryStatus end of topic ===
    ${summaryStatus_list}=    Get Slice From List    ${full_list}    start=${summaryStatus_start}    end=${summaryStatus_end + 1}
    Log Many    ${summaryStatus_list}
    Should Contain    ${summaryStatus_list}    === MTCamera_summaryStatus start of topic ===
    Should Contain    ${summaryStatus_list}    === MTCamera_summaryStatus end of topic ===
    ${alertRaised_start}=    Get Index From List    ${full_list}    === MTCamera_alertRaised start of topic ===
    ${alertRaised_end}=    Get Index From List    ${full_list}    === MTCamera_alertRaised end of topic ===
    ${alertRaised_list}=    Get Slice From List    ${full_list}    start=${alertRaised_start}    end=${alertRaised_end + 1}
    Log Many    ${alertRaised_list}
    Should Contain    ${alertRaised_list}    === MTCamera_alertRaised start of topic ===
    Should Contain    ${alertRaised_list}    === MTCamera_alertRaised end of topic ===
    ${filterChangerPowerStatus_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerPowerStatus start of topic ===
    ${filterChangerPowerStatus_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerPowerStatus end of topic ===
    ${filterChangerPowerStatus_list}=    Get Slice From List    ${full_list}    start=${filterChangerPowerStatus_start}    end=${filterChangerPowerStatus_end + 1}
    Log Many    ${filterChangerPowerStatus_list}
    Should Contain    ${filterChangerPowerStatus_list}    === MTCamera_filterChangerPowerStatus start of topic ===
    Should Contain    ${filterChangerPowerStatus_list}    === MTCamera_filterChangerPowerStatus end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTCamera_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTCamera_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTCamera_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTCamera_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === MTCamera_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === MTCamera_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === MTCamera_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === MTCamera_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === MTCamera_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === MTCamera_configurationsAvailable end of topic ===
