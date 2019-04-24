*** Settings ***
Documentation    MTM1M3 PidData communications tests.
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
${component}    pidData
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pidData
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
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measurement : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 9    1
