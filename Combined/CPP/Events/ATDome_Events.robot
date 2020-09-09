*** Settings ***
Documentation    ATDome_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATDome
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
    Wait Until Keyword Succeeds    60s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_azimuthCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthCommandedState generated =
    Comment    ======= Verify ${subSystem}_azimuthState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthState generated =
    Comment    ======= Verify ${subSystem}_dropoutDoorCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dropoutDoorCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event dropoutDoorCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dropoutDoorCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dropoutDoorCommandedState generated =
    Comment    ======= Verify ${subSystem}_dropoutDoorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dropoutDoorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event dropoutDoorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dropoutDoorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dropoutDoorState generated =
    Comment    ======= Verify ${subSystem}_mainDoorCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainDoorCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainDoorCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainDoorCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainDoorCommandedState generated =
    Comment    ======= Verify ${subSystem}_mainDoorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainDoorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainDoorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainDoorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainDoorState generated =
    Comment    ======= Verify ${subSystem}_azimuthInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthInPosition generated =
    Comment    ======= Verify ${subSystem}_shutterInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterInPosition generated =
    Comment    ======= Verify ${subSystem}_allAxesInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_allAxesInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event allAxesInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_allAxesInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event allAxesInPosition generated =
    Comment    ======= Verify ${subSystem}_doorEncoderExtremes test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_doorEncoderExtremes
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event doorEncoderExtremes iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_doorEncoderExtremes_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event doorEncoderExtremes generated =
    Comment    ======= Verify ${subSystem}_lastAzimuthGoTo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lastAzimuthGoTo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event lastAzimuthGoTo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lastAzimuthGoTo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event lastAzimuthGoTo generated =
    Comment    ======= Verify ${subSystem}_emergencyStop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_emergencyStop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event emergencyStop iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_emergencyStop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event emergencyStop generated =
    Comment    ======= Verify ${subSystem}_scbLink test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_scbLink
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event scbLink iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_scbLink_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event scbLink generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedDomeController test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedDomeController
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedDomeController iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedDomeController_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedDomeController generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedDomeTcp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedDomeTcp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedDomeTcp iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedDomeTcp_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedDomeTcp generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${azimuthCommandedState_start}=    Get Index From List    ${full_list}    === Event azimuthCommandedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthCommandedState_start}
    ${azimuthCommandedState_end}=    Evaluate    ${end}+${1}
    ${azimuthCommandedState_list}=    Get Slice From List    ${full_list}    start=${azimuthCommandedState_start}    end=${azimuthCommandedState_end}
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthState_start}=    Get Index From List    ${full_list}    === Event azimuthState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthState_start}
    ${azimuthState_end}=    Evaluate    ${end}+${1}
    ${azimuthState_list}=    Get Slice From List    ${full_list}    start=${azimuthState_start}    end=${azimuthState_end}
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homing : 1    1
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dropoutDoorCommandedState_start}=    Get Index From List    ${full_list}    === Event dropoutDoorCommandedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dropoutDoorCommandedState_start}
    ${dropoutDoorCommandedState_end}=    Evaluate    ${end}+${1}
    ${dropoutDoorCommandedState_list}=    Get Slice From List    ${full_list}    start=${dropoutDoorCommandedState_start}    end=${dropoutDoorCommandedState_end}
    Should Contain X Times    ${dropoutDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${dropoutDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dropoutDoorState_start}=    Get Index From List    ${full_list}    === Event dropoutDoorState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dropoutDoorState_start}
    ${dropoutDoorState_end}=    Evaluate    ${end}+${1}
    ${dropoutDoorState_list}=    Get Slice From List    ${full_list}    start=${dropoutDoorState_start}    end=${dropoutDoorState_end}
    Should Contain X Times    ${dropoutDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${dropoutDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainDoorCommandedState_start}=    Get Index From List    ${full_list}    === Event mainDoorCommandedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mainDoorCommandedState_start}
    ${mainDoorCommandedState_end}=    Evaluate    ${end}+${1}
    ${mainDoorCommandedState_list}=    Get Slice From List    ${full_list}    start=${mainDoorCommandedState_start}    end=${mainDoorCommandedState_end}
    Should Contain X Times    ${mainDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${mainDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainDoorState_start}=    Get Index From List    ${full_list}    === Event mainDoorState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mainDoorState_start}
    ${mainDoorState_end}=    Evaluate    ${end}+${1}
    ${mainDoorState_list}=    Get Slice From List    ${full_list}    start=${mainDoorState_start}    end=${mainDoorState_end}
    Should Contain X Times    ${mainDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mainDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthInPosition_start}=    Get Index From List    ${full_list}    === Event azimuthInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azimuthInPosition_start}
    ${azimuthInPosition_end}=    Evaluate    ${end}+${1}
    ${azimuthInPosition_list}=    Get Slice From List    ${full_list}    start=${azimuthInPosition_start}    end=${azimuthInPosition_end}
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterInPosition_start}=    Get Index From List    ${full_list}    === Event shutterInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${shutterInPosition_start}
    ${shutterInPosition_end}=    Evaluate    ${end}+${1}
    ${shutterInPosition_list}=    Get Slice From List    ${full_list}    start=${shutterInPosition_start}    end=${shutterInPosition_end}
    Should Contain X Times    ${shutterInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${shutterInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${allAxesInPosition_start}=    Get Index From List    ${full_list}    === Event allAxesInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${allAxesInPosition_start}
    ${allAxesInPosition_end}=    Evaluate    ${end}+${1}
    ${allAxesInPosition_list}=    Get Slice From List    ${full_list}    start=${allAxesInPosition_start}    end=${allAxesInPosition_end}
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${doorEncoderExtremes_start}=    Get Index From List    ${full_list}    === Event doorEncoderExtremes received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${doorEncoderExtremes_start}
    ${doorEncoderExtremes_end}=    Evaluate    ${end}+${1}
    ${doorEncoderExtremes_list}=    Get Slice From List    ${full_list}    start=${doorEncoderExtremes_start}    end=${doorEncoderExtremes_end}
    Should Contain X Times    ${doorEncoderExtremes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainClosed : 1    1
    Should Contain X Times    ${doorEncoderExtremes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainOpened : 1    1
    Should Contain X Times    ${doorEncoderExtremes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dropoutClosed : 1    1
    Should Contain X Times    ${doorEncoderExtremes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dropoutOpened : 1    1
    Should Contain X Times    ${doorEncoderExtremes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lastAzimuthGoTo_start}=    Get Index From List    ${full_list}    === Event lastAzimuthGoTo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${lastAzimuthGoTo_start}
    ${lastAzimuthGoTo_end}=    Evaluate    ${end}+${1}
    ${lastAzimuthGoTo_list}=    Get Slice From List    ${full_list}    start=${lastAzimuthGoTo_start}    end=${lastAzimuthGoTo_end}
    Should Contain X Times    ${lastAzimuthGoTo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${lastAzimuthGoTo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${emergencyStop_start}=    Get Index From List    ${full_list}    === Event emergencyStop received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${emergencyStop_start}
    ${emergencyStop_end}=    Evaluate    ${end}+${1}
    ${emergencyStop_list}=    Get Slice From List    ${full_list}    start=${emergencyStop_start}    end=${emergencyStop_end}
    Should Contain X Times    ${emergencyStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${emergencyStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${scbLink_start}=    Get Index From List    ${full_list}    === Event scbLink received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${scbLink_start}
    ${scbLink_end}=    Evaluate    ${end}+${1}
    ${scbLink_list}=    Get Slice From List    ${full_list}    start=${scbLink_start}    end=${scbLink_end}
    Should Contain X Times    ${scbLink_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${scbLink_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedDomeController_start}=    Get Index From List    ${full_list}    === Event settingsAppliedDomeController received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedDomeController_start}
    ${settingsAppliedDomeController_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedDomeController_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedDomeController_start}    end=${settingsAppliedDomeController_end}
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rainSensorEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloudSensorEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tolerance : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homeAzimuth : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}highSpeedDistance : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogTimer : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dropoutTimer : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reversalDelay : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoShutdownEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coast : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderCountsPer360 : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMoveTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}doorMoveTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedDomeTcp_start}=    Get Index From List    ${full_list}    === Event settingsAppliedDomeTcp received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedDomeTcp_start}
    ${settingsAppliedDomeTcp_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedDomeTcp_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedDomeTcp_start}    end=${settingsAppliedDomeTcp_end}
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}host : RO    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connectionTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
