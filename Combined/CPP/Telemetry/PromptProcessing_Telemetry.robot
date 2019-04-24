*** Settings ***
Documentation    PromptProcessing Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    PromptProcessing
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
    Comment    ======= Verify ${subSystem}_sequencerHeartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sequencerHeartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === PromptProcessing_sequencerHeartbeat start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::sequencerHeartbeat_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === PromptProcessing_sequencerHeartbeat end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== PromptProcessing subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${sequencerHeartbeat_start}=    Get Index From List    ${full_list}    === PromptProcessing_sequencerHeartbeat start of topic ===
    ${sequencerHeartbeat_end}=    Get Index From List    ${full_list}    === PromptProcessing_sequencerHeartbeat end of topic ===
    ${sequencerHeartbeat_list}=    Get Slice From List    ${full_list}    start=${sequencerHeartbeat_start}    end=${sequencerHeartbeat_end}
    Should Contain X Times    ${sequencerHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    10
    Should Contain X Times    ${sequencerHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    10
    Should Contain X Times    ${sequencerHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    10
