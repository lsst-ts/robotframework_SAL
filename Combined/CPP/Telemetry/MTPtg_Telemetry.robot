*** Settings ***
Documentation    MTPtg Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTPtg
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTPtg subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_currentTimesToLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTimesToLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_currentTimesToLimits start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTimesToLimits_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_currentTimesToLimits end of topic ===
    Comment    ======= Verify ${subSystem}_currentTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_currentTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_currentTargetStatus end of topic ===
    Comment    ======= Verify ${subSystem}_guidingAndOffsets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_guidingAndOffsets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_guidingAndOffsets start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::guidingAndOffsets_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_guidingAndOffsets end of topic ===
    Comment    ======= Verify ${subSystem}_timeAndDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timeAndDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_timeAndDate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timeAndDate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_timeAndDate end of topic ===
    Comment    ======= Verify ${subSystem}_mountStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_mountStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_mountStatus end of topic ===
    Comment    ======= Verify ${subSystem}_skyEnvironment test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_skyEnvironment
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_skyEnvironment start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::skyEnvironment_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_skyEnvironment end of topic ===
    Comment    ======= Verify ${subSystem}_namedAzEl test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_namedAzEl
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_namedAzEl start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::namedAzEl_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_namedAzEl end of topic ===
    Comment    ======= Verify ${subSystem}_mount_positions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mount_positions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTPtg_mount_positions start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mount_positions_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_mount_positions end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTPtg subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${currentTimesToLimits_start}=    Get Index From List    ${full_list}    === MTPtg_currentTimesToLimits start of topic ===
    ${currentTimesToLimits_end}=    Get Index From List    ${full_list}    === MTPtg_currentTimesToLimits end of topic ===
    ${currentTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${currentTimesToLimits_start}    end=${currentTimesToLimits_end}
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToAzlim : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToRotlim : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToObservable : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToUnobservable : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpot : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToBlindSpotExit : 1    10
    Should Contain X Times    ${currentTimesToLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToElHighLimit : 1    10
    ${currentTargetStatus_start}=    Get Index From List    ${full_list}    === MTPtg_currentTargetStatus start of topic ===
    ${currentTargetStatus_end}=    Get Index From List    ${full_list}    === MTPtg_currentTargetStatus end of topic ===
    ${currentTargetStatus_list}=    Get Slice From List    ${full_list}    start=${currentTargetStatus_start}    end=${currentTargetStatus_end}
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAzVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandElVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRotVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRaString : LSST    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDecString : LSST    10
    ${guidingAndOffsets_start}=    Get Index From List    ${full_list}    === MTPtg_guidingAndOffsets start of topic ===
    ${guidingAndOffsets_end}=    Get Index From List    ${full_list}    === MTPtg_guidingAndOffsets end of topic ===
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
    ${timeAndDate_start}=    Get Index From List    ${full_list}    === MTPtg_timeAndDate start of topic ===
    ${timeAndDate_end}=    Get Index From List    ${full_list}    === MTPtg_timeAndDate end of topic ===
    ${timeAndDate_list}=    Get Slice From List    ${full_list}    start=${timeAndDate_start}    end=${timeAndDate_end}
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utc : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lst : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mjd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTimeString : LSST    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leapSecs : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timezone : 1    10
    ${mountStatus_start}=    Get Index From List    ${full_list}    === MTPtg_mountStatus start of topic ===
    ${mountStatus_end}=    Get Index From List    ${full_list}    === MTPtg_mountStatus end of topic ===
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
    ${skyEnvironment_start}=    Get Index From List    ${full_list}    === MTPtg_skyEnvironment start of topic ===
    ${skyEnvironment_end}=    Get Index From List    ${full_list}    === MTPtg_skyEnvironment end of topic ===
    ${skyEnvironment_list}=    Get Slice From List    ${full_list}    start=${skyEnvironment_start}    end=${skyEnvironment_end}
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunsetTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToSunset : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightEndTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToTwilightEnd : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBeginTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToTwilightBegin : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunriseTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToSunrise : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonriseTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToMoonrise : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonsetTime : LSST    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeToMoonset : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunTargetDistance : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonTargetDistance : 1    10
    ${namedAzEl_start}=    Get Index From List    ${full_list}    === MTPtg_namedAzEl start of topic ===
    ${namedAzEl_end}=    Get Index From List    ${full_list}    === MTPtg_namedAzEl end of topic ===
    ${namedAzEl_list}=    Get Slice From List    ${full_list}    start=${namedAzEl_start}    end=${namedAzEl_end}
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}names : LSST    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azPositions : LSST    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elPositions : LSST    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPositions : LSST    10
    ${mount_positions_start}=    Get Index From List    ${full_list}    === MTPtg_mount_positions start of topic ===
    ${mount_positions_end}=    Get Index From List    ${full_list}    === MTPtg_mount_positions end of topic ===
    ${mount_positions_list}=    Get Slice From List    ${full_list}    start=${mount_positions_start}    end=${mount_positions_end}
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 0    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 1    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 2    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 3    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 4    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 5    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 6    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 7    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 8    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 9    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 0    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 1    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 2    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 3    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 4    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 5    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 6    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 7    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 8    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 9    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 0    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 2    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 3    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 4    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 5    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 6    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 7    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 8    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 9    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 0    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 2    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 3    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 4    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 5    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 6    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 7    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 8    1
    Should Contain X Times    ${mount_positions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 9    1
