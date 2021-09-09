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
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_BFR_LimitsSettingsApplied] writing a message containing :
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_BFR_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VC_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VC_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VD_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VD_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_48V_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_48V_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_5V_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_5V_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === [putSample logevent_quadbox_PeriodicTasksSettingsApplied] writing a message containing :
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_quadbox_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_LimitsSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_REB_Bulk_PS_LimitsSettingsApplied] writing a message containing :
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_REB_Bulk_PS_QuadboxSettingsApplied] writing a message containing :
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === MTCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === MTCamera_rebpowerSettingsApplied end of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === [putSample logevent_rebpowerSettingsApplied] writing a message containing :
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === [putSample logevent_rebpower_EmergencyResponseManagerSettingsApplied] writing a message containing :
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === [putSample logevent_rebpower_PeriodicTasksSettingsApplied] writing a message containing :
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_rebpower_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === MTCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === MTCamera_rebpower_RebSettingsApplied end of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === [putSample logevent_rebpower_RebSettingsApplied] writing a message containing :
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === [putSample logevent_rebpower_Reb_LimitsSettingsApplied] writing a message containing :
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === [putSample logevent_rebpower_Rebps_LimitsSettingsApplied] writing a message containing :
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === [putSample logevent_rebpower_Rebps_PowerSettingsApplied] writing a message containing :
    ${hexSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hexSettingsApplied start of topic ===
    ${hexSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hexSettingsApplied end of topic ===
    ${hexSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hexSettingsApplied_start}    end=${hexSettingsApplied_end + 1}
    Log Many    ${hexSettingsApplied_list}
    Should Contain    ${hexSettingsApplied_list}    === MTCamera_hexSettingsApplied start of topic ===
    Should Contain    ${hexSettingsApplied_list}    === MTCamera_hexSettingsApplied end of topic ===
    Should Contain    ${hexSettingsApplied_list}    === [putSample logevent_hexSettingsApplied] writing a message containing :
    ${hex_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied start of topic ===
    ${hex_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied end of topic ===
    ${hex_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_LimitsSettingsApplied_start}    end=${hex_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cold1_LimitsSettingsApplied] writing a message containing :
    ${hex_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied start of topic ===
    ${hex_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied end of topic ===
    ${hex_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_LimitsSettingsApplied_start}    end=${hex_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cold2_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied start of topic ===
    ${hex_Cryo1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied end of topic ===
    ${hex_Cryo1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_LimitsSettingsApplied_start}    end=${hex_Cryo1_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo1_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo1_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied start of topic ===
    ${hex_Cryo2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied end of topic ===
    ${hex_Cryo2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_LimitsSettingsApplied_start}    end=${hex_Cryo2_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo2_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo2_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo3_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied start of topic ===
    ${hex_Cryo3_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied end of topic ===
    ${hex_Cryo3_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_LimitsSettingsApplied_start}    end=${hex_Cryo3_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo3_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo3_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo4_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied start of topic ===
    ${hex_Cryo4_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied end of topic ===
    ${hex_Cryo4_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_LimitsSettingsApplied_start}    end=${hex_Cryo4_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo4_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo4_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo5_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied start of topic ===
    ${hex_Cryo5_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied end of topic ===
    ${hex_Cryo5_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_LimitsSettingsApplied_start}    end=${hex_Cryo5_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo5_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo5_LimitsSettingsApplied] writing a message containing :
    ${hex_Cryo6_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied start of topic ===
    ${hex_Cryo6_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied end of topic ===
    ${hex_Cryo6_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_LimitsSettingsApplied_start}    end=${hex_Cryo6_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo6_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === [putSample logevent_hex_Cryo6_LimitsSettingsApplied] writing a message containing :
    ${hex_Maq20_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied start of topic ===
    ${hex_Maq20_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied end of topic ===
    ${hex_Maq20_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceSettingsApplied_start}    end=${hex_Maq20_DeviceSettingsApplied_end + 1}
    Log Many    ${hex_Maq20_DeviceSettingsApplied_list}
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied start of topic ===
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied end of topic ===
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === [putSample logevent_hex_Maq20_DeviceSettingsApplied] writing a message containing :
    ${hex_Maq20x_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied start of topic ===
    ${hex_Maq20x_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied end of topic ===
    ${hex_Maq20x_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20x_DeviceSettingsApplied_start}    end=${hex_Maq20x_DeviceSettingsApplied_end + 1}
    Log Many    ${hex_Maq20x_DeviceSettingsApplied_list}
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied start of topic ===
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied end of topic ===
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === [putSample logevent_hex_Maq20x_DeviceSettingsApplied] writing a message containing :
    ${hex_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksSettingsApplied start of topic ===
    ${hex_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksSettingsApplied end of topic ===
    ${hex_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasksSettingsApplied_start}    end=${hex_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${hex_PeriodicTasksSettingsApplied_list}
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === MTCamera_hex_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === MTCamera_hex_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === [putSample logevent_hex_PeriodicTasksSettingsApplied] writing a message containing :
    ${hex_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied start of topic ===
    ${hex_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied end of topic ===
    ${hex_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersSettingsApplied_start}    end=${hex_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${hex_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_hex_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${refrig_Cold1_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cold1_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cold1_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_CompLimitsSettingsApplied_start}    end=${refrig_Cold1_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cold1_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cold1_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied start of topic ===
    ${refrig_Cold1_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied end of topic ===
    ${refrig_Cold1_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_DeviceSettingsApplied_start}    end=${refrig_Cold1_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cold1_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied start of topic ===
    ${refrig_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied end of topic ===
    ${refrig_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_LimitsSettingsApplied_start}    end=${refrig_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cold1_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cold2_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cold2_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cold2_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_CompLimitsSettingsApplied_start}    end=${refrig_Cold2_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cold2_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cold2_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied start of topic ===
    ${refrig_Cold2_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied end of topic ===
    ${refrig_Cold2_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_DeviceSettingsApplied_start}    end=${refrig_Cold2_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cold2_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied start of topic ===
    ${refrig_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied end of topic ===
    ${refrig_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_LimitsSettingsApplied_start}    end=${refrig_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cold2_LimitsSettingsApplied] writing a message containing :
    ${refrig_CoolMaq20_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied start of topic ===
    ${refrig_CoolMaq20_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied end of topic ===
    ${refrig_CoolMaq20_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_CoolMaq20_DeviceSettingsApplied_start}    end=${refrig_CoolMaq20_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_CoolMaq20_DeviceSettingsApplied_list}
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === [putSample logevent_refrig_CoolMaq20_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo1_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo1_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo1_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_CompLimitsSettingsApplied_start}    end=${refrig_Cryo1_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo1_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo1_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo1_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo1_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceSettingsApplied_start}    end=${refrig_Cryo1_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo1_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsSettingsApplied_start}    end=${refrig_Cryo1_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo1_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo2_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo2_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo2_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_CompLimitsSettingsApplied_start}    end=${refrig_Cryo2_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo2_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo2_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo2_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo2_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceSettingsApplied_start}    end=${refrig_Cryo2_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo2_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsSettingsApplied_start}    end=${refrig_Cryo2_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo2_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo3_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo3_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo3_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_CompLimitsSettingsApplied_start}    end=${refrig_Cryo3_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo3_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo3_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo3_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo3_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceSettingsApplied_start}    end=${refrig_Cryo3_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo3_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo3_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo3_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo3_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsSettingsApplied_start}    end=${refrig_Cryo3_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo3_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo4_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo4_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo4_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_CompLimitsSettingsApplied_start}    end=${refrig_Cryo4_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo4_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo4_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo4_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo4_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceSettingsApplied_start}    end=${refrig_Cryo4_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo4_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo4_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo4_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo4_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsSettingsApplied_start}    end=${refrig_Cryo4_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo4_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo5_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo5_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo5_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_CompLimitsSettingsApplied_start}    end=${refrig_Cryo5_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo5_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo5_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo5_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo5_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceSettingsApplied_start}    end=${refrig_Cryo5_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo5_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo5_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo5_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo5_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsSettingsApplied_start}    end=${refrig_Cryo5_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo5_LimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo6_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo6_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo6_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_CompLimitsSettingsApplied_start}    end=${refrig_Cryo6_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo6_CompLimitsSettingsApplied] writing a message containing :
    ${refrig_Cryo6_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo6_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo6_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceSettingsApplied_start}    end=${refrig_Cryo6_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === [putSample logevent_refrig_Cryo6_DeviceSettingsApplied] writing a message containing :
    ${refrig_Cryo6_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo6_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo6_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsSettingsApplied_start}    end=${refrig_Cryo6_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === [putSample logevent_refrig_Cryo6_LimitsSettingsApplied] writing a message containing :
    ${refrig_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied start of topic ===
    ${refrig_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied end of topic ===
    ${refrig_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasksSettingsApplied_start}    end=${refrig_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${refrig_PeriodicTasksSettingsApplied_list}
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === [putSample logevent_refrig_PeriodicTasksSettingsApplied] writing a message containing :
    ${refrig_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied start of topic ===
    ${refrig_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied end of topic ===
    ${refrig_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersSettingsApplied_start}    end=${refrig_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_refrig_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${vacuum_AgentMonitorServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied start of topic ===
    ${vacuum_AgentMonitorServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied end of topic ===
    ${vacuum_AgentMonitorServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_AgentMonitorServiceSettingsApplied_start}    end=${vacuum_AgentMonitorServiceSettingsApplied_end + 1}
    Log Many    ${vacuum_AgentMonitorServiceSettingsApplied_list}
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied start of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied end of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === [putSample logevent_vacuum_AgentMonitorServiceSettingsApplied] writing a message containing :
    ${vacuum_CIP1CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CSettingsApplied start of topic ===
    ${vacuum_CIP1CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CSettingsApplied end of topic ===
    ${vacuum_CIP1CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1CSettingsApplied_start}    end=${vacuum_CIP1CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1CSettingsApplied_list}
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === MTCamera_vacuum_CIP1CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === MTCamera_vacuum_CIP1CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === [putSample logevent_vacuum_CIP1CSettingsApplied] writing a message containing :
    ${vacuum_CIP1_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_ISettingsApplied start of topic ===
    ${vacuum_CIP1_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_ISettingsApplied end of topic ===
    ${vacuum_CIP1_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_ISettingsApplied_start}    end=${vacuum_CIP1_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === MTCamera_vacuum_CIP1_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === MTCamera_vacuum_CIP1_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP1_ISettingsApplied] writing a message containing :
    ${vacuum_CIP1_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VSettingsApplied start of topic ===
    ${vacuum_CIP1_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VSettingsApplied end of topic ===
    ${vacuum_CIP1_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_VSettingsApplied_start}    end=${vacuum_CIP1_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === MTCamera_vacuum_CIP1_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === MTCamera_vacuum_CIP1_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP1_VSettingsApplied] writing a message containing :
    ${vacuum_CIP2CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CSettingsApplied start of topic ===
    ${vacuum_CIP2CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CSettingsApplied end of topic ===
    ${vacuum_CIP2CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2CSettingsApplied_start}    end=${vacuum_CIP2CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2CSettingsApplied_list}
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === MTCamera_vacuum_CIP2CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === MTCamera_vacuum_CIP2CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === [putSample logevent_vacuum_CIP2CSettingsApplied] writing a message containing :
    ${vacuum_CIP2_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_ISettingsApplied start of topic ===
    ${vacuum_CIP2_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_ISettingsApplied end of topic ===
    ${vacuum_CIP2_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_ISettingsApplied_start}    end=${vacuum_CIP2_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === MTCamera_vacuum_CIP2_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === MTCamera_vacuum_CIP2_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP2_ISettingsApplied] writing a message containing :
    ${vacuum_CIP2_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VSettingsApplied start of topic ===
    ${vacuum_CIP2_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VSettingsApplied end of topic ===
    ${vacuum_CIP2_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_VSettingsApplied_start}    end=${vacuum_CIP2_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === MTCamera_vacuum_CIP2_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === MTCamera_vacuum_CIP2_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP2_VSettingsApplied] writing a message containing :
    ${vacuum_CIP3CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CSettingsApplied start of topic ===
    ${vacuum_CIP3CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CSettingsApplied end of topic ===
    ${vacuum_CIP3CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3CSettingsApplied_start}    end=${vacuum_CIP3CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3CSettingsApplied_list}
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === MTCamera_vacuum_CIP3CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === MTCamera_vacuum_CIP3CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === [putSample logevent_vacuum_CIP3CSettingsApplied] writing a message containing :
    ${vacuum_CIP3_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_ISettingsApplied start of topic ===
    ${vacuum_CIP3_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_ISettingsApplied end of topic ===
    ${vacuum_CIP3_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_ISettingsApplied_start}    end=${vacuum_CIP3_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === MTCamera_vacuum_CIP3_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === MTCamera_vacuum_CIP3_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP3_ISettingsApplied] writing a message containing :
    ${vacuum_CIP3_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VSettingsApplied start of topic ===
    ${vacuum_CIP3_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VSettingsApplied end of topic ===
    ${vacuum_CIP3_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_VSettingsApplied_start}    end=${vacuum_CIP3_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === MTCamera_vacuum_CIP3_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === MTCamera_vacuum_CIP3_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP3_VSettingsApplied] writing a message containing :
    ${vacuum_CIP4CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CSettingsApplied start of topic ===
    ${vacuum_CIP4CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CSettingsApplied end of topic ===
    ${vacuum_CIP4CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4CSettingsApplied_start}    end=${vacuum_CIP4CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4CSettingsApplied_list}
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === MTCamera_vacuum_CIP4CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === MTCamera_vacuum_CIP4CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === [putSample logevent_vacuum_CIP4CSettingsApplied] writing a message containing :
    ${vacuum_CIP4_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_ISettingsApplied start of topic ===
    ${vacuum_CIP4_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_ISettingsApplied end of topic ===
    ${vacuum_CIP4_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_ISettingsApplied_start}    end=${vacuum_CIP4_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === MTCamera_vacuum_CIP4_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === MTCamera_vacuum_CIP4_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP4_ISettingsApplied] writing a message containing :
    ${vacuum_CIP4_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VSettingsApplied start of topic ===
    ${vacuum_CIP4_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VSettingsApplied end of topic ===
    ${vacuum_CIP4_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_VSettingsApplied_start}    end=${vacuum_CIP4_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === MTCamera_vacuum_CIP4_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === MTCamera_vacuum_CIP4_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP4_VSettingsApplied] writing a message containing :
    ${vacuum_CIP5CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CSettingsApplied start of topic ===
    ${vacuum_CIP5CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CSettingsApplied end of topic ===
    ${vacuum_CIP5CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5CSettingsApplied_start}    end=${vacuum_CIP5CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5CSettingsApplied_list}
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === MTCamera_vacuum_CIP5CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === MTCamera_vacuum_CIP5CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === [putSample logevent_vacuum_CIP5CSettingsApplied] writing a message containing :
    ${vacuum_CIP5_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_ISettingsApplied start of topic ===
    ${vacuum_CIP5_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_ISettingsApplied end of topic ===
    ${vacuum_CIP5_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_ISettingsApplied_start}    end=${vacuum_CIP5_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === MTCamera_vacuum_CIP5_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === MTCamera_vacuum_CIP5_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP5_ISettingsApplied] writing a message containing :
    ${vacuum_CIP5_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VSettingsApplied start of topic ===
    ${vacuum_CIP5_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VSettingsApplied end of topic ===
    ${vacuum_CIP5_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_VSettingsApplied_start}    end=${vacuum_CIP5_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === MTCamera_vacuum_CIP5_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === MTCamera_vacuum_CIP5_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP5_VSettingsApplied] writing a message containing :
    ${vacuum_CIP6CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CSettingsApplied start of topic ===
    ${vacuum_CIP6CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CSettingsApplied end of topic ===
    ${vacuum_CIP6CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6CSettingsApplied_start}    end=${vacuum_CIP6CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6CSettingsApplied_list}
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === MTCamera_vacuum_CIP6CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === MTCamera_vacuum_CIP6CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === [putSample logevent_vacuum_CIP6CSettingsApplied] writing a message containing :
    ${vacuum_CIP6_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_ISettingsApplied start of topic ===
    ${vacuum_CIP6_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_ISettingsApplied end of topic ===
    ${vacuum_CIP6_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_ISettingsApplied_start}    end=${vacuum_CIP6_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === MTCamera_vacuum_CIP6_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === MTCamera_vacuum_CIP6_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === [putSample logevent_vacuum_CIP6_ISettingsApplied] writing a message containing :
    ${vacuum_CIP6_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VSettingsApplied start of topic ===
    ${vacuum_CIP6_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VSettingsApplied end of topic ===
    ${vacuum_CIP6_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_VSettingsApplied_start}    end=${vacuum_CIP6_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === MTCamera_vacuum_CIP6_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === MTCamera_vacuum_CIP6_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === [putSample logevent_vacuum_CIP6_VSettingsApplied] writing a message containing :
    ${vacuum_CryoVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacSettingsApplied start of topic ===
    ${vacuum_CryoVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacSettingsApplied end of topic ===
    ${vacuum_CryoVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacSettingsApplied_start}    end=${vacuum_CryoVacSettingsApplied_end + 1}
    Log Many    ${vacuum_CryoVacSettingsApplied_list}
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === MTCamera_vacuum_CryoVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === MTCamera_vacuum_CryoVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === [putSample logevent_vacuum_CryoVacSettingsApplied] writing a message containing :
    ${vacuum_CryoVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied start of topic ===
    ${vacuum_CryoVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied end of topic ===
    ${vacuum_CryoVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGaugeSettingsApplied_start}    end=${vacuum_CryoVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_CryoVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === [putSample logevent_vacuum_CryoVacGaugeSettingsApplied] writing a message containing :
    ${vacuum_ForelineVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacSettingsApplied start of topic ===
    ${vacuum_ForelineVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacSettingsApplied end of topic ===
    ${vacuum_ForelineVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacSettingsApplied_start}    end=${vacuum_ForelineVacSettingsApplied_end + 1}
    Log Many    ${vacuum_ForelineVacSettingsApplied_list}
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === MTCamera_vacuum_ForelineVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === MTCamera_vacuum_ForelineVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === [putSample logevent_vacuum_ForelineVacSettingsApplied] writing a message containing :
    ${vacuum_ForelineVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied start of topic ===
    ${vacuum_ForelineVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied end of topic ===
    ${vacuum_ForelineVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacGaugeSettingsApplied_start}    end=${vacuum_ForelineVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_ForelineVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === [putSample logevent_vacuum_ForelineVacGaugeSettingsApplied] writing a message containing :
    ${vacuum_HeartbeatSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatSettingsApplied start of topic ===
    ${vacuum_HeartbeatSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatSettingsApplied end of topic ===
    ${vacuum_HeartbeatSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_HeartbeatSettingsApplied_start}    end=${vacuum_HeartbeatSettingsApplied_end + 1}
    Log Many    ${vacuum_HeartbeatSettingsApplied_list}
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === MTCamera_vacuum_HeartbeatSettingsApplied start of topic ===
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === MTCamera_vacuum_HeartbeatSettingsApplied end of topic ===
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === [putSample logevent_vacuum_HeartbeatSettingsApplied] writing a message containing :
    ${vacuum_Hex1VacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacSettingsApplied start of topic ===
    ${vacuum_Hex1VacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacSettingsApplied end of topic ===
    ${vacuum_Hex1VacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacSettingsApplied_start}    end=${vacuum_Hex1VacSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex1VacSettingsApplied_list}
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === MTCamera_vacuum_Hex1VacSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === MTCamera_vacuum_Hex1VacSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === [putSample logevent_vacuum_Hex1VacSettingsApplied] writing a message containing :
    ${vacuum_Hex1VacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied start of topic ===
    ${vacuum_Hex1VacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied end of topic ===
    ${vacuum_Hex1VacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacGaugeSettingsApplied_start}    end=${vacuum_Hex1VacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex1VacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === [putSample logevent_vacuum_Hex1VacGaugeSettingsApplied] writing a message containing :
    ${vacuum_Hex2VacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacSettingsApplied start of topic ===
    ${vacuum_Hex2VacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacSettingsApplied end of topic ===
    ${vacuum_Hex2VacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacSettingsApplied_start}    end=${vacuum_Hex2VacSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex2VacSettingsApplied_list}
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === MTCamera_vacuum_Hex2VacSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === MTCamera_vacuum_Hex2VacSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === [putSample logevent_vacuum_Hex2VacSettingsApplied] writing a message containing :
    ${vacuum_Hex2VacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied start of topic ===
    ${vacuum_Hex2VacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied end of topic ===
    ${vacuum_Hex2VacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacGaugeSettingsApplied_start}    end=${vacuum_Hex2VacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex2VacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === [putSample logevent_vacuum_Hex2VacGaugeSettingsApplied] writing a message containing :
    ${vacuum_IonPumpsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsSettingsApplied start of topic ===
    ${vacuum_IonPumpsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsSettingsApplied end of topic ===
    ${vacuum_IonPumpsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumpsSettingsApplied_start}    end=${vacuum_IonPumpsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumpsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === MTCamera_vacuum_IonPumpsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === MTCamera_vacuum_IonPumpsSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === [putSample logevent_vacuum_IonPumpsSettingsApplied] writing a message containing :
    ${vacuum_Monitor_checkSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied start of topic ===
    ${vacuum_Monitor_checkSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied end of topic ===
    ${vacuum_Monitor_checkSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_checkSettingsApplied_start}    end=${vacuum_Monitor_checkSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_checkSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === [putSample logevent_vacuum_Monitor_checkSettingsApplied] writing a message containing :
    ${vacuum_Monitor_publishSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied start of topic ===
    ${vacuum_Monitor_publishSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied end of topic ===
    ${vacuum_Monitor_publishSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_publishSettingsApplied_start}    end=${vacuum_Monitor_publishSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_publishSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === [putSample logevent_vacuum_Monitor_publishSettingsApplied] writing a message containing :
    ${vacuum_Monitor_updateSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied start of topic ===
    ${vacuum_Monitor_updateSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied end of topic ===
    ${vacuum_Monitor_updateSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_updateSettingsApplied_start}    end=${vacuum_Monitor_updateSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_updateSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === [putSample logevent_vacuum_Monitor_updateSettingsApplied] writing a message containing :
    ${vacuum_RuntimeInfoSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied start of topic ===
    ${vacuum_RuntimeInfoSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied end of topic ===
    ${vacuum_RuntimeInfoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_RuntimeInfoSettingsApplied_start}    end=${vacuum_RuntimeInfoSettingsApplied_end + 1}
    Log Many    ${vacuum_RuntimeInfoSettingsApplied_list}
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied start of topic ===
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied end of topic ===
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === [putSample logevent_vacuum_RuntimeInfoSettingsApplied] writing a message containing :
    ${vacuum_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersSettingsApplied start of topic ===
    ${vacuum_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersSettingsApplied end of topic ===
    ${vacuum_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_SchedulersSettingsApplied_start}    end=${vacuum_SchedulersSettingsApplied_end + 1}
    Log Many    ${vacuum_SchedulersSettingsApplied_list}
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === MTCamera_vacuum_SchedulersSettingsApplied start of topic ===
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === MTCamera_vacuum_SchedulersSettingsApplied end of topic ===
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === [putSample logevent_vacuum_SchedulersSettingsApplied] writing a message containing :
    ${vacuum_TurboCurrentSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied start of topic ===
    ${vacuum_TurboCurrentSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied end of topic ===
    ${vacuum_TurboCurrentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrentSettingsApplied_start}    end=${vacuum_TurboCurrentSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboCurrentSettingsApplied_list}
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === [putSample logevent_vacuum_TurboCurrentSettingsApplied] writing a message containing :
    ${vacuum_TurboPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerSettingsApplied start of topic ===
    ${vacuum_TurboPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerSettingsApplied end of topic ===
    ${vacuum_TurboPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPowerSettingsApplied_start}    end=${vacuum_TurboPowerSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPowerSettingsApplied_list}
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === MTCamera_vacuum_TurboPowerSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === MTCamera_vacuum_TurboPowerSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === [putSample logevent_vacuum_TurboPowerSettingsApplied] writing a message containing :
    ${vacuum_TurboPumpSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpSettingsApplied start of topic ===
    ${vacuum_TurboPumpSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpSettingsApplied end of topic ===
    ${vacuum_TurboPumpSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpSettingsApplied_start}    end=${vacuum_TurboPumpSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPumpSettingsApplied_list}
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === MTCamera_vacuum_TurboPumpSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === MTCamera_vacuum_TurboPumpSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === [putSample logevent_vacuum_TurboPumpSettingsApplied] writing a message containing :
    ${vacuum_TurboPumpTempSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied start of topic ===
    ${vacuum_TurboPumpTempSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied end of topic ===
    ${vacuum_TurboPumpTempSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTempSettingsApplied_start}    end=${vacuum_TurboPumpTempSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPumpTempSettingsApplied_list}
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === [putSample logevent_vacuum_TurboPumpTempSettingsApplied] writing a message containing :
    ${vacuum_TurboSpeedSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied start of topic ===
    ${vacuum_TurboSpeedSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied end of topic ===
    ${vacuum_TurboSpeedSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeedSettingsApplied_start}    end=${vacuum_TurboSpeedSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSpeedSettingsApplied_list}
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === [putSample logevent_vacuum_TurboSpeedSettingsApplied] writing a message containing :
    ${vacuum_TurboVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacSettingsApplied start of topic ===
    ${vacuum_TurboVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacSettingsApplied end of topic ===
    ${vacuum_TurboVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacSettingsApplied_start}    end=${vacuum_TurboVacSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVacSettingsApplied_list}
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === MTCamera_vacuum_TurboVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === MTCamera_vacuum_TurboVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === [putSample logevent_vacuum_TurboVacSettingsApplied] writing a message containing :
    ${vacuum_TurboVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied start of topic ===
    ${vacuum_TurboVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied end of topic ===
    ${vacuum_TurboVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacGaugeSettingsApplied_start}    end=${vacuum_TurboVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === [putSample logevent_vacuum_TurboVacGaugeSettingsApplied] writing a message containing :
    ${vacuum_TurboVoltageSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied start of topic ===
    ${vacuum_TurboVoltageSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied end of topic ===
    ${vacuum_TurboVoltageSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltageSettingsApplied_start}    end=${vacuum_TurboVoltageSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVoltageSettingsApplied_list}
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === [putSample logevent_vacuum_TurboVoltageSettingsApplied] writing a message containing :
    ${vacuum_VacPlutoSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoSettingsApplied start of topic ===
    ${vacuum_VacPlutoSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoSettingsApplied end of topic ===
    ${vacuum_VacPlutoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPlutoSettingsApplied_start}    end=${vacuum_VacPlutoSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPlutoSettingsApplied_list}
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === MTCamera_vacuum_VacPlutoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === MTCamera_vacuum_VacPlutoSettingsApplied end of topic ===
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === [putSample logevent_vacuum_VacPlutoSettingsApplied] writing a message containing :
    ${vacuum_Vacuum_stateSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied start of topic ===
    ${vacuum_Vacuum_stateSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied end of topic ===
    ${vacuum_Vacuum_stateSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Vacuum_stateSettingsApplied_start}    end=${vacuum_Vacuum_stateSettingsApplied_end + 1}
    Log Many    ${vacuum_Vacuum_stateSettingsApplied_list}
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied start of topic ===
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied end of topic ===
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === [putSample logevent_vacuum_Vacuum_stateSettingsApplied] writing a message containing :
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === [putSample logevent_daq_monitor_PeriodicTasksSettingsApplied] writing a message containing :
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_daq_monitor_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === [putSample logevent_daq_monitor_Stats_StatisticsSettingsApplied] writing a message containing :
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === [putSample logevent_daq_monitor_Stats_buildSettingsApplied] writing a message containing :
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === MTCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === MTCamera_daq_monitor_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === [putSample logevent_daq_monitor_StoreSettingsApplied] writing a message containing :
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === [putSample logevent_daq_monitor_Store_LimitsSettingsApplied] writing a message containing :
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === [putSample logevent_daq_monitor_Store_StoreSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_RaftsSettingsApplied] writing a message containing :
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === [putSample logevent_focal_plane_ImageDatabaseServiceSettingsApplied] writing a message containing :
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === [putSample logevent_focal_plane_ImageNameServiceSettingsApplied] writing a message containing :
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === [putSample logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied] writing a message containing :
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === [putSample logevent_focal_plane_PeriodicTasksSettingsApplied] writing a message containing :
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_focal_plane_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_RaftTempControlSettingsApplied] writing a message containing :
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied] writing a message containing :
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_RebTotalPower_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsLimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsPowerSettingsApplied] writing a message containing :
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_timersSettingsApplied] writing a message containing :
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Segment_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === [putSample logevent_focal_plane_SequencerConfig_DAQSettingsApplied] writing a message containing :
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === [putSample logevent_focal_plane_SequencerConfig_SequencerSettingsApplied] writing a message containing :
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === [putSample logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied] writing a message containing :
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
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === MTCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_BFR_LimitsSettingsApplied ] message received :0
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === MTCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_BFR_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VC_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VC_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VD_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VD_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_48V_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_48V_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_5V_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === MTCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_5V_QuadboxSettingsApplied ] message received :0
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === [getSample logevent_quadbox_PeriodicTasksSettingsApplied ] message received :0
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_quadbox_PeriodicTasks_timersSettingsApplied ] message received :0
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_LimitsSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_REB_Bulk_PS_LimitsSettingsApplied ] message received :0
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === MTCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_REB_Bulk_PS_QuadboxSettingsApplied ] message received :0
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === MTCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === MTCamera_rebpowerSettingsApplied end of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === [getSample logevent_rebpowerSettingsApplied ] message received :0
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === MTCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === [getSample logevent_rebpower_EmergencyResponseManagerSettingsApplied ] message received :0
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === [getSample logevent_rebpower_PeriodicTasksSettingsApplied ] message received :0
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_rebpower_PeriodicTasks_timersSettingsApplied ] message received :0
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === MTCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === MTCamera_rebpower_RebSettingsApplied end of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === [getSample logevent_rebpower_RebSettingsApplied ] message received :0
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === MTCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === [getSample logevent_rebpower_Reb_LimitsSettingsApplied ] message received :0
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === MTCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === [getSample logevent_rebpower_Rebps_LimitsSettingsApplied ] message received :0
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === MTCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === [getSample logevent_rebpower_Rebps_PowerSettingsApplied ] message received :0
    ${hexSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hexSettingsApplied start of topic ===
    ${hexSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hexSettingsApplied end of topic ===
    ${hexSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hexSettingsApplied_start}    end=${hexSettingsApplied_end + 1}
    Log Many    ${hexSettingsApplied_list}
    Should Contain    ${hexSettingsApplied_list}    === MTCamera_hexSettingsApplied start of topic ===
    Should Contain    ${hexSettingsApplied_list}    === MTCamera_hexSettingsApplied end of topic ===
    Should Contain    ${hexSettingsApplied_list}    === [getSample logevent_hexSettingsApplied ] message received :0
    ${hex_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied start of topic ===
    ${hex_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied end of topic ===
    ${hex_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_LimitsSettingsApplied_start}    end=${hex_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === MTCamera_hex_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cold1_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cold1_LimitsSettingsApplied ] message received :0
    ${hex_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied start of topic ===
    ${hex_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied end of topic ===
    ${hex_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_LimitsSettingsApplied_start}    end=${hex_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === MTCamera_hex_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cold2_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cold2_LimitsSettingsApplied ] message received :0
    ${hex_Cryo1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied start of topic ===
    ${hex_Cryo1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied end of topic ===
    ${hex_Cryo1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_LimitsSettingsApplied_start}    end=${hex_Cryo1_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo1_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo1_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo1_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo1_LimitsSettingsApplied ] message received :0
    ${hex_Cryo2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied start of topic ===
    ${hex_Cryo2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied end of topic ===
    ${hex_Cryo2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_LimitsSettingsApplied_start}    end=${hex_Cryo2_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo2_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo2_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo2_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo2_LimitsSettingsApplied ] message received :0
    ${hex_Cryo3_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied start of topic ===
    ${hex_Cryo3_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied end of topic ===
    ${hex_Cryo3_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_LimitsSettingsApplied_start}    end=${hex_Cryo3_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo3_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo3_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo3_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo3_LimitsSettingsApplied ] message received :0
    ${hex_Cryo4_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied start of topic ===
    ${hex_Cryo4_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied end of topic ===
    ${hex_Cryo4_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_LimitsSettingsApplied_start}    end=${hex_Cryo4_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo4_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo4_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo4_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo4_LimitsSettingsApplied ] message received :0
    ${hex_Cryo5_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied start of topic ===
    ${hex_Cryo5_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied end of topic ===
    ${hex_Cryo5_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_LimitsSettingsApplied_start}    end=${hex_Cryo5_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo5_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo5_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo5_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo5_LimitsSettingsApplied ] message received :0
    ${hex_Cryo6_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied start of topic ===
    ${hex_Cryo6_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied end of topic ===
    ${hex_Cryo6_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_LimitsSettingsApplied_start}    end=${hex_Cryo6_LimitsSettingsApplied_end + 1}
    Log Many    ${hex_Cryo6_LimitsSettingsApplied_list}
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied start of topic ===
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === MTCamera_hex_Cryo6_LimitsSettingsApplied end of topic ===
    Should Contain    ${hex_Cryo6_LimitsSettingsApplied_list}    === [getSample logevent_hex_Cryo6_LimitsSettingsApplied ] message received :0
    ${hex_Maq20_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied start of topic ===
    ${hex_Maq20_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied end of topic ===
    ${hex_Maq20_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20_DeviceSettingsApplied_start}    end=${hex_Maq20_DeviceSettingsApplied_end + 1}
    Log Many    ${hex_Maq20_DeviceSettingsApplied_list}
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied start of topic ===
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20_DeviceSettingsApplied end of topic ===
    Should Contain    ${hex_Maq20_DeviceSettingsApplied_list}    === [getSample logevent_hex_Maq20_DeviceSettingsApplied ] message received :0
    ${hex_Maq20x_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied start of topic ===
    ${hex_Maq20x_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied end of topic ===
    ${hex_Maq20x_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_Maq20x_DeviceSettingsApplied_start}    end=${hex_Maq20x_DeviceSettingsApplied_end + 1}
    Log Many    ${hex_Maq20x_DeviceSettingsApplied_list}
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied start of topic ===
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === MTCamera_hex_Maq20x_DeviceSettingsApplied end of topic ===
    Should Contain    ${hex_Maq20x_DeviceSettingsApplied_list}    === [getSample logevent_hex_Maq20x_DeviceSettingsApplied ] message received :0
    ${hex_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksSettingsApplied start of topic ===
    ${hex_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasksSettingsApplied end of topic ===
    ${hex_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasksSettingsApplied_start}    end=${hex_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${hex_PeriodicTasksSettingsApplied_list}
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === MTCamera_hex_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === MTCamera_hex_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${hex_PeriodicTasksSettingsApplied_list}    === [getSample logevent_hex_PeriodicTasksSettingsApplied ] message received :0
    ${hex_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied start of topic ===
    ${hex_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied end of topic ===
    ${hex_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${hex_PeriodicTasks_timersSettingsApplied_start}    end=${hex_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${hex_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_hex_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${hex_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_hex_PeriodicTasks_timersSettingsApplied ] message received :0
    ${refrig_Cold1_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cold1_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cold1_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_CompLimitsSettingsApplied_start}    end=${refrig_Cold1_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cold1_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cold1_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied start of topic ===
    ${refrig_Cold1_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied end of topic ===
    ${refrig_Cold1_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_DeviceSettingsApplied_start}    end=${refrig_Cold1_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold1_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cold1_DeviceSettingsApplied ] message received :0
    ${refrig_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied start of topic ===
    ${refrig_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied end of topic ===
    ${refrig_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_LimitsSettingsApplied_start}    end=${refrig_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold1_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cold1_LimitsSettingsApplied ] message received :0
    ${refrig_Cold2_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cold2_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cold2_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_CompLimitsSettingsApplied_start}    end=${refrig_Cold2_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cold2_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cold2_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied start of topic ===
    ${refrig_Cold2_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied end of topic ===
    ${refrig_Cold2_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_DeviceSettingsApplied_start}    end=${refrig_Cold2_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cold2_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cold2_DeviceSettingsApplied ] message received :0
    ${refrig_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied start of topic ===
    ${refrig_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied end of topic ===
    ${refrig_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_LimitsSettingsApplied_start}    end=${refrig_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cold2_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cold2_LimitsSettingsApplied ] message received :0
    ${refrig_CoolMaq20_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied start of topic ===
    ${refrig_CoolMaq20_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied end of topic ===
    ${refrig_CoolMaq20_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_CoolMaq20_DeviceSettingsApplied_start}    end=${refrig_CoolMaq20_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_CoolMaq20_DeviceSettingsApplied_list}
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === MTCamera_refrig_CoolMaq20_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_CoolMaq20_DeviceSettingsApplied_list}    === [getSample logevent_refrig_CoolMaq20_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo1_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo1_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo1_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_CompLimitsSettingsApplied_start}    end=${refrig_Cryo1_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo1_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo1_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo1_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo1_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_DeviceSettingsApplied_start}    end=${refrig_Cryo1_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo1_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo1_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_LimitsSettingsApplied_start}    end=${refrig_Cryo1_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo1_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo1_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo1_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo1_LimitsSettingsApplied ] message received :0
    ${refrig_Cryo2_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo2_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo2_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_CompLimitsSettingsApplied_start}    end=${refrig_Cryo2_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo2_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo2_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo2_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo2_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_DeviceSettingsApplied_start}    end=${refrig_Cryo2_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo2_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo2_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_LimitsSettingsApplied_start}    end=${refrig_Cryo2_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo2_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo2_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo2_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo2_LimitsSettingsApplied ] message received :0
    ${refrig_Cryo3_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo3_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo3_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_CompLimitsSettingsApplied_start}    end=${refrig_Cryo3_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo3_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo3_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo3_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo3_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_DeviceSettingsApplied_start}    end=${refrig_Cryo3_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo3_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo3_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo3_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo3_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo3_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_LimitsSettingsApplied_start}    end=${refrig_Cryo3_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo3_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo3_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo3_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo3_LimitsSettingsApplied ] message received :0
    ${refrig_Cryo4_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo4_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo4_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_CompLimitsSettingsApplied_start}    end=${refrig_Cryo4_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo4_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo4_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo4_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo4_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_DeviceSettingsApplied_start}    end=${refrig_Cryo4_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo4_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo4_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo4_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo4_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo4_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_LimitsSettingsApplied_start}    end=${refrig_Cryo4_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo4_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo4_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo4_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo4_LimitsSettingsApplied ] message received :0
    ${refrig_Cryo5_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo5_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo5_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_CompLimitsSettingsApplied_start}    end=${refrig_Cryo5_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo5_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo5_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo5_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo5_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_DeviceSettingsApplied_start}    end=${refrig_Cryo5_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo5_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo5_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo5_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo5_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo5_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_LimitsSettingsApplied_start}    end=${refrig_Cryo5_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo5_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo5_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo5_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo5_LimitsSettingsApplied ] message received :0
    ${refrig_Cryo6_CompLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied start of topic ===
    ${refrig_Cryo6_CompLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied end of topic ===
    ${refrig_Cryo6_CompLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_CompLimitsSettingsApplied_start}    end=${refrig_Cryo6_CompLimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_CompLimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_CompLimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_CompLimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo6_CompLimitsSettingsApplied ] message received :0
    ${refrig_Cryo6_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied start of topic ===
    ${refrig_Cryo6_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied end of topic ===
    ${refrig_Cryo6_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_DeviceSettingsApplied_start}    end=${refrig_Cryo6_DeviceSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_DeviceSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === MTCamera_refrig_Cryo6_DeviceSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_DeviceSettingsApplied_list}    === [getSample logevent_refrig_Cryo6_DeviceSettingsApplied ] message received :0
    ${refrig_Cryo6_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied start of topic ===
    ${refrig_Cryo6_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied end of topic ===
    ${refrig_Cryo6_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_LimitsSettingsApplied_start}    end=${refrig_Cryo6_LimitsSettingsApplied_end + 1}
    Log Many    ${refrig_Cryo6_LimitsSettingsApplied_list}
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied start of topic ===
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === MTCamera_refrig_Cryo6_LimitsSettingsApplied end of topic ===
    Should Contain    ${refrig_Cryo6_LimitsSettingsApplied_list}    === [getSample logevent_refrig_Cryo6_LimitsSettingsApplied ] message received :0
    ${refrig_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied start of topic ===
    ${refrig_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied end of topic ===
    ${refrig_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasksSettingsApplied_start}    end=${refrig_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${refrig_PeriodicTasksSettingsApplied_list}
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === MTCamera_refrig_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${refrig_PeriodicTasksSettingsApplied_list}    === [getSample logevent_refrig_PeriodicTasksSettingsApplied ] message received :0
    ${refrig_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied start of topic ===
    ${refrig_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied end of topic ===
    ${refrig_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${refrig_PeriodicTasks_timersSettingsApplied_start}    end=${refrig_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${refrig_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_refrig_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${refrig_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_refrig_PeriodicTasks_timersSettingsApplied ] message received :0
    ${vacuum_AgentMonitorServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied start of topic ===
    ${vacuum_AgentMonitorServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied end of topic ===
    ${vacuum_AgentMonitorServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_AgentMonitorServiceSettingsApplied_start}    end=${vacuum_AgentMonitorServiceSettingsApplied_end + 1}
    Log Many    ${vacuum_AgentMonitorServiceSettingsApplied_list}
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied start of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === MTCamera_vacuum_AgentMonitorServiceSettingsApplied end of topic ===
    Should Contain    ${vacuum_AgentMonitorServiceSettingsApplied_list}    === [getSample logevent_vacuum_AgentMonitorServiceSettingsApplied ] message received :0
    ${vacuum_CIP1CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CSettingsApplied start of topic ===
    ${vacuum_CIP1CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1CSettingsApplied end of topic ===
    ${vacuum_CIP1CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1CSettingsApplied_start}    end=${vacuum_CIP1CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1CSettingsApplied_list}
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === MTCamera_vacuum_CIP1CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === MTCamera_vacuum_CIP1CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1CSettingsApplied_list}    === [getSample logevent_vacuum_CIP1CSettingsApplied ] message received :0
    ${vacuum_CIP1_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_ISettingsApplied start of topic ===
    ${vacuum_CIP1_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_ISettingsApplied end of topic ===
    ${vacuum_CIP1_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_ISettingsApplied_start}    end=${vacuum_CIP1_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === MTCamera_vacuum_CIP1_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === MTCamera_vacuum_CIP1_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP1_ISettingsApplied ] message received :0
    ${vacuum_CIP1_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VSettingsApplied start of topic ===
    ${vacuum_CIP1_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_VSettingsApplied end of topic ===
    ${vacuum_CIP1_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_VSettingsApplied_start}    end=${vacuum_CIP1_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP1_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === MTCamera_vacuum_CIP1_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === MTCamera_vacuum_CIP1_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP1_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP1_VSettingsApplied ] message received :0
    ${vacuum_CIP2CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CSettingsApplied start of topic ===
    ${vacuum_CIP2CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2CSettingsApplied end of topic ===
    ${vacuum_CIP2CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2CSettingsApplied_start}    end=${vacuum_CIP2CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2CSettingsApplied_list}
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === MTCamera_vacuum_CIP2CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === MTCamera_vacuum_CIP2CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2CSettingsApplied_list}    === [getSample logevent_vacuum_CIP2CSettingsApplied ] message received :0
    ${vacuum_CIP2_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_ISettingsApplied start of topic ===
    ${vacuum_CIP2_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_ISettingsApplied end of topic ===
    ${vacuum_CIP2_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_ISettingsApplied_start}    end=${vacuum_CIP2_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === MTCamera_vacuum_CIP2_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === MTCamera_vacuum_CIP2_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP2_ISettingsApplied ] message received :0
    ${vacuum_CIP2_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VSettingsApplied start of topic ===
    ${vacuum_CIP2_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_VSettingsApplied end of topic ===
    ${vacuum_CIP2_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_VSettingsApplied_start}    end=${vacuum_CIP2_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP2_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === MTCamera_vacuum_CIP2_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === MTCamera_vacuum_CIP2_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP2_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP2_VSettingsApplied ] message received :0
    ${vacuum_CIP3CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CSettingsApplied start of topic ===
    ${vacuum_CIP3CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3CSettingsApplied end of topic ===
    ${vacuum_CIP3CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3CSettingsApplied_start}    end=${vacuum_CIP3CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3CSettingsApplied_list}
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === MTCamera_vacuum_CIP3CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === MTCamera_vacuum_CIP3CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3CSettingsApplied_list}    === [getSample logevent_vacuum_CIP3CSettingsApplied ] message received :0
    ${vacuum_CIP3_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_ISettingsApplied start of topic ===
    ${vacuum_CIP3_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_ISettingsApplied end of topic ===
    ${vacuum_CIP3_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_ISettingsApplied_start}    end=${vacuum_CIP3_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === MTCamera_vacuum_CIP3_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === MTCamera_vacuum_CIP3_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP3_ISettingsApplied ] message received :0
    ${vacuum_CIP3_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VSettingsApplied start of topic ===
    ${vacuum_CIP3_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_VSettingsApplied end of topic ===
    ${vacuum_CIP3_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_VSettingsApplied_start}    end=${vacuum_CIP3_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP3_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === MTCamera_vacuum_CIP3_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === MTCamera_vacuum_CIP3_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP3_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP3_VSettingsApplied ] message received :0
    ${vacuum_CIP4CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CSettingsApplied start of topic ===
    ${vacuum_CIP4CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4CSettingsApplied end of topic ===
    ${vacuum_CIP4CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4CSettingsApplied_start}    end=${vacuum_CIP4CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4CSettingsApplied_list}
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === MTCamera_vacuum_CIP4CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === MTCamera_vacuum_CIP4CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4CSettingsApplied_list}    === [getSample logevent_vacuum_CIP4CSettingsApplied ] message received :0
    ${vacuum_CIP4_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_ISettingsApplied start of topic ===
    ${vacuum_CIP4_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_ISettingsApplied end of topic ===
    ${vacuum_CIP4_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_ISettingsApplied_start}    end=${vacuum_CIP4_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === MTCamera_vacuum_CIP4_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === MTCamera_vacuum_CIP4_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP4_ISettingsApplied ] message received :0
    ${vacuum_CIP4_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VSettingsApplied start of topic ===
    ${vacuum_CIP4_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_VSettingsApplied end of topic ===
    ${vacuum_CIP4_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_VSettingsApplied_start}    end=${vacuum_CIP4_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP4_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === MTCamera_vacuum_CIP4_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === MTCamera_vacuum_CIP4_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP4_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP4_VSettingsApplied ] message received :0
    ${vacuum_CIP5CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CSettingsApplied start of topic ===
    ${vacuum_CIP5CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5CSettingsApplied end of topic ===
    ${vacuum_CIP5CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5CSettingsApplied_start}    end=${vacuum_CIP5CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5CSettingsApplied_list}
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === MTCamera_vacuum_CIP5CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === MTCamera_vacuum_CIP5CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5CSettingsApplied_list}    === [getSample logevent_vacuum_CIP5CSettingsApplied ] message received :0
    ${vacuum_CIP5_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_ISettingsApplied start of topic ===
    ${vacuum_CIP5_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_ISettingsApplied end of topic ===
    ${vacuum_CIP5_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_ISettingsApplied_start}    end=${vacuum_CIP5_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === MTCamera_vacuum_CIP5_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === MTCamera_vacuum_CIP5_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP5_ISettingsApplied ] message received :0
    ${vacuum_CIP5_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VSettingsApplied start of topic ===
    ${vacuum_CIP5_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_VSettingsApplied end of topic ===
    ${vacuum_CIP5_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_VSettingsApplied_start}    end=${vacuum_CIP5_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP5_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === MTCamera_vacuum_CIP5_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === MTCamera_vacuum_CIP5_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP5_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP5_VSettingsApplied ] message received :0
    ${vacuum_CIP6CSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CSettingsApplied start of topic ===
    ${vacuum_CIP6CSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6CSettingsApplied end of topic ===
    ${vacuum_CIP6CSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6CSettingsApplied_start}    end=${vacuum_CIP6CSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6CSettingsApplied_list}
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === MTCamera_vacuum_CIP6CSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === MTCamera_vacuum_CIP6CSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6CSettingsApplied_list}    === [getSample logevent_vacuum_CIP6CSettingsApplied ] message received :0
    ${vacuum_CIP6_ISettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_ISettingsApplied start of topic ===
    ${vacuum_CIP6_ISettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_ISettingsApplied end of topic ===
    ${vacuum_CIP6_ISettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_ISettingsApplied_start}    end=${vacuum_CIP6_ISettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6_ISettingsApplied_list}
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === MTCamera_vacuum_CIP6_ISettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === MTCamera_vacuum_CIP6_ISettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6_ISettingsApplied_list}    === [getSample logevent_vacuum_CIP6_ISettingsApplied ] message received :0
    ${vacuum_CIP6_VSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VSettingsApplied start of topic ===
    ${vacuum_CIP6_VSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_VSettingsApplied end of topic ===
    ${vacuum_CIP6_VSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_VSettingsApplied_start}    end=${vacuum_CIP6_VSettingsApplied_end + 1}
    Log Many    ${vacuum_CIP6_VSettingsApplied_list}
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === MTCamera_vacuum_CIP6_VSettingsApplied start of topic ===
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === MTCamera_vacuum_CIP6_VSettingsApplied end of topic ===
    Should Contain    ${vacuum_CIP6_VSettingsApplied_list}    === [getSample logevent_vacuum_CIP6_VSettingsApplied ] message received :0
    ${vacuum_CryoVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacSettingsApplied start of topic ===
    ${vacuum_CryoVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacSettingsApplied end of topic ===
    ${vacuum_CryoVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacSettingsApplied_start}    end=${vacuum_CryoVacSettingsApplied_end + 1}
    Log Many    ${vacuum_CryoVacSettingsApplied_list}
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === MTCamera_vacuum_CryoVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === MTCamera_vacuum_CryoVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_CryoVacSettingsApplied_list}    === [getSample logevent_vacuum_CryoVacSettingsApplied ] message received :0
    ${vacuum_CryoVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied start of topic ===
    ${vacuum_CryoVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied end of topic ===
    ${vacuum_CryoVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGaugeSettingsApplied_start}    end=${vacuum_CryoVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_CryoVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === MTCamera_vacuum_CryoVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_CryoVacGaugeSettingsApplied_list}    === [getSample logevent_vacuum_CryoVacGaugeSettingsApplied ] message received :0
    ${vacuum_ForelineVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacSettingsApplied start of topic ===
    ${vacuum_ForelineVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacSettingsApplied end of topic ===
    ${vacuum_ForelineVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacSettingsApplied_start}    end=${vacuum_ForelineVacSettingsApplied_end + 1}
    Log Many    ${vacuum_ForelineVacSettingsApplied_list}
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === MTCamera_vacuum_ForelineVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === MTCamera_vacuum_ForelineVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_ForelineVacSettingsApplied_list}    === [getSample logevent_vacuum_ForelineVacSettingsApplied ] message received :0
    ${vacuum_ForelineVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied start of topic ===
    ${vacuum_ForelineVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied end of topic ===
    ${vacuum_ForelineVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacGaugeSettingsApplied_start}    end=${vacuum_ForelineVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_ForelineVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === MTCamera_vacuum_ForelineVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_ForelineVacGaugeSettingsApplied_list}    === [getSample logevent_vacuum_ForelineVacGaugeSettingsApplied ] message received :0
    ${vacuum_HeartbeatSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatSettingsApplied start of topic ===
    ${vacuum_HeartbeatSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HeartbeatSettingsApplied end of topic ===
    ${vacuum_HeartbeatSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_HeartbeatSettingsApplied_start}    end=${vacuum_HeartbeatSettingsApplied_end + 1}
    Log Many    ${vacuum_HeartbeatSettingsApplied_list}
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === MTCamera_vacuum_HeartbeatSettingsApplied start of topic ===
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === MTCamera_vacuum_HeartbeatSettingsApplied end of topic ===
    Should Contain    ${vacuum_HeartbeatSettingsApplied_list}    === [getSample logevent_vacuum_HeartbeatSettingsApplied ] message received :0
    ${vacuum_Hex1VacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacSettingsApplied start of topic ===
    ${vacuum_Hex1VacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacSettingsApplied end of topic ===
    ${vacuum_Hex1VacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacSettingsApplied_start}    end=${vacuum_Hex1VacSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex1VacSettingsApplied_list}
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === MTCamera_vacuum_Hex1VacSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === MTCamera_vacuum_Hex1VacSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex1VacSettingsApplied_list}    === [getSample logevent_vacuum_Hex1VacSettingsApplied ] message received :0
    ${vacuum_Hex1VacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied start of topic ===
    ${vacuum_Hex1VacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied end of topic ===
    ${vacuum_Hex1VacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacGaugeSettingsApplied_start}    end=${vacuum_Hex1VacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex1VacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex1VacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex1VacGaugeSettingsApplied_list}    === [getSample logevent_vacuum_Hex1VacGaugeSettingsApplied ] message received :0
    ${vacuum_Hex2VacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacSettingsApplied start of topic ===
    ${vacuum_Hex2VacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacSettingsApplied end of topic ===
    ${vacuum_Hex2VacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacSettingsApplied_start}    end=${vacuum_Hex2VacSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex2VacSettingsApplied_list}
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === MTCamera_vacuum_Hex2VacSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === MTCamera_vacuum_Hex2VacSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex2VacSettingsApplied_list}    === [getSample logevent_vacuum_Hex2VacSettingsApplied ] message received :0
    ${vacuum_Hex2VacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied start of topic ===
    ${vacuum_Hex2VacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied end of topic ===
    ${vacuum_Hex2VacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacGaugeSettingsApplied_start}    end=${vacuum_Hex2VacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_Hex2VacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === MTCamera_vacuum_Hex2VacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_Hex2VacGaugeSettingsApplied_list}    === [getSample logevent_vacuum_Hex2VacGaugeSettingsApplied ] message received :0
    ${vacuum_IonPumpsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsSettingsApplied start of topic ===
    ${vacuum_IonPumpsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumpsSettingsApplied end of topic ===
    ${vacuum_IonPumpsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumpsSettingsApplied_start}    end=${vacuum_IonPumpsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumpsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === MTCamera_vacuum_IonPumpsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === MTCamera_vacuum_IonPumpsSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumpsSettingsApplied_list}    === [getSample logevent_vacuum_IonPumpsSettingsApplied ] message received :0
    ${vacuum_Monitor_checkSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied start of topic ===
    ${vacuum_Monitor_checkSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied end of topic ===
    ${vacuum_Monitor_checkSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_checkSettingsApplied_start}    end=${vacuum_Monitor_checkSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_checkSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === MTCamera_vacuum_Monitor_checkSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_checkSettingsApplied_list}    === [getSample logevent_vacuum_Monitor_checkSettingsApplied ] message received :0
    ${vacuum_Monitor_publishSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied start of topic ===
    ${vacuum_Monitor_publishSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied end of topic ===
    ${vacuum_Monitor_publishSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_publishSettingsApplied_start}    end=${vacuum_Monitor_publishSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_publishSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === MTCamera_vacuum_Monitor_publishSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_publishSettingsApplied_list}    === [getSample logevent_vacuum_Monitor_publishSettingsApplied ] message received :0
    ${vacuum_Monitor_updateSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied start of topic ===
    ${vacuum_Monitor_updateSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied end of topic ===
    ${vacuum_Monitor_updateSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Monitor_updateSettingsApplied_start}    end=${vacuum_Monitor_updateSettingsApplied_end + 1}
    Log Many    ${vacuum_Monitor_updateSettingsApplied_list}
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied start of topic ===
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === MTCamera_vacuum_Monitor_updateSettingsApplied end of topic ===
    Should Contain    ${vacuum_Monitor_updateSettingsApplied_list}    === [getSample logevent_vacuum_Monitor_updateSettingsApplied ] message received :0
    ${vacuum_RuntimeInfoSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied start of topic ===
    ${vacuum_RuntimeInfoSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied end of topic ===
    ${vacuum_RuntimeInfoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_RuntimeInfoSettingsApplied_start}    end=${vacuum_RuntimeInfoSettingsApplied_end + 1}
    Log Many    ${vacuum_RuntimeInfoSettingsApplied_list}
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied start of topic ===
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === MTCamera_vacuum_RuntimeInfoSettingsApplied end of topic ===
    Should Contain    ${vacuum_RuntimeInfoSettingsApplied_list}    === [getSample logevent_vacuum_RuntimeInfoSettingsApplied ] message received :0
    ${vacuum_SchedulersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersSettingsApplied start of topic ===
    ${vacuum_SchedulersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_SchedulersSettingsApplied end of topic ===
    ${vacuum_SchedulersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_SchedulersSettingsApplied_start}    end=${vacuum_SchedulersSettingsApplied_end + 1}
    Log Many    ${vacuum_SchedulersSettingsApplied_list}
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === MTCamera_vacuum_SchedulersSettingsApplied start of topic ===
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === MTCamera_vacuum_SchedulersSettingsApplied end of topic ===
    Should Contain    ${vacuum_SchedulersSettingsApplied_list}    === [getSample logevent_vacuum_SchedulersSettingsApplied ] message received :0
    ${vacuum_TurboCurrentSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied start of topic ===
    ${vacuum_TurboCurrentSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied end of topic ===
    ${vacuum_TurboCurrentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrentSettingsApplied_start}    end=${vacuum_TurboCurrentSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboCurrentSettingsApplied_list}
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === MTCamera_vacuum_TurboCurrentSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboCurrentSettingsApplied_list}    === [getSample logevent_vacuum_TurboCurrentSettingsApplied ] message received :0
    ${vacuum_TurboPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerSettingsApplied start of topic ===
    ${vacuum_TurboPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPowerSettingsApplied end of topic ===
    ${vacuum_TurboPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPowerSettingsApplied_start}    end=${vacuum_TurboPowerSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPowerSettingsApplied_list}
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === MTCamera_vacuum_TurboPowerSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === MTCamera_vacuum_TurboPowerSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPowerSettingsApplied_list}    === [getSample logevent_vacuum_TurboPowerSettingsApplied ] message received :0
    ${vacuum_TurboPumpSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpSettingsApplied start of topic ===
    ${vacuum_TurboPumpSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpSettingsApplied end of topic ===
    ${vacuum_TurboPumpSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpSettingsApplied_start}    end=${vacuum_TurboPumpSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPumpSettingsApplied_list}
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === MTCamera_vacuum_TurboPumpSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === MTCamera_vacuum_TurboPumpSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPumpSettingsApplied_list}    === [getSample logevent_vacuum_TurboPumpSettingsApplied ] message received :0
    ${vacuum_TurboPumpTempSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied start of topic ===
    ${vacuum_TurboPumpTempSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied end of topic ===
    ${vacuum_TurboPumpTempSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTempSettingsApplied_start}    end=${vacuum_TurboPumpTempSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboPumpTempSettingsApplied_list}
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === MTCamera_vacuum_TurboPumpTempSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboPumpTempSettingsApplied_list}    === [getSample logevent_vacuum_TurboPumpTempSettingsApplied ] message received :0
    ${vacuum_TurboSpeedSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied start of topic ===
    ${vacuum_TurboSpeedSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied end of topic ===
    ${vacuum_TurboSpeedSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeedSettingsApplied_start}    end=${vacuum_TurboSpeedSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSpeedSettingsApplied_list}
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === MTCamera_vacuum_TurboSpeedSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboSpeedSettingsApplied_list}    === [getSample logevent_vacuum_TurboSpeedSettingsApplied ] message received :0
    ${vacuum_TurboVacSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacSettingsApplied start of topic ===
    ${vacuum_TurboVacSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacSettingsApplied end of topic ===
    ${vacuum_TurboVacSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacSettingsApplied_start}    end=${vacuum_TurboVacSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVacSettingsApplied_list}
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === MTCamera_vacuum_TurboVacSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === MTCamera_vacuum_TurboVacSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVacSettingsApplied_list}    === [getSample logevent_vacuum_TurboVacSettingsApplied ] message received :0
    ${vacuum_TurboVacGaugeSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied start of topic ===
    ${vacuum_TurboVacGaugeSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied end of topic ===
    ${vacuum_TurboVacGaugeSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacGaugeSettingsApplied_start}    end=${vacuum_TurboVacGaugeSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVacGaugeSettingsApplied_list}
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === MTCamera_vacuum_TurboVacGaugeSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVacGaugeSettingsApplied_list}    === [getSample logevent_vacuum_TurboVacGaugeSettingsApplied ] message received :0
    ${vacuum_TurboVoltageSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied start of topic ===
    ${vacuum_TurboVoltageSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied end of topic ===
    ${vacuum_TurboVoltageSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltageSettingsApplied_start}    end=${vacuum_TurboVoltageSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboVoltageSettingsApplied_list}
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === MTCamera_vacuum_TurboVoltageSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboVoltageSettingsApplied_list}    === [getSample logevent_vacuum_TurboVoltageSettingsApplied ] message received :0
    ${vacuum_VacPlutoSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoSettingsApplied start of topic ===
    ${vacuum_VacPlutoSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_VacPlutoSettingsApplied end of topic ===
    ${vacuum_VacPlutoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPlutoSettingsApplied_start}    end=${vacuum_VacPlutoSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPlutoSettingsApplied_list}
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === MTCamera_vacuum_VacPlutoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === MTCamera_vacuum_VacPlutoSettingsApplied end of topic ===
    Should Contain    ${vacuum_VacPlutoSettingsApplied_list}    === [getSample logevent_vacuum_VacPlutoSettingsApplied ] message received :0
    ${vacuum_Vacuum_stateSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied start of topic ===
    ${vacuum_Vacuum_stateSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied end of topic ===
    ${vacuum_Vacuum_stateSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Vacuum_stateSettingsApplied_start}    end=${vacuum_Vacuum_stateSettingsApplied_end + 1}
    Log Many    ${vacuum_Vacuum_stateSettingsApplied_list}
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied start of topic ===
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === MTCamera_vacuum_Vacuum_stateSettingsApplied end of topic ===
    Should Contain    ${vacuum_Vacuum_stateSettingsApplied_list}    === [getSample logevent_vacuum_Vacuum_stateSettingsApplied ] message received :0
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === [getSample logevent_daq_monitor_PeriodicTasksSettingsApplied ] message received :0
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_daq_monitor_PeriodicTasks_timersSettingsApplied ] message received :0
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === MTCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === [getSample logevent_daq_monitor_Stats_StatisticsSettingsApplied ] message received :0
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === MTCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === [getSample logevent_daq_monitor_Stats_buildSettingsApplied ] message received :0
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === MTCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === MTCamera_daq_monitor_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === [getSample logevent_daq_monitor_StoreSettingsApplied ] message received :0
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === MTCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === [getSample logevent_daq_monitor_Store_LimitsSettingsApplied ] message received :0
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === MTCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === [getSample logevent_daq_monitor_Store_StoreSettingsApplied ] message received :0
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_LimitsSettingsApplied ] message received :0
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_RaftsSettingsApplied ] message received :0
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === [getSample logevent_focal_plane_ImageDatabaseServiceSettingsApplied ] message received :0
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === MTCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === [getSample logevent_focal_plane_ImageNameServiceSettingsApplied ] message received :0
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === MTCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === [getSample logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied ] message received :0
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === [getSample logevent_focal_plane_PeriodicTasksSettingsApplied ] message received :0
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === MTCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_focal_plane_PeriodicTasks_timersSettingsApplied ] message received :0
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_RaftTempControlSettingsApplied ] message received :0
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === MTCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied ] message received :0
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === MTCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_RebTotalPower_LimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === MTCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_LimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsLimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === MTCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsPowerSettingsApplied ] message received :0
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === MTCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_timersSettingsApplied ] message received :0
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === MTCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Segment_LimitsSettingsApplied ] message received :0
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === [getSample logevent_focal_plane_SequencerConfig_DAQSettingsApplied ] message received :0
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === MTCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === [getSample logevent_focal_plane_SequencerConfig_SequencerSettingsApplied ] message received :0
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === MTCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === [getSample logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied ] message received :0
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
