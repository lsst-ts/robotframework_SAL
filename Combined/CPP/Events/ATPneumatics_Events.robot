*** Settings ***
Documentation    ATPneumatics_Events communications tests.
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
${subSystem}    ATPneumatics
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
    Comment    ======= Verify ${subSystem}_m1CoverLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CoverLimitSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CoverLimitSwitches iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CoverLimitSwitches_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CoverLimitSwitches generated =
    Comment    ======= Verify ${subSystem}_m1VentsLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1VentsLimitSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1VentsLimitSwitches iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1VentsLimitSwitches_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1VentsLimitSwitches generated =
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerStatus generated =
    Comment    ======= Verify ${subSystem}_eStop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_eStop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event eStop iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_eStop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event eStop generated =
    Comment    ======= Verify ${subSystem}_m1CoverState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CoverState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CoverState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CoverState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CoverState generated =
    Comment    ======= Verify ${subSystem}_m1State test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1State
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1State iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1State_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1State generated =
    Comment    ======= Verify ${subSystem}_m2State test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2State
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2State iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2State_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2State generated =
    Comment    ======= Verify ${subSystem}_instrumentState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_instrumentState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event instrumentState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_instrumentState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event instrumentState generated =
    Comment    ======= Verify ${subSystem}_cellVentsState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellVentsState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellVentsState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellVentsState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellVentsState generated =
    Comment    ======= Verify ${subSystem}_mainValveState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainValveState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mainValveState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainValveState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mainValveState generated =
    Comment    ======= Verify ${subSystem}_m1VentsPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1VentsPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1VentsPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1VentsPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1VentsPosition generated =
    Comment    ======= Verify ${subSystem}_m1SetPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1SetPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1SetPressure iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1SetPressure_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1SetPressure generated =
    Comment    ======= Verify ${subSystem}_m2SetPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2SetPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2SetPressure iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2SetPressure_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2SetPressure generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${m1CoverLimitSwitches_start}=    Get Index From List    ${full_list}    === Event m1CoverLimitSwitches received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1CoverLimitSwitches_start}
    ${m1CoverLimitSwitches_end}=    Evaluate    ${end}+${1}
    ${m1CoverLimitSwitches_list}=    Get Slice From List    ${full_list}    start=${m1CoverLimitSwitches_start}    end=${m1CoverLimitSwitches_end}
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover1ClosedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover2ClosedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover3ClosedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover4ClosedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover1OpenedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover2OpenedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover3OpenedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cover4OpenedActive : 1    1
    Should Contain X Times    ${m1CoverLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1VentsLimitSwitches_start}=    Get Index From List    ${full_list}    === Event m1VentsLimitSwitches received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1VentsLimitSwitches_start}
    ${m1VentsLimitSwitches_end}=    Evaluate    ${end}+${1}
    ${m1VentsLimitSwitches_list}=    Get Slice From List    ${full_list}    start=${m1VentsLimitSwitches_start}    end=${m1VentsLimitSwitches_end}
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ventsClosedActive : 1    1
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ventsOpenedActive : 1    1
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === Event powerStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${powerStatus_start}
    ${powerStatus_end}=    Evaluate    ${end}+${1}
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL1 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL2 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL3 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${eStop_start}=    Get Index From List    ${full_list}    === Event eStop received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${eStop_start}
    ${eStop_end}=    Evaluate    ${end}+${1}
    ${eStop_list}=    Get Slice From List    ${full_list}    start=${eStop_start}    end=${eStop_end}
    Should Contain X Times    ${eStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}triggered : 1    1
    Should Contain X Times    ${eStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CoverState_start}=    Get Index From List    ${full_list}    === Event m1CoverState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1CoverState_start}
    ${m1CoverState_end}=    Evaluate    ${end}+${1}
    ${m1CoverState_list}=    Get Slice From List    ${full_list}    start=${m1CoverState_start}    end=${m1CoverState_end}
    Should Contain X Times    ${m1CoverState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m1CoverState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1State_start}=    Get Index From List    ${full_list}    === Event m1State received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1State_start}
    ${m1State_end}=    Evaluate    ${end}+${1}
    ${m1State_list}=    Get Slice From List    ${full_list}    start=${m1State_start}    end=${m1State_end}
    Should Contain X Times    ${m1State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m1State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2State_start}=    Get Index From List    ${full_list}    === Event m2State received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2State_start}
    ${m2State_end}=    Evaluate    ${end}+${1}
    ${m2State_list}=    Get Slice From List    ${full_list}    start=${m2State_start}    end=${m2State_end}
    Should Contain X Times    ${m2State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m2State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${instrumentState_start}=    Get Index From List    ${full_list}    === Event instrumentState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${instrumentState_start}
    ${instrumentState_end}=    Evaluate    ${end}+${1}
    ${instrumentState_list}=    Get Slice From List    ${full_list}    start=${instrumentState_start}    end=${instrumentState_end}
    Should Contain X Times    ${instrumentState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${instrumentState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellVentsState_start}=    Get Index From List    ${full_list}    === Event cellVentsState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cellVentsState_start}
    ${cellVentsState_end}=    Evaluate    ${end}+${1}
    ${cellVentsState_list}=    Get Slice From List    ${full_list}    start=${cellVentsState_start}    end=${cellVentsState_end}
    Should Contain X Times    ${cellVentsState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${cellVentsState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainValveState_start}=    Get Index From List    ${full_list}    === Event mainValveState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mainValveState_start}
    ${mainValveState_end}=    Evaluate    ${end}+${1}
    ${mainValveState_list}=    Get Slice From List    ${full_list}    start=${mainValveState_start}    end=${mainValveState_end}
    Should Contain X Times    ${mainValveState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mainValveState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1VentsPosition_start}=    Get Index From List    ${full_list}    === Event m1VentsPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1VentsPosition_start}
    ${m1VentsPosition_end}=    Evaluate    ${end}+${1}
    ${m1VentsPosition_list}=    Get Slice From List    ${full_list}    start=${m1VentsPosition_start}    end=${m1VentsPosition_end}
    Should Contain X Times    ${m1VentsPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${m1VentsPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1SetPressure_start}=    Get Index From List    ${full_list}    === Event m1SetPressure received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1SetPressure_start}
    ${m1SetPressure_end}=    Evaluate    ${end}+${1}
    ${m1SetPressure_list}=    Get Slice From List    ${full_list}    start=${m1SetPressure_start}    end=${m1SetPressure_end}
    Should Contain X Times    ${m1SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2SetPressure_start}=    Get Index From List    ${full_list}    === Event m2SetPressure received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2SetPressure_start}
    ${m2SetPressure_end}=    Evaluate    ${end}+${1}
    ${m2SetPressure_list}=    Get Slice From List    ${full_list}    start=${m2SetPressure_start}    end=${m2SetPressure_end}
    Should Contain X Times    ${m2SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
