*** Settings ***
Documentation    Rotator_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Rotator
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
    Comment    ======= Verify ${subSystem}_controllerState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_controllerState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event controllerState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_controllerState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event controllerState generated =
    Comment    ======= Verify ${subSystem}_connected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_connected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event connected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_connected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event connected generated =
    Comment    ======= Verify ${subSystem}_interlock test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlock
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlock iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlock_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlock generated =
    Comment    ======= Verify ${subSystem}_target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_target_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event target generated =
    Comment    ======= Verify ${subSystem}_tracking test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_tracking
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event tracking iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_tracking_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event tracking generated =
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_configuration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_configuration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event configuration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_configuration_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event configuration generated =
    Comment    ======= Verify ${subSystem}_commandableByDDS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_commandableByDDS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event commandableByDDS iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_commandableByDDS_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event commandableByDDS generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${controllerState_start}=    Get Index From List    ${full_list}    === Event controllerState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${controllerState_start}
    ${controllerState_end}=    Evaluate    ${end}+${1}
    ${controllerState_list}=    Get Slice From List    ${full_list}    start=${controllerState_start}    end=${controllerState_end}
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controllerState : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offlineSubstate : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabledSubstate : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationStatus : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${connected_start}=    Get Index From List    ${full_list}    === Event connected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${connected_start}
    ${connected_end}=    Evaluate    ${end}+${1}
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${connected_end}
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}command : 1    1
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telemetry : 1    1
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlock_start}=    Get Index From List    ${full_list}    === Event interlock received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlock_start}
    ${interlock_end}=    Evaluate    ${end}+${1}
    ${interlock_list}=    Get Slice From List    ${full_list}    start=${interlock_start}    end=${interlock_end}
    Should Contain X Times    ${interlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detail : RO    1
    Should Contain X Times    ${interlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${target_start}
    ${target_end}=    Evaluate    ${end}+${1}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${tracking_start}=    Get Index From List    ${full_list}    === Event tracking received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${tracking_start}
    ${tracking_end}=    Evaluate    ${end}+${1}
    ${tracking_list}=    Get Slice From List    ${full_list}    start=${tracking_start}    end=${tracking_end}
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracking : 1    1
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lost : 1    1
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}noNewCommand : 1    1
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPosition_start}
    ${inPosition_end}=    Evaluate    ${end}+${1}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${configuration_start}=    Get Index From List    ${full_list}    === Event configuration received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${configuration_start}
    ${configuration_end}=    Evaluate    ${end}+${1}
    ${configuration_list}=    Get Slice From List    ${full_list}    start=${configuration_start}    end=${configuration_end}
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionAngleUpperLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionErrorThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionAngleLowerLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}followingErrorThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackingSuccessPositionThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackingLostTimeout : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${commandableByDDS_start}=    Get Index From List    ${full_list}    === Event commandableByDDS received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${commandableByDDS_start}
    ${commandableByDDS_end}=    Evaluate    ${end}+${1}
    ${commandableByDDS_list}=    Get Slice From List    ${full_list}    start=${commandableByDDS_start}    end=${commandableByDDS_end}
    Should Contain X Times    ${commandableByDDS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${commandableByDDS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
