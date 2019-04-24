*** Settings ***
Documentation    HVAC LowerChillerStatus communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    HVAC
${component}    lowerChillerStatus
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
    Comment    ======= Verify ${subSystem}_whiteRoomAHU test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lowerChillerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeTemperatureSetpoint : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outgoingEvaporateWaterTemperature : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnEvaporateWaterTemperature : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}operationMode : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}chillerStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}circuit1LowPressure : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}circuit2LowPressure : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workloadStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalAlarm : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workStatus : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnCommand : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSetpointCommand : 1    10
    Should Contain X Times    ${lowerChillerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : LSST    10
