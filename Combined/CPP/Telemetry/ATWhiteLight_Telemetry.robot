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

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
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
