*** Settings ***
Documentation    AdamSensors Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    AdamSensors
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
    Should Contain    ${output}    ===== AdamSensors subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === AdamSensors_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === AdamSensors_temperature end of topic ===
    Comment    ======= Verify ${subSystem}_pressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === AdamSensors_pressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::pressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === AdamSensors_pressure end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== AdamSensors subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${temperature_start}=    Get Index From List    ${full_list}    === AdamSensors_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === AdamSensors_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end}
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch0 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch1 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch2 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch3 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch4 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp_ch5 : 1    10
    ${pressure_start}=    Get Index From List    ${full_list}    === AdamSensors_pressure start of topic ===
    ${pressure_end}=    Get Index From List    ${full_list}    === AdamSensors_pressure end of topic ===
    ${pressure_list}=    Get Slice From List    ${full_list}    start=${pressure_start}    end=${pressure_end}
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch0 : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch1 : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch2 : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch3 : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch4 : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure_ch5 : 1    10