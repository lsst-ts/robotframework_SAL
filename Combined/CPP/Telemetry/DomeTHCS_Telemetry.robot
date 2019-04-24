*** Settings ***
Documentation    DomeTHCS Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DomeTHCS
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
    Should Contain    ${string}    ===== DomeTHCS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === DomeTHCS_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === DomeTHCS_status end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== DomeTHCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${status_start}=    Get Index From List    ${full_list}    === DomeTHCS_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === DomeTHCS_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end}
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 9    1
