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
    Should Contain    ${offlineDetailedState_list}    === [putSample logevent_offlineDetailedState] writing a message containing :
    ${endReadout_start}=    Get Index From List    ${full_list}    === MTCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === MTCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === MTCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === MTCamera_endReadout end of topic ===
    Should Contain    ${endReadout_list}    === [putSample logevent_endReadout] writing a message containing :
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage end of topic ===
    Should Contain    ${endTakeImage_list}    === [putSample logevent_endTakeImage] writing a message containing :
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === [putSample logevent_imageReadinessDetailedState] writing a message containing :
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter end of topic ===
    Should Contain    ${startSetFilter_list}    === [putSample logevent_startSetFilter] writing a message containing :
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter end of topic ===
    Should Contain    ${startUnloadFilter_list}    === [putSample logevent_startUnloadFilter] writing a message containing :
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage end of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === [putSample logevent_notReadyToTakeImage] writing a message containing :
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose end of topic ===
    Should Contain    ${startShutterClose_list}    === [putSample logevent_startShutterClose] writing a message containing :
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider end of topic ===
    Should Contain    ${endInitializeGuider_list}    === [putSample logevent_endInitializeGuider] writing a message containing :
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose end of topic ===
    Should Contain    ${endShutterClose_list}    === [putSample logevent_endShutterClose] writing a message containing :
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry end of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === [putSample logevent_endOfImageTelemetry] writing a message containing :
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter end of topic ===
    Should Contain    ${endUnloadFilter_list}    === [putSample logevent_endUnloadFilter] writing a message containing :
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState end of topic ===
    Should Contain    ${calibrationDetailedState_list}    === [putSample logevent_calibrationDetailedState] writing a message containing :
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel end of topic ===
    Should Contain    ${endRotateCarousel_list}    === [putSample logevent_endRotateCarousel] writing a message containing :
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter end of topic ===
    Should Contain    ${startLoadFilter_list}    === [putSample logevent_startLoadFilter] writing a message containing :
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState end of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === [putSample logevent_filterChangerDetailedState] writing a message containing :
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState end of topic ===
    Should Contain    ${shutterDetailedState_list}    === [putSample logevent_shutterDetailedState] writing a message containing :
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage end of topic ===
    Should Contain    ${readyToTakeImage_list}    === [putSample logevent_readyToTakeImage] writing a message containing :
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState end of topic ===
    Should Contain    ${ccsCommandState_list}    === [putSample logevent_ccsCommandState] writing a message containing :
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage end of topic ===
    Should Contain    ${prepareToTakeImage_list}    === [putSample logevent_prepareToTakeImage] writing a message containing :
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured end of topic ===
    Should Contain    ${ccsConfigured_list}    === [putSample logevent_ccsConfigured] writing a message containing :
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter end of topic ===
    Should Contain    ${endLoadFilter_list}    === [putSample logevent_endLoadFilter] writing a message containing :
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen end of topic ===
    Should Contain    ${endShutterOpen_list}    === [putSample logevent_endShutterOpen] writing a message containing :
    ${startIntegration_start}=    Get Index From List    ${full_list}    === MTCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === MTCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration end of topic ===
    Should Contain    ${startIntegration_list}    === [putSample logevent_startIntegration] writing a message containing :
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage end of topic ===
    Should Contain    ${endInitializeImage_list}    === [putSample logevent_endInitializeImage] writing a message containing :
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter end of topic ===
    Should Contain    ${endSetFilter_list}    === [putSample logevent_endSetFilter] writing a message containing :
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen end of topic ===
    Should Contain    ${startShutterOpen_list}    === [putSample logevent_startShutterOpen] writing a message containing :
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState end of topic ===
    Should Contain    ${raftsDetailedState_list}    === [putSample logevent_raftsDetailedState] writing a message containing :
    ${availableFilters_start}=    Get Index From List    ${full_list}    === MTCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === MTCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters end of topic ===
    Should Contain    ${availableFilters_list}    === [putSample logevent_availableFilters] writing a message containing :
    ${startReadout_start}=    Get Index From List    ${full_list}    === MTCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === MTCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === MTCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === MTCamera_startReadout end of topic ===
    Should Contain    ${startReadout_list}    === [putSample logevent_startReadout] writing a message containing :
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel end of topic ===
    Should Contain    ${startRotateCarousel_list}    === [putSample logevent_startRotateCarousel] writing a message containing :
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters end of topic ===
    Should Contain    ${imageReadoutParameters_list}    === [putSample logevent_imageReadoutParameters] writing a message containing :
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === [putSample logevent_focalPlaneSummaryInfo] writing a message containing :
    ${settingVersions_start}=    Get Index From List    ${full_list}    === MTCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === MTCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === MTCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === MTCamera_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [putSample logevent_settingVersions] writing a message containing :
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTCamera_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [putSample logevent_errorCode] writing a message containing :
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTCamera_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [putSample logevent_summaryState] writing a message containing :
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === MTCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === MTCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === MTCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === MTCamera_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [putSample logevent_appliedSettingsMatchStart] writing a message containing :
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTCamera_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [putSample logevent_logLevel] writing a message containing :
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTCamera_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [putSample logevent_logMessage] writing a message containing :
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === MTCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === MTCamera_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [putSample logevent_settingsApplied] writing a message containing :
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [putSample logevent_simulationMode] writing a message containing :
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [putSample logevent_softwareVersions] writing a message containing :
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [putSample logevent_heartbeat] writing a message containing :
    ${authList_start}=    Get Index From List    ${full_list}    === MTCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTCamera_authList start of topic ===
    Should Contain    ${authList_list}    === MTCamera_authList end of topic ===
    Should Contain    ${authList_list}    === [putSample logevent_authList] writing a message containing :
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === [putSample logevent_largeFileObjectAvailable] writing a message containing :

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
    Should Contain    ${offlineDetailedState_list}    === [getSample logevent_offlineDetailedState ] message received :0
    ${endReadout_start}=    Get Index From List    ${full_list}    === MTCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === MTCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === MTCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === MTCamera_endReadout end of topic ===
    Should Contain    ${endReadout_list}    === [getSample logevent_endReadout ] message received :0
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === MTCamera_endTakeImage end of topic ===
    Should Contain    ${endTakeImage_list}    === [getSample logevent_endTakeImage ] message received :0
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === MTCamera_imageReadinessDetailedState end of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === [getSample logevent_imageReadinessDetailedState ] message received :0
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === MTCamera_startSetFilter end of topic ===
    Should Contain    ${startSetFilter_list}    === [getSample logevent_startSetFilter ] message received :0
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === MTCamera_startUnloadFilter end of topic ===
    Should Contain    ${startUnloadFilter_list}    === [getSample logevent_startUnloadFilter ] message received :0
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === MTCamera_notReadyToTakeImage end of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === [getSample logevent_notReadyToTakeImage ] message received :0
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === MTCamera_startShutterClose end of topic ===
    Should Contain    ${startShutterClose_list}    === [getSample logevent_startShutterClose ] message received :0
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === MTCamera_endInitializeGuider end of topic ===
    Should Contain    ${endInitializeGuider_list}    === [getSample logevent_endInitializeGuider ] message received :0
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === MTCamera_endShutterClose end of topic ===
    Should Contain    ${endShutterClose_list}    === [getSample logevent_endShutterClose ] message received :0
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === MTCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === MTCamera_endOfImageTelemetry end of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === [getSample logevent_endOfImageTelemetry ] message received :0
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === MTCamera_endUnloadFilter end of topic ===
    Should Contain    ${endUnloadFilter_list}    === [getSample logevent_endUnloadFilter ] message received :0
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === MTCamera_calibrationDetailedState end of topic ===
    Should Contain    ${calibrationDetailedState_list}    === [getSample logevent_calibrationDetailedState ] message received :0
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === MTCamera_endRotateCarousel end of topic ===
    Should Contain    ${endRotateCarousel_list}    === [getSample logevent_endRotateCarousel ] message received :0
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === MTCamera_startLoadFilter end of topic ===
    Should Contain    ${startLoadFilter_list}    === [getSample logevent_startLoadFilter ] message received :0
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === MTCamera_filterChangerDetailedState end of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === [getSample logevent_filterChangerDetailedState ] message received :0
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === MTCamera_shutterDetailedState end of topic ===
    Should Contain    ${shutterDetailedState_list}    === [getSample logevent_shutterDetailedState ] message received :0
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === MTCamera_readyToTakeImage end of topic ===
    Should Contain    ${readyToTakeImage_list}    === [getSample logevent_readyToTakeImage ] message received :0
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === MTCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === MTCamera_ccsCommandState end of topic ===
    Should Contain    ${ccsCommandState_list}    === [getSample logevent_ccsCommandState ] message received :0
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === MTCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === MTCamera_prepareToTakeImage end of topic ===
    Should Contain    ${prepareToTakeImage_list}    === [getSample logevent_prepareToTakeImage ] message received :0
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === MTCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === MTCamera_ccsConfigured end of topic ===
    Should Contain    ${ccsConfigured_list}    === [getSample logevent_ccsConfigured ] message received :0
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === MTCamera_endLoadFilter end of topic ===
    Should Contain    ${endLoadFilter_list}    === [getSample logevent_endLoadFilter ] message received :0
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === MTCamera_endShutterOpen end of topic ===
    Should Contain    ${endShutterOpen_list}    === [getSample logevent_endShutterOpen ] message received :0
    ${startIntegration_start}=    Get Index From List    ${full_list}    === MTCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === MTCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === MTCamera_startIntegration end of topic ===
    Should Contain    ${startIntegration_list}    === [getSample logevent_startIntegration ] message received :0
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === MTCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === MTCamera_endInitializeImage end of topic ===
    Should Contain    ${endInitializeImage_list}    === [getSample logevent_endInitializeImage ] message received :0
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === MTCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === MTCamera_endSetFilter end of topic ===
    Should Contain    ${endSetFilter_list}    === [getSample logevent_endSetFilter ] message received :0
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === MTCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === MTCamera_startShutterOpen end of topic ===
    Should Contain    ${startShutterOpen_list}    === [getSample logevent_startShutterOpen ] message received :0
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === MTCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === MTCamera_raftsDetailedState end of topic ===
    Should Contain    ${raftsDetailedState_list}    === [getSample logevent_raftsDetailedState ] message received :0
    ${availableFilters_start}=    Get Index From List    ${full_list}    === MTCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === MTCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === MTCamera_availableFilters end of topic ===
    Should Contain    ${availableFilters_list}    === [getSample logevent_availableFilters ] message received :0
    ${startReadout_start}=    Get Index From List    ${full_list}    === MTCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === MTCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === MTCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === MTCamera_startReadout end of topic ===
    Should Contain    ${startReadout_list}    === [getSample logevent_startReadout ] message received :0
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === MTCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === MTCamera_startRotateCarousel end of topic ===
    Should Contain    ${startRotateCarousel_list}    === [getSample logevent_startRotateCarousel ] message received :0
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === MTCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === MTCamera_imageReadoutParameters end of topic ===
    Should Contain    ${imageReadoutParameters_list}    === [getSample logevent_imageReadoutParameters ] message received :0
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === MTCamera_focalPlaneSummaryInfo end of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === [getSample logevent_focalPlaneSummaryInfo ] message received :0
    ${settingVersions_start}=    Get Index From List    ${full_list}    === MTCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === MTCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === MTCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === MTCamera_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [getSample logevent_settingVersions ] message received :0
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTCamera_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [getSample logevent_errorCode ] message received :0
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTCamera_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [getSample logevent_summaryState ] message received :0
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === MTCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === MTCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === MTCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === MTCamera_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [getSample logevent_appliedSettingsMatchStart ] message received :0
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTCamera_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [getSample logevent_logLevel ] message received :0
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTCamera_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [getSample logevent_logMessage ] message received :0
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === MTCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === MTCamera_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [getSample logevent_settingsApplied ] message received :0
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTCamera_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [getSample logevent_simulationMode ] message received :0
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTCamera_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [getSample logevent_softwareVersions ] message received :0
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [getSample logevent_heartbeat ] message received :0
    ${authList_start}=    Get Index From List    ${full_list}    === MTCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTCamera_authList start of topic ===
    Should Contain    ${authList_list}    === MTCamera_authList end of topic ===
    Should Contain    ${authList_list}    === [getSample logevent_authList ] message received :0
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTCamera_largeFileObjectAvailable end of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === [getSample logevent_largeFileObjectAvailable ] message received :0
