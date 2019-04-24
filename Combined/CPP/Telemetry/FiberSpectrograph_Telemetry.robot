*** Settings ***
Documentation    FiberSpectrograph Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    FiberSpectrograph
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
    Comment    ======= Verify ${subSystem}_spectTemperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_spectTemperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === FiberSpectrograph_spectTemperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::spectTemperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === FiberSpectrograph_spectTemperature end of topic ===
    Comment    ======= Verify ${subSystem}_loopTime_ms test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loopTime_ms
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === FiberSpectrograph_loopTime_ms start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loopTime_ms_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === FiberSpectrograph_loopTime_ms end of topic ===
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === FiberSpectrograph_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === FiberSpectrograph_timestamp end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== FiberSpectrograph subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${spectTemperature_start}=    Get Index From List    ${full_list}    === FiberSpectrograph_spectTemperature start of topic ===
    ${spectTemperature_end}=    Get Index From List    ${full_list}    === FiberSpectrograph_spectTemperature end of topic ===
    ${spectTemperature_list}=    Get Slice From List    ${full_list}    start=${spectTemperature_start}    end=${spectTemperature_end}
    Should Contain X Times    ${spectTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${spectTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${loopTime_ms_start}=    Get Index From List    ${full_list}    === FiberSpectrograph_loopTime_ms start of topic ===
    ${loopTime_ms_end}=    Get Index From List    ${full_list}    === FiberSpectrograph_loopTime_ms end of topic ===
    ${loopTime_ms_list}=    Get Slice From List    ${full_list}    start=${loopTime_ms_start}    end=${loopTime_ms_end}
    Should Contain X Times    ${loopTime_ms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTime_ms : 1    10
    ${timestamp_start}=    Get Index From List    ${full_list}    === FiberSpectrograph_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === FiberSpectrograph_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
