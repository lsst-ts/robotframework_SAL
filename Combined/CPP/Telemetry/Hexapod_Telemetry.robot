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
    Comment    ======= Verify ${subSystem}_Actuators test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Actuators
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_Actuators start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Actuators_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_Actuators end of topic ===
    Comment    ======= Verify ${subSystem}_Application test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Application
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_Application start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Application_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_Application end of topic ===
    Comment    ======= Verify ${subSystem}_Electrical test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Electrical
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Hexapod_Electrical start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Electrical_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Hexapod_Electrical end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Hexapod subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${Actuators_start}=    Get Index From List    ${full_list}    === Hexapod_Actuators start of topic ===
    ${Actuators_end}=    Get Index From List    ${full_list}    === Hexapod_Actuators end of topic ===
    ${Actuators_list}=    Get Slice From List    ${full_list}    start=${Actuators_start}    end=${Actuators_end}
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 0    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 1    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 2    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 3    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 4    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 5    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 6    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 7    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 8    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 9    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 0    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 1    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 2    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 3    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 4    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 5    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 6    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 7    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 8    1
    Should Contain X Times    ${Actuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 9    1
    ${Application_start}=    Get Index From List    ${full_list}    === Hexapod_Application start of topic ===
    ${Application_end}=    Get Index From List    ${full_list}    === Hexapod_Application end of topic ===
    ${Application_list}=    Get Slice From List    ${full_list}    start=${Application_start}    end=${Application_end}
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 9    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 9    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 9    1
    ${Electrical_start}=    Get Index From List    ${full_list}    === Hexapod_Electrical start of topic ===
    ${Electrical_end}=    Get Index From List    ${full_list}    === Hexapod_Electrical end of topic ===
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
