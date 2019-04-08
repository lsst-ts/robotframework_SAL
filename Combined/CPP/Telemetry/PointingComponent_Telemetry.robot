*** Settings ***
Documentation    PointingComponent Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_prospectiveTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_prospectiveTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::prospectiveTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_currentTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_currentTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_guidingAndOffsets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_guidingAndOffsets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::guidingAndOffsets_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_prospectiveTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_prospectiveTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::prospectiveTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_nextTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_nextTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::nextTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_timeAndDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timeAndDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timeAndDate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_mountStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Comment    ======= Verify ${subSystem}_nextTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_nextTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::nextTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=10    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ${subSystem} subscriber Ready
    @{list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}iaa : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideControlState : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideAutoClearState : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGB : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetRA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetDec : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetRA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetDec : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCE : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCE : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginX : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginY : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDX : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDY : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDX : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDY : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}utc : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}lst : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}jd : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mjd : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTime : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}leapSecs : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timezone : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDec : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRAString : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDecString : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzCurrentWrap : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotCurrentWrap : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzError : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountElError : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotError : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAzString : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountElString : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotString : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotIAA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRotIPA : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    80
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    30
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    30
