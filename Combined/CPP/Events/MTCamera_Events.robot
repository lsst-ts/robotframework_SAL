*** Settings ***
Documentation    MTCamera_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_offlineDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_offlineDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event offlineDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_offlineDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event offlineDetailedState generated =
    Comment    ======= Verify ${subSystem}_endReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endReadout generated =
    Comment    ======= Verify ${subSystem}_endTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endTakeImage generated =
    Comment    ======= Verify ${subSystem}_imageReadinessDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadinessDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadinessDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadinessDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadinessDetailedState generated =
    Comment    ======= Verify ${subSystem}_startSetFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startSetFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startSetFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startSetFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startSetFilter generated =
    Comment    ======= Verify ${subSystem}_startUnloadFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startUnloadFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startUnloadFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startUnloadFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startUnloadFilter generated =
    Comment    ======= Verify ${subSystem}_notReadyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_notReadyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event notReadyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_notReadyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event notReadyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_startShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterClose generated =
    Comment    ======= Verify ${subSystem}_endInitializeGuider test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endInitializeGuider
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endInitializeGuider iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endInitializeGuider_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endInitializeGuider generated =
    Comment    ======= Verify ${subSystem}_endShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterClose generated =
    Comment    ======= Verify ${subSystem}_endOfImageTelemetry test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endOfImageTelemetry
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endOfImageTelemetry iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endOfImageTelemetry_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endOfImageTelemetry generated =
    Comment    ======= Verify ${subSystem}_endUnloadFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endUnloadFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endUnloadFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endUnloadFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endUnloadFilter generated =
    Comment    ======= Verify ${subSystem}_calibrationDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_calibrationDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event calibrationDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_calibrationDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event calibrationDetailedState generated =
    Comment    ======= Verify ${subSystem}_endRotateCarousel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endRotateCarousel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endRotateCarousel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endRotateCarousel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endRotateCarousel generated =
    Comment    ======= Verify ${subSystem}_startLoadFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startLoadFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startLoadFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startLoadFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startLoadFilter generated =
    Comment    ======= Verify ${subSystem}_filterChangerDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_filterChangerDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event filterChangerDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_filterChangerDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event filterChangerDetailedState generated =
    Comment    ======= Verify ${subSystem}_shutterDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterDetailedState generated =
    Comment    ======= Verify ${subSystem}_readyToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_readyToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event readyToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_readyToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event readyToTakeImage generated =
    Comment    ======= Verify ${subSystem}_ccsCommandState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ccsCommandState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ccsCommandState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ccsCommandState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ccsCommandState generated =
    Comment    ======= Verify ${subSystem}_prepareToTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_prepareToTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event prepareToTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_prepareToTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event prepareToTakeImage generated =
    Comment    ======= Verify ${subSystem}_ccsConfigured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ccsConfigured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ccsConfigured iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ccsConfigured_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ccsConfigured generated =
    Comment    ======= Verify ${subSystem}_endLoadFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endLoadFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endLoadFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endLoadFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endLoadFilter generated =
    Comment    ======= Verify ${subSystem}_endShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterOpen generated =
    Comment    ======= Verify ${subSystem}_startIntegration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startIntegration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startIntegration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startIntegration_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startIntegration generated =
    Comment    ======= Verify ${subSystem}_endInitializeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endInitializeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endInitializeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endInitializeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endInitializeImage generated =
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
    Comment    ======= Verify ${subSystem}_endSetFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endSetFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endSetFilter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endSetFilter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endSetFilter generated =
    Comment    ======= Verify ${subSystem}_startShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterOpen generated =
    Comment    ======= Verify ${subSystem}_raftsDetailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_raftsDetailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event raftsDetailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_raftsDetailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event raftsDetailedState generated =
    Comment    ======= Verify ${subSystem}_availableFilters test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_availableFilters
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event availableFilters iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_availableFilters_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event availableFilters generated =
    Comment    ======= Verify ${subSystem}_startReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startReadout generated =
    Comment    ======= Verify ${subSystem}_startRotateCarousel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startRotateCarousel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startRotateCarousel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startRotateCarousel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startRotateCarousel generated =
    Comment    ======= Verify ${subSystem}_imageReadoutParameters test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageReadoutParameters
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageReadoutParameters iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageReadoutParameters_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageReadoutParameters generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${offlineDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_offlineDetailedState start of topic ===
    ${offlineDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_offlineDetailedState end of topic ===
    ${offlineDetailedState_list}=    Get Slice From List    ${full_list}    start=${offlineDetailedState_start}    end=${offlineDetailedState_end}
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${offlineDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endReadout_start}=    Get Index From List    ${full_list}    === ${subSystem}_endReadout start of topic ===
    ${endReadout_end}=    Get Index From List    ${full_list}    === ${subSystem}_endReadout end of topic ===
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end}
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampEndOfReadout : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === ${subSystem}_endTakeImage start of topic ===
    ${endTakeImage_end}=    Get Index From List    ${full_list}    === ${subSystem}_endTakeImage end of topic ===
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end}
    Should Contain X Times    ${endTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageReadinessDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_imageReadinessDetailedState start of topic ===
    ${imageReadinessDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_imageReadinessDetailedState end of topic ===
    ${imageReadinessDetailedState_list}=    Get Slice From List    ${full_list}    start=${imageReadinessDetailedState_start}    end=${imageReadinessDetailedState_end}
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${imageReadinessDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startSetFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_startSetFilter start of topic ===
    ${startSetFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_startSetFilter end of topic ===
    ${startSetFilter_list}=    Get Slice From List    ${full_list}    start=${startSetFilter_start}    end=${startSetFilter_end}
    Should Contain X Times    ${startSetFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterName : LSST    1
    Should Contain X Times    ${startSetFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startUnloadFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_startUnloadFilter start of topic ===
    ${startUnloadFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_startUnloadFilter end of topic ===
    ${startUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${startUnloadFilter_start}    end=${startUnloadFilter_end}
    Should Contain X Times    ${startUnloadFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${notReadyToTakeImage_start}=    Get Index From List    ${full_list}    === ${subSystem}_notReadyToTakeImage start of topic ===
    ${notReadyToTakeImage_end}=    Get Index From List    ${full_list}    === ${subSystem}_notReadyToTakeImage end of topic ===
    ${notReadyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${notReadyToTakeImage_start}    end=${notReadyToTakeImage_end}
    Should Contain X Times    ${notReadyToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === ${subSystem}_startShutterClose start of topic ===
    ${startShutterClose_end}=    Get Index From List    ${full_list}    === ${subSystem}_startShutterClose end of topic ===
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end}
    Should Contain X Times    ${startShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endInitializeGuider_start}=    Get Index From List    ${full_list}    === ${subSystem}_endInitializeGuider start of topic ===
    ${endInitializeGuider_end}=    Get Index From List    ${full_list}    === ${subSystem}_endInitializeGuider end of topic ===
    ${endInitializeGuider_list}=    Get Slice From List    ${full_list}    start=${endInitializeGuider_start}    end=${endInitializeGuider_end}
    Should Contain X Times    ${endInitializeGuider_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === ${subSystem}_endShutterClose start of topic ===
    ${endShutterClose_end}=    Get Index From List    ${full_list}    === ${subSystem}_endShutterClose end of topic ===
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end}
    Should Contain X Times    ${endShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endOfImageTelemetry_start}=    Get Index From List    ${full_list}    === ${subSystem}_endOfImageTelemetry start of topic ===
    ${endOfImageTelemetry_end}=    Get Index From List    ${full_list}    === ${subSystem}_endOfImageTelemetry end of topic ===
    ${endOfImageTelemetry_list}=    Get Slice From List    ${full_list}    start=${endOfImageTelemetry_start}    end=${endOfImageTelemetry_end}
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageTag : LSST    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampDateObs : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampDateEnd : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkTime : 1    1
    Should Contain X Times    ${endOfImageTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endUnloadFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_endUnloadFilter start of topic ===
    ${endUnloadFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_endUnloadFilter end of topic ===
    ${endUnloadFilter_list}=    Get Slice From List    ${full_list}    start=${endUnloadFilter_start}    end=${endUnloadFilter_end}
    Should Contain X Times    ${endUnloadFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${calibrationDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_calibrationDetailedState start of topic ===
    ${calibrationDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_calibrationDetailedState end of topic ===
    ${calibrationDetailedState_list}=    Get Slice From List    ${full_list}    start=${calibrationDetailedState_start}    end=${calibrationDetailedState_end}
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${calibrationDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endRotateCarousel_start}=    Get Index From List    ${full_list}    === ${subSystem}_endRotateCarousel start of topic ===
    ${endRotateCarousel_end}=    Get Index From List    ${full_list}    === ${subSystem}_endRotateCarousel end of topic ===
    ${endRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${endRotateCarousel_start}    end=${endRotateCarousel_end}
    Should Contain X Times    ${endRotateCarousel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startLoadFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_startLoadFilter start of topic ===
    ${startLoadFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_startLoadFilter end of topic ===
    ${startLoadFilter_list}=    Get Slice From List    ${full_list}    start=${startLoadFilter_start}    end=${startLoadFilter_end}
    Should Contain X Times    ${startLoadFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${filterChangerDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_filterChangerDetailedState start of topic ===
    ${filterChangerDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_filterChangerDetailedState end of topic ===
    ${filterChangerDetailedState_list}=    Get Slice From List    ${full_list}    start=${filterChangerDetailedState_start}    end=${filterChangerDetailedState_end}
    Should Contain X Times    ${filterChangerDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${filterChangerDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_shutterDetailedState start of topic ===
    ${shutterDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_shutterDetailedState end of topic ===
    ${shutterDetailedState_list}=    Get Slice From List    ${full_list}    start=${shutterDetailedState_start}    end=${shutterDetailedState_end}
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${shutterDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${readyToTakeImage_start}=    Get Index From List    ${full_list}    === ${subSystem}_readyToTakeImage start of topic ===
    ${readyToTakeImage_end}=    Get Index From List    ${full_list}    === ${subSystem}_readyToTakeImage end of topic ===
    ${readyToTakeImage_list}=    Get Slice From List    ${full_list}    start=${readyToTakeImage_start}    end=${readyToTakeImage_end}
    Should Contain X Times    ${readyToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ccsCommandState_start}=    Get Index From List    ${full_list}    === ${subSystem}_ccsCommandState start of topic ===
    ${ccsCommandState_end}=    Get Index From List    ${full_list}    === ${subSystem}_ccsCommandState end of topic ===
    ${ccsCommandState_list}=    Get Slice From List    ${full_list}    start=${ccsCommandState_start}    end=${ccsCommandState_end}
    Should Contain X Times    ${ccsCommandState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${ccsCommandState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${prepareToTakeImage_start}=    Get Index From List    ${full_list}    === ${subSystem}_prepareToTakeImage start of topic ===
    ${prepareToTakeImage_end}=    Get Index From List    ${full_list}    === ${subSystem}_prepareToTakeImage end of topic ===
    ${prepareToTakeImage_list}=    Get Slice From List    ${full_list}    start=${prepareToTakeImage_start}    end=${prepareToTakeImage_end}
    Should Contain X Times    ${prepareToTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ccsConfigured_start}=    Get Index From List    ${full_list}    === ${subSystem}_ccsConfigured start of topic ===
    ${ccsConfigured_end}=    Get Index From List    ${full_list}    === ${subSystem}_ccsConfigured end of topic ===
    ${ccsConfigured_list}=    Get Slice From List    ${full_list}    start=${ccsConfigured_start}    end=${ccsConfigured_end}
    Should Contain X Times    ${ccsConfigured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endLoadFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_endLoadFilter start of topic ===
    ${endLoadFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_endLoadFilter end of topic ===
    ${endLoadFilter_list}=    Get Slice From List    ${full_list}    start=${endLoadFilter_start}    end=${endLoadFilter_end}
    Should Contain X Times    ${endLoadFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === ${subSystem}_endShutterOpen start of topic ===
    ${endShutterOpen_end}=    Get Index From List    ${full_list}    === ${subSystem}_endShutterOpen end of topic ===
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end}
    Should Contain X Times    ${endShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startIntegration_start}=    Get Index From List    ${full_list}    === ${subSystem}_startIntegration start of topic ===
    ${startIntegration_end}=    Get Index From List    ${full_list}    === ${subSystem}_startIntegration end of topic ===
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end}
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endInitializeImage_start}=    Get Index From List    ${full_list}    === ${subSystem}_endInitializeImage start of topic ===
    ${endInitializeImage_end}=    Get Index From List    ${full_list}    === ${subSystem}_endInitializeImage end of topic ===
    ${endInitializeImage_list}=    Get Slice From List    ${full_list}    start=${endInitializeImage_start}    end=${endInitializeImage_end}
    Should Contain X Times    ${endInitializeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settings : LSST    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endSetFilter_start}=    Get Index From List    ${full_list}    === ${subSystem}_endSetFilter start of topic ===
    ${endSetFilter_end}=    Get Index From List    ${full_list}    === ${subSystem}_endSetFilter end of topic ===
    ${endSetFilter_list}=    Get Slice From List    ${full_list}    start=${endSetFilter_start}    end=${endSetFilter_end}
    Should Contain X Times    ${endSetFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterName : LSST    1
    Should Contain X Times    ${endSetFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === ${subSystem}_startShutterOpen start of topic ===
    ${startShutterOpen_end}=    Get Index From List    ${full_list}    === ${subSystem}_startShutterOpen end of topic ===
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end}
    Should Contain X Times    ${startShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${raftsDetailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_raftsDetailedState start of topic ===
    ${raftsDetailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_raftsDetailedState end of topic ===
    ${raftsDetailedState_list}=    Get Slice From List    ${full_list}    start=${raftsDetailedState_start}    end=${raftsDetailedState_end}
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${raftsDetailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${availableFilters_start}=    Get Index From List    ${full_list}    === ${subSystem}_availableFilters start of topic ===
    ${availableFilters_end}=    Get Index From List    ${full_list}    === ${subSystem}_availableFilters end of topic ===
    ${availableFilters_list}=    Get Slice From List    ${full_list}    start=${availableFilters_start}    end=${availableFilters_end}
    Should Contain X Times    ${availableFilters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterNames : LSST    1
    Should Contain X Times    ${availableFilters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startReadout_start}=    Get Index From List    ${full_list}    === ${subSystem}_startReadout start of topic ===
    ${startReadout_end}=    Get Index From List    ${full_list}    === ${subSystem}_startReadout end of topic ===
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end}
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageType : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSource : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageController : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageDate : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageNumber : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampAcquisitionStart : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStampStartOfReadout : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startRotateCarousel_start}=    Get Index From List    ${full_list}    === ${subSystem}_startRotateCarousel start of topic ===
    ${startRotateCarousel_end}=    Get Index From List    ${full_list}    === ${subSystem}_startRotateCarousel end of topic ===
    ${startRotateCarousel_list}=    Get Slice From List    ${full_list}    start=${startRotateCarousel_start}    end=${startRotateCarousel_end}
    Should Contain X Times    ${startRotateCarousel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${imageReadoutParameters_start}=    Get Index From List    ${full_list}    === ${subSystem}_imageReadoutParameters start of topic ===
    ${imageReadoutParameters_end}=    Get Index From List    ${full_list}    === ${subSystem}_imageReadoutParameters end of topic ===
    ${imageReadoutParameters_list}=    Get Slice From List    ${full_list}    start=${imageReadoutParameters_start}    end=${imageReadoutParameters_end}
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdNames : LSST    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdType : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overRows : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overCols : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readRows : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readCols2 : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preCols : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preRows : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postCols : 0    1
    Should Contain X Times    ${imageReadoutParameters_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
