*** Settings ***
Documentation    MTMount Azimuth_Drives_Thermal communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    Azimuth_Drives_Thermal
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
    Should Contain    ${string}    ===== MTMount subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth_Drives_Thermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Thermal_Status_Group_1 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Thermal_Status_Group_2 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Thermal_Status_Group_3 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Thermal_Status_Group_4 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_1 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_2 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_3 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_4 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_5 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_6 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_7 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_8 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_9 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_10 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_11 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_12 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_13 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_14 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_15 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Motor_16 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_1 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_2 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_3 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_4 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_5 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_6 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_7 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_8 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_9 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_10 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_11 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_12 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_13 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_14 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_15 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Drive_16 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Setpoint_Group_1 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Setpoint_Group_2 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Setpoint_Group_3 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Surface_Temperature_Setpoint_Group_4 : 1    10
    Should Contain X Times    ${Azimuth_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
