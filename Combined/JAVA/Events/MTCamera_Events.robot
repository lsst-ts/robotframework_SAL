*** Settings ***
Documentation    MTCamera_Events communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
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
        Exit For Loop If     'MTCamera all loggers ready' in $loggerOutput
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
    ${quadbox_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksConfiguration start of topic ===
    ${quadbox_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksConfiguration end of topic ===
    ${quadbox_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksConfiguration_start}    end=${quadbox_PeriodicTasksConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasksConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasksConfiguration_list}    === MTCamera_quadbox_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasksConfiguration_list}    === MTCamera_quadbox_PeriodicTasksConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
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
    ${rebpowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpowerConfiguration start of topic ===
    ${rebpowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpowerConfiguration end of topic ===
    ${rebpowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpowerConfiguration_start}    end=${rebpowerConfiguration_end + 1}
    Log Many    ${rebpowerConfiguration_list}
    Should Contain    ${rebpowerConfiguration_list}    === MTCamera_rebpowerConfiguration start of topic ===
    Should Contain    ${rebpowerConfiguration_list}    === MTCamera_rebpowerConfiguration end of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration start of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration end of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerConfiguration_start}    end=${rebpower_EmergencyResponseManagerConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManagerConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration end of topic ===
    ${rebpower_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksConfiguration start of topic ===
    ${rebpower_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksConfiguration end of topic ===
    ${rebpower_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksConfiguration_start}    end=${rebpower_PeriodicTasksConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasksConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasksConfiguration_list}    === MTCamera_rebpower_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasksConfiguration_list}    === MTCamera_rebpower_PeriodicTasksConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_RebConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebConfiguration start of topic ===
    ${rebpower_RebConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebConfiguration end of topic ===
    ${rebpower_RebConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebConfiguration_start}    end=${rebpower_RebConfiguration_end + 1}
    Log Many    ${rebpower_RebConfiguration_list}
    Should Contain    ${rebpower_RebConfiguration_list}    === MTCamera_rebpower_RebConfiguration start of topic ===
    Should Contain    ${rebpower_RebConfiguration_list}    === MTCamera_rebpower_RebConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
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
    ${hexConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hexConfiguration start of topic ===
    ${hexConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hexConfiguration end of topic ===
    ${hexConfiguration_list}=    Get Slice From List    ${full_list}    start=${hexConfiguration_start}    end=${hexConfiguration_end + 1}
    Log Many    ${hexConfiguration_list}
    Should Contain    ${hexConfiguration_list}    === MTCamera_hexConfiguration start of topic ===
    Should Contain    ${hexConfiguration_list}    === MTCamera_hexConfiguration end of topic ===
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
    ${hex_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    ${hex_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceConfiguration_start}    end=${hex_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20x_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceConfiguration start of topic ===
    ${hex_Maq20x_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceConfiguration end of topic ===
    ${hex_Maq20x_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20x_DeviceConfiguration_start}    end=${hex_Maq20x_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20x_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20x_DeviceConfiguration_list}    === MTCamera_hex_Maq20x_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20x_DeviceConfiguration_list}    === MTCamera_hex_Maq20x_DeviceConfiguration end of topic ===
    ${hex_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksConfiguration start of topic ===
    ${hex_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksConfiguration end of topic ===
    ${hex_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasksConfiguration_start}    end=${hex_PeriodicTasksConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasksConfiguration_list}
    Should Contain    ${hex_PeriodicTasksConfiguration_list}    === MTCamera_hex_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasksConfiguration_list}    === MTCamera_hex_PeriodicTasksConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    ${hex_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersConfiguration_start}    end=${hex_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration start of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration end of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_CompLimitsConfiguration_start}    end=${refrig_Cold1_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold1_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cold1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration end of topic ===
    ${refrig_Cold1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceConfiguration start of topic ===
    ${refrig_Cold1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceConfiguration end of topic ===
    ${refrig_Cold1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_DeviceConfiguration_start}    end=${refrig_Cold1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cold1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cold1_DeviceConfiguration_list}    === MTCamera_refrig_Cold1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_DeviceConfiguration_list}    === MTCamera_refrig_Cold1_DeviceConfiguration end of topic ===
    ${refrig_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsConfiguration start of topic ===
    ${refrig_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsConfiguration end of topic ===
    ${refrig_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_LimitsConfiguration_start}    end=${refrig_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cold1_LimitsConfiguration_list}    === MTCamera_refrig_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_LimitsConfiguration_list}    === MTCamera_refrig_Cold1_LimitsConfiguration end of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration start of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration end of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_CompLimitsConfiguration_start}    end=${refrig_Cold2_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold2_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cold2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration end of topic ===
    ${refrig_Cold2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceConfiguration start of topic ===
    ${refrig_Cold2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceConfiguration end of topic ===
    ${refrig_Cold2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_DeviceConfiguration_start}    end=${refrig_Cold2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cold2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cold2_DeviceConfiguration_list}    === MTCamera_refrig_Cold2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_DeviceConfiguration_list}    === MTCamera_refrig_Cold2_DeviceConfiguration end of topic ===
    ${refrig_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsConfiguration start of topic ===
    ${refrig_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsConfiguration end of topic ===
    ${refrig_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_LimitsConfiguration_start}    end=${refrig_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cold2_LimitsConfiguration_list}    === MTCamera_refrig_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_LimitsConfiguration_list}    === MTCamera_refrig_Cold2_LimitsConfiguration end of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_CoolMaq20_DeviceConfiguration_start}    end=${refrig_CoolMaq20_DeviceConfiguration_end + 1}
    Log Many    ${refrig_CoolMaq20_DeviceConfiguration_list}
    Should Contain    ${refrig_CoolMaq20_DeviceConfiguration_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceConfiguration_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_CompLimitsConfiguration_start}    end=${refrig_Cryo1_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceConfiguration_start}    end=${refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsConfiguration_start}    end=${refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_CompLimitsConfiguration_start}    end=${refrig_Cryo2_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceConfiguration_start}    end=${refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsConfiguration_start}    end=${refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_CompLimitsConfiguration_start}    end=${refrig_Cryo3_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceConfiguration_start}    end=${refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsConfiguration_start}    end=${refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_CompLimitsConfiguration_start}    end=${refrig_Cryo4_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceConfiguration_start}    end=${refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsConfiguration_start}    end=${refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_CompLimitsConfiguration_start}    end=${refrig_Cryo5_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceConfiguration_start}    end=${refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsConfiguration_start}    end=${refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_CompLimitsConfiguration_start}    end=${refrig_Cryo6_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceConfiguration_start}    end=${refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsConfiguration_start}    end=${refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksConfiguration start of topic ===
    ${refrig_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksConfiguration end of topic ===
    ${refrig_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasksConfiguration_start}    end=${refrig_PeriodicTasksConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasksConfiguration_list}
    Should Contain    ${refrig_PeriodicTasksConfiguration_list}    === MTCamera_refrig_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasksConfiguration_list}    === MTCamera_refrig_PeriodicTasksConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersConfiguration_start}    end=${refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration start of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration end of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_AgentMonitorServiceConfiguration_start}    end=${vacuum_AgentMonitorServiceConfiguration_end + 1}
    Log Many    ${vacuum_AgentMonitorServiceConfiguration_list}
    Should Contain    ${vacuum_AgentMonitorServiceConfiguration_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration start of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceConfiguration_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration end of topic ===
    ${vacuum_CIP1CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CConfiguration start of topic ===
    ${vacuum_CIP1CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CConfiguration end of topic ===
    ${vacuum_CIP1CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1CConfiguration_start}    end=${vacuum_CIP1CConfiguration_end + 1}
    Log Many    ${vacuum_CIP1CConfiguration_list}
    Should Contain    ${vacuum_CIP1CConfiguration_list}    === MTCamera_vacuum_CIP1CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1CConfiguration_list}    === MTCamera_vacuum_CIP1CConfiguration end of topic ===
    ${vacuum_CIP1_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_IConfiguration start of topic ===
    ${vacuum_CIP1_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_IConfiguration end of topic ===
    ${vacuum_CIP1_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_IConfiguration_start}    end=${vacuum_CIP1_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP1_IConfiguration_list}
    Should Contain    ${vacuum_CIP1_IConfiguration_list}    === MTCamera_vacuum_CIP1_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1_IConfiguration_list}    === MTCamera_vacuum_CIP1_IConfiguration end of topic ===
    ${vacuum_CIP1_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VConfiguration start of topic ===
    ${vacuum_CIP1_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VConfiguration end of topic ===
    ${vacuum_CIP1_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_VConfiguration_start}    end=${vacuum_CIP1_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP1_VConfiguration_list}
    Should Contain    ${vacuum_CIP1_VConfiguration_list}    === MTCamera_vacuum_CIP1_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1_VConfiguration_list}    === MTCamera_vacuum_CIP1_VConfiguration end of topic ===
    ${vacuum_CIP2CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CConfiguration start of topic ===
    ${vacuum_CIP2CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CConfiguration end of topic ===
    ${vacuum_CIP2CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2CConfiguration_start}    end=${vacuum_CIP2CConfiguration_end + 1}
    Log Many    ${vacuum_CIP2CConfiguration_list}
    Should Contain    ${vacuum_CIP2CConfiguration_list}    === MTCamera_vacuum_CIP2CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2CConfiguration_list}    === MTCamera_vacuum_CIP2CConfiguration end of topic ===
    ${vacuum_CIP2_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_IConfiguration start of topic ===
    ${vacuum_CIP2_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_IConfiguration end of topic ===
    ${vacuum_CIP2_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_IConfiguration_start}    end=${vacuum_CIP2_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP2_IConfiguration_list}
    Should Contain    ${vacuum_CIP2_IConfiguration_list}    === MTCamera_vacuum_CIP2_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2_IConfiguration_list}    === MTCamera_vacuum_CIP2_IConfiguration end of topic ===
    ${vacuum_CIP2_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VConfiguration start of topic ===
    ${vacuum_CIP2_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VConfiguration end of topic ===
    ${vacuum_CIP2_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_VConfiguration_start}    end=${vacuum_CIP2_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP2_VConfiguration_list}
    Should Contain    ${vacuum_CIP2_VConfiguration_list}    === MTCamera_vacuum_CIP2_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2_VConfiguration_list}    === MTCamera_vacuum_CIP2_VConfiguration end of topic ===
    ${vacuum_CIP3CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CConfiguration start of topic ===
    ${vacuum_CIP3CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CConfiguration end of topic ===
    ${vacuum_CIP3CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3CConfiguration_start}    end=${vacuum_CIP3CConfiguration_end + 1}
    Log Many    ${vacuum_CIP3CConfiguration_list}
    Should Contain    ${vacuum_CIP3CConfiguration_list}    === MTCamera_vacuum_CIP3CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3CConfiguration_list}    === MTCamera_vacuum_CIP3CConfiguration end of topic ===
    ${vacuum_CIP3_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_IConfiguration start of topic ===
    ${vacuum_CIP3_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_IConfiguration end of topic ===
    ${vacuum_CIP3_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_IConfiguration_start}    end=${vacuum_CIP3_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP3_IConfiguration_list}
    Should Contain    ${vacuum_CIP3_IConfiguration_list}    === MTCamera_vacuum_CIP3_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3_IConfiguration_list}    === MTCamera_vacuum_CIP3_IConfiguration end of topic ===
    ${vacuum_CIP3_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VConfiguration start of topic ===
    ${vacuum_CIP3_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VConfiguration end of topic ===
    ${vacuum_CIP3_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_VConfiguration_start}    end=${vacuum_CIP3_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP3_VConfiguration_list}
    Should Contain    ${vacuum_CIP3_VConfiguration_list}    === MTCamera_vacuum_CIP3_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3_VConfiguration_list}    === MTCamera_vacuum_CIP3_VConfiguration end of topic ===
    ${vacuum_CIP4CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CConfiguration start of topic ===
    ${vacuum_CIP4CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CConfiguration end of topic ===
    ${vacuum_CIP4CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4CConfiguration_start}    end=${vacuum_CIP4CConfiguration_end + 1}
    Log Many    ${vacuum_CIP4CConfiguration_list}
    Should Contain    ${vacuum_CIP4CConfiguration_list}    === MTCamera_vacuum_CIP4CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4CConfiguration_list}    === MTCamera_vacuum_CIP4CConfiguration end of topic ===
    ${vacuum_CIP4_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_IConfiguration start of topic ===
    ${vacuum_CIP4_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_IConfiguration end of topic ===
    ${vacuum_CIP4_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_IConfiguration_start}    end=${vacuum_CIP4_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP4_IConfiguration_list}
    Should Contain    ${vacuum_CIP4_IConfiguration_list}    === MTCamera_vacuum_CIP4_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4_IConfiguration_list}    === MTCamera_vacuum_CIP4_IConfiguration end of topic ===
    ${vacuum_CIP4_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VConfiguration start of topic ===
    ${vacuum_CIP4_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VConfiguration end of topic ===
    ${vacuum_CIP4_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_VConfiguration_start}    end=${vacuum_CIP4_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP4_VConfiguration_list}
    Should Contain    ${vacuum_CIP4_VConfiguration_list}    === MTCamera_vacuum_CIP4_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4_VConfiguration_list}    === MTCamera_vacuum_CIP4_VConfiguration end of topic ===
    ${vacuum_CIP5CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CConfiguration start of topic ===
    ${vacuum_CIP5CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CConfiguration end of topic ===
    ${vacuum_CIP5CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5CConfiguration_start}    end=${vacuum_CIP5CConfiguration_end + 1}
    Log Many    ${vacuum_CIP5CConfiguration_list}
    Should Contain    ${vacuum_CIP5CConfiguration_list}    === MTCamera_vacuum_CIP5CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5CConfiguration_list}    === MTCamera_vacuum_CIP5CConfiguration end of topic ===
    ${vacuum_CIP5_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_IConfiguration start of topic ===
    ${vacuum_CIP5_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_IConfiguration end of topic ===
    ${vacuum_CIP5_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_IConfiguration_start}    end=${vacuum_CIP5_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP5_IConfiguration_list}
    Should Contain    ${vacuum_CIP5_IConfiguration_list}    === MTCamera_vacuum_CIP5_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5_IConfiguration_list}    === MTCamera_vacuum_CIP5_IConfiguration end of topic ===
    ${vacuum_CIP5_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VConfiguration start of topic ===
    ${vacuum_CIP5_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VConfiguration end of topic ===
    ${vacuum_CIP5_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_VConfiguration_start}    end=${vacuum_CIP5_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP5_VConfiguration_list}
    Should Contain    ${vacuum_CIP5_VConfiguration_list}    === MTCamera_vacuum_CIP5_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5_VConfiguration_list}    === MTCamera_vacuum_CIP5_VConfiguration end of topic ===
    ${vacuum_CIP6CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CConfiguration start of topic ===
    ${vacuum_CIP6CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CConfiguration end of topic ===
    ${vacuum_CIP6CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6CConfiguration_start}    end=${vacuum_CIP6CConfiguration_end + 1}
    Log Many    ${vacuum_CIP6CConfiguration_list}
    Should Contain    ${vacuum_CIP6CConfiguration_list}    === MTCamera_vacuum_CIP6CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6CConfiguration_list}    === MTCamera_vacuum_CIP6CConfiguration end of topic ===
    ${vacuum_CIP6_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_IConfiguration start of topic ===
    ${vacuum_CIP6_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_IConfiguration end of topic ===
    ${vacuum_CIP6_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_IConfiguration_start}    end=${vacuum_CIP6_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP6_IConfiguration_list}
    Should Contain    ${vacuum_CIP6_IConfiguration_list}    === MTCamera_vacuum_CIP6_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6_IConfiguration_list}    === MTCamera_vacuum_CIP6_IConfiguration end of topic ===
    ${vacuum_CIP6_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VConfiguration start of topic ===
    ${vacuum_CIP6_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VConfiguration end of topic ===
    ${vacuum_CIP6_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_VConfiguration_start}    end=${vacuum_CIP6_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP6_VConfiguration_list}
    Should Contain    ${vacuum_CIP6_VConfiguration_list}    === MTCamera_vacuum_CIP6_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6_VConfiguration_list}    === MTCamera_vacuum_CIP6_VConfiguration end of topic ===
    ${vacuum_CryoVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacConfiguration start of topic ===
    ${vacuum_CryoVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacConfiguration end of topic ===
    ${vacuum_CryoVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacConfiguration_start}    end=${vacuum_CryoVacConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacConfiguration_list}
    Should Contain    ${vacuum_CryoVacConfiguration_list}    === MTCamera_vacuum_CryoVacConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacConfiguration_list}    === MTCamera_vacuum_CryoVacConfiguration end of topic ===
    ${vacuum_CryoVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration start of topic ===
    ${vacuum_CryoVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration end of topic ===
    ${vacuum_CryoVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGaugeConfiguration_start}    end=${vacuum_CryoVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGaugeConfiguration_list}
    Should Contain    ${vacuum_CryoVacGaugeConfiguration_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGaugeConfiguration_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration end of topic ===
    ${vacuum_ForelineVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacConfiguration start of topic ===
    ${vacuum_ForelineVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacConfiguration end of topic ===
    ${vacuum_ForelineVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacConfiguration_start}    end=${vacuum_ForelineVacConfiguration_end + 1}
    Log Many    ${vacuum_ForelineVacConfiguration_list}
    Should Contain    ${vacuum_ForelineVacConfiguration_list}    === MTCamera_vacuum_ForelineVacConfiguration start of topic ===
    Should Contain    ${vacuum_ForelineVacConfiguration_list}    === MTCamera_vacuum_ForelineVacConfiguration end of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration start of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration end of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacGaugeConfiguration_start}    end=${vacuum_ForelineVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_ForelineVacGaugeConfiguration_list}
    Should Contain    ${vacuum_ForelineVacGaugeConfiguration_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeConfiguration_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration end of topic ===
    ${vacuum_HeartbeatConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatConfiguration start of topic ===
    ${vacuum_HeartbeatConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatConfiguration end of topic ===
    ${vacuum_HeartbeatConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HeartbeatConfiguration_start}    end=${vacuum_HeartbeatConfiguration_end + 1}
    Log Many    ${vacuum_HeartbeatConfiguration_list}
    Should Contain    ${vacuum_HeartbeatConfiguration_list}    === MTCamera_vacuum_HeartbeatConfiguration start of topic ===
    Should Contain    ${vacuum_HeartbeatConfiguration_list}    === MTCamera_vacuum_HeartbeatConfiguration end of topic ===
    ${vacuum_Hex1VacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacConfiguration start of topic ===
    ${vacuum_Hex1VacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacConfiguration end of topic ===
    ${vacuum_Hex1VacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacConfiguration_start}    end=${vacuum_Hex1VacConfiguration_end + 1}
    Log Many    ${vacuum_Hex1VacConfiguration_list}
    Should Contain    ${vacuum_Hex1VacConfiguration_list}    === MTCamera_vacuum_Hex1VacConfiguration start of topic ===
    Should Contain    ${vacuum_Hex1VacConfiguration_list}    === MTCamera_vacuum_Hex1VacConfiguration end of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration start of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration end of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacGaugeConfiguration_start}    end=${vacuum_Hex1VacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_Hex1VacGaugeConfiguration_list}
    Should Contain    ${vacuum_Hex1VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration end of topic ===
    ${vacuum_Hex2VacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacConfiguration start of topic ===
    ${vacuum_Hex2VacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacConfiguration end of topic ===
    ${vacuum_Hex2VacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacConfiguration_start}    end=${vacuum_Hex2VacConfiguration_end + 1}
    Log Many    ${vacuum_Hex2VacConfiguration_list}
    Should Contain    ${vacuum_Hex2VacConfiguration_list}    === MTCamera_vacuum_Hex2VacConfiguration start of topic ===
    Should Contain    ${vacuum_Hex2VacConfiguration_list}    === MTCamera_vacuum_Hex2VacConfiguration end of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration start of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration end of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacGaugeConfiguration_start}    end=${vacuum_Hex2VacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_Hex2VacGaugeConfiguration_list}
    Should Contain    ${vacuum_Hex2VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration end of topic ===
    ${vacuum_IonPumpsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsConfiguration start of topic ===
    ${vacuum_IonPumpsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsConfiguration end of topic ===
    ${vacuum_IonPumpsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumpsConfiguration_start}    end=${vacuum_IonPumpsConfiguration_end + 1}
    Log Many    ${vacuum_IonPumpsConfiguration_list}
    Should Contain    ${vacuum_IonPumpsConfiguration_list}    === MTCamera_vacuum_IonPumpsConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumpsConfiguration_list}    === MTCamera_vacuum_IonPumpsConfiguration end of topic ===
    ${vacuum_Monitor_checkConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkConfiguration start of topic ===
    ${vacuum_Monitor_checkConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkConfiguration end of topic ===
    ${vacuum_Monitor_checkConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_checkConfiguration_start}    end=${vacuum_Monitor_checkConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_checkConfiguration_list}
    Should Contain    ${vacuum_Monitor_checkConfiguration_list}    === MTCamera_vacuum_Monitor_checkConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_checkConfiguration_list}    === MTCamera_vacuum_Monitor_checkConfiguration end of topic ===
    ${vacuum_Monitor_publishConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishConfiguration start of topic ===
    ${vacuum_Monitor_publishConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishConfiguration end of topic ===
    ${vacuum_Monitor_publishConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_publishConfiguration_start}    end=${vacuum_Monitor_publishConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_publishConfiguration_list}
    Should Contain    ${vacuum_Monitor_publishConfiguration_list}    === MTCamera_vacuum_Monitor_publishConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_publishConfiguration_list}    === MTCamera_vacuum_Monitor_publishConfiguration end of topic ===
    ${vacuum_Monitor_updateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateConfiguration start of topic ===
    ${vacuum_Monitor_updateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateConfiguration end of topic ===
    ${vacuum_Monitor_updateConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_updateConfiguration_start}    end=${vacuum_Monitor_updateConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_updateConfiguration_list}
    Should Contain    ${vacuum_Monitor_updateConfiguration_list}    === MTCamera_vacuum_Monitor_updateConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_updateConfiguration_list}    === MTCamera_vacuum_Monitor_updateConfiguration end of topic ===
    ${vacuum_RuntimeInfoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoConfiguration start of topic ===
    ${vacuum_RuntimeInfoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoConfiguration end of topic ===
    ${vacuum_RuntimeInfoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_RuntimeInfoConfiguration_start}    end=${vacuum_RuntimeInfoConfiguration_end + 1}
    Log Many    ${vacuum_RuntimeInfoConfiguration_list}
    Should Contain    ${vacuum_RuntimeInfoConfiguration_list}    === MTCamera_vacuum_RuntimeInfoConfiguration start of topic ===
    Should Contain    ${vacuum_RuntimeInfoConfiguration_list}    === MTCamera_vacuum_RuntimeInfoConfiguration end of topic ===
    ${vacuum_SchedulersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersConfiguration start of topic ===
    ${vacuum_SchedulersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersConfiguration end of topic ===
    ${vacuum_SchedulersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_SchedulersConfiguration_start}    end=${vacuum_SchedulersConfiguration_end + 1}
    Log Many    ${vacuum_SchedulersConfiguration_list}
    Should Contain    ${vacuum_SchedulersConfiguration_list}    === MTCamera_vacuum_SchedulersConfiguration start of topic ===
    Should Contain    ${vacuum_SchedulersConfiguration_list}    === MTCamera_vacuum_SchedulersConfiguration end of topic ===
    ${vacuum_TurboCurrentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentConfiguration start of topic ===
    ${vacuum_TurboCurrentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentConfiguration end of topic ===
    ${vacuum_TurboCurrentConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrentConfiguration_start}    end=${vacuum_TurboCurrentConfiguration_end + 1}
    Log Many    ${vacuum_TurboCurrentConfiguration_list}
    Should Contain    ${vacuum_TurboCurrentConfiguration_list}    === MTCamera_vacuum_TurboCurrentConfiguration start of topic ===
    Should Contain    ${vacuum_TurboCurrentConfiguration_list}    === MTCamera_vacuum_TurboCurrentConfiguration end of topic ===
    ${vacuum_TurboPowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerConfiguration start of topic ===
    ${vacuum_TurboPowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerConfiguration end of topic ===
    ${vacuum_TurboPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPowerConfiguration_start}    end=${vacuum_TurboPowerConfiguration_end + 1}
    Log Many    ${vacuum_TurboPowerConfiguration_list}
    Should Contain    ${vacuum_TurboPowerConfiguration_list}    === MTCamera_vacuum_TurboPowerConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPowerConfiguration_list}    === MTCamera_vacuum_TurboPowerConfiguration end of topic ===
    ${vacuum_TurboPumpConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpConfiguration start of topic ===
    ${vacuum_TurboPumpConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpConfiguration end of topic ===
    ${vacuum_TurboPumpConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpConfiguration_start}    end=${vacuum_TurboPumpConfiguration_end + 1}
    Log Many    ${vacuum_TurboPumpConfiguration_list}
    Should Contain    ${vacuum_TurboPumpConfiguration_list}    === MTCamera_vacuum_TurboPumpConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPumpConfiguration_list}    === MTCamera_vacuum_TurboPumpConfiguration end of topic ===
    ${vacuum_TurboPumpTempConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempConfiguration start of topic ===
    ${vacuum_TurboPumpTempConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempConfiguration end of topic ===
    ${vacuum_TurboPumpTempConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTempConfiguration_start}    end=${vacuum_TurboPumpTempConfiguration_end + 1}
    Log Many    ${vacuum_TurboPumpTempConfiguration_list}
    Should Contain    ${vacuum_TurboPumpTempConfiguration_list}    === MTCamera_vacuum_TurboPumpTempConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPumpTempConfiguration_list}    === MTCamera_vacuum_TurboPumpTempConfiguration end of topic ===
    ${vacuum_TurboSpeedConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedConfiguration start of topic ===
    ${vacuum_TurboSpeedConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedConfiguration end of topic ===
    ${vacuum_TurboSpeedConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeedConfiguration_start}    end=${vacuum_TurboSpeedConfiguration_end + 1}
    Log Many    ${vacuum_TurboSpeedConfiguration_list}
    Should Contain    ${vacuum_TurboSpeedConfiguration_list}    === MTCamera_vacuum_TurboSpeedConfiguration start of topic ===
    Should Contain    ${vacuum_TurboSpeedConfiguration_list}    === MTCamera_vacuum_TurboSpeedConfiguration end of topic ===
    ${vacuum_TurboVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacConfiguration start of topic ===
    ${vacuum_TurboVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacConfiguration end of topic ===
    ${vacuum_TurboVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacConfiguration_start}    end=${vacuum_TurboVacConfiguration_end + 1}
    Log Many    ${vacuum_TurboVacConfiguration_list}
    Should Contain    ${vacuum_TurboVacConfiguration_list}    === MTCamera_vacuum_TurboVacConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVacConfiguration_list}    === MTCamera_vacuum_TurboVacConfiguration end of topic ===
    ${vacuum_TurboVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration start of topic ===
    ${vacuum_TurboVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration end of topic ===
    ${vacuum_TurboVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacGaugeConfiguration_start}    end=${vacuum_TurboVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_TurboVacGaugeConfiguration_list}
    Should Contain    ${vacuum_TurboVacGaugeConfiguration_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVacGaugeConfiguration_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration end of topic ===
    ${vacuum_TurboVoltageConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageConfiguration start of topic ===
    ${vacuum_TurboVoltageConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageConfiguration end of topic ===
    ${vacuum_TurboVoltageConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltageConfiguration_start}    end=${vacuum_TurboVoltageConfiguration_end + 1}
    Log Many    ${vacuum_TurboVoltageConfiguration_list}
    Should Contain    ${vacuum_TurboVoltageConfiguration_list}    === MTCamera_vacuum_TurboVoltageConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVoltageConfiguration_list}    === MTCamera_vacuum_TurboVoltageConfiguration end of topic ===
    ${vacuum_VacPlutoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoConfiguration start of topic ===
    ${vacuum_VacPlutoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoConfiguration end of topic ===
    ${vacuum_VacPlutoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPlutoConfiguration_start}    end=${vacuum_VacPlutoConfiguration_end + 1}
    Log Many    ${vacuum_VacPlutoConfiguration_list}
    Should Contain    ${vacuum_VacPlutoConfiguration_list}    === MTCamera_vacuum_VacPlutoConfiguration start of topic ===
    Should Contain    ${vacuum_VacPlutoConfiguration_list}    === MTCamera_vacuum_VacPlutoConfiguration end of topic ===
    ${vacuum_Vacuum_stateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateConfiguration start of topic ===
    ${vacuum_Vacuum_stateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateConfiguration end of topic ===
    ${vacuum_Vacuum_stateConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Vacuum_stateConfiguration_start}    end=${vacuum_Vacuum_stateConfiguration_end + 1}
    Log Many    ${vacuum_Vacuum_stateConfiguration_list}
    Should Contain    ${vacuum_Vacuum_stateConfiguration_list}    === MTCamera_vacuum_Vacuum_stateConfiguration start of topic ===
    Should Contain    ${vacuum_Vacuum_stateConfiguration_list}    === MTCamera_vacuum_Vacuum_stateConfiguration end of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration start of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration end of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksConfiguration_start}    end=${daq_monitor_PeriodicTasksConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasksConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration end of topic ===
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
    ${daq_monitor_Stats_buildConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildConfiguration start of topic ===
    ${daq_monitor_Stats_buildConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildConfiguration end of topic ===
    ${daq_monitor_Stats_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildConfiguration_start}    end=${daq_monitor_Stats_buildConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_buildConfiguration_list}
    Should Contain    ${daq_monitor_Stats_buildConfiguration_list}    === MTCamera_daq_monitor_Stats_buildConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_buildConfiguration_list}    === MTCamera_daq_monitor_Stats_buildConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
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
    ${focal_plane_Ccd_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration start of topic ===
    ${focal_plane_Ccd_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration end of topic ===
    ${focal_plane_Ccd_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsConfiguration_start}    end=${focal_plane_Ccd_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_RaftsConfiguration_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsConfiguration_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration start of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration end of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceConfiguration_start}    end=${focal_plane_ImageDatabaseServiceConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration end of topic ===
    ${focal_plane_ImageNameServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration start of topic ===
    ${focal_plane_ImageNameServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration end of topic ===
    ${focal_plane_ImageNameServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceConfiguration_start}    end=${focal_plane_ImageNameServiceConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameServiceConfiguration_list}
    Should Contain    ${focal_plane_ImageNameServiceConfiguration_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceConfiguration_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration start of topic ===
    ${focal_plane_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration end of topic ===
    ${focal_plane_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksConfiguration_start}    end=${focal_plane_PeriodicTasksConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasksConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasksConfiguration_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksConfiguration_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration end of topic ===
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
    ${image_handling_Reb_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration start of topic ===
    ${image_handling_Reb_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration end of topic ===
    ${image_handling_Reb_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_Reb_FitsHandlingConfiguration_start}    end=${image_handling_Reb_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_Reb_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_Reb_FitsHandlingConfiguration_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_Reb_FitsHandlingConfiguration_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration end of topic ===
    ${image_handling_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_GeneralConfiguration start of topic ===
    ${image_handling_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_GeneralConfiguration end of topic ===
    ${image_handling_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_Reb_GeneralConfiguration_start}    end=${image_handling_Reb_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_Reb_GeneralConfiguration_list}
    Should Contain    ${image_handling_Reb_GeneralConfiguration_list}    === MTCamera_image_handling_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_Reb_GeneralConfiguration_list}    === MTCamera_image_handling_Reb_GeneralConfiguration end of topic ===
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
    ${authList_start}=    Get Index From List    ${full_list}    === MTCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTCamera_authList start of topic ===
    Should Contain    ${authList_list}    === MTCamera_authList end of topic ===
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

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
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
    ${quadbox_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksConfiguration start of topic ===
    ${quadbox_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksConfiguration end of topic ===
    ${quadbox_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksConfiguration_start}    end=${quadbox_PeriodicTasksConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasksConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasksConfiguration_list}    === MTCamera_quadbox_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasksConfiguration_list}    === MTCamera_quadbox_PeriodicTasksConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
    ${quadbox_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersConfiguration_start}    end=${quadbox_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersConfiguration_list}    === MTCamera_quadbox_PeriodicTasks_timersConfiguration end of topic ===
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
    ${rebpowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpowerConfiguration start of topic ===
    ${rebpowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpowerConfiguration end of topic ===
    ${rebpowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpowerConfiguration_start}    end=${rebpowerConfiguration_end + 1}
    Log Many    ${rebpowerConfiguration_list}
    Should Contain    ${rebpowerConfiguration_list}    === MTCamera_rebpowerConfiguration start of topic ===
    Should Contain    ${rebpowerConfiguration_list}    === MTCamera_rebpowerConfiguration end of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration start of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration end of topic ===
    ${rebpower_EmergencyResponseManagerConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerConfiguration_start}    end=${rebpower_EmergencyResponseManagerConfiguration_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerConfiguration_list}
    Should Contain    ${rebpower_EmergencyResponseManagerConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerConfiguration_list}    === MTCamera_rebpower_EmergencyResponseManagerConfiguration end of topic ===
    ${rebpower_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksConfiguration start of topic ===
    ${rebpower_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksConfiguration end of topic ===
    ${rebpower_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksConfiguration_start}    end=${rebpower_PeriodicTasksConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasksConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasksConfiguration_list}    === MTCamera_rebpower_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasksConfiguration_list}    === MTCamera_rebpower_PeriodicTasksConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersConfiguration_start}    end=${rebpower_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersConfiguration_list}    === MTCamera_rebpower_PeriodicTasks_timersConfiguration end of topic ===
    ${rebpower_RebConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebConfiguration start of topic ===
    ${rebpower_RebConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebConfiguration end of topic ===
    ${rebpower_RebConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebConfiguration_start}    end=${rebpower_RebConfiguration_end + 1}
    Log Many    ${rebpower_RebConfiguration_list}
    Should Contain    ${rebpower_RebConfiguration_list}    === MTCamera_rebpower_RebConfiguration start of topic ===
    Should Contain    ${rebpower_RebConfiguration_list}    === MTCamera_rebpower_RebConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    ${rebpower_Reb_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
    ${rebpower_Reb_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsConfiguration_start}    end=${rebpower_Reb_LimitsConfiguration_end + 1}
    Log Many    ${rebpower_Reb_LimitsConfiguration_list}
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration start of topic ===
    Should Contain    ${rebpower_Reb_LimitsConfiguration_list}    === MTCamera_rebpower_Reb_LimitsConfiguration end of topic ===
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
    ${hexConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hexConfiguration start of topic ===
    ${hexConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hexConfiguration end of topic ===
    ${hexConfiguration_list}=    Get Slice From List    ${full_list}    start=${hexConfiguration_start}    end=${hexConfiguration_end + 1}
    Log Many    ${hexConfiguration_list}
    Should Contain    ${hexConfiguration_list}    === MTCamera_hexConfiguration start of topic ===
    Should Contain    ${hexConfiguration_list}    === MTCamera_hexConfiguration end of topic ===
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
    ${hex_Maq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    ${hex_Maq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceConfiguration_start}    end=${hex_Maq20_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20_DeviceConfiguration_list}    === MTCamera_hex_Maq20_DeviceConfiguration end of topic ===
    ${hex_Maq20x_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceConfiguration start of topic ===
    ${hex_Maq20x_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceConfiguration end of topic ===
    ${hex_Maq20x_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20x_DeviceConfiguration_start}    end=${hex_Maq20x_DeviceConfiguration_end + 1}
    Log Many    ${hex_Maq20x_DeviceConfiguration_list}
    Should Contain    ${hex_Maq20x_DeviceConfiguration_list}    === MTCamera_hex_Maq20x_DeviceConfiguration start of topic ===
    Should Contain    ${hex_Maq20x_DeviceConfiguration_list}    === MTCamera_hex_Maq20x_DeviceConfiguration end of topic ===
    ${hex_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksConfiguration start of topic ===
    ${hex_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksConfiguration end of topic ===
    ${hex_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasksConfiguration_start}    end=${hex_PeriodicTasksConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasksConfiguration_list}
    Should Contain    ${hex_PeriodicTasksConfiguration_list}    === MTCamera_hex_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasksConfiguration_list}    === MTCamera_hex_PeriodicTasksConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    ${hex_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${hex_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersConfiguration_start}    end=${hex_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${hex_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersConfiguration_list}    === MTCamera_hex_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration start of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration end of topic ===
    ${refrig_Cold1_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_CompLimitsConfiguration_start}    end=${refrig_Cold1_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold1_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cold1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold1_CompLimitsConfiguration end of topic ===
    ${refrig_Cold1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceConfiguration start of topic ===
    ${refrig_Cold1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceConfiguration end of topic ===
    ${refrig_Cold1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_DeviceConfiguration_start}    end=${refrig_Cold1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cold1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cold1_DeviceConfiguration_list}    === MTCamera_refrig_Cold1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_DeviceConfiguration_list}    === MTCamera_refrig_Cold1_DeviceConfiguration end of topic ===
    ${refrig_Cold1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsConfiguration start of topic ===
    ${refrig_Cold1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsConfiguration end of topic ===
    ${refrig_Cold1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_LimitsConfiguration_start}    end=${refrig_Cold1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cold1_LimitsConfiguration_list}    === MTCamera_refrig_Cold1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold1_LimitsConfiguration_list}    === MTCamera_refrig_Cold1_LimitsConfiguration end of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration start of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration end of topic ===
    ${refrig_Cold2_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_CompLimitsConfiguration_start}    end=${refrig_Cold2_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold2_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cold2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cold2_CompLimitsConfiguration end of topic ===
    ${refrig_Cold2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceConfiguration start of topic ===
    ${refrig_Cold2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceConfiguration end of topic ===
    ${refrig_Cold2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_DeviceConfiguration_start}    end=${refrig_Cold2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cold2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cold2_DeviceConfiguration_list}    === MTCamera_refrig_Cold2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_DeviceConfiguration_list}    === MTCamera_refrig_Cold2_DeviceConfiguration end of topic ===
    ${refrig_Cold2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsConfiguration start of topic ===
    ${refrig_Cold2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsConfiguration end of topic ===
    ${refrig_Cold2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_LimitsConfiguration_start}    end=${refrig_Cold2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cold2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cold2_LimitsConfiguration_list}    === MTCamera_refrig_Cold2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cold2_LimitsConfiguration_list}    === MTCamera_refrig_Cold2_LimitsConfiguration end of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${refrig_CoolMaq20_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_CoolMaq20_DeviceConfiguration_start}    end=${refrig_CoolMaq20_DeviceConfiguration_end + 1}
    Log Many    ${refrig_CoolMaq20_DeviceConfiguration_list}
    Should Contain    ${refrig_CoolMaq20_DeviceConfiguration_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceConfiguration_list}    === MTCamera_refrig_CoolMaq20_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo1_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_CompLimitsConfiguration_start}    end=${refrig_Cryo1_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo1_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    ${refrig_Cryo1_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceConfiguration_start}    end=${refrig_Cryo1_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceConfiguration_list}    === MTCamera_refrig_Cryo1_DeviceConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    ${refrig_Cryo1_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo1_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsConfiguration_start}    end=${refrig_Cryo1_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo1_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsConfiguration_list}    === MTCamera_refrig_Cryo1_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo2_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_CompLimitsConfiguration_start}    end=${refrig_Cryo2_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo2_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    ${refrig_Cryo2_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceConfiguration_start}    end=${refrig_Cryo2_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceConfiguration_list}    === MTCamera_refrig_Cryo2_DeviceConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    ${refrig_Cryo2_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo2_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsConfiguration_start}    end=${refrig_Cryo2_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo2_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsConfiguration_list}    === MTCamera_refrig_Cryo2_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo3_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_CompLimitsConfiguration_start}    end=${refrig_Cryo3_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo3_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    ${refrig_Cryo3_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceConfiguration_start}    end=${refrig_Cryo3_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceConfiguration_list}    === MTCamera_refrig_Cryo3_DeviceConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    ${refrig_Cryo3_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo3_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsConfiguration_start}    end=${refrig_Cryo3_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo3_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsConfiguration_list}    === MTCamera_refrig_Cryo3_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo4_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_CompLimitsConfiguration_start}    end=${refrig_Cryo4_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo4_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    ${refrig_Cryo4_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceConfiguration_start}    end=${refrig_Cryo4_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceConfiguration_list}    === MTCamera_refrig_Cryo4_DeviceConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    ${refrig_Cryo4_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo4_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsConfiguration_start}    end=${refrig_Cryo4_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo4_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsConfiguration_list}    === MTCamera_refrig_Cryo4_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo5_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_CompLimitsConfiguration_start}    end=${refrig_Cryo5_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo5_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    ${refrig_Cryo5_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceConfiguration_start}    end=${refrig_Cryo5_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceConfiguration_list}    === MTCamera_refrig_Cryo5_DeviceConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    ${refrig_Cryo5_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo5_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsConfiguration_start}    end=${refrig_Cryo5_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo5_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsConfiguration_list}    === MTCamera_refrig_Cryo5_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration start of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo6_CompLimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_CompLimitsConfiguration_start}    end=${refrig_Cryo6_CompLimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_CompLimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsConfiguration_list}    === MTCamera_refrig_Cryo6_CompLimitsConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    ${refrig_Cryo6_DeviceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_DeviceConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceConfiguration_start}    end=${refrig_Cryo6_DeviceConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_DeviceConfiguration_list}
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceConfiguration_list}    === MTCamera_refrig_Cryo6_DeviceConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    ${refrig_Cryo6_LimitsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_Cryo6_LimitsConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsConfiguration_start}    end=${refrig_Cryo6_LimitsConfiguration_end + 1}
    Log Many    ${refrig_Cryo6_LimitsConfiguration_list}
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsConfiguration_list}    === MTCamera_refrig_Cryo6_LimitsConfiguration end of topic ===
    ${refrig_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksConfiguration start of topic ===
    ${refrig_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksConfiguration end of topic ===
    ${refrig_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasksConfiguration_start}    end=${refrig_PeriodicTasksConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasksConfiguration_list}
    Should Contain    ${refrig_PeriodicTasksConfiguration_list}    === MTCamera_refrig_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasksConfiguration_list}    === MTCamera_refrig_PeriodicTasksConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${refrig_PeriodicTasks_timersConfiguration_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersConfiguration_start}    end=${refrig_PeriodicTasks_timersConfiguration_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersConfiguration_list}
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersConfiguration_list}    === MTCamera_refrig_PeriodicTasks_timersConfiguration end of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration start of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration end of topic ===
    ${vacuum_AgentMonitorServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_AgentMonitorServiceConfiguration_start}    end=${vacuum_AgentMonitorServiceConfiguration_end + 1}
    Log Many    ${vacuum_AgentMonitorServiceConfiguration_list}
    Should Contain    ${vacuum_AgentMonitorServiceConfiguration_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration start of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceConfiguration_list}    === MTCamera_vacuum_AgentMonitorServiceConfiguration end of topic ===
    ${vacuum_CIP1CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CConfiguration start of topic ===
    ${vacuum_CIP1CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CConfiguration end of topic ===
    ${vacuum_CIP1CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1CConfiguration_start}    end=${vacuum_CIP1CConfiguration_end + 1}
    Log Many    ${vacuum_CIP1CConfiguration_list}
    Should Contain    ${vacuum_CIP1CConfiguration_list}    === MTCamera_vacuum_CIP1CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1CConfiguration_list}    === MTCamera_vacuum_CIP1CConfiguration end of topic ===
    ${vacuum_CIP1_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_IConfiguration start of topic ===
    ${vacuum_CIP1_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_IConfiguration end of topic ===
    ${vacuum_CIP1_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_IConfiguration_start}    end=${vacuum_CIP1_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP1_IConfiguration_list}
    Should Contain    ${vacuum_CIP1_IConfiguration_list}    === MTCamera_vacuum_CIP1_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1_IConfiguration_list}    === MTCamera_vacuum_CIP1_IConfiguration end of topic ===
    ${vacuum_CIP1_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VConfiguration start of topic ===
    ${vacuum_CIP1_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VConfiguration end of topic ===
    ${vacuum_CIP1_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_VConfiguration_start}    end=${vacuum_CIP1_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP1_VConfiguration_list}
    Should Contain    ${vacuum_CIP1_VConfiguration_list}    === MTCamera_vacuum_CIP1_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP1_VConfiguration_list}    === MTCamera_vacuum_CIP1_VConfiguration end of topic ===
    ${vacuum_CIP2CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CConfiguration start of topic ===
    ${vacuum_CIP2CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CConfiguration end of topic ===
    ${vacuum_CIP2CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2CConfiguration_start}    end=${vacuum_CIP2CConfiguration_end + 1}
    Log Many    ${vacuum_CIP2CConfiguration_list}
    Should Contain    ${vacuum_CIP2CConfiguration_list}    === MTCamera_vacuum_CIP2CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2CConfiguration_list}    === MTCamera_vacuum_CIP2CConfiguration end of topic ===
    ${vacuum_CIP2_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_IConfiguration start of topic ===
    ${vacuum_CIP2_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_IConfiguration end of topic ===
    ${vacuum_CIP2_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_IConfiguration_start}    end=${vacuum_CIP2_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP2_IConfiguration_list}
    Should Contain    ${vacuum_CIP2_IConfiguration_list}    === MTCamera_vacuum_CIP2_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2_IConfiguration_list}    === MTCamera_vacuum_CIP2_IConfiguration end of topic ===
    ${vacuum_CIP2_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VConfiguration start of topic ===
    ${vacuum_CIP2_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VConfiguration end of topic ===
    ${vacuum_CIP2_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_VConfiguration_start}    end=${vacuum_CIP2_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP2_VConfiguration_list}
    Should Contain    ${vacuum_CIP2_VConfiguration_list}    === MTCamera_vacuum_CIP2_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP2_VConfiguration_list}    === MTCamera_vacuum_CIP2_VConfiguration end of topic ===
    ${vacuum_CIP3CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CConfiguration start of topic ===
    ${vacuum_CIP3CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CConfiguration end of topic ===
    ${vacuum_CIP3CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3CConfiguration_start}    end=${vacuum_CIP3CConfiguration_end + 1}
    Log Many    ${vacuum_CIP3CConfiguration_list}
    Should Contain    ${vacuum_CIP3CConfiguration_list}    === MTCamera_vacuum_CIP3CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3CConfiguration_list}    === MTCamera_vacuum_CIP3CConfiguration end of topic ===
    ${vacuum_CIP3_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_IConfiguration start of topic ===
    ${vacuum_CIP3_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_IConfiguration end of topic ===
    ${vacuum_CIP3_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_IConfiguration_start}    end=${vacuum_CIP3_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP3_IConfiguration_list}
    Should Contain    ${vacuum_CIP3_IConfiguration_list}    === MTCamera_vacuum_CIP3_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3_IConfiguration_list}    === MTCamera_vacuum_CIP3_IConfiguration end of topic ===
    ${vacuum_CIP3_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VConfiguration start of topic ===
    ${vacuum_CIP3_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VConfiguration end of topic ===
    ${vacuum_CIP3_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_VConfiguration_start}    end=${vacuum_CIP3_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP3_VConfiguration_list}
    Should Contain    ${vacuum_CIP3_VConfiguration_list}    === MTCamera_vacuum_CIP3_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP3_VConfiguration_list}    === MTCamera_vacuum_CIP3_VConfiguration end of topic ===
    ${vacuum_CIP4CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CConfiguration start of topic ===
    ${vacuum_CIP4CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CConfiguration end of topic ===
    ${vacuum_CIP4CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4CConfiguration_start}    end=${vacuum_CIP4CConfiguration_end + 1}
    Log Many    ${vacuum_CIP4CConfiguration_list}
    Should Contain    ${vacuum_CIP4CConfiguration_list}    === MTCamera_vacuum_CIP4CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4CConfiguration_list}    === MTCamera_vacuum_CIP4CConfiguration end of topic ===
    ${vacuum_CIP4_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_IConfiguration start of topic ===
    ${vacuum_CIP4_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_IConfiguration end of topic ===
    ${vacuum_CIP4_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_IConfiguration_start}    end=${vacuum_CIP4_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP4_IConfiguration_list}
    Should Contain    ${vacuum_CIP4_IConfiguration_list}    === MTCamera_vacuum_CIP4_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4_IConfiguration_list}    === MTCamera_vacuum_CIP4_IConfiguration end of topic ===
    ${vacuum_CIP4_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VConfiguration start of topic ===
    ${vacuum_CIP4_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VConfiguration end of topic ===
    ${vacuum_CIP4_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_VConfiguration_start}    end=${vacuum_CIP4_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP4_VConfiguration_list}
    Should Contain    ${vacuum_CIP4_VConfiguration_list}    === MTCamera_vacuum_CIP4_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP4_VConfiguration_list}    === MTCamera_vacuum_CIP4_VConfiguration end of topic ===
    ${vacuum_CIP5CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CConfiguration start of topic ===
    ${vacuum_CIP5CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CConfiguration end of topic ===
    ${vacuum_CIP5CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5CConfiguration_start}    end=${vacuum_CIP5CConfiguration_end + 1}
    Log Many    ${vacuum_CIP5CConfiguration_list}
    Should Contain    ${vacuum_CIP5CConfiguration_list}    === MTCamera_vacuum_CIP5CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5CConfiguration_list}    === MTCamera_vacuum_CIP5CConfiguration end of topic ===
    ${vacuum_CIP5_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_IConfiguration start of topic ===
    ${vacuum_CIP5_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_IConfiguration end of topic ===
    ${vacuum_CIP5_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_IConfiguration_start}    end=${vacuum_CIP5_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP5_IConfiguration_list}
    Should Contain    ${vacuum_CIP5_IConfiguration_list}    === MTCamera_vacuum_CIP5_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5_IConfiguration_list}    === MTCamera_vacuum_CIP5_IConfiguration end of topic ===
    ${vacuum_CIP5_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VConfiguration start of topic ===
    ${vacuum_CIP5_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VConfiguration end of topic ===
    ${vacuum_CIP5_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_VConfiguration_start}    end=${vacuum_CIP5_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP5_VConfiguration_list}
    Should Contain    ${vacuum_CIP5_VConfiguration_list}    === MTCamera_vacuum_CIP5_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP5_VConfiguration_list}    === MTCamera_vacuum_CIP5_VConfiguration end of topic ===
    ${vacuum_CIP6CConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CConfiguration start of topic ===
    ${vacuum_CIP6CConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CConfiguration end of topic ===
    ${vacuum_CIP6CConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6CConfiguration_start}    end=${vacuum_CIP6CConfiguration_end + 1}
    Log Many    ${vacuum_CIP6CConfiguration_list}
    Should Contain    ${vacuum_CIP6CConfiguration_list}    === MTCamera_vacuum_CIP6CConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6CConfiguration_list}    === MTCamera_vacuum_CIP6CConfiguration end of topic ===
    ${vacuum_CIP6_IConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_IConfiguration start of topic ===
    ${vacuum_CIP6_IConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_IConfiguration end of topic ===
    ${vacuum_CIP6_IConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_IConfiguration_start}    end=${vacuum_CIP6_IConfiguration_end + 1}
    Log Many    ${vacuum_CIP6_IConfiguration_list}
    Should Contain    ${vacuum_CIP6_IConfiguration_list}    === MTCamera_vacuum_CIP6_IConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6_IConfiguration_list}    === MTCamera_vacuum_CIP6_IConfiguration end of topic ===
    ${vacuum_CIP6_VConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VConfiguration start of topic ===
    ${vacuum_CIP6_VConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VConfiguration end of topic ===
    ${vacuum_CIP6_VConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_VConfiguration_start}    end=${vacuum_CIP6_VConfiguration_end + 1}
    Log Many    ${vacuum_CIP6_VConfiguration_list}
    Should Contain    ${vacuum_CIP6_VConfiguration_list}    === MTCamera_vacuum_CIP6_VConfiguration start of topic ===
    Should Contain    ${vacuum_CIP6_VConfiguration_list}    === MTCamera_vacuum_CIP6_VConfiguration end of topic ===
    ${vacuum_CryoVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacConfiguration start of topic ===
    ${vacuum_CryoVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacConfiguration end of topic ===
    ${vacuum_CryoVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacConfiguration_start}    end=${vacuum_CryoVacConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacConfiguration_list}
    Should Contain    ${vacuum_CryoVacConfiguration_list}    === MTCamera_vacuum_CryoVacConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacConfiguration_list}    === MTCamera_vacuum_CryoVacConfiguration end of topic ===
    ${vacuum_CryoVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration start of topic ===
    ${vacuum_CryoVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration end of topic ===
    ${vacuum_CryoVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGaugeConfiguration_start}    end=${vacuum_CryoVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_CryoVacGaugeConfiguration_list}
    Should Contain    ${vacuum_CryoVacGaugeConfiguration_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_CryoVacGaugeConfiguration_list}    === MTCamera_vacuum_CryoVacGaugeConfiguration end of topic ===
    ${vacuum_ForelineVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacConfiguration start of topic ===
    ${vacuum_ForelineVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacConfiguration end of topic ===
    ${vacuum_ForelineVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacConfiguration_start}    end=${vacuum_ForelineVacConfiguration_end + 1}
    Log Many    ${vacuum_ForelineVacConfiguration_list}
    Should Contain    ${vacuum_ForelineVacConfiguration_list}    === MTCamera_vacuum_ForelineVacConfiguration start of topic ===
    Should Contain    ${vacuum_ForelineVacConfiguration_list}    === MTCamera_vacuum_ForelineVacConfiguration end of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration start of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration end of topic ===
    ${vacuum_ForelineVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacGaugeConfiguration_start}    end=${vacuum_ForelineVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_ForelineVacGaugeConfiguration_list}
    Should Contain    ${vacuum_ForelineVacGaugeConfiguration_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeConfiguration_list}    === MTCamera_vacuum_ForelineVacGaugeConfiguration end of topic ===
    ${vacuum_HeartbeatConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatConfiguration start of topic ===
    ${vacuum_HeartbeatConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatConfiguration end of topic ===
    ${vacuum_HeartbeatConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_HeartbeatConfiguration_start}    end=${vacuum_HeartbeatConfiguration_end + 1}
    Log Many    ${vacuum_HeartbeatConfiguration_list}
    Should Contain    ${vacuum_HeartbeatConfiguration_list}    === MTCamera_vacuum_HeartbeatConfiguration start of topic ===
    Should Contain    ${vacuum_HeartbeatConfiguration_list}    === MTCamera_vacuum_HeartbeatConfiguration end of topic ===
    ${vacuum_Hex1VacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacConfiguration start of topic ===
    ${vacuum_Hex1VacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacConfiguration end of topic ===
    ${vacuum_Hex1VacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacConfiguration_start}    end=${vacuum_Hex1VacConfiguration_end + 1}
    Log Many    ${vacuum_Hex1VacConfiguration_list}
    Should Contain    ${vacuum_Hex1VacConfiguration_list}    === MTCamera_vacuum_Hex1VacConfiguration start of topic ===
    Should Contain    ${vacuum_Hex1VacConfiguration_list}    === MTCamera_vacuum_Hex1VacConfiguration end of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration start of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration end of topic ===
    ${vacuum_Hex1VacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacGaugeConfiguration_start}    end=${vacuum_Hex1VacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_Hex1VacGaugeConfiguration_list}
    Should Contain    ${vacuum_Hex1VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex1VacGaugeConfiguration end of topic ===
    ${vacuum_Hex2VacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacConfiguration start of topic ===
    ${vacuum_Hex2VacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacConfiguration end of topic ===
    ${vacuum_Hex2VacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacConfiguration_start}    end=${vacuum_Hex2VacConfiguration_end + 1}
    Log Many    ${vacuum_Hex2VacConfiguration_list}
    Should Contain    ${vacuum_Hex2VacConfiguration_list}    === MTCamera_vacuum_Hex2VacConfiguration start of topic ===
    Should Contain    ${vacuum_Hex2VacConfiguration_list}    === MTCamera_vacuum_Hex2VacConfiguration end of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration start of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration end of topic ===
    ${vacuum_Hex2VacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacGaugeConfiguration_start}    end=${vacuum_Hex2VacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_Hex2VacGaugeConfiguration_list}
    Should Contain    ${vacuum_Hex2VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeConfiguration_list}    === MTCamera_vacuum_Hex2VacGaugeConfiguration end of topic ===
    ${vacuum_IonPumpsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsConfiguration start of topic ===
    ${vacuum_IonPumpsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsConfiguration end of topic ===
    ${vacuum_IonPumpsConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumpsConfiguration_start}    end=${vacuum_IonPumpsConfiguration_end + 1}
    Log Many    ${vacuum_IonPumpsConfiguration_list}
    Should Contain    ${vacuum_IonPumpsConfiguration_list}    === MTCamera_vacuum_IonPumpsConfiguration start of topic ===
    Should Contain    ${vacuum_IonPumpsConfiguration_list}    === MTCamera_vacuum_IonPumpsConfiguration end of topic ===
    ${vacuum_Monitor_checkConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkConfiguration start of topic ===
    ${vacuum_Monitor_checkConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkConfiguration end of topic ===
    ${vacuum_Monitor_checkConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_checkConfiguration_start}    end=${vacuum_Monitor_checkConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_checkConfiguration_list}
    Should Contain    ${vacuum_Monitor_checkConfiguration_list}    === MTCamera_vacuum_Monitor_checkConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_checkConfiguration_list}    === MTCamera_vacuum_Monitor_checkConfiguration end of topic ===
    ${vacuum_Monitor_publishConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishConfiguration start of topic ===
    ${vacuum_Monitor_publishConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishConfiguration end of topic ===
    ${vacuum_Monitor_publishConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_publishConfiguration_start}    end=${vacuum_Monitor_publishConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_publishConfiguration_list}
    Should Contain    ${vacuum_Monitor_publishConfiguration_list}    === MTCamera_vacuum_Monitor_publishConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_publishConfiguration_list}    === MTCamera_vacuum_Monitor_publishConfiguration end of topic ===
    ${vacuum_Monitor_updateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateConfiguration start of topic ===
    ${vacuum_Monitor_updateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateConfiguration end of topic ===
    ${vacuum_Monitor_updateConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_updateConfiguration_start}    end=${vacuum_Monitor_updateConfiguration_end + 1}
    Log Many    ${vacuum_Monitor_updateConfiguration_list}
    Should Contain    ${vacuum_Monitor_updateConfiguration_list}    === MTCamera_vacuum_Monitor_updateConfiguration start of topic ===
    Should Contain    ${vacuum_Monitor_updateConfiguration_list}    === MTCamera_vacuum_Monitor_updateConfiguration end of topic ===
    ${vacuum_RuntimeInfoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoConfiguration start of topic ===
    ${vacuum_RuntimeInfoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoConfiguration end of topic ===
    ${vacuum_RuntimeInfoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_RuntimeInfoConfiguration_start}    end=${vacuum_RuntimeInfoConfiguration_end + 1}
    Log Many    ${vacuum_RuntimeInfoConfiguration_list}
    Should Contain    ${vacuum_RuntimeInfoConfiguration_list}    === MTCamera_vacuum_RuntimeInfoConfiguration start of topic ===
    Should Contain    ${vacuum_RuntimeInfoConfiguration_list}    === MTCamera_vacuum_RuntimeInfoConfiguration end of topic ===
    ${vacuum_SchedulersConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersConfiguration start of topic ===
    ${vacuum_SchedulersConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersConfiguration end of topic ===
    ${vacuum_SchedulersConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_SchedulersConfiguration_start}    end=${vacuum_SchedulersConfiguration_end + 1}
    Log Many    ${vacuum_SchedulersConfiguration_list}
    Should Contain    ${vacuum_SchedulersConfiguration_list}    === MTCamera_vacuum_SchedulersConfiguration start of topic ===
    Should Contain    ${vacuum_SchedulersConfiguration_list}    === MTCamera_vacuum_SchedulersConfiguration end of topic ===
    ${vacuum_TurboCurrentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentConfiguration start of topic ===
    ${vacuum_TurboCurrentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentConfiguration end of topic ===
    ${vacuum_TurboCurrentConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrentConfiguration_start}    end=${vacuum_TurboCurrentConfiguration_end + 1}
    Log Many    ${vacuum_TurboCurrentConfiguration_list}
    Should Contain    ${vacuum_TurboCurrentConfiguration_list}    === MTCamera_vacuum_TurboCurrentConfiguration start of topic ===
    Should Contain    ${vacuum_TurboCurrentConfiguration_list}    === MTCamera_vacuum_TurboCurrentConfiguration end of topic ===
    ${vacuum_TurboPowerConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerConfiguration start of topic ===
    ${vacuum_TurboPowerConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerConfiguration end of topic ===
    ${vacuum_TurboPowerConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPowerConfiguration_start}    end=${vacuum_TurboPowerConfiguration_end + 1}
    Log Many    ${vacuum_TurboPowerConfiguration_list}
    Should Contain    ${vacuum_TurboPowerConfiguration_list}    === MTCamera_vacuum_TurboPowerConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPowerConfiguration_list}    === MTCamera_vacuum_TurboPowerConfiguration end of topic ===
    ${vacuum_TurboPumpConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpConfiguration start of topic ===
    ${vacuum_TurboPumpConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpConfiguration end of topic ===
    ${vacuum_TurboPumpConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpConfiguration_start}    end=${vacuum_TurboPumpConfiguration_end + 1}
    Log Many    ${vacuum_TurboPumpConfiguration_list}
    Should Contain    ${vacuum_TurboPumpConfiguration_list}    === MTCamera_vacuum_TurboPumpConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPumpConfiguration_list}    === MTCamera_vacuum_TurboPumpConfiguration end of topic ===
    ${vacuum_TurboPumpTempConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempConfiguration start of topic ===
    ${vacuum_TurboPumpTempConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempConfiguration end of topic ===
    ${vacuum_TurboPumpTempConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTempConfiguration_start}    end=${vacuum_TurboPumpTempConfiguration_end + 1}
    Log Many    ${vacuum_TurboPumpTempConfiguration_list}
    Should Contain    ${vacuum_TurboPumpTempConfiguration_list}    === MTCamera_vacuum_TurboPumpTempConfiguration start of topic ===
    Should Contain    ${vacuum_TurboPumpTempConfiguration_list}    === MTCamera_vacuum_TurboPumpTempConfiguration end of topic ===
    ${vacuum_TurboSpeedConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedConfiguration start of topic ===
    ${vacuum_TurboSpeedConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedConfiguration end of topic ===
    ${vacuum_TurboSpeedConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeedConfiguration_start}    end=${vacuum_TurboSpeedConfiguration_end + 1}
    Log Many    ${vacuum_TurboSpeedConfiguration_list}
    Should Contain    ${vacuum_TurboSpeedConfiguration_list}    === MTCamera_vacuum_TurboSpeedConfiguration start of topic ===
    Should Contain    ${vacuum_TurboSpeedConfiguration_list}    === MTCamera_vacuum_TurboSpeedConfiguration end of topic ===
    ${vacuum_TurboVacConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacConfiguration start of topic ===
    ${vacuum_TurboVacConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacConfiguration end of topic ===
    ${vacuum_TurboVacConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacConfiguration_start}    end=${vacuum_TurboVacConfiguration_end + 1}
    Log Many    ${vacuum_TurboVacConfiguration_list}
    Should Contain    ${vacuum_TurboVacConfiguration_list}    === MTCamera_vacuum_TurboVacConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVacConfiguration_list}    === MTCamera_vacuum_TurboVacConfiguration end of topic ===
    ${vacuum_TurboVacGaugeConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration start of topic ===
    ${vacuum_TurboVacGaugeConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration end of topic ===
    ${vacuum_TurboVacGaugeConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacGaugeConfiguration_start}    end=${vacuum_TurboVacGaugeConfiguration_end + 1}
    Log Many    ${vacuum_TurboVacGaugeConfiguration_list}
    Should Contain    ${vacuum_TurboVacGaugeConfiguration_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVacGaugeConfiguration_list}    === MTCamera_vacuum_TurboVacGaugeConfiguration end of topic ===
    ${vacuum_TurboVoltageConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageConfiguration start of topic ===
    ${vacuum_TurboVoltageConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageConfiguration end of topic ===
    ${vacuum_TurboVoltageConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltageConfiguration_start}    end=${vacuum_TurboVoltageConfiguration_end + 1}
    Log Many    ${vacuum_TurboVoltageConfiguration_list}
    Should Contain    ${vacuum_TurboVoltageConfiguration_list}    === MTCamera_vacuum_TurboVoltageConfiguration start of topic ===
    Should Contain    ${vacuum_TurboVoltageConfiguration_list}    === MTCamera_vacuum_TurboVoltageConfiguration end of topic ===
    ${vacuum_VacPlutoConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoConfiguration start of topic ===
    ${vacuum_VacPlutoConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoConfiguration end of topic ===
    ${vacuum_VacPlutoConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPlutoConfiguration_start}    end=${vacuum_VacPlutoConfiguration_end + 1}
    Log Many    ${vacuum_VacPlutoConfiguration_list}
    Should Contain    ${vacuum_VacPlutoConfiguration_list}    === MTCamera_vacuum_VacPlutoConfiguration start of topic ===
    Should Contain    ${vacuum_VacPlutoConfiguration_list}    === MTCamera_vacuum_VacPlutoConfiguration end of topic ===
    ${vacuum_Vacuum_stateConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateConfiguration start of topic ===
    ${vacuum_Vacuum_stateConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateConfiguration end of topic ===
    ${vacuum_Vacuum_stateConfiguration_list}=    Get Slice From List    ${full_list}    start=${vacuum_Vacuum_stateConfiguration_start}    end=${vacuum_Vacuum_stateConfiguration_end + 1}
    Log Many    ${vacuum_Vacuum_stateConfiguration_list}
    Should Contain    ${vacuum_Vacuum_stateConfiguration_list}    === MTCamera_vacuum_Vacuum_stateConfiguration start of topic ===
    Should Contain    ${vacuum_Vacuum_stateConfiguration_list}    === MTCamera_vacuum_Vacuum_stateConfiguration end of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration start of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration end of topic ===
    ${daq_monitor_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksConfiguration_start}    end=${daq_monitor_PeriodicTasksConfiguration_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksConfiguration_list}
    Should Contain    ${daq_monitor_PeriodicTasksConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksConfiguration_list}    === MTCamera_daq_monitor_PeriodicTasksConfiguration end of topic ===
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
    ${daq_monitor_Stats_buildConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildConfiguration start of topic ===
    ${daq_monitor_Stats_buildConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildConfiguration end of topic ===
    ${daq_monitor_Stats_buildConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildConfiguration_start}    end=${daq_monitor_Stats_buildConfiguration_end + 1}
    Log Many    ${daq_monitor_Stats_buildConfiguration_list}
    Should Contain    ${daq_monitor_Stats_buildConfiguration_list}    === MTCamera_daq_monitor_Stats_buildConfiguration start of topic ===
    Should Contain    ${daq_monitor_Stats_buildConfiguration_list}    === MTCamera_daq_monitor_Stats_buildConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    ${daq_monitor_StoreConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
    ${daq_monitor_StoreConfiguration_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreConfiguration_start}    end=${daq_monitor_StoreConfiguration_end + 1}
    Log Many    ${daq_monitor_StoreConfiguration_list}
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration start of topic ===
    Should Contain    ${daq_monitor_StoreConfiguration_list}    === MTCamera_daq_monitor_StoreConfiguration end of topic ===
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
    ${focal_plane_Ccd_RaftsConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration start of topic ===
    ${focal_plane_Ccd_RaftsConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration end of topic ===
    ${focal_plane_Ccd_RaftsConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsConfiguration_start}    end=${focal_plane_Ccd_RaftsConfiguration_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsConfiguration_list}
    Should Contain    ${focal_plane_Ccd_RaftsConfiguration_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsConfiguration_list}    === MTCamera_focal_plane_Ccd_RaftsConfiguration end of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration start of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration end of topic ===
    ${focal_plane_ImageDatabaseServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceConfiguration_start}    end=${focal_plane_ImageDatabaseServiceConfiguration_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceConfiguration_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceConfiguration_list}    === MTCamera_focal_plane_ImageDatabaseServiceConfiguration end of topic ===
    ${focal_plane_ImageNameServiceConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration start of topic ===
    ${focal_plane_ImageNameServiceConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration end of topic ===
    ${focal_plane_ImageNameServiceConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceConfiguration_start}    end=${focal_plane_ImageNameServiceConfiguration_end + 1}
    Log Many    ${focal_plane_ImageNameServiceConfiguration_list}
    Should Contain    ${focal_plane_ImageNameServiceConfiguration_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceConfiguration_list}    === MTCamera_focal_plane_ImageNameServiceConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentConfiguration_start}    end=${focal_plane_InstrumentConfig_InstrumentConfiguration_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentConfiguration_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentConfiguration end of topic ===
    ${focal_plane_PeriodicTasksConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration start of topic ===
    ${focal_plane_PeriodicTasksConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration end of topic ===
    ${focal_plane_PeriodicTasksConfiguration_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksConfiguration_start}    end=${focal_plane_PeriodicTasksConfiguration_end + 1}
    Log Many    ${focal_plane_PeriodicTasksConfiguration_list}
    Should Contain    ${focal_plane_PeriodicTasksConfiguration_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksConfiguration_list}    === MTCamera_focal_plane_PeriodicTasksConfiguration end of topic ===
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
    ${image_handling_Reb_FitsHandlingConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration start of topic ===
    ${image_handling_Reb_FitsHandlingConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration end of topic ===
    ${image_handling_Reb_FitsHandlingConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_Reb_FitsHandlingConfiguration_start}    end=${image_handling_Reb_FitsHandlingConfiguration_end + 1}
    Log Many    ${image_handling_Reb_FitsHandlingConfiguration_list}
    Should Contain    ${image_handling_Reb_FitsHandlingConfiguration_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration start of topic ===
    Should Contain    ${image_handling_Reb_FitsHandlingConfiguration_list}    === MTCamera_image_handling_Reb_FitsHandlingConfiguration end of topic ===
    ${image_handling_Reb_GeneralConfiguration_start}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_GeneralConfiguration start of topic ===
    ${image_handling_Reb_GeneralConfiguration_end}=    Get Index From List    ${full_list}    === MTCamera_image_handling_Reb_GeneralConfiguration end of topic ===
    ${image_handling_Reb_GeneralConfiguration_list}=    Get Slice From List    ${full_list}    start=${image_handling_Reb_GeneralConfiguration_start}    end=${image_handling_Reb_GeneralConfiguration_end + 1}
    Log Many    ${image_handling_Reb_GeneralConfiguration_list}
    Should Contain    ${image_handling_Reb_GeneralConfiguration_list}    === MTCamera_image_handling_Reb_GeneralConfiguration start of topic ===
    Should Contain    ${image_handling_Reb_GeneralConfiguration_list}    === MTCamera_image_handling_Reb_GeneralConfiguration end of topic ===
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
    ${authList_start}=    Get Index From List    ${full_list}    === MTCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTCamera_authList start of topic ===
    Should Contain    ${authList_list}    === MTCamera_authList end of topic ===
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
