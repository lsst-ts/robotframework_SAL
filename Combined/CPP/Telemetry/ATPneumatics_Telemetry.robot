*** Settings ***
Documentation    ATPneumatics Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPneumatics
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== ATPneumatics subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_m1AirPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_m1AirPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPneumatics_m1AirPressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::m1AirPressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPneumatics_m1AirPressure end of topic ===
    Comment    ======= Verify ${subSystem}_m2AirPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_m2AirPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPneumatics_m2AirPressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::m2AirPressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPneumatics_m2AirPressure end of topic ===
    Comment    ======= Verify ${subSystem}_mainAirSourcePressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mainAirSourcePressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPneumatics_mainAirSourcePressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mainAirSourcePressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPneumatics_mainAirSourcePressure end of topic ===
    Comment    ======= Verify ${subSystem}_loadCell test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loadCell
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPneumatics_loadCell start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loadCell_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPneumatics_loadCell end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATPneumatics subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${m1AirPressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_m1AirPressure start of topic ===
    ${m1AirPressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_m1AirPressure end of topic ===
    ${m1AirPressure_list}=    Get Slice From List    ${full_list}    start=${m1AirPressure_start}    end=${m1AirPressure_end}
    Should Contain X Times    ${m1AirPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    10
    ${m2AirPressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_m2AirPressure start of topic ===
    ${m2AirPressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_m2AirPressure end of topic ===
    ${m2AirPressure_list}=    Get Slice From List    ${full_list}    start=${m2AirPressure_start}    end=${m2AirPressure_end}
    Should Contain X Times    ${m2AirPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    10
    ${mainAirSourcePressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_mainAirSourcePressure start of topic ===
    ${mainAirSourcePressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_mainAirSourcePressure end of topic ===
    ${mainAirSourcePressure_list}=    Get Slice From List    ${full_list}    start=${mainAirSourcePressure_start}    end=${mainAirSourcePressure_end}
    Should Contain X Times    ${mainAirSourcePressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    10
    ${loadCell_start}=    Get Index From List    ${full_list}    === ATPneumatics_loadCell start of topic ===
    ${loadCell_end}=    Get Index From List    ${full_list}    === ATPneumatics_loadCell end of topic ===
    ${loadCell_list}=    Get Slice From List    ${full_list}    start=${loadCell_start}    end=${loadCell_end}
    Should Contain X Times    ${loadCell_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLoad : 1    10
