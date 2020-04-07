*** Settings ***
Documentation    Rotator Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Rotator
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
    Should Contain    ${output}    ===== Rotator subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Application test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Application
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_Application start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Application_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_Application end of topic ===
    Comment    ======= Verify ${subSystem}_electrical test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_electrical
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_electrical start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::electrical_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_electrical end of topic ===
    Comment    ======= Verify ${subSystem}_motors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_motors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_motors start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::motors_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_motors end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Rotator subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${Application_start}=    Get Index From List    ${full_list}    === Rotator_Application start of topic ===
    ${Application_end}=    Get Index From List    ${full_list}    === Rotator_Application end of topic ===
    ${Application_list}=    Get Slice From List    ${full_list}    start=${Application_start}    end=${Application_end}
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 1    10
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 1    10
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 1    10
    ${electrical_start}=    Get Index From List    ${full_list}    === Rotator_electrical start of topic ===
    ${electrical_end}=    Get Index From List    ${full_list}    === Rotator_electrical end of topic ===
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
    ${motors_start}=    Get Index From List    ${full_list}    === Rotator_motors start of topic ===
    ${motors_end}=    Get Index From List    ${full_list}    === Rotator_motors end of topic ===
    ${motors_list}=    Get Slice From List    ${full_list}    start=${motors_start}    end=${motors_end}
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 0    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 1    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 2    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 3    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 4    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 5    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 6    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 7    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 8    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calibrated : 9    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 0    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 1    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 2    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 3    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 4    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 5    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 6    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 7    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 8    1
    Should Contain X Times    ${motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raw : 9    1
