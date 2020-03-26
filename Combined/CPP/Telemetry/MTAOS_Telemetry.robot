*** Settings ***
Documentation    MTAOS Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTAOS
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTAOS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_wepDuration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wepDuration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTAOS_wepDuration start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wepDuration_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTAOS_wepDuration end of topic ===
    Comment    ======= Verify ${subSystem}_ofcDuration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_ofcDuration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTAOS_ofcDuration start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::ofcDuration_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTAOS_ofcDuration end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTAOS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${wepDuration_start}=    Get Index From List    ${full_list}    === MTAOS_wepDuration start of topic ===
    ${wepDuration_end}=    Get Index From List    ${full_list}    === MTAOS_wepDuration end of topic ===
    ${wepDuration_list}=    Get Slice From List    ${full_list}    start=${wepDuration_start}    end=${wepDuration_end}
    Should Contain X Times    ${wepDuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${wepDuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calcTime : 1    10
    ${ofcDuration_start}=    Get Index From List    ${full_list}    === MTAOS_ofcDuration start of topic ===
    ${ofcDuration_end}=    Get Index From List    ${full_list}    === MTAOS_ofcDuration end of topic ===
    ${ofcDuration_list}=    Get Slice From List    ${full_list}    start=${ofcDuration_start}    end=${ofcDuration_end}
    Should Contain X Times    ${ofcDuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${ofcDuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calcTime : 1    10
