*** Settings ***
Documentation    ATWhiteLight Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATWhiteLight
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== ATWhiteLight subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_timestamp end of topic ===
    Comment    ======= Verify ${subSystem}_loopTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loopTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_loopTime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loopTime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_loopTime end of topic ===
    Comment    ======= Verify ${subSystem}_bulbHours test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bulbHours
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_bulbHours start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bulbHours_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_bulbHours end of topic ===
    Comment    ======= Verify ${subSystem}_bulbWattHours test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bulbWattHours
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_bulbWattHours start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bulbWattHours_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_bulbWattHours end of topic ===
    Comment    ======= Verify ${subSystem}_chillerFansSpeed test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerFansSpeed
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerFansSpeed start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerFansSpeed_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerFansSpeed end of topic ===
    Comment    ======= Verify ${subSystem}_chillerUpTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerUpTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerUpTime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerUpTime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerUpTime end of topic ===
    Comment    ======= Verify ${subSystem}_chillerTempSensors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerTempSensors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTempSensors start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerTempSensors_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTempSensors end of topic ===
    Comment    ======= Verify ${subSystem}_chillerProcessFlow test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerProcessFlow
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerProcessFlow start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerProcessFlow_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerProcessFlow end of topic ===
    Comment    ======= Verify ${subSystem}_chillerTECBankCurrent test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerTECBankCurrent
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTECBankCurrent start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerTECBankCurrent_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTECBankCurrent end of topic ===
    Comment    ======= Verify ${subSystem}_chillerTEDriveLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chillerTEDriveLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTEDriveLevel start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chillerTEDriveLevel_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATWhiteLight_chillerTEDriveLevel end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATWhiteLight subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${timestamp_start}=    Get Index From List    ${full_list}    === ATWhiteLight_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === ATWhiteLight_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${loopTime_start}=    Get Index From List    ${full_list}    === ATWhiteLight_loopTime start of topic ===
    ${loopTime_end}=    Get Index From List    ${full_list}    === ATWhiteLight_loopTime end of topic ===
    ${loopTime_list}=    Get Slice From List    ${full_list}    start=${loopTime_start}    end=${loopTime_end}
    Should Contain X Times    ${loopTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTime : 1    10
    ${bulbHours_start}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbHours start of topic ===
    ${bulbHours_end}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbHours end of topic ===
    ${bulbHours_list}=    Get Slice From List    ${full_list}    start=${bulbHours_start}    end=${bulbHours_end}
    Should Contain X Times    ${bulbHours_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bulbHours : 1    10
    ${bulbWattHours_start}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbWattHours start of topic ===
    ${bulbWattHours_end}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbWattHours end of topic ===
    ${bulbWattHours_list}=    Get Slice From List    ${full_list}    start=${bulbWattHours_start}    end=${bulbWattHours_end}
    Should Contain X Times    ${bulbWattHours_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bulbHours : 1    10
    ${chillerFansSpeed_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerFansSpeed start of topic ===
    ${chillerFansSpeed_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerFansSpeed end of topic ===
    ${chillerFansSpeed_list}=    Get Slice From List    ${full_list}    start=${chillerFansSpeed_start}    end=${chillerFansSpeed_end}
    Should Contain X Times    ${chillerFansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan1Speed : 1    10
    Should Contain X Times    ${chillerFansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan2Speed : 1    10
    Should Contain X Times    ${chillerFansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan3Speed : 1    10
    Should Contain X Times    ${chillerFansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan4Speed : 1    10
    Should Contain X Times    ${chillerFansSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${chillerUpTime_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerUpTime start of topic ===
    ${chillerUpTime_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerUpTime end of topic ===
    ${chillerUpTime_list}=    Get Slice From List    ${full_list}    start=${chillerUpTime_start}    end=${chillerUpTime_end}
    Should Contain X Times    ${chillerUpTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}upTime : 1    10
    Should Contain X Times    ${chillerUpTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${chillerTempSensors_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTempSensors start of topic ===
    ${chillerTempSensors_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTempSensors end of topic ===
    ${chillerTempSensors_list}=    Get Slice From List    ${full_list}    start=${chillerTempSensors_start}    end=${chillerTempSensors_end}
    Should Contain X Times    ${chillerTempSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setTemperature : 1    10
    Should Contain X Times    ${chillerTempSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyTemperature : 1    10
    Should Contain X Times    ${chillerTempSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemperature : 1    10
    Should Contain X Times    ${chillerTempSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${chillerTempSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${chillerProcessFlow_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerProcessFlow start of topic ===
    ${chillerProcessFlow_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerProcessFlow end of topic ===
    ${chillerProcessFlow_list}=    Get Slice From List    ${full_list}    start=${chillerProcessFlow_start}    end=${chillerProcessFlow_end}
    Should Contain X Times    ${chillerProcessFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flow : 1    10
    Should Contain X Times    ${chillerProcessFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${chillerTECBankCurrent_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTECBankCurrent start of topic ===
    ${chillerTECBankCurrent_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTECBankCurrent end of topic ===
    ${chillerTECBankCurrent_list}=    Get Slice From List    ${full_list}    start=${chillerTECBankCurrent_start}    end=${chillerTECBankCurrent_end}
    Should Contain X Times    ${chillerTECBankCurrent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bank1Current : 1    10
    Should Contain X Times    ${chillerTECBankCurrent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bank2Current : 1    10
    Should Contain X Times    ${chillerTECBankCurrent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${chillerTEDriveLevel_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTEDriveLevel start of topic ===
    ${chillerTEDriveLevel_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTEDriveLevel end of topic ===
    ${chillerTEDriveLevel_list}=    Get Slice From List    ${full_list}    start=${chillerTEDriveLevel_start}    end=${chillerTEDriveLevel_end}
    Should Contain X Times    ${chillerTEDriveLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}chillerTEDriveLevel : 1    10
    Should Contain X Times    ${chillerTEDriveLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
