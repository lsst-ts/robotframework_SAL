*** Settings ***
Documentation    HVAC LowerAHUStatus communications tests.
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
${component}    lowerAHUStatus
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
    Should Contain    ${string}    ===== HVAC subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_whiteRoomAHU test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lowerAHUStatus
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
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldValveOpeningStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}damperState : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}injectionTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}antiFreezeTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outsideTemperature : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterAlarmStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalAlarmStatus : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOnCommand : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}workloadSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}winterSetpoint : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSetpointMin : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSetpointMax : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialPressure : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmsReset : 1    10
    Should Contain X Times    ${lowerAHUStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : LSST    10
