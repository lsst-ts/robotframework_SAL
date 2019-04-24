*** Settings ***
Documentation    MTMount OSS communications tests.
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
${component}    OSS
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS
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
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Status : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5802 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5801 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5303 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5302 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5301 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_valve_5011 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_pump_5004 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_Status_Filter_7 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_centre_pump_5012 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_centre_valve_5001 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_heater_HET_5001 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_left_pump_5011 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_left_valve_5000 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_right_pump_5013 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Bottom_right_valve_5002 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_bridge_pump_running_unit_1 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_bridge_pump_running_unit_2 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_cooler_running_unit_1 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_cooler_running_unit_2 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Filter_5 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_Filter_6 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_pump_5001 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_valve_5201 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_centre_valve_5009 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_Filter_1 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_Filter_2 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_Filter_3 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_Filter_4 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_left_valve_5008 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_pump_5001 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_pump_5002 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_pump_5003 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_Status_right_valve_5010 : LSST    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_CPM_5007 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_CPM_5008 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_CPM_5021 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_CPM_5031 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_A_CPM_5053 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temperature_Oil_from_bearings_XPos_side : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temperature_Oil_from_bearings_XNeg_side : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temperature_Tank : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Pressure_Tank : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Ambient_Temperature_Measured_by_OSS : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Valve_feedback : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Cooling_Valve_control_signal : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Cooling_CTM_5013 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Cooling_CTM_5012 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Cooling_CPM_5052 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_Oil_Cooling_CPM_5051 : 1    10
    Should Contain X Times    ${OSS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CTM_5002 : 1    10
