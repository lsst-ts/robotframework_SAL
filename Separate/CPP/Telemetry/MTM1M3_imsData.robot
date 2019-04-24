*** Settings ***
Documentation    MTM1M3 ImsData communications tests.
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
${component}    imsData
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
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== MTM1M3 subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_powerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_imsData
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
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 0    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 1    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 2    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 3    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 4    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 5    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 6    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 7    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 8    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 9    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    10
