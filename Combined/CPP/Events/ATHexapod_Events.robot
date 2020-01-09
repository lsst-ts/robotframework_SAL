*** Settings ***
Documentation    ATHexapod_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATHexapod
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
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedPositionLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedPositionLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedPositionLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedPositionLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedPositionLimits generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedVelocities test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedVelocities
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedVelocities iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedVelocities_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedVelocities generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedPivot test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedPivot
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedPivot iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedPivot_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedPivot generated =
    Comment    ======= Verify ${subSystem}_positionUpdate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_positionUpdate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event positionUpdate iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_positionUpdate_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event positionUpdate generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedTcp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedTcp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedTcp iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedTcp_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedTcp generated =
    Comment    ======= Verify ${subSystem}_readyForCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_readyForCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event readyForCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_readyForCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event readyForCommand generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPosition_start}
    ${inPosition_end}=    Evaluate    ${end}+${1}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedPositionLimits_start}=    Get Index From List    ${full_list}    === Event settingsAppliedPositionLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedPositionLimits_start}
    ${settingsAppliedPositionLimits_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedPositionLimits_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedPositionLimits_start}    end=${settingsAppliedPositionLimits_end}
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitXYMax : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitZMin : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitZMax : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitUVMax : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitWMin : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitWMax : 1    1
    Should Contain X Times    ${settingsAppliedPositionLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedVelocities_start}=    Get Index From List    ${full_list}    === Event settingsAppliedVelocities received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedVelocities_start}
    ${settingsAppliedVelocities_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedVelocities_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedVelocities_start}    end=${settingsAppliedVelocities_end}
    Should Contain X Times    ${settingsAppliedVelocities_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemSpeed : 1    1
    Should Contain X Times    ${settingsAppliedVelocities_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedPivot_start}=    Get Index From List    ${full_list}    === Event settingsAppliedPivot received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedPivot_start}
    ${settingsAppliedPivot_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedPivot_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedPivot_start}    end=${settingsAppliedPivot_end}
    Should Contain X Times    ${settingsAppliedPivot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pivotX : 1    1
    Should Contain X Times    ${settingsAppliedPivot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pivotY : 1    1
    Should Contain X Times    ${settingsAppliedPivot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pivotZ : 1    1
    Should Contain X Times    ${settingsAppliedPivot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${positionUpdate_start}=    Get Index From List    ${full_list}    === Event positionUpdate received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${positionUpdate_start}
    ${positionUpdate_end}=    Evaluate    ${end}+${1}
    ${positionUpdate_list}=    Get Slice From List    ${full_list}    start=${positionUpdate_start}    end=${positionUpdate_end}
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionX : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionY : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionZ : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionU : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionV : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionW : 1    1
    Should Contain X Times    ${positionUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedTcp_start}=    Get Index From List    ${full_list}    === Event settingsAppliedTcp received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedTcp_start}
    ${settingsAppliedTcp_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedTcp_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedTcp_start}    end=${settingsAppliedTcp_end}
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ip : LSST    1
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}port : 1    1
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readTimeout : 1    1
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}writeTimeout : 1    1
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connectionTimeout : 1    1
    Should Contain X Times    ${settingsAppliedTcp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${readyForCommand_start}=    Get Index From List    ${full_list}    === Event readyForCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${readyForCommand_start}
    ${readyForCommand_end}=    Evaluate    ${end}+${1}
    ${readyForCommand_list}=    Get Slice From List    ${full_list}    start=${readyForCommand_start}    end=${readyForCommand_end}
    Should Contain X Times    ${readyForCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ready : 1    1
    Should Contain X Times    ${readyForCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
