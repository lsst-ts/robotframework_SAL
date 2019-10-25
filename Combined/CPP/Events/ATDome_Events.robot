*** Settings ***
Documentation    ATDome_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
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
    Comment    ======= Verify ${subSystem}_azimuthCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthCommandedState generated =
    Comment    ======= Verify ${subSystem}_azimuthState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthState generated =
    Comment    ======= Verify ${subSystem}_dropoutDoorCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dropoutDoorCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event dropoutDoorCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dropoutDoorCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dropoutDoorCommandedState generated =
    Comment    ======= Verify ${subSystem}_dropoutDoorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dropoutDoorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event dropoutDoorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dropoutDoorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dropoutDoorState generated =
    Comment    ======= Verify ${subSystem}_mainDoorCommandedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainDoorCommandedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainDoorCommandedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainDoorCommandedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainDoorCommandedState generated =
    Comment    ======= Verify ${subSystem}_mainDoorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainDoorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainDoorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainDoorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainDoorState generated =
    Comment    ======= Verify ${subSystem}_azimuthInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azimuthInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azimuthInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azimuthInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azimuthInPosition generated =
    Comment    ======= Verify ${subSystem}_shutterInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_shutterInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event shutterInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_shutterInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event shutterInPosition generated =
    Comment    ======= Verify ${subSystem}_allAxesInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_allAxesInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event allAxesInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_allAxesInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event allAxesInPosition generated =
    Comment    ======= Verify ${subSystem}_emergencyStop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_emergencyStop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event emergencyStop iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_emergencyStop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event emergencyStop generated =
    Comment    ======= Verify ${subSystem}_scbLink test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_scbLink
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event scbLink iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_scbLink_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event scbLink generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedDomeController test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedDomeController
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedDomeController iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedDomeController_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedDomeController generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedDomeTcp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedDomeTcp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedDomeTcp iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedDomeTcp_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedDomeTcp generated =
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
    Should Contain    ${output.stdout}    ===== ${subSystem} loggers ready
    ${azimuthCommandedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthCommandedState start of topic ===
    ${azimuthCommandedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthCommandedState end of topic ===
    ${azimuthCommandedState_list}=    Get Slice From List    ${full_list}    start=${azimuthCommandedState_start}    end=${azimuthCommandedState_end}
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${azimuthCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthState_start}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthState start of topic ===
    ${azimuthState_end}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthState end of topic ===
    ${azimuthState_list}=    Get Slice From List    ${full_list}    start=${azimuthState_start}    end=${azimuthState_end}
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homing : 1    1
    Should Contain X Times    ${azimuthState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dropoutDoorCommandedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_dropoutDoorCommandedState start of topic ===
    ${dropoutDoorCommandedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_dropoutDoorCommandedState end of topic ===
    ${dropoutDoorCommandedState_list}=    Get Slice From List    ${full_list}    start=${dropoutDoorCommandedState_start}    end=${dropoutDoorCommandedState_end}
    Should Contain X Times    ${dropoutDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${dropoutDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dropoutDoorState_start}=    Get Index From List    ${full_list}    === ${subSystem}_dropoutDoorState start of topic ===
    ${dropoutDoorState_end}=    Get Index From List    ${full_list}    === ${subSystem}_dropoutDoorState end of topic ===
    ${dropoutDoorState_list}=    Get Slice From List    ${full_list}    start=${dropoutDoorState_start}    end=${dropoutDoorState_end}
    Should Contain X Times    ${dropoutDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${dropoutDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainDoorCommandedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_mainDoorCommandedState start of topic ===
    ${mainDoorCommandedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_mainDoorCommandedState end of topic ===
    ${mainDoorCommandedState_list}=    Get Slice From List    ${full_list}    start=${mainDoorCommandedState_start}    end=${mainDoorCommandedState_end}
    Should Contain X Times    ${mainDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedState : 1    1
    Should Contain X Times    ${mainDoorCommandedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainDoorState_start}=    Get Index From List    ${full_list}    === ${subSystem}_mainDoorState start of topic ===
    ${mainDoorState_end}=    Get Index From List    ${full_list}    === ${subSystem}_mainDoorState end of topic ===
    ${mainDoorState_list}=    Get Slice From List    ${full_list}    start=${mainDoorState_start}    end=${mainDoorState_end}
    Should Contain X Times    ${mainDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mainDoorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azimuthInPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthInPosition start of topic ===
    ${azimuthInPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_azimuthInPosition end of topic ===
    ${azimuthInPosition_list}=    Get Slice From List    ${full_list}    start=${azimuthInPosition_start}    end=${azimuthInPosition_end}
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${azimuthInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${shutterInPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_shutterInPosition start of topic ===
    ${shutterInPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_shutterInPosition end of topic ===
    ${shutterInPosition_list}=    Get Slice From List    ${full_list}    start=${shutterInPosition_start}    end=${shutterInPosition_end}
    Should Contain X Times    ${shutterInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${shutterInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${allAxesInPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_allAxesInPosition start of topic ===
    ${allAxesInPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_allAxesInPosition end of topic ===
    ${allAxesInPosition_list}=    Get Slice From List    ${full_list}    start=${allAxesInPosition_start}    end=${allAxesInPosition_end}
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${allAxesInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${emergencyStop_start}=    Get Index From List    ${full_list}    === ${subSystem}_emergencyStop start of topic ===
    ${emergencyStop_end}=    Get Index From List    ${full_list}    === ${subSystem}_emergencyStop end of topic ===
    ${emergencyStop_list}=    Get Slice From List    ${full_list}    start=${emergencyStop_start}    end=${emergencyStop_end}
    Should Contain X Times    ${emergencyStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${emergencyStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${scbLink_start}=    Get Index From List    ${full_list}    === ${subSystem}_scbLink start of topic ===
    ${scbLink_end}=    Get Index From List    ${full_list}    === ${subSystem}_scbLink end of topic ===
    ${scbLink_list}=    Get Slice From List    ${full_list}    start=${scbLink_start}    end=${scbLink_end}
    Should Contain X Times    ${scbLink_list}    ${SPACE}${SPACE}${SPACE}${SPACE}active : 1    1
    Should Contain X Times    ${scbLink_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedDomeController_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedDomeController start of topic ===
    ${settingsAppliedDomeController_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedDomeController end of topic ===
    ${settingsAppliedDomeController_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedDomeController_start}    end=${settingsAppliedDomeController_end}
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rainSensorEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloudSensorEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tolerance : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}homeAzimuth : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}highSpeedDistance : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogTimer : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reversalDelay : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoShutdownEnabled : 1    1
    Should Contain X Times    ${settingsAppliedDomeController_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedDomeTcp_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedDomeTcp start of topic ===
    ${settingsAppliedDomeTcp_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedDomeTcp end of topic ===
    ${settingsAppliedDomeTcp_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedDomeTcp_start}    end=${settingsAppliedDomeTcp_end}
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}host : LSST    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connectionTimeout : 1    1
    Should Contain X Times    ${settingsAppliedDomeTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
