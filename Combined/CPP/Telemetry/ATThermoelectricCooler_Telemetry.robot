*** Settings ***
Documentation    ATThermoelectricCooler Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATThermoelectricCooler
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
    Should Contain    ${string}    ===== ATThermoelectricCooler subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_timestamp end of topic ===
    Comment    ======= Verify ${subSystem}_loopTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loopTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_loopTime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loopTime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_loopTime end of topic ===
    Comment    ======= Verify ${subSystem}_fansSpeed test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fansSpeed
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_fansSpeed start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fansSpeed_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_fansSpeed end of topic ===
    Comment    ======= Verify ${subSystem}_unitUpTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_unitUpTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_unitUpTime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::unitUpTime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_unitUpTime end of topic ===
    Comment    ======= Verify ${subSystem}_temperatureSensors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperatureSensors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_temperatureSensors start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperatureSensors_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_temperatureSensors end of topic ===
    Comment    ======= Verify ${subSystem}_processFlow test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_processFlow
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_processFlow start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::processFlow_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATThermoelectricCooler_processFlow end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATThermoelectricCooler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${timestamp_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${loopTime_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_loopTime start of topic ===
    ${loopTime_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_loopTime end of topic ===
    ${loopTime_list}=    Get Slice From List    ${full_list}    start=${loopTime_start}    end=${loopTime_end}
    Should Contain X Times    ${loopTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTime : 1    10
    ${fansSpeed_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_fansSpeed start of topic ===
    ${fansSpeed_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_fansSpeed end of topic ===
    ${fansSpeed_list}=    Get Slice From List    ${full_list}    start=${fansSpeed_start}    end=${fansSpeed_end}
    Should Contain X Times    ${fansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan1Speed : 1    10
    Should Contain X Times    ${fansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan2Speed : 1    10
    Should Contain X Times    ${fansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan3Speed : 1    10
    Should Contain X Times    ${fansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan4Speed : 1    10
    Should Contain X Times    ${fansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${unitUpTime_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_unitUpTime start of topic ===
    ${unitUpTime_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_unitUpTime end of topic ===
    ${unitUpTime_list}=    Get Slice From List    ${full_list}    start=${unitUpTime_start}    end=${unitUpTime_end}
    Should Contain X Times    ${unitUpTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}upTime : 1    10
    Should Contain X Times    ${unitUpTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${temperatureSensors_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_temperatureSensors start of topic ===
    ${temperatureSensors_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_temperatureSensors end of topic ===
    ${temperatureSensors_list}=    Get Slice From List    ${full_list}    start=${temperatureSensors_start}    end=${temperatureSensors_end}
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyTemperature : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalRTD : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalThermistor : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemperature : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${temperatureSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${processFlow_start}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_processFlow start of topic ===
    ${processFlow_end}=    Get Index From List    ${full_list}    === ATThermoelectricCooler_processFlow end of topic ===
    ${processFlow_list}=    Get Slice From List    ${full_list}    start=${processFlow_start}    end=${processFlow_end}
    Should Contain X Times    ${processFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flow : 1    10
    Should Contain X Times    ${processFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
