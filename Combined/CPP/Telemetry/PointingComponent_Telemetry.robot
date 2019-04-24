*** Settings ***
Documentation    PointingComponent Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    PointingComponent
${component}    all
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== PointingComponent subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_prospectiveTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_prospectiveTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_prospectiveTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::prospectiveTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_prospectiveTargetStatus end of topic ===
    Comment    ======= Verify ${subSystem}_currentTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_currentTimesToLimits start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_currentTimesToLimits end of topic ===
    Comment    ======= Verify ${subSystem}_currentTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_currentTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_currentTargetStatus end of topic ===
    Comment    ======= Verify ${subSystem}_guidingAndOffsets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_guidingAndOffsets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_guidingAndOffsets start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::guidingAndOffsets_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_guidingAndOffsets end of topic ===
    Comment    ======= Verify ${subSystem}_prospectiveTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_prospectiveTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_prospectiveTimesToLimits start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::prospectiveTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_prospectiveTimesToLimits end of topic ===
    Comment    ======= Verify ${subSystem}_nextTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_nextTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_nextTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::nextTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_nextTargetStatus end of topic ===
    Comment    ======= Verify ${subSystem}_timeAndDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timeAndDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_timeAndDate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timeAndDate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_timeAndDate end of topic ===
    Comment    ======= Verify ${subSystem}_mountStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_mountStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_mountStatus end of topic ===
    Comment    ======= Verify ${subSystem}_nextTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_nextTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PointingComponent_nextTimesToLimits start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::nextTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PointingComponent_nextTimesToLimits end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== PointingComponent subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${prospectiveTargetStatus_start}=    Get Index From List    ${full_list}    === PointingComponent_prospectiveTargetStatus start of topic ===
    ${prospectiveTargetStatus_end}=    Get Index From List    ${full_list}    === PointingComponent_prospectiveTargetStatus end of topic ===
    ${prospectiveTargetStatus_list}=    Get Slice From List    ${full_list}    start=${prospectiveTargetStatus_start}    end=${prospectiveTargetStatus_end}
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    10
    Should Contain X Times    ${prospectiveTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    10
    ${currentTimesToLimits_start}=    Get Index From List    ${full_list}    === PointingComponent_currentTimesToLimits start of topic ===
    ${currentTimesToLimits_end}=    Get Index From List    ${full_list}    === PointingComponent_currentTimesToLimits end of topic ===
    ${currentTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${currentTimesToLimits_start}    end=${currentTimesToLimits_end}
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    10
    ${currentTargetStatus_start}=    Get Index From List    ${full_list}    === PointingComponent_currentTargetStatus start of topic ===
    ${currentTargetStatus_end}=    Get Index From List    ${full_list}    === PointingComponent_currentTargetStatus end of topic ===
    ${currentTargetStatus_list}=    Get Slice From List    ${full_list}    start=${currentTargetStatus_start}    end=${currentTargetStatus_end}
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    10
    ${guidingAndOffsets_start}=    Get Index From List    ${full_list}    === PointingComponent_guidingAndOffsets start of topic ===
    ${guidingAndOffsets_end}=    Get Index From List    ${full_list}    === PointingComponent_guidingAndOffsets end of topic ===
    ${guidingAndOffsets_list}=    Get Slice From List    ${full_list}    start=${guidingAndOffsets_start}    end=${guidingAndOffsets_end}
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}iaa : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideControlState : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideAutoClearState : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGA : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGB : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetRA : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetDec : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetRA : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetDec : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCA : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCE : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCA : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCE : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginX : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginY : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDX : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDY : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDX : 1    10
    Should Contain X Times    ${guidingAndOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDY : 1    10
    ${prospectiveTimesToLimits_start}=    Get Index From List    ${full_list}    === PointingComponent_prospectiveTimesToLimits start of topic ===
    ${prospectiveTimesToLimits_end}=    Get Index From List    ${full_list}    === PointingComponent_prospectiveTimesToLimits end of topic ===
    ${prospectiveTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${prospectiveTimesToLimits_start}    end=${prospectiveTimesToLimits_end}
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    10
    Should Contain X Times    ${prospectiveTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    10
    ${nextTargetStatus_start}=    Get Index From List    ${full_list}    === PointingComponent_nextTargetStatus start of topic ===
    ${nextTargetStatus_end}=    Get Index From List    ${full_list}    === PointingComponent_nextTargetStatus end of topic ===
    ${nextTargetStatus_list}=    Get Slice From List    ${full_list}    start=${nextTargetStatus_start}    end=${nextTargetStatus_end}
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    10
    Should Contain X Times    ${nextTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    10
    ${timeAndDate_start}=    Get Index From List    ${full_list}    === PointingComponent_timeAndDate start of topic ===
    ${timeAndDate_end}=    Get Index From List    ${full_list}    === PointingComponent_timeAndDate end of topic ===
    ${timeAndDate_list}=    Get Slice From List    ${full_list}    start=${timeAndDate_start}    end=${timeAndDate_end}
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utc : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lst : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mjd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTimeString : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leapSecs : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timezone : 1    10
    ${mountStatus_start}=    Get Index From List    ${full_list}    === PointingComponent_mountStatus start of topic ===
    ${mountStatus_end}=    Get Index From List    ${full_list}    === PointingComponent_mountStatus end of topic ===
    ${mountStatus_list}=    Get Slice From List    ${full_list}    start=${mountStatus_start}    end=${mountStatus_end}
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRA : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDec : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRAString : LSST    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDecString : LSST    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzCurrentWrap : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotCurrentWrap : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzError : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountElError : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotError : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzString : LSST    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountElString : LSST    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotString : LSST    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotIAA : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotIPA : 1    10
    ${nextTimesToLimits_start}=    Get Index From List    ${full_list}    === PointingComponent_nextTimesToLimits start of topic ===
    ${nextTimesToLimits_end}=    Get Index From List    ${full_list}    === PointingComponent_nextTimesToLimits end of topic ===
    ${nextTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${nextTimesToLimits_start}    end=${nextTimesToLimits_end}
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    10
    Should Contain X Times    ${nextTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    10
