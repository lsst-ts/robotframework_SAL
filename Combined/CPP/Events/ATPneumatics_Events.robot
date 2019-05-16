*** Settings ***
Documentation    ATPneumatics_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== ${subSystem} all loggers ready =====
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_heartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_m1CoverLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CoverLimitSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CoverLimitSwitches_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1CoverLimitSwitches end of topic ===
    Comment    ======= Verify ${subSystem}_m1VentsLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1VentsLimitSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1VentsLimitSwitches_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1VentsLimitSwitches end of topic ===
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_powerStatus end of topic ===
    Comment    ======= Verify ${subSystem}_eStop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_eStop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_eStop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_eStop end of topic ===
    Comment    ======= Verify ${subSystem}_m1CoverState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CoverState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CoverState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1CoverState end of topic ===
    Comment    ======= Verify ${subSystem}_m1State test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1State
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1State_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1State end of topic ===
    Comment    ======= Verify ${subSystem}_m2State test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2State
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2State_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m2State end of topic ===
    Comment    ======= Verify ${subSystem}_instrumentState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_instrumentState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_instrumentState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_instrumentState end of topic ===
    Comment    ======= Verify ${subSystem}_cellVentsState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellVentsState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellVentsState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_cellVentsState end of topic ===
    Comment    ======= Verify ${subSystem}_mainValveState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mainValveState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mainValveState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_mainValveState end of topic ===
    Comment    ======= Verify ${subSystem}_m1VentsPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1VentsPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1VentsPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1VentsPosition end of topic ===
    Comment    ======= Verify ${subSystem}_m1SetPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1SetPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1SetPressure_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m1SetPressure end of topic ===
    Comment    ======= Verify ${subSystem}_m2SetPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2SetPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2SetPressure_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_m2SetPressure end of topic ===
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingVersions end of topic ===
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_errorCode end of topic ===
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_summaryState end of topic ===
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logLevel end of topic ===
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logMessage end of topic ===
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_simulationMode end of topic ===

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CoverLimitSwitches_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1CoverLimitSwitches start of topic ===
    ${m1CoverLimitSwitches_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1CoverLimitSwitches end of topic ===
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
    ${m1VentsLimitSwitches_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1VentsLimitSwitches start of topic ===
    ${m1VentsLimitSwitches_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1VentsLimitSwitches end of topic ===
    ${m1VentsLimitSwitches_list}=    Get Slice From List    ${full_list}    start=${m1VentsLimitSwitches_start}    end=${m1VentsLimitSwitches_end}
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ventsClosedActive : 1    1
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ventsOpenedActive : 1    1
    Should Contain X Times    ${m1VentsLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL1 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL2 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnL3 : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${eStop_start}=    Get Index From List    ${full_list}    === ${subSystem}_eStop start of topic ===
    ${eStop_end}=    Get Index From List    ${full_list}    === ${subSystem}_eStop end of topic ===
    ${eStop_list}=    Get Slice From List    ${full_list}    start=${eStop_start}    end=${eStop_end}
    Should Contain X Times    ${eStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}triggered : 1    1
    Should Contain X Times    ${eStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CoverState_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1CoverState start of topic ===
    ${m1CoverState_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1CoverState end of topic ===
    ${m1CoverState_list}=    Get Slice From List    ${full_list}    start=${m1CoverState_start}    end=${m1CoverState_end}
    Should Contain X Times    ${m1CoverState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m1CoverState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1State_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1State start of topic ===
    ${m1State_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1State end of topic ===
    ${m1State_list}=    Get Slice From List    ${full_list}    start=${m1State_start}    end=${m1State_end}
    Should Contain X Times    ${m1State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m1State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2State_start}=    Get Index From List    ${full_list}    === ${subSystem}_m2State start of topic ===
    ${m2State_end}=    Get Index From List    ${full_list}    === ${subSystem}_m2State end of topic ===
    ${m2State_list}=    Get Slice From List    ${full_list}    start=${m2State_start}    end=${m2State_end}
    Should Contain X Times    ${m2State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${m2State_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${instrumentState_start}=    Get Index From List    ${full_list}    === ${subSystem}_instrumentState start of topic ===
    ${instrumentState_end}=    Get Index From List    ${full_list}    === ${subSystem}_instrumentState end of topic ===
    ${instrumentState_list}=    Get Slice From List    ${full_list}    start=${instrumentState_start}    end=${instrumentState_end}
    Should Contain X Times    ${instrumentState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${instrumentState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellVentsState_start}=    Get Index From List    ${full_list}    === ${subSystem}_cellVentsState start of topic ===
    ${cellVentsState_end}=    Get Index From List    ${full_list}    === ${subSystem}_cellVentsState end of topic ===
    ${cellVentsState_list}=    Get Slice From List    ${full_list}    start=${cellVentsState_start}    end=${cellVentsState_end}
    Should Contain X Times    ${cellVentsState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${cellVentsState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mainValveState_start}=    Get Index From List    ${full_list}    === ${subSystem}_mainValveState start of topic ===
    ${mainValveState_end}=    Get Index From List    ${full_list}    === ${subSystem}_mainValveState end of topic ===
    ${mainValveState_list}=    Get Slice From List    ${full_list}    start=${mainValveState_start}    end=${mainValveState_end}
    Should Contain X Times    ${mainValveState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${mainValveState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1VentsPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1VentsPosition start of topic ===
    ${m1VentsPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1VentsPosition end of topic ===
    ${m1VentsPosition_list}=    Get Slice From List    ${full_list}    start=${m1VentsPosition_start}    end=${m1VentsPosition_end}
    Should Contain X Times    ${m1VentsPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${m1VentsPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1SetPressure_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1SetPressure start of topic ===
    ${m1SetPressure_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1SetPressure end of topic ===
    ${m1SetPressure_list}=    Get Slice From List    ${full_list}    start=${m1SetPressure_start}    end=${m1SetPressure_end}
    Should Contain X Times    ${m1SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2SetPressure_start}=    Get Index From List    ${full_list}    === ${subSystem}_m2SetPressure start of topic ===
    ${m2SetPressure_end}=    Get Index From List    ${full_list}    === ${subSystem}_m2SetPressure end of topic ===
    ${m2SetPressure_list}=    Get Slice From List    ${full_list}    start=${m2SetPressure_start}    end=${m2SetPressure_end}
    Should Contain X Times    ${m2SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2SetPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
