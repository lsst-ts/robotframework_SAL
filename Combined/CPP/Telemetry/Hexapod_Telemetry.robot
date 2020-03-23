*** Settings ***
Documentation    Hexapod Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Hexapod
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
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== Hexapod subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_actuators test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_actuators
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_actuators start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::actuators_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_actuators end of topic ===
    Comment    ======= Verify ${subSystem}_application test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_application
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_application start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::application_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_application end of topic ===
    Comment    ======= Verify ${subSystem}_electrical test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_electrical
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_electrical start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::electrical_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_electrical end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Hexapod subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${actuators_start}=    Get Index From List    ${full_list}    === Hexapod_actuators start of topic ===
    ${actuators_end}=    Get Index From List    ${full_list}    === Hexapod_actuators end of topic ===
    ${actuators_list}=    Get Slice From List    ${full_list}    start=${actuators_start}    end=${actuators_end}
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 0    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 1    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 2    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 3    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 4    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 5    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 6    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 7    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 8    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 9    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 0    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 1    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 2    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 3    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 4    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 5    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 6    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 7    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 8    1
    Should Contain X Times    ${actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 9    1
    ${application_start}=    Get Index From List    ${full_list}    === Hexapod_application start of topic ===
    ${application_end}=    Get Index From List    ${full_list}    === Hexapod_application end of topic ===
    ${application_list}=    Get Slice From List    ${full_list}    start=${application_start}    end=${application_end}
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 0    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 1    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 2    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 3    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 4    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 5    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 6    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 7    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 8    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demand : 9    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 0    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 2    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 3    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 4    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 5    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 6    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 7    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 8    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 9    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 0    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 1    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 2    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 3    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 4    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 5    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 6    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 7    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 8    1
    Should Contain X Times    ${application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 9    1
    ${electrical_start}=    Get Index From List    ${full_list}    === Hexapod_electrical start of topic ===
    ${electrical_end}=    Get Index From List    ${full_list}    === Hexapod_electrical end of topic ===
    ${electrical_list}=    Get Slice From List    ${full_list}    start=${electrical_start}    end=${electrical_end}
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 0    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 1    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 2    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 3    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 4    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 5    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 6    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 7    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 8    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyStatusWordDrive : 9    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 0    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 1    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 2    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 3    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 4    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 5    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 6    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 7    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 8    1
    Should Contain X Times    ${electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}copleyLatchingFaultStatus : 9    1
