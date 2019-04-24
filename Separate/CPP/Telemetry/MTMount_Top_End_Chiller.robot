*** Settings ***
Documentation    MTMount Top_End_Chiller communications tests.
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
${component}    Top_End_Chiller
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Top_End_Chiller
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
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Chiller_1 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Chiller_2 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_1 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_2 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_3 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_4 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_5 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Cabinet_6 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_1 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_2 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_3 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_4 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_5 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Fan_Status_Cabinet_6 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Chiller_1_Valve : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Chiller_2_Valve : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_11 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_12 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_13 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_14 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_31 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_32 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_33 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Status_Fan_34 : LSST    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Area_1 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Area_2 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Area_3 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Area_4 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Area_5 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_1 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_2 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_3 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_4 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_5 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Humidity_Cabinet_6 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_1 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_2 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_3 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_4 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_5 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Internal_Temperature_Cabinet_6 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_1 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_2 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_3 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_4 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_5 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Surface_Temperature_Cabinet_6 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Humidity_Area_1 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Humidity_Area_2 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Humidity_Area_3 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Humidity_Area_4 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Humidity_Area_5 : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Fan_13_Input : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Temperature_Fan_14_Input : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Regulation_Chiller_1_Valve : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TEC_Regulation_Chiller_2_Valve : 1    10
    Should Contain X Times    ${Top_End_Chiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
