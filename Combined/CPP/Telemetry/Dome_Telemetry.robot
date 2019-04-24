*** Settings ***
Documentation    Dome Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Comment    ======= Verify ${subSystem}_summary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_summary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_summary start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::summary_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_summary end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Dome subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${summary_start}=    Get Index From List    ${full_list}    === Dome_summary start of topic ===
    ${summary_end}=    Get Index From List    ${full_list}    === Dome_summary end of topic ===
    ${summary_list}=    Get Slice From List    ${full_list}    start=${summary_start}    end=${summary_end}
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 0    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 1    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 2    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 3    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 4    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 5    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 6    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 7    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 8    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 9    1
