*** Settings ***
Documentation    GenericCamera_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    GenericCamera
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cameraInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraInfo generated =
    Comment    ======= Verify ${subSystem}_cameraSpecificProperty test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraSpecificProperty
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraSpecificProperty iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraSpecificProperty_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraSpecificProperty generated =
    Comment    ======= Verify ${subSystem}_roi test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_roi
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event roi iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_roi_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event roi generated =
    Comment    ======= Verify ${subSystem}_startLiveView test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startLiveView
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startLiveView iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startLiveView_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startLiveView generated =
    Comment    ======= Verify ${subSystem}_endLiveView test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endLiveView
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endLiveView iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endLiveView_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endLiveView generated =
    Comment    ======= Verify ${subSystem}_startTakeImage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startTakeImage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startTakeImage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startTakeImage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startTakeImage generated =
    Comment    ======= Verify ${subSystem}_startShutterOpen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterOpen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterOpen iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterOpen_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterOpen generated =
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
    Comment    ======= Verify ${subSystem}_endIntegration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endIntegration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endIntegration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endIntegration_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endIntegration generated =
    Comment    ======= Verify ${subSystem}_startShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startShutterClose generated =
    Comment    ======= Verify ${subSystem}_endShutterClose test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_endShutterClose
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event endShutterClose iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_endShutterClose_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event endShutterClose generated =
    Comment    ======= Verify ${subSystem}_startReadout test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_startReadout
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event startReadout iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_startReadout_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event startReadout generated =
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

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${cameraInfo_start}=    Get Index From List    ${full_list}    === Event cameraInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraInfo_start}
    ${cameraInfo_end}=    Evaluate    ${end}+${1}
    ${cameraInfo_list}=    Get Slice From List    ${full_list}    start=${cameraInfo_start}    end=${cameraInfo_end}
    Should Contain X Times    ${cameraInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraMakeAndModel : LSST    1
    Should Contain X Times    ${cameraInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraSpecificProperty_start}=    Get Index From List    ${full_list}    === Event cameraSpecificProperty received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraSpecificProperty_start}
    ${cameraSpecificProperty_end}=    Evaluate    ${end}+${1}
    ${cameraSpecificProperty_list}=    Get Slice From List    ${full_list}    start=${cameraSpecificProperty_start}    end=${cameraSpecificProperty_end}
    Should Contain X Times    ${cameraSpecificProperty_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propertyName : LSST    1
    Should Contain X Times    ${cameraSpecificProperty_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propertyValue : LSST    1
    Should Contain X Times    ${cameraSpecificProperty_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${roi_start}=    Get Index From List    ${full_list}    === Event roi received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${roi_start}
    ${roi_end}=    Evaluate    ${end}+${1}
    ${roi_list}=    Get Slice From List    ${full_list}    start=${roi_start}    end=${roi_end}
    Should Contain X Times    ${roi_list}    ${SPACE}${SPACE}${SPACE}${SPACE}topPixel : 1    1
    Should Contain X Times    ${roi_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leftPixel : 1    1
    Should Contain X Times    ${roi_list}    ${SPACE}${SPACE}${SPACE}${SPACE}width : 1    1
    Should Contain X Times    ${roi_list}    ${SPACE}${SPACE}${SPACE}${SPACE}height : 1    1
    Should Contain X Times    ${roi_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startLiveView_start}=    Get Index From List    ${full_list}    === Event startLiveView received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startLiveView_start}
    ${startLiveView_end}=    Evaluate    ${end}+${1}
    ${startLiveView_list}=    Get Slice From List    ${full_list}    start=${startLiveView_start}    end=${startLiveView_end}
    Should Contain X Times    ${startLiveView_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ip : LSST    1
    Should Contain X Times    ${startLiveView_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port : 1    1
    Should Contain X Times    ${startLiveView_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endLiveView_start}=    Get Index From List    ${full_list}    === Event endLiveView received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endLiveView_start}
    ${endLiveView_end}=    Evaluate    ${end}+${1}
    ${endLiveView_list}=    Get Slice From List    ${full_list}    start=${endLiveView_start}    end=${endLiveView_end}
    Should Contain X Times    ${endLiveView_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${endLiveView_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startTakeImage_start}=    Get Index From List    ${full_list}    === Event startTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startTakeImage_start}
    ${startTakeImage_end}=    Evaluate    ${end}+${1}
    ${startTakeImage_list}=    Get Slice From List    ${full_list}    start=${startTakeImage_start}    end=${startTakeImage_end}
    Should Contain X Times    ${startTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${startTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterOpen_start}=    Get Index From List    ${full_list}    === Event startShutterOpen received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startShutterOpen_start}
    ${startShutterOpen_end}=    Evaluate    ${end}+${1}
    ${startShutterOpen_list}=    Get Slice From List    ${full_list}    start=${startShutterOpen_start}    end=${startShutterOpen_end}
    Should Contain X Times    ${startShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${startShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterOpen_start}=    Get Index From List    ${full_list}    === Event endShutterOpen received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endShutterOpen_start}
    ${endShutterOpen_end}=    Evaluate    ${end}+${1}
    ${endShutterOpen_list}=    Get Slice From List    ${full_list}    start=${endShutterOpen_start}    end=${endShutterOpen_end}
    Should Contain X Times    ${endShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${endShutterOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startIntegration_start}=    Get Index From List    ${full_list}    === Event startIntegration received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startIntegration_start}
    ${startIntegration_end}=    Evaluate    ${end}+${1}
    ${startIntegration_list}=    Get Slice From List    ${full_list}    start=${startIntegration_start}    end=${startIntegration_end}
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSequenceName : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStamp : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endIntegration_start}=    Get Index From List    ${full_list}    === Event endIntegration received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endIntegration_start}
    ${endIntegration_end}=    Evaluate    ${end}+${1}
    ${endIntegration_list}=    Get Slice From List    ${full_list}    start=${endIntegration_start}    end=${endIntegration_end}
    Should Contain X Times    ${endIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${endIntegration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startShutterClose_start}=    Get Index From List    ${full_list}    === Event startShutterClose received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startShutterClose_start}
    ${startShutterClose_end}=    Evaluate    ${end}+${1}
    ${startShutterClose_list}=    Get Slice From List    ${full_list}    start=${startShutterClose_start}    end=${startShutterClose_end}
    Should Contain X Times    ${startShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${startShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endShutterClose_start}=    Get Index From List    ${full_list}    === Event endShutterClose received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endShutterClose_start}
    ${endShutterClose_end}=    Evaluate    ${end}+${1}
    ${endShutterClose_list}=    Get Slice From List    ${full_list}    start=${endShutterClose_start}    end=${endShutterClose_end}
    Should Contain X Times    ${endShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${endShutterClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${startReadout_start}=    Get Index From List    ${full_list}    === Event startReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${startReadout_start}
    ${startReadout_end}=    Evaluate    ${end}+${1}
    ${startReadout_list}=    Get Slice From List    ${full_list}    start=${startReadout_start}    end=${startReadout_end}
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSequenceName : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStamp : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${startReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endReadout_start}=    Get Index From List    ${full_list}    === Event endReadout received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endReadout_start}
    ${endReadout_end}=    Evaluate    ${end}+${1}
    ${endReadout_list}=    Get Slice From List    ${full_list}    start=${endReadout_start}    end=${endReadout_end}
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSequenceName : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imagesInSequence : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageName : LSST    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageIndex : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeStamp : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTime : 1    1
    Should Contain X Times    ${endReadout_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${endTakeImage_start}=    Get Index From List    ${full_list}    === Event endTakeImage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${endTakeImage_start}
    ${endTakeImage_end}=    Evaluate    ${end}+${1}
    ${endTakeImage_list}=    Get Slice From List    ${full_list}    start=${endTakeImage_start}    end=${endTakeImage_end}
    Should Contain X Times    ${endTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${endTakeImage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
