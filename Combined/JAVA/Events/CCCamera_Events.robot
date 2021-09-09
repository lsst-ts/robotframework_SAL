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
    Should Contain    ${offlineDetailedState_list}    === [putSample logevent_offlineDetailedState] writing a message containing :
    ${endReadout_start}=    Get Index From List    ${full_list}    === CCCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === CCCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === CCCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === CCCamera_endReadout end of topic ===
    Should Contain    ${endReadout_list}    === [putSample logevent_endReadout] writing a message containing :
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage end of topic ===
    Should Contain    ${endTakeImage_list}    === [putSample logevent_endTakeImage] writing a message containing :
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === [putSample logevent_imageReadinessDetailedState] writing a message containing :
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter end of topic ===
    Should Contain    ${startSetFilter_list}    === [putSample logevent_startSetFilter] writing a message containing :
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter end of topic ===
    Should Contain    ${startUnloadFilter_list}    === [putSample logevent_startUnloadFilter] writing a message containing :
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage end of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === [putSample logevent_notReadyToTakeImage] writing a message containing :
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose end of topic ===
    Should Contain    ${startShutterClose_list}    === [putSample logevent_startShutterClose] writing a message containing :
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider end of topic ===
    Should Contain    ${endInitializeGuider_list}    === [putSample logevent_endInitializeGuider] writing a message containing :
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose end of topic ===
    Should Contain    ${endShutterClose_list}    === [putSample logevent_endShutterClose] writing a message containing :
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry end of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === [putSample logevent_endOfImageTelemetry] writing a message containing :
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter end of topic ===
    Should Contain    ${endUnloadFilter_list}    === [putSample logevent_endUnloadFilter] writing a message containing :
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState end of topic ===
    Should Contain    ${calibrationDetailedState_list}    === [putSample logevent_calibrationDetailedState] writing a message containing :
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel end of topic ===
    Should Contain    ${endRotateCarousel_list}    === [putSample logevent_endRotateCarousel] writing a message containing :
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter end of topic ===
    Should Contain    ${startLoadFilter_list}    === [putSample logevent_startLoadFilter] writing a message containing :
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState end of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === [putSample logevent_filterChangerDetailedState] writing a message containing :
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState end of topic ===
    Should Contain    ${shutterDetailedState_list}    === [putSample logevent_shutterDetailedState] writing a message containing :
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage end of topic ===
    Should Contain    ${readyToTakeImage_list}    === [putSample logevent_readyToTakeImage] writing a message containing :
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState end of topic ===
    Should Contain    ${ccsCommandState_list}    === [putSample logevent_ccsCommandState] writing a message containing :
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage end of topic ===
    Should Contain    ${prepareToTakeImage_list}    === [putSample logevent_prepareToTakeImage] writing a message containing :
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured end of topic ===
    Should Contain    ${ccsConfigured_list}    === [putSample logevent_ccsConfigured] writing a message containing :
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter end of topic ===
    Should Contain    ${endLoadFilter_list}    === [putSample logevent_endLoadFilter] writing a message containing :
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen end of topic ===
    Should Contain    ${endShutterOpen_list}    === [putSample logevent_endShutterOpen] writing a message containing :
    ${startIntegration_start}=    Get Index From List    ${full_list}    === CCCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === CCCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration end of topic ===
    Should Contain    ${startIntegration_list}    === [putSample logevent_startIntegration] writing a message containing :
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage end of topic ===
    Should Contain    ${endInitializeImage_list}    === [putSample logevent_endInitializeImage] writing a message containing :
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter end of topic ===
    Should Contain    ${endSetFilter_list}    === [putSample logevent_endSetFilter] writing a message containing :
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen end of topic ===
    Should Contain    ${startShutterOpen_list}    === [putSample logevent_startShutterOpen] writing a message containing :
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState end of topic ===
    Should Contain    ${raftsDetailedState_list}    === [putSample logevent_raftsDetailedState] writing a message containing :
    ${availableFilters_start}=    Get Index From List    ${full_list}    === CCCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === CCCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters end of topic ===
    Should Contain    ${availableFilters_list}    === [putSample logevent_availableFilters] writing a message containing :
    ${startReadout_start}=    Get Index From List    ${full_list}    === CCCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === CCCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === CCCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === CCCamera_startReadout end of topic ===
    Should Contain    ${startReadout_list}    === [putSample logevent_startReadout] writing a message containing :
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel end of topic ===
    Should Contain    ${startRotateCarousel_list}    === [putSample logevent_startRotateCarousel] writing a message containing :
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters end of topic ===
    Should Contain    ${imageReadoutParameters_list}    === [putSample logevent_imageReadoutParameters] writing a message containing :
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === [putSample logevent_focalPlaneSummaryInfo] writing a message containing :
    ${fcsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied start of topic ===
    ${fcsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcsSettingsApplied_start}    end=${fcsSettingsApplied_end + 1}
    Log Many    ${fcsSettingsApplied_list}
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied start of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied end of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === [putSample logevent_fcsSettingsApplied] writing a message containing :
    ${fcs_LinearEncoderSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    ${fcs_LinearEncoderSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoderSettingsApplied_start}    end=${fcs_LinearEncoderSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoderSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === [putSample logevent_fcs_LinearEncoderSettingsApplied] writing a message containing :
    ${fcs_LinearEncoder_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_LimitsSettingsApplied_start}    end=${fcs_LinearEncoder_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoder_LimitsSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === [putSample logevent_fcs_LinearEncoder_LimitsSettingsApplied] writing a message containing :
    ${fcs_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    ${fcs_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasksSettingsApplied_start}    end=${fcs_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasksSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === [putSample logevent_fcs_PeriodicTasksSettingsApplied] writing a message containing :
    ${fcs_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersSettingsApplied_start}    end=${fcs_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_fcs_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${fcs_StepperMotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    ${fcs_StepperMotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotorSettingsApplied_start}    end=${fcs_StepperMotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === [putSample logevent_fcs_StepperMotorSettingsApplied] writing a message containing :
    ${fcs_StepperMotor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsSettingsApplied_start}    end=${fcs_StepperMotor_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === [putSample logevent_fcs_StepperMotor_LimitsSettingsApplied] writing a message containing :
    ${fcs_StepperMotor_MotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorSettingsApplied_start}    end=${fcs_StepperMotor_MotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_MotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === [putSample logevent_fcs_StepperMotor_MotorSettingsApplied] writing a message containing :
    ${bonn_shutter_Device_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralSettingsApplied_start}    end=${bonn_shutter_Device_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === [putSample logevent_bonn_shutter_Device_GeneralSettingsApplied] writing a message containing :
    ${bonn_shutter_Device_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsSettingsApplied_start}    end=${bonn_shutter_Device_LimitsSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === [putSample logevent_bonn_shutter_Device_LimitsSettingsApplied] writing a message containing :
    ${bonn_shutter_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralSettingsApplied_start}    end=${bonn_shutter_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === [putSample logevent_bonn_shutter_GeneralSettingsApplied] writing a message containing :
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === [putSample logevent_bonn_shutter_PeriodicTasksSettingsApplied] writing a message containing :
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_bonn_shutter_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === [putSample logevent_daq_monitor_PeriodicTasksSettingsApplied] writing a message containing :
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_daq_monitor_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === [putSample logevent_daq_monitor_Stats_StatisticsSettingsApplied] writing a message containing :
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === [putSample logevent_daq_monitor_Stats_buildSettingsApplied] writing a message containing :
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === [putSample logevent_daq_monitor_StoreSettingsApplied] writing a message containing :
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === [putSample logevent_daq_monitor_Store_LimitsSettingsApplied] writing a message containing :
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === [putSample logevent_daq_monitor_Store_StoreSettingsApplied] writing a message containing :
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === [putSample logevent_rebpowerSettingsApplied] writing a message containing :
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === [putSample logevent_rebpower_EmergencyResponseManagerSettingsApplied] writing a message containing :
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === [putSample logevent_rebpower_PeriodicTasksSettingsApplied] writing a message containing :
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_rebpower_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === [putSample logevent_rebpower_RebSettingsApplied] writing a message containing :
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === [putSample logevent_rebpower_Reb_LimitsSettingsApplied] writing a message containing :
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === [putSample logevent_rebpower_Rebps_LimitsSettingsApplied] writing a message containing :
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === [putSample logevent_rebpower_Rebps_PowerSettingsApplied] writing a message containing :
    ${vacuum_Cold1_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconSettingsApplied_start}    end=${vacuum_Cold1_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === [putSample logevent_vacuum_Cold1_CryoconSettingsApplied] writing a message containing :
    ${vacuum_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsSettingsApplied_start}    end=${vacuum_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_Cold1_LimitsSettingsApplied] writing a message containing :
    ${vacuum_Cold2_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconSettingsApplied_start}    end=${vacuum_Cold2_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === [putSample logevent_vacuum_Cold2_CryoconSettingsApplied] writing a message containing :
    ${vacuum_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsSettingsApplied_start}    end=${vacuum_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_Cold2_LimitsSettingsApplied] writing a message containing :
    ${vacuum_Cryo_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconSettingsApplied_start}    end=${vacuum_Cryo_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === [putSample logevent_vacuum_Cryo_CryoconSettingsApplied] writing a message containing :
    ${vacuum_Cryo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsSettingsApplied_start}    end=${vacuum_Cryo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_Cryo_LimitsSettingsApplied] writing a message containing :
    ${vacuum_IonPumps_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoSettingsApplied_start}    end=${vacuum_IonPumps_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_CryoSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === [putSample logevent_vacuum_IonPumps_CryoSettingsApplied] writing a message containing :
    ${vacuum_IonPumps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsSettingsApplied_start}    end=${vacuum_IonPumps_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_IonPumps_LimitsSettingsApplied] writing a message containing :
    ${vacuum_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasksSettingsApplied_start}    end=${vacuum_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasksSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === [putSample logevent_vacuum_PeriodicTasksSettingsApplied] writing a message containing :
    ${vacuum_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersSettingsApplied_start}    end=${vacuum_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_vacuum_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${vacuum_Rtds_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceSettingsApplied_start}    end=${vacuum_Rtds_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === [putSample logevent_vacuum_Rtds_DeviceSettingsApplied] writing a message containing :
    ${vacuum_Rtds_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsSettingsApplied_start}    end=${vacuum_Rtds_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_Rtds_LimitsSettingsApplied] writing a message containing :
    ${vacuum_TurboSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    ${vacuum_TurboSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSettingsApplied_start}    end=${vacuum_TurboSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSettingsApplied_list}
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === [putSample logevent_vacuum_TurboSettingsApplied] writing a message containing :
    ${vacuum_Turbo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsSettingsApplied_start}    end=${vacuum_Turbo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Turbo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_Turbo_LimitsSettingsApplied] writing a message containing :
    ${vacuum_VQMonitor_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoSettingsApplied_start}    end=${vacuum_VQMonitor_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === [putSample logevent_vacuum_VQMonitor_CryoSettingsApplied] writing a message containing :
    ${vacuum_VQMonitor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsSettingsApplied_start}    end=${vacuum_VQMonitor_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === [putSample logevent_vacuum_VQMonitor_LimitsSettingsApplied] writing a message containing :
    ${vacuum_VacPluto_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceSettingsApplied_start}    end=${vacuum_VacPluto_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === [putSample logevent_vacuum_VacPluto_DeviceSettingsApplied] writing a message containing :
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_BFR_LimitsSettingsApplied] writing a message containing :
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_BFR_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VC_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VC_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VD_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_24VD_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_48V_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_48V_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === [putSample logevent_quadbox_PDU_5V_LimitsSettingsApplied] writing a message containing :
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_PDU_5V_QuadboxSettingsApplied] writing a message containing :
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === [putSample logevent_quadbox_PeriodicTasksSettingsApplied] writing a message containing :
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_quadbox_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === [putSample logevent_quadbox_REB_Bulk_PS_QuadboxSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === [putSample logevent_focal_plane_Ccd_RaftsSettingsApplied] writing a message containing :
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === [putSample logevent_focal_plane_ImageDatabaseServiceSettingsApplied] writing a message containing :
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === [putSample logevent_focal_plane_ImageNameServiceSettingsApplied] writing a message containing :
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === [putSample logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied] writing a message containing :
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === [putSample logevent_focal_plane_PeriodicTasksSettingsApplied] writing a message containing :
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === [putSample logevent_focal_plane_PeriodicTasks_timersSettingsApplied] writing a message containing :
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_RaftTempControlSettingsApplied] writing a message containing :
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === [putSample logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied] writing a message containing :
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_RebTotalPower_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_HardwareIdSettingsApplied] writing a message containing :
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsLimitsSettingsApplied] writing a message containing :
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_RaftsPowerSettingsApplied] writing a message containing :
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === [putSample logevent_focal_plane_Reb_timersSettingsApplied] writing a message containing :
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === [putSample logevent_focal_plane_Segment_LimitsSettingsApplied] writing a message containing :
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === [putSample logevent_focal_plane_SequencerConfig_DAQSettingsApplied] writing a message containing :
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === [putSample logevent_focal_plane_SequencerConfig_SequencerSettingsApplied] writing a message containing :
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === [putSample logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied] writing a message containing :
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === [putSample logevent_shutterBladeMotionProfile] writing a message containing :
    ${imageStored_start}=    Get Index From List    ${full_list}    === CCCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === CCCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === CCCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === CCCamera_imageStored end of topic ===
    Should Contain    ${imageStored_list}    === [putSample logevent_imageStored] writing a message containing :
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten end of topic ===
    Should Contain    ${fitsFilesWritten_list}    === [putSample logevent_fitsFilesWritten] writing a message containing :
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution end of topic ===
    Should Contain    ${fileCommandExecution_list}    === [putSample logevent_fileCommandExecution] writing a message containing :
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization end of topic ===
    Should Contain    ${imageVisualization_list}    === [putSample logevent_imageVisualization] writing a message containing :
    ${settingVersions_start}=    Get Index From List    ${full_list}    === CCCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === CCCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === CCCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === CCCamera_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [putSample logevent_settingVersions] writing a message containing :
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCCamera_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [putSample logevent_errorCode] writing a message containing :
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCCamera_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [putSample logevent_summaryState] writing a message containing :
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === CCCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === CCCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === CCCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === CCCamera_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [putSample logevent_appliedSettingsMatchStart] writing a message containing :
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCCamera_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [putSample logevent_logLevel] writing a message containing :
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCCamera_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [putSample logevent_logMessage] writing a message containing :
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === CCCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === CCCamera_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [putSample logevent_settingsApplied] writing a message containing :
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [putSample logevent_simulationMode] writing a message containing :
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [putSample logevent_softwareVersions] writing a message containing :
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [putSample logevent_heartbeat] writing a message containing :
    ${authList_start}=    Get Index From List    ${full_list}    === CCCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCCamera_authList start of topic ===
    Should Contain    ${authList_list}    === CCCamera_authList end of topic ===
    Should Contain    ${authList_list}    === [putSample logevent_authList] writing a message containing :

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
    Should Contain    ${offlineDetailedState_list}    === [getSample logevent_offlineDetailedState ] message received :0
    ${endReadout_start}=    Get Index From List    ${full_list}    === CCCamera_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === CCCamera_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end + 1}
    Log Many    ${endReadout_list}
    Should Contain    ${endReadout_list}    === CCCamera_endReadout start of topic ===
    Should Contain    ${endReadout_list}    === CCCamera_endReadout end of topic ===
    Should Contain    ${endReadout_list}    === [getSample logevent_endReadout ] message received :0
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end + 1}
    Log Many    ${endTakeImage_list}
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage start of topic ===
    Should Contain    ${endTakeImage_list}    === CCCamera_endTakeImage end of topic ===
    Should Contain    ${endTakeImage_list}    === [getSample logevent_endTakeImage ] message received :0
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end + 1}
    Log Many    ${imageReadinessDetailedState_list}
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState start of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === CCCamera_imageReadinessDetailedState end of topic ===
    Should Contain    ${imageReadinessDetailedState_list}    === [getSample logevent_imageReadinessDetailedState ] message received :0
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end + 1}
    Log Many    ${startSetFilter_list}
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter start of topic ===
    Should Contain    ${startSetFilter_list}    === CCCamera_startSetFilter end of topic ===
    Should Contain    ${startSetFilter_list}    === [getSample logevent_startSetFilter ] message received :0
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end + 1}
    Log Many    ${startUnloadFilter_list}
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter start of topic ===
    Should Contain    ${startUnloadFilter_list}    === CCCamera_startUnloadFilter end of topic ===
    Should Contain    ${startUnloadFilter_list}    === [getSample logevent_startUnloadFilter ] message received :0
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end + 1}
    Log Many    ${notReadyToTakeImage_list}
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage start of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === CCCamera_notReadyToTakeImage end of topic ===
    Should Contain    ${notReadyToTakeImage_list}    === [getSample logevent_notReadyToTakeImage ] message received :0
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end + 1}
    Log Many    ${startShutterClose_list}
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose start of topic ===
    Should Contain    ${startShutterClose_list}    === CCCamera_startShutterClose end of topic ===
    Should Contain    ${startShutterClose_list}    === [getSample logevent_startShutterClose ] message received :0
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end + 1}
    Log Many    ${endInitializeGuider_list}
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider start of topic ===
    Should Contain    ${endInitializeGuider_list}    === CCCamera_endInitializeGuider end of topic ===
    Should Contain    ${endInitializeGuider_list}    === [getSample logevent_endInitializeGuider ] message received :0
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end + 1}
    Log Many    ${endShutterClose_list}
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose start of topic ===
    Should Contain    ${endShutterClose_list}    === CCCamera_endShutterClose end of topic ===
    Should Contain    ${endShutterClose_list}    === [getSample logevent_endShutterClose ] message received :0
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === CCCamera_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end + 1}
    Log Many    ${endOfImageTelemetry_list}
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry start of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === CCCamera_endOfImageTelemetry end of topic ===
    Should Contain    ${endOfImageTelemetry_list}    === [getSample logevent_endOfImageTelemetry ] message received :0
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end + 1}
    Log Many    ${endUnloadFilter_list}
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter start of topic ===
    Should Contain    ${endUnloadFilter_list}    === CCCamera_endUnloadFilter end of topic ===
    Should Contain    ${endUnloadFilter_list}    === [getSample logevent_endUnloadFilter ] message received :0
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end + 1}
    Log Many    ${calibrationDetailedState_list}
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState start of topic ===
    Should Contain    ${calibrationDetailedState_list}    === CCCamera_calibrationDetailedState end of topic ===
    Should Contain    ${calibrationDetailedState_list}    === [getSample logevent_calibrationDetailedState ] message received :0
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end + 1}
    Log Many    ${endRotateCarousel_list}
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel start of topic ===
    Should Contain    ${endRotateCarousel_list}    === CCCamera_endRotateCarousel end of topic ===
    Should Contain    ${endRotateCarousel_list}    === [getSample logevent_endRotateCarousel ] message received :0
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end + 1}
    Log Many    ${startLoadFilter_list}
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter start of topic ===
    Should Contain    ${startLoadFilter_list}    === CCCamera_startLoadFilter end of topic ===
    Should Contain    ${startLoadFilter_list}    === [getSample logevent_startLoadFilter ] message received :0
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end + 1}
    Log Many    ${filterChangerDetailedState_list}
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState start of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === CCCamera_filterChangerDetailedState end of topic ===
    Should Contain    ${filterChangerDetailedState_list}    === [getSample logevent_filterChangerDetailedState ] message received :0
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end + 1}
    Log Many    ${shutterDetailedState_list}
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState start of topic ===
    Should Contain    ${shutterDetailedState_list}    === CCCamera_shutterDetailedState end of topic ===
    Should Contain    ${shutterDetailedState_list}    === [getSample logevent_shutterDetailedState ] message received :0
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end + 1}
    Log Many    ${readyToTakeImage_list}
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage start of topic ===
    Should Contain    ${readyToTakeImage_list}    === CCCamera_readyToTakeImage end of topic ===
    Should Contain    ${readyToTakeImage_list}    === [getSample logevent_readyToTakeImage ] message received :0
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === CCCamera_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end + 1}
    Log Many    ${ccsCommandState_list}
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState start of topic ===
    Should Contain    ${ccsCommandState_list}    === CCCamera_ccsCommandState end of topic ===
    Should Contain    ${ccsCommandState_list}    === [getSample logevent_ccsCommandState ] message received :0
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === CCCamera_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end + 1}
    Log Many    ${prepareToTakeImage_list}
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage start of topic ===
    Should Contain    ${prepareToTakeImage_list}    === CCCamera_prepareToTakeImage end of topic ===
    Should Contain    ${prepareToTakeImage_list}    === [getSample logevent_prepareToTakeImage ] message received :0
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === CCCamera_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end + 1}
    Log Many    ${ccsConfigured_list}
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured start of topic ===
    Should Contain    ${ccsConfigured_list}    === CCCamera_ccsConfigured end of topic ===
    Should Contain    ${ccsConfigured_list}    === [getSample logevent_ccsConfigured ] message received :0
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end + 1}
    Log Many    ${endLoadFilter_list}
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter start of topic ===
    Should Contain    ${endLoadFilter_list}    === CCCamera_endLoadFilter end of topic ===
    Should Contain    ${endLoadFilter_list}    === [getSample logevent_endLoadFilter ] message received :0
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end + 1}
    Log Many    ${endShutterOpen_list}
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen start of topic ===
    Should Contain    ${endShutterOpen_list}    === CCCamera_endShutterOpen end of topic ===
    Should Contain    ${endShutterOpen_list}    === [getSample logevent_endShutterOpen ] message received :0
    ${startIntegration_start}=    Get Index From List    ${full_list}    === CCCamera_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === CCCamera_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end + 1}
    Log Many    ${startIntegration_list}
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration start of topic ===
    Should Contain    ${startIntegration_list}    === CCCamera_startIntegration end of topic ===
    Should Contain    ${startIntegration_list}    === [getSample logevent_startIntegration ] message received :0
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === CCCamera_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end + 1}
    Log Many    ${endInitializeImage_list}
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage start of topic ===
    Should Contain    ${endInitializeImage_list}    === CCCamera_endInitializeImage end of topic ===
    Should Contain    ${endInitializeImage_list}    === [getSample logevent_endInitializeImage ] message received :0
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === CCCamera_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end + 1}
    Log Many    ${endSetFilter_list}
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter start of topic ===
    Should Contain    ${endSetFilter_list}    === CCCamera_endSetFilter end of topic ===
    Should Contain    ${endSetFilter_list}    === [getSample logevent_endSetFilter ] message received :0
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === CCCamera_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end + 1}
    Log Many    ${startShutterOpen_list}
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen start of topic ===
    Should Contain    ${startShutterOpen_list}    === CCCamera_startShutterOpen end of topic ===
    Should Contain    ${startShutterOpen_list}    === [getSample logevent_startShutterOpen ] message received :0
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === CCCamera_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end + 1}
    Log Many    ${raftsDetailedState_list}
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState start of topic ===
    Should Contain    ${raftsDetailedState_list}    === CCCamera_raftsDetailedState end of topic ===
    Should Contain    ${raftsDetailedState_list}    === [getSample logevent_raftsDetailedState ] message received :0
    ${availableFilters_start}=    Get Index From List    ${full_list}    === CCCamera_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === CCCamera_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end + 1}
    Log Many    ${availableFilters_list}
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters start of topic ===
    Should Contain    ${availableFilters_list}    === CCCamera_availableFilters end of topic ===
    Should Contain    ${availableFilters_list}    === [getSample logevent_availableFilters ] message received :0
    ${startReadout_start}=    Get Index From List    ${full_list}    === CCCamera_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === CCCamera_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end + 1}
    Log Many    ${startReadout_list}
    Should Contain    ${startReadout_list}    === CCCamera_startReadout start of topic ===
    Should Contain    ${startReadout_list}    === CCCamera_startReadout end of topic ===
    Should Contain    ${startReadout_list}    === [getSample logevent_startReadout ] message received :0
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === CCCamera_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end + 1}
    Log Many    ${startRotateCarousel_list}
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel start of topic ===
    Should Contain    ${startRotateCarousel_list}    === CCCamera_startRotateCarousel end of topic ===
    Should Contain    ${startRotateCarousel_list}    === [getSample logevent_startRotateCarousel ] message received :0
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === CCCamera_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end + 1}
    Log Many    ${imageReadoutParameters_list}
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters start of topic ===
    Should Contain    ${imageReadoutParameters_list}    === CCCamera_imageReadoutParameters end of topic ===
    Should Contain    ${imageReadoutParameters_list}    === [getSample logevent_imageReadoutParameters ] message received :0
    ${focalPlaneSummaryInfo_start}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    ${focalPlaneSummaryInfo_end}=    Get Index From List    ${full_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    ${focalPlaneSummaryInfo_list}=    Get Slice From List    ${full_list}    start=${focalPlaneSummaryInfo_start}    end=${focalPlaneSummaryInfo_end + 1}
    Log Many    ${focalPlaneSummaryInfo_list}
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo start of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === CCCamera_focalPlaneSummaryInfo end of topic ===
    Should Contain    ${focalPlaneSummaryInfo_list}    === [getSample logevent_focalPlaneSummaryInfo ] message received :0
    ${fcsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied start of topic ===
    ${fcsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcsSettingsApplied end of topic ===
    ${fcsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcsSettingsApplied_start}    end=${fcsSettingsApplied_end + 1}
    Log Many    ${fcsSettingsApplied_list}
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied start of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === CCCamera_fcsSettingsApplied end of topic ===
    Should Contain    ${fcsSettingsApplied_list}    === [getSample logevent_fcsSettingsApplied ] message received :0
    ${fcs_LinearEncoderSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    ${fcs_LinearEncoderSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    ${fcs_LinearEncoderSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoderSettingsApplied_start}    end=${fcs_LinearEncoderSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoderSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === CCCamera_fcs_LinearEncoderSettingsApplied end of topic ===
    Should Contain    ${fcs_LinearEncoderSettingsApplied_list}    === [getSample logevent_fcs_LinearEncoderSettingsApplied ] message received :0
    ${fcs_LinearEncoder_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    ${fcs_LinearEncoder_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_LinearEncoder_LimitsSettingsApplied_start}    end=${fcs_LinearEncoder_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_LinearEncoder_LimitsSettingsApplied_list}
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === CCCamera_fcs_LinearEncoder_LimitsSettingsApplied end of topic ===
    Should Contain    ${fcs_LinearEncoder_LimitsSettingsApplied_list}    === [getSample logevent_fcs_LinearEncoder_LimitsSettingsApplied ] message received :0
    ${fcs_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    ${fcs_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    ${fcs_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasksSettingsApplied_start}    end=${fcs_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasksSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === CCCamera_fcs_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${fcs_PeriodicTasksSettingsApplied_list}    === [getSample logevent_fcs_PeriodicTasksSettingsApplied ] message received :0
    ${fcs_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    ${fcs_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_PeriodicTasks_timersSettingsApplied_start}    end=${fcs_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${fcs_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_fcs_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${fcs_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_fcs_PeriodicTasks_timersSettingsApplied ] message received :0
    ${fcs_StepperMotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    ${fcs_StepperMotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    ${fcs_StepperMotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotorSettingsApplied_start}    end=${fcs_StepperMotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === CCCamera_fcs_StepperMotorSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotorSettingsApplied_list}    === [getSample logevent_fcs_StepperMotorSettingsApplied ] message received :0
    ${fcs_StepperMotor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    ${fcs_StepperMotor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_LimitsSettingsApplied_start}    end=${fcs_StepperMotor_LimitsSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_LimitsSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === CCCamera_fcs_StepperMotor_LimitsSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotor_LimitsSettingsApplied_list}    === [getSample logevent_fcs_StepperMotor_LimitsSettingsApplied ] message received :0
    ${fcs_StepperMotor_MotorSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    ${fcs_StepperMotor_MotorSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${fcs_StepperMotor_MotorSettingsApplied_start}    end=${fcs_StepperMotor_MotorSettingsApplied_end + 1}
    Log Many    ${fcs_StepperMotor_MotorSettingsApplied_list}
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied start of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === CCCamera_fcs_StepperMotor_MotorSettingsApplied end of topic ===
    Should Contain    ${fcs_StepperMotor_MotorSettingsApplied_list}    === [getSample logevent_fcs_StepperMotor_MotorSettingsApplied ] message received :0
    ${bonn_shutter_Device_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_Device_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_GeneralSettingsApplied_start}    end=${bonn_shutter_Device_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_Device_GeneralSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_Device_GeneralSettingsApplied_list}    === [getSample logevent_bonn_shutter_Device_GeneralSettingsApplied ] message received :0
    ${bonn_shutter_Device_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    ${bonn_shutter_Device_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_LimitsSettingsApplied_start}    end=${bonn_shutter_Device_LimitsSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_Device_LimitsSettingsApplied_list}
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === CCCamera_bonn_shutter_Device_LimitsSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_Device_LimitsSettingsApplied_list}    === [getSample logevent_bonn_shutter_Device_LimitsSettingsApplied ] message received :0
    ${bonn_shutter_GeneralSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    ${bonn_shutter_GeneralSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    ${bonn_shutter_GeneralSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_GeneralSettingsApplied_start}    end=${bonn_shutter_GeneralSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_GeneralSettingsApplied_list}
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === CCCamera_bonn_shutter_GeneralSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_GeneralSettingsApplied_list}    === [getSample logevent_bonn_shutter_GeneralSettingsApplied ] message received :0
    ${bonn_shutter_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasksSettingsApplied_start}    end=${bonn_shutter_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasksSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasksSettingsApplied_list}    === [getSample logevent_bonn_shutter_PeriodicTasksSettingsApplied ] message received :0
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_PeriodicTasks_timersSettingsApplied_start}    end=${bonn_shutter_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_bonn_shutter_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${bonn_shutter_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_bonn_shutter_PeriodicTasks_timersSettingsApplied ] message received :0
    ${daq_monitor_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasksSettingsApplied_start}    end=${daq_monitor_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasksSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasksSettingsApplied_list}    === [getSample logevent_daq_monitor_PeriodicTasksSettingsApplied ] message received :0
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_PeriodicTasks_timersSettingsApplied_start}    end=${daq_monitor_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_daq_monitor_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_daq_monitor_PeriodicTasks_timersSettingsApplied ] message received :0
    ${daq_monitor_Stats_StatisticsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    ${daq_monitor_Stats_StatisticsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_StatisticsSettingsApplied_start}    end=${daq_monitor_Stats_StatisticsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_StatisticsSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === CCCamera_daq_monitor_Stats_StatisticsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_StatisticsSettingsApplied_list}    === [getSample logevent_daq_monitor_Stats_StatisticsSettingsApplied ] message received :0
    ${daq_monitor_Stats_buildSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    ${daq_monitor_Stats_buildSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Stats_buildSettingsApplied_start}    end=${daq_monitor_Stats_buildSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Stats_buildSettingsApplied_list}
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === CCCamera_daq_monitor_Stats_buildSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Stats_buildSettingsApplied_list}    === [getSample logevent_daq_monitor_Stats_buildSettingsApplied ] message received :0
    ${daq_monitor_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    ${daq_monitor_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    ${daq_monitor_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_StoreSettingsApplied_start}    end=${daq_monitor_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === CCCamera_daq_monitor_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_StoreSettingsApplied_list}    === [getSample logevent_daq_monitor_StoreSettingsApplied ] message received :0
    ${daq_monitor_Store_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    ${daq_monitor_Store_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_LimitsSettingsApplied_start}    end=${daq_monitor_Store_LimitsSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_LimitsSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === CCCamera_daq_monitor_Store_LimitsSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_LimitsSettingsApplied_list}    === [getSample logevent_daq_monitor_Store_LimitsSettingsApplied ] message received :0
    ${daq_monitor_Store_StoreSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    ${daq_monitor_Store_StoreSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_StoreSettingsApplied_start}    end=${daq_monitor_Store_StoreSettingsApplied_end + 1}
    Log Many    ${daq_monitor_Store_StoreSettingsApplied_list}
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied start of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === CCCamera_daq_monitor_Store_StoreSettingsApplied end of topic ===
    Should Contain    ${daq_monitor_Store_StoreSettingsApplied_list}    === [getSample logevent_daq_monitor_Store_StoreSettingsApplied ] message received :0
    ${rebpowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    ${rebpowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    ${rebpowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpowerSettingsApplied_start}    end=${rebpowerSettingsApplied_end + 1}
    Log Many    ${rebpowerSettingsApplied_list}
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied start of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === CCCamera_rebpowerSettingsApplied end of topic ===
    Should Contain    ${rebpowerSettingsApplied_list}    === [getSample logevent_rebpowerSettingsApplied ] message received :0
    ${rebpower_EmergencyResponseManagerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    ${rebpower_EmergencyResponseManagerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_EmergencyResponseManagerSettingsApplied_start}    end=${rebpower_EmergencyResponseManagerSettingsApplied_end + 1}
    Log Many    ${rebpower_EmergencyResponseManagerSettingsApplied_list}
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied start of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === CCCamera_rebpower_EmergencyResponseManagerSettingsApplied end of topic ===
    Should Contain    ${rebpower_EmergencyResponseManagerSettingsApplied_list}    === [getSample logevent_rebpower_EmergencyResponseManagerSettingsApplied ] message received :0
    ${rebpower_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    ${rebpower_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasksSettingsApplied_start}    end=${rebpower_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasksSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasksSettingsApplied_list}    === [getSample logevent_rebpower_PeriodicTasksSettingsApplied ] message received :0
    ${rebpower_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    ${rebpower_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_PeriodicTasks_timersSettingsApplied_start}    end=${rebpower_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${rebpower_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_rebpower_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${rebpower_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_rebpower_PeriodicTasks_timersSettingsApplied ] message received :0
    ${rebpower_RebSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    ${rebpower_RebSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    ${rebpower_RebSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebSettingsApplied_start}    end=${rebpower_RebSettingsApplied_end + 1}
    Log Many    ${rebpower_RebSettingsApplied_list}
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied start of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === CCCamera_rebpower_RebSettingsApplied end of topic ===
    Should Contain    ${rebpower_RebSettingsApplied_list}    === [getSample logevent_rebpower_RebSettingsApplied ] message received :0
    ${rebpower_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    ${rebpower_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_LimitsSettingsApplied_start}    end=${rebpower_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Reb_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === CCCamera_rebpower_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Reb_LimitsSettingsApplied_list}    === [getSample logevent_rebpower_Reb_LimitsSettingsApplied ] message received :0
    ${rebpower_Rebps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    ${rebpower_Rebps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_LimitsSettingsApplied_start}    end=${rebpower_Rebps_LimitsSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_LimitsSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === CCCamera_rebpower_Rebps_LimitsSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_LimitsSettingsApplied_list}    === [getSample logevent_rebpower_Rebps_LimitsSettingsApplied ] message received :0
    ${rebpower_Rebps_PowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    ${rebpower_Rebps_PowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_PowerSettingsApplied_start}    end=${rebpower_Rebps_PowerSettingsApplied_end + 1}
    Log Many    ${rebpower_Rebps_PowerSettingsApplied_list}
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied start of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === CCCamera_rebpower_Rebps_PowerSettingsApplied end of topic ===
    Should Contain    ${rebpower_Rebps_PowerSettingsApplied_list}    === [getSample logevent_rebpower_Rebps_PowerSettingsApplied ] message received :0
    ${vacuum_Cold1_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold1_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_CryoconSettingsApplied_start}    end=${vacuum_Cold1_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold1_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold1_CryoconSettingsApplied_list}    === [getSample logevent_vacuum_Cold1_CryoconSettingsApplied ] message received :0
    ${vacuum_Cold1_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold1_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_LimitsSettingsApplied_start}    end=${vacuum_Cold1_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold1_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold1_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold1_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_Cold1_LimitsSettingsApplied ] message received :0
    ${vacuum_Cold2_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    ${vacuum_Cold2_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_CryoconSettingsApplied_start}    end=${vacuum_Cold2_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cold2_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold2_CryoconSettingsApplied_list}    === [getSample logevent_vacuum_Cold2_CryoconSettingsApplied ] message received :0
    ${vacuum_Cold2_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    ${vacuum_Cold2_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_LimitsSettingsApplied_start}    end=${vacuum_Cold2_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cold2_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cold2_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cold2_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_Cold2_LimitsSettingsApplied ] message received :0
    ${vacuum_Cryo_CryoconSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    ${vacuum_Cryo_CryoconSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_CryoconSettingsApplied_start}    end=${vacuum_Cryo_CryoconSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_CryoconSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === CCCamera_vacuum_Cryo_CryoconSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cryo_CryoconSettingsApplied_list}    === [getSample logevent_vacuum_Cryo_CryoconSettingsApplied ] message received :0
    ${vacuum_Cryo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    ${vacuum_Cryo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_LimitsSettingsApplied_start}    end=${vacuum_Cryo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Cryo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Cryo_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Cryo_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_Cryo_LimitsSettingsApplied ] message received :0
    ${vacuum_IonPumps_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    ${vacuum_IonPumps_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_CryoSettingsApplied_start}    end=${vacuum_IonPumps_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_CryoSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === CCCamera_vacuum_IonPumps_CryoSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumps_CryoSettingsApplied_list}    === [getSample logevent_vacuum_IonPumps_CryoSettingsApplied ] message received :0
    ${vacuum_IonPumps_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    ${vacuum_IonPumps_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_LimitsSettingsApplied_start}    end=${vacuum_IonPumps_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_IonPumps_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === CCCamera_vacuum_IonPumps_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_IonPumps_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_IonPumps_LimitsSettingsApplied ] message received :0
    ${vacuum_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    ${vacuum_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasksSettingsApplied_start}    end=${vacuum_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasksSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${vacuum_PeriodicTasksSettingsApplied_list}    === [getSample logevent_vacuum_PeriodicTasksSettingsApplied ] message received :0
    ${vacuum_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    ${vacuum_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_PeriodicTasks_timersSettingsApplied_start}    end=${vacuum_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${vacuum_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_vacuum_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${vacuum_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_vacuum_PeriodicTasks_timersSettingsApplied ] message received :0
    ${vacuum_Rtds_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    ${vacuum_Rtds_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_DeviceSettingsApplied_start}    end=${vacuum_Rtds_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === CCCamera_vacuum_Rtds_DeviceSettingsApplied end of topic ===
    Should Contain    ${vacuum_Rtds_DeviceSettingsApplied_list}    === [getSample logevent_vacuum_Rtds_DeviceSettingsApplied ] message received :0
    ${vacuum_Rtds_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    ${vacuum_Rtds_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_LimitsSettingsApplied_start}    end=${vacuum_Rtds_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Rtds_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === CCCamera_vacuum_Rtds_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Rtds_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_Rtds_LimitsSettingsApplied ] message received :0
    ${vacuum_TurboSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    ${vacuum_TurboSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    ${vacuum_TurboSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSettingsApplied_start}    end=${vacuum_TurboSettingsApplied_end + 1}
    Log Many    ${vacuum_TurboSettingsApplied_list}
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied start of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === CCCamera_vacuum_TurboSettingsApplied end of topic ===
    Should Contain    ${vacuum_TurboSettingsApplied_list}    === [getSample logevent_vacuum_TurboSettingsApplied ] message received :0
    ${vacuum_Turbo_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    ${vacuum_Turbo_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_LimitsSettingsApplied_start}    end=${vacuum_Turbo_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_Turbo_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === CCCamera_vacuum_Turbo_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_Turbo_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_Turbo_LimitsSettingsApplied ] message received :0
    ${vacuum_VQMonitor_CryoSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    ${vacuum_VQMonitor_CryoSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_CryoSettingsApplied_start}    end=${vacuum_VQMonitor_CryoSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_CryoSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_CryoSettingsApplied end of topic ===
    Should Contain    ${vacuum_VQMonitor_CryoSettingsApplied_list}    === [getSample logevent_vacuum_VQMonitor_CryoSettingsApplied ] message received :0
    ${vacuum_VQMonitor_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    ${vacuum_VQMonitor_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_LimitsSettingsApplied_start}    end=${vacuum_VQMonitor_LimitsSettingsApplied_end + 1}
    Log Many    ${vacuum_VQMonitor_LimitsSettingsApplied_list}
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied start of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === CCCamera_vacuum_VQMonitor_LimitsSettingsApplied end of topic ===
    Should Contain    ${vacuum_VQMonitor_LimitsSettingsApplied_list}    === [getSample logevent_vacuum_VQMonitor_LimitsSettingsApplied ] message received :0
    ${vacuum_VacPluto_DeviceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    ${vacuum_VacPluto_DeviceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${vacuum_VacPluto_DeviceSettingsApplied_start}    end=${vacuum_VacPluto_DeviceSettingsApplied_end + 1}
    Log Many    ${vacuum_VacPluto_DeviceSettingsApplied_list}
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied start of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === CCCamera_vacuum_VacPluto_DeviceSettingsApplied end of topic ===
    Should Contain    ${vacuum_VacPluto_DeviceSettingsApplied_list}    === [getSample logevent_vacuum_VacPluto_DeviceSettingsApplied ] message received :0
    ${quadbox_BFR_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    ${quadbox_BFR_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_LimitsSettingsApplied_start}    end=${quadbox_BFR_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === CCCamera_quadbox_BFR_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_BFR_LimitsSettingsApplied ] message received :0
    ${quadbox_BFR_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    ${quadbox_BFR_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_QuadboxSettingsApplied_start}    end=${quadbox_BFR_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_BFR_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === CCCamera_quadbox_BFR_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_BFR_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_BFR_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_24VC_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VC_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VC_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VC_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VC_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VC_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VC_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_24VD_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_LimitsSettingsApplied_start}    end=${quadbox_PDU_24VD_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VD_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_QuadboxSettingsApplied_start}    end=${quadbox_PDU_24VD_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_24VD_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_24VD_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_24VD_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_48V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_48V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_LimitsSettingsApplied_start}    end=${quadbox_PDU_48V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_48V_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_48V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_48V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_48V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_48V_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_48V_QuadboxSettingsApplied ] message received :0
    ${quadbox_PDU_5V_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    ${quadbox_PDU_5V_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_LimitsSettingsApplied_start}    end=${quadbox_PDU_5V_LimitsSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_LimitsSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_LimitsSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_LimitsSettingsApplied_list}    === [getSample logevent_quadbox_PDU_5V_LimitsSettingsApplied ] message received :0
    ${quadbox_PDU_5V_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_QuadboxSettingsApplied_start}    end=${quadbox_PDU_5V_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === CCCamera_quadbox_PDU_5V_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_PDU_5V_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_PDU_5V_QuadboxSettingsApplied ] message received :0
    ${quadbox_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    ${quadbox_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasksSettingsApplied_start}    end=${quadbox_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasksSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasksSettingsApplied_list}    === [getSample logevent_quadbox_PeriodicTasksSettingsApplied ] message received :0
    ${quadbox_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    ${quadbox_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_PeriodicTasks_timersSettingsApplied_start}    end=${quadbox_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${quadbox_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_quadbox_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${quadbox_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_quadbox_PeriodicTasks_timersSettingsApplied ] message received :0
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_start}    end=${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === CCCamera_quadbox_REB_Bulk_PS_QuadboxSettingsApplied end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_QuadboxSettingsApplied_list}    === [getSample logevent_quadbox_REB_Bulk_PS_QuadboxSettingsApplied ] message received :0
    ${focal_plane_Ccd_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_HardwareIdSettingsApplied_start}    end=${focal_plane_Ccd_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Ccd_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Ccd_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    ${focal_plane_Ccd_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_LimitsSettingsApplied_start}    end=${focal_plane_Ccd_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_LimitsSettingsApplied ] message received :0
    ${focal_plane_Ccd_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    ${focal_plane_Ccd_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_RaftsSettingsApplied_start}    end=${focal_plane_Ccd_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Ccd_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Ccd_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Ccd_RaftsSettingsApplied_list}    === [getSample logevent_focal_plane_Ccd_RaftsSettingsApplied ] message received :0
    ${focal_plane_ImageDatabaseServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageDatabaseServiceSettingsApplied_start}    end=${focal_plane_ImageDatabaseServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageDatabaseServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageDatabaseServiceSettingsApplied_list}    === [getSample logevent_focal_plane_ImageDatabaseServiceSettingsApplied ] message received :0
    ${focal_plane_ImageNameServiceSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    ${focal_plane_ImageNameServiceSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_ImageNameServiceSettingsApplied_start}    end=${focal_plane_ImageNameServiceSettingsApplied_end + 1}
    Log Many    ${focal_plane_ImageNameServiceSettingsApplied_list}
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied start of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === CCCamera_focal_plane_ImageNameServiceSettingsApplied end of topic ===
    Should Contain    ${focal_plane_ImageNameServiceSettingsApplied_list}    === [getSample logevent_focal_plane_ImageNameServiceSettingsApplied ] message received :0
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_start}    end=${focal_plane_InstrumentConfig_InstrumentSettingsApplied_end + 1}
    Log Many    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied start of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === CCCamera_focal_plane_InstrumentConfig_InstrumentSettingsApplied end of topic ===
    Should Contain    ${focal_plane_InstrumentConfig_InstrumentSettingsApplied_list}    === [getSample logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied ] message received :0
    ${focal_plane_PeriodicTasksSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasksSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasksSettingsApplied_start}    end=${focal_plane_PeriodicTasksSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasksSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasksSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasksSettingsApplied_list}    === [getSample logevent_focal_plane_PeriodicTasksSettingsApplied ] message received :0
    ${focal_plane_PeriodicTasks_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_PeriodicTasks_timersSettingsApplied_start}    end=${focal_plane_PeriodicTasks_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === CCCamera_focal_plane_PeriodicTasks_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_PeriodicTasks_timersSettingsApplied_list}    === [getSample logevent_focal_plane_PeriodicTasks_timersSettingsApplied ] message received :0
    ${focal_plane_Raft_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Raft_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_HardwareIdSettingsApplied_start}    end=${focal_plane_Raft_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Raft_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Raft_RaftTempControlSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_RaftTempControlSettingsApplied ] message received :0
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_start}    end=${focal_plane_Raft_RaftTempControlStatusSettingsApplied_end + 1}
    Log Many    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === CCCamera_focal_plane_Raft_RaftTempControlStatusSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Raft_RaftTempControlStatusSettingsApplied_list}    === [getSample logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied ] message received :0
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_LimitsSettingsApplied_start}    end=${focal_plane_RebTotalPower_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === CCCamera_focal_plane_RebTotalPower_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_RebTotalPower_LimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_HardwareIdSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    ${focal_plane_Reb_HardwareIdSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_HardwareIdSettingsApplied_start}    end=${focal_plane_Reb_HardwareIdSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_HardwareIdSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === CCCamera_focal_plane_Reb_HardwareIdSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_HardwareIdSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_HardwareIdSettingsApplied ] message received :0
    ${focal_plane_Reb_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_LimitsSettingsApplied_start}    end=${focal_plane_Reb_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_LimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsSettingsApplied_start}    end=${focal_plane_Reb_RaftsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsLimitsSettingsApplied_start}    end=${focal_plane_Reb_RaftsLimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsLimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsLimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsLimitsSettingsApplied ] message received :0
    ${focal_plane_Reb_RaftsPowerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_RaftsPowerSettingsApplied_start}    end=${focal_plane_Reb_RaftsPowerSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === CCCamera_focal_plane_Reb_RaftsPowerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_RaftsPowerSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_RaftsPowerSettingsApplied ] message received :0
    ${focal_plane_Reb_timersSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    ${focal_plane_Reb_timersSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    ${focal_plane_Reb_timersSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_timersSettingsApplied_start}    end=${focal_plane_Reb_timersSettingsApplied_end + 1}
    Log Many    ${focal_plane_Reb_timersSettingsApplied_list}
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === CCCamera_focal_plane_Reb_timersSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Reb_timersSettingsApplied_list}    === [getSample logevent_focal_plane_Reb_timersSettingsApplied ] message received :0
    ${focal_plane_Segment_LimitsSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    ${focal_plane_Segment_LimitsSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_LimitsSettingsApplied_start}    end=${focal_plane_Segment_LimitsSettingsApplied_end + 1}
    Log Many    ${focal_plane_Segment_LimitsSettingsApplied_list}
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied start of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === CCCamera_focal_plane_Segment_LimitsSettingsApplied end of topic ===
    Should Contain    ${focal_plane_Segment_LimitsSettingsApplied_list}    === [getSample logevent_focal_plane_Segment_LimitsSettingsApplied ] message received :0
    ${focal_plane_SequencerConfig_DAQSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_DAQSettingsApplied_start}    end=${focal_plane_SequencerConfig_DAQSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_DAQSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_DAQSettingsApplied_list}    === [getSample logevent_focal_plane_SequencerConfig_DAQSettingsApplied ] message received :0
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_SequencerConfig_SequencerSettingsApplied_start}    end=${focal_plane_SequencerConfig_SequencerSettingsApplied_end + 1}
    Log Many    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied start of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === CCCamera_focal_plane_SequencerConfig_SequencerSettingsApplied end of topic ===
    Should Contain    ${focal_plane_SequencerConfig_SequencerSettingsApplied_list}    === [getSample logevent_focal_plane_SequencerConfig_SequencerSettingsApplied ] message received :0
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}=    Get Slice From List    ${full_list}    start=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_start}    end=${focal_plane_WebHooksConfig_VisualizationSettingsApplied_end + 1}
    Log Many    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied start of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === CCCamera_focal_plane_WebHooksConfig_VisualizationSettingsApplied end of topic ===
    Should Contain    ${focal_plane_WebHooksConfig_VisualizationSettingsApplied_list}    === [getSample logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied ] message received :0
    ${shutterBladeMotionProfile_start}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    ${shutterBladeMotionProfile_end}=    Get Index From List    ${full_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    ${shutterBladeMotionProfile_list}=    Get Slice From List    ${full_list}    start=${shutterBladeMotionProfile_start}    end=${shutterBladeMotionProfile_end + 1}
    Log Many    ${shutterBladeMotionProfile_list}
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile start of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === CCCamera_shutterBladeMotionProfile end of topic ===
    Should Contain    ${shutterBladeMotionProfile_list}    === [getSample logevent_shutterBladeMotionProfile ] message received :0
    ${imageStored_start}=    Get Index From List    ${full_list}    === CCCamera_imageStored start of topic ===
    ${imageStored_end}=    Get Index From List    ${full_list}    === CCCamera_imageStored end of topic ===
    ${imageStored_list}=    Get Slice From List    ${full_list}    start=${imageStored_start}    end=${imageStored_end + 1}
    Log Many    ${imageStored_list}
    Should Contain    ${imageStored_list}    === CCCamera_imageStored start of topic ===
    Should Contain    ${imageStored_list}    === CCCamera_imageStored end of topic ===
    Should Contain    ${imageStored_list}    === [getSample logevent_imageStored ] message received :0
    ${fitsFilesWritten_start}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten start of topic ===
    ${fitsFilesWritten_end}=    Get Index From List    ${full_list}    === CCCamera_fitsFilesWritten end of topic ===
    ${fitsFilesWritten_list}=    Get Slice From List    ${full_list}    start=${fitsFilesWritten_start}    end=${fitsFilesWritten_end + 1}
    Log Many    ${fitsFilesWritten_list}
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten start of topic ===
    Should Contain    ${fitsFilesWritten_list}    === CCCamera_fitsFilesWritten end of topic ===
    Should Contain    ${fitsFilesWritten_list}    === [getSample logevent_fitsFilesWritten ] message received :0
    ${fileCommandExecution_start}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution start of topic ===
    ${fileCommandExecution_end}=    Get Index From List    ${full_list}    === CCCamera_fileCommandExecution end of topic ===
    ${fileCommandExecution_list}=    Get Slice From List    ${full_list}    start=${fileCommandExecution_start}    end=${fileCommandExecution_end + 1}
    Log Many    ${fileCommandExecution_list}
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution start of topic ===
    Should Contain    ${fileCommandExecution_list}    === CCCamera_fileCommandExecution end of topic ===
    Should Contain    ${fileCommandExecution_list}    === [getSample logevent_fileCommandExecution ] message received :0
    ${imageVisualization_start}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization start of topic ===
    ${imageVisualization_end}=    Get Index From List    ${full_list}    === CCCamera_imageVisualization end of topic ===
    ${imageVisualization_list}=    Get Slice From List    ${full_list}    start=${imageVisualization_start}    end=${imageVisualization_end + 1}
    Log Many    ${imageVisualization_list}
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization start of topic ===
    Should Contain    ${imageVisualization_list}    === CCCamera_imageVisualization end of topic ===
    Should Contain    ${imageVisualization_list}    === [getSample logevent_imageVisualization ] message received :0
    ${settingVersions_start}=    Get Index From List    ${full_list}    === CCCamera_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === CCCamera_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === CCCamera_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === CCCamera_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [getSample logevent_settingVersions ] message received :0
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCCamera_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCCamera_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCCamera_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCCamera_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [getSample logevent_errorCode ] message received :0
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCCamera_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCCamera_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCCamera_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCCamera_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [getSample logevent_summaryState ] message received :0
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === CCCamera_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === CCCamera_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === CCCamera_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === CCCamera_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [getSample logevent_appliedSettingsMatchStart ] message received :0
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCCamera_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCCamera_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCCamera_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCCamera_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [getSample logevent_logLevel ] message received :0
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCCamera_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCCamera_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCCamera_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCCamera_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [getSample logevent_logMessage ] message received :0
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === CCCamera_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === CCCamera_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === CCCamera_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === CCCamera_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [getSample logevent_settingsApplied ] message received :0
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCCamera_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCCamera_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCCamera_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [getSample logevent_simulationMode ] message received :0
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCCamera_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCCamera_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [getSample logevent_softwareVersions ] message received :0
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCCamera_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [getSample logevent_heartbeat ] message received :0
    ${authList_start}=    Get Index From List    ${full_list}    === CCCamera_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCCamera_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCCamera_authList start of topic ===
    Should Contain    ${authList_list}    === CCCamera_authList end of topic ===
    Should Contain    ${authList_list}    === [getSample logevent_authList ] message received :0
