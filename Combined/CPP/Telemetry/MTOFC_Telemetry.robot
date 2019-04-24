*** Settings ***
Documentation    MTOFC Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTOFC
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
    Should Contain    ${string}    ===== MTOFC subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTOFC_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTOFC_timestamp end of topic ===
    Comment    ======= Verify ${subSystem}_loopTimeMs test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loopTimeMs
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTOFC_loopTimeMs start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loopTimeMs_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTOFC_loopTimeMs end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTOFC subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${timestamp_start}=    Get Index From List    ${full_list}    === MTOFC_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === MTOFC_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${loopTimeMs_start}=    Get Index From List    ${full_list}    === MTOFC_loopTimeMs start of topic ===
    ${loopTimeMs_end}=    Get Index From List    ${full_list}    === MTOFC_loopTimeMs end of topic ===
    ${loopTimeMs_list}=    Get Slice From List    ${full_list}    start=${loopTimeMs_start}    end=${loopTimeMs_end}
    Should Contain X Times    ${loopTimeMs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTimeMs : 1    10
