*** Settings ***
Documentation    HVAC Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    HVAC
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
    Should Contain    ${string}    ===== HVAC subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_lowerAHUStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lowerAHUStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lowerAHUStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lowerAHUStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lowerAHUStatus end of topic ===
    Comment    ======= Verify ${subSystem}_lowerChillerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lowerChillerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lowerChillerStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lowerChillerStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lowerChillerStatus end of topic ===
    Comment    ======= Verify ${subSystem}_whiteRoomAHU test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_whiteRoomAHU
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_whiteRoomAHU start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::whiteRoomAHU_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_whiteRoomAHU end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${lowerAHUStatus_start}=    Get Index From List    ${full_list}    === HVAC_lowerAHUStatus start of topic ===
    ${lowerAHUStatus_end}=    Get Index From List    ${full_list}    === HVAC_lowerAHUStatus end of topic ===
    ${lowerAHUStatus_list}=    Get Slice From List    ${full_list}    start=${lowerAHUStatus_start}    end=${lowerAHUStatus_end}
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldValveOpeningStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}damperState : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}injectionTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}antiFreezeTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outsideTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterAlarmStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalAlarmStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnCommand : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workloadSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}winterSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSetpointMin : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSetpointMax : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialPressure : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmsReset : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : LSST    10
    ${lowerChillerStatus_start}=    Get Index From List    ${full_list}    === HVAC_lowerChillerStatus start of topic ===
    ${lowerChillerStatus_end}=    Get Index From List    ${full_list}    === HVAC_lowerChillerStatus end of topic ===
    ${lowerChillerStatus_list}=    Get Slice From List    ${full_list}    start=${lowerChillerStatus_start}    end=${lowerChillerStatus_end}
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeTemperatureSetpoint : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outgoingEvaporateWaterTemperature : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnEvaporateWaterTemperature : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}operationMode : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}chillerStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}circuit1LowPressure : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}circuit2LowPressure : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workloadStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalAlarm : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnCommand : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSetpointCommand : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : LSST    10
    ${whiteRoomAHU_start}=    Get Index From List    ${full_list}    === HVAC_whiteRoomAHU start of topic ===
    ${whiteRoomAHU_end}=    Get Index From List    ${full_list}    === HVAC_whiteRoomAHU end of topic ===
    ${whiteRoomAHU_list}=    Get Slice From List    ${full_list}    start=${whiteRoomAHU_start}    end=${whiteRoomAHU_end}
    Should Contain X Times    ${whiteRoomAHU_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workStatus : 1    10
