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
    Comment    ======= Verify ${subSystem}_Electrical test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Electrical
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_Electrical start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Electrical_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_Electrical end of topic ===
    Comment    ======= Verify ${subSystem}_Application test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Application
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_Application start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Application_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_Application end of topic ===
    Comment    ======= Verify ${subSystem}_Motors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Motors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Rotator_Motors start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Motors_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Rotator_Motors end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Rotator subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${Electrical_start}=    Get Index From List    ${full_list}    === Rotator_Electrical start of topic ===
    ${Electrical_end}=    Get Index From List    ${full_list}    === Rotator_Electrical end of topic ===
    ${Electrical_list}=    Get Slice From List    ${full_list}    start=${Electrical_start}    end=${Electrical_end}
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 0    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 1    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 2    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 3    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 4    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 5    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 6    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 7    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 8    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyStatusWordDrive : 9    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 0    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 1    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 2    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 3    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 4    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 5    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 6    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 7    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 8    1
    Should Contain X Times    ${Electrical_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CopleyLatchingFaultStatus : 9    1
    ${Application_start}=    Get Index From List    ${full_list}    === Rotator_Application start of topic ===
    ${Application_end}=    Get Index From List    ${full_list}    === Rotator_Application end of topic ===
    ${Application_list}=    Get Slice From List    ${full_list}    start=${Application_start}    end=${Application_end}
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 1    10
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 1    10
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 1    10
    ${Motors_start}=    Get Index From List    ${full_list}    === Rotator_Motors start of topic ===
    ${Motors_end}=    Get Index From List    ${full_list}    === Rotator_Motors end of topic ===
    ${Motors_list}=    Get Slice From List    ${full_list}    start=${Motors_start}    end=${Motors_end}
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 0    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 1    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 2    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 3    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 4    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 5    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 6    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 7    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 8    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 9    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 0    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 1    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 2    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 3    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 4    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 5    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 6    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 7    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 8    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 9    1
