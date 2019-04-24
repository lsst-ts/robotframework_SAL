*** Settings ***
Documentation    MTM1M3 HardpointMonitorData communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    hardpointMonitorData
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_powerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hardpointMonitorData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM1M3 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 9    1
