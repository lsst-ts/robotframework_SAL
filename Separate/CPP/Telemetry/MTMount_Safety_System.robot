*** Settings ***
Documentation    MTMount Safety_System communications tests.
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
${component}    Safety_System
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Safety_System
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
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_LimPos_AND_topple_block_pos_A : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_LimNeg_AND_topple_block_pos_B : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_Overspeed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_press_brake : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_brake_NO_actuated : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_LimPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_LimNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_Overspeed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_press_brake : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_brake_NO_actuated : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Mirror_cover_position_NO_Closed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Mirror_cover_locked_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_cable_wrap_LimPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_cable_wrap_LimNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_locking_pin_inserted : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_locking_pin_test_position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_locking_retracted : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Access_door_NO_closed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Access_door_ladder_NO_parked : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hatch_NO_Closed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Platform_NO_parking : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Platform_NO_total_extended : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Platform_extension_NO_inserted : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Pull_CordPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Pull_CordNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Phase : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Global_IS_Interlock : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Earthquake : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}SKF_NO_ok : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_NO_ok : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MCS_watchdog : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Loss_communication : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}GISfailure : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}PierAccess : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DomeAccess : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPBdome : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DomeParked : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}M1M3Interlok : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ManLiftParked : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_and_brake_Azimuth : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_and_brake_Elevation : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_AZCW : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_CCW : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_Balancing_System : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_Mirror_Cover : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_Locking_pins : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}STO_Deployable_Platforms : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Platform_extensions : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Cutoff_power : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Discharge_capacitors : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}SKF_Pressure_Off : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Pull_Cord : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Emergency_to_GIS : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_Brakes_Failed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MCS_Failed : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Access_door_1_ladder_parker_position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Access_door_2_ladder_parker_position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_platform_access_Door_1_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_platform_access_Door_2_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hath_switch_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hath_switch_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hath_switch_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hath_switch_4 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Mirror_cover_1_assembly_locked_manual_switch_off : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Mirror_cover_2_assembly_locked_manual_switch_off : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_1_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_2_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_3_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_4_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_5_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_6_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_7_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Phase_Capacitor_cabinet_8_Door_Switch_1_9 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_middle_floor_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_middle_floor_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_middle_floor_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_top_floor_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_top_floor_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_AZCW_handrail_top_floor_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XPos_beam_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XPos_beam_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XPos_beam_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XNeg_beam_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XNeg_beam_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_area_XNeg_beam_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XPos_section_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XPos_section_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XPos_section_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XNeg_section_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XNeg_section_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Azimuth_stair_XNeg_section_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Deployable_platform_XPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Deployable_platform_XNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XPos_pylon_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XPos_pylon_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XPos_TEA_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XPos_TEA_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XNeg_pylon_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XNeg_pylon_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XNeg_TEA_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_XNeg_TEA_4 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XPos_section_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XPos_section_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XPos_section_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XNeg_section_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XNeg_section_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Elevation_ring_XNeg_section_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Handdeld_emergency_3 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Handdeld_emergency_4 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Handheld_emergency_1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Handheld_emergency_2 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_MCS_Cabinet : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Phase_cabinet : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Cable_Wrap_Negative_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Cable_Wrap_Positive_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative__power_off_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_positive__power_off_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Movement_Negative_limit__pull_cord_ : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Movement_Positive_limit__pull_cord_ : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_power_off_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_power_off_limit_switch : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hard_Stop_1_topple_block_LS1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Hard_Stop_2_topple_block_LS1 : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_1_Bypass_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_1_Enable_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_2_Bypass_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_2_Enable_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_3_Bypass_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_3_Enable_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_4_Bypass_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_4_Enable_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_1_Extension_1_Inserted_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_1_Extension_2_Inserted_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_1_Module_1_Parking_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_1_Module_2_Parking_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_2_Extension_1_Inserted_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_2_Extension_2_Inserted_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_2_Module_1_Parking_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Deployable_Platform_2_Module_2_Parking_Position : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
