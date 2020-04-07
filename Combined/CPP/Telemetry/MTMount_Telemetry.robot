*** Settings ***
Documentation    MTMount Telemetry communications tests.
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
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTMount subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Auxliary_Cabinet_Azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Auxliary_Cabinet_Azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Auxliary_Cabinet_Azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Auxliary_Cabinet_Azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Auxliary_Cabinet_Azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_General test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_General
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_General start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::General_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_General end of topic ===
    Comment    ======= Verify ${subSystem}_Azimuth_Cable_Wrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth_Cable_Wrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Cable_Wrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Azimuth_Cable_Wrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Cable_Wrap end of topic ===
    Comment    ======= Verify ${subSystem}_Azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_Azimuth_Drives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth_Drives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Drives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Azimuth_Drives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Drives end of topic ===
    Comment    ======= Verify ${subSystem}_Azimuth_Drives_Thermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth_Drives_Thermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Drives_Thermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Azimuth_Drives_Thermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Azimuth_Drives_Thermal end of topic ===
    Comment    ======= Verify ${subSystem}_OSS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_OSS start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::OSS_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_OSS end of topic ===
    Comment    ======= Verify ${subSystem}_OSS2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_OSS2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::OSS2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_OSS2 end of topic ===
    Comment    ======= Verify ${subSystem}_OSS4 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS4
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_OSS4 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::OSS4_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_OSS4 end of topic ===
    Comment    ======= Verify ${subSystem}_OSS5 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS5
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_OSS5 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::OSS5_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_OSS5 end of topic ===
    Comment    ======= Verify ${subSystem}_OSS6 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS6
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_OSS6 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::OSS6_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_OSS6 end of topic ===
    Comment    ======= Verify ${subSystem}_Main_Power_Supply test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Main_Power_Supply
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Main_Power_Supply start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Main_Power_Supply_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Main_Power_Supply end of topic ===
    Comment    ======= Verify ${subSystem}_Encoder_EIB test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Encoder_EIB
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Encoder_EIB start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Encoder_EIB_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Encoder_EIB end of topic ===
    Comment    ======= Verify ${subSystem}_Balancing_Drives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Balancing_Drives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Balancing_Drives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Balancing_Drives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Balancing_Drives end of topic ===
    Comment    ======= Verify ${subSystem}_Balancing test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Balancing
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Balancing start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Balancing_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Balancing end of topic ===
    Comment    ======= Verify ${subSystem}_Elevation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Elevation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Elevation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Elevation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Elevation end of topic ===
    Comment    ======= Verify ${subSystem}_Elevation_Drives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Elevation_Drives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Elevation_Drives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Elevation_Drives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Elevation_Drives end of topic ===
    Comment    ======= Verify ${subSystem}_Locking_Pins test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Locking_Pins
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Locking_Pins start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Locking_Pins_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Locking_Pins end of topic ===
    Comment    ======= Verify ${subSystem}_Camera_Cable_Wrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Camera_Cable_Wrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Camera_Cable_Wrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Camera_Cable_Wrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Camera_Cable_Wrap end of topic ===
    Comment    ======= Verify ${subSystem}_Deployable_Platforms test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Deployable_Platforms
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Deployable_Platforms start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Deployable_Platforms_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Deployable_Platforms end of topic ===
    Comment    ======= Verify ${subSystem}_Elevation_Drives_Thermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Elevation_Drives_Thermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Elevation_Drives_Thermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Elevation_Drives_Thermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Elevation_Drives_Thermal end of topic ===
    Comment    ======= Verify ${subSystem}_Mirror_Cover test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Mirror_Cover
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Mirror_Cover start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Mirror_Cover_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Mirror_Cover end of topic ===
    Comment    ======= Verify ${subSystem}_Mount_Control_Main_Cabinet test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Mount_Control_Main_Cabinet
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Mount_Control_Main_Cabinet start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Mount_Control_Main_Cabinet_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Mount_Control_Main_Cabinet end of topic ===
    Comment    ======= Verify ${subSystem}_Top_End_Chiller test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Top_End_Chiller
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Top_End_Chiller start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Top_End_Chiller_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Top_End_Chiller end of topic ===
    Comment    ======= Verify ${subSystem}_Mirror_Cover_Locks test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Mirror_Cover_Locks
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Mirror_Cover_Locks start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Mirror_Cover_Locks_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Mirror_Cover_Locks end of topic ===
    Comment    ======= Verify ${subSystem}_Main_Power_Supply_Cabinet test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Main_Power_Supply_Cabinet
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Main_Power_Supply_Cabinet start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Main_Power_Supply_Cabinet_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Main_Power_Supply_Cabinet end of topic ===
    Comment    ======= Verify ${subSystem}_Auxiliary_Boxes test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Auxiliary_Boxes
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Auxiliary_Boxes start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Auxiliary_Boxes_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Auxiliary_Boxes end of topic ===
    Comment    ======= Verify ${subSystem}_Compressed_Air test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Compressed_Air
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Compressed_Air start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Compressed_Air_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Compressed_Air end of topic ===
    Comment    ======= Verify ${subSystem}_Cooling test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Cooling
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Cooling start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Cooling_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Cooling end of topic ===
    Comment    ======= Verify ${subSystem}_Dynalene_Cooling test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Dynalene_Cooling
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Dynalene_Cooling start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Dynalene_Cooling_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Dynalene_Cooling end of topic ===
    Comment    ======= Verify ${subSystem}_General_Purpose_Glycol_Water test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_General_Purpose_Glycol_Water
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_General_Purpose_Glycol_Water start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::General_Purpose_Glycol_Water_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_General_Purpose_Glycol_Water end of topic ===
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Safety_System
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Safety_System start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Safety_System_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Safety_System end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${Auxliary_Cabinet_Azimuth_start}=    Get Index From List    ${full_list}    === MTMount_Auxliary_Cabinet_Azimuth start of topic ===
    ${Auxliary_Cabinet_Azimuth_end}=    Get Index From List    ${full_list}    === MTMount_Auxliary_Cabinet_Azimuth end of topic ===
    ${Auxliary_Cabinet_Azimuth_list}=    Get Slice From List    ${full_list}    start=${Auxliary_Cabinet_Azimuth_start}    end=${Auxliary_Cabinet_Azimuth_end}
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Auxiliar_Azimuth_Cabinet_Status : LSST    10
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Auxiliar_Azimuth_Cabinet_External_Temperature : 1    10
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Auxiliar_Azimuth_Cabinet_Internal_Temperature_1 : 1    10
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Auxiliar_Azimuth_Cabinet_Internal_Temperature_2 : 1    10
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Auxiliar_Azimuth_Cabinet_Setpoint_Temperature : 1    10
    Should Contain X Times    ${Auxliary_Cabinet_Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${General_start}=    Get Index From List    ${full_list}    === MTMount_General start of topic ===
    ${General_end}=    Get Index From List    ${full_list}    === MTMount_General end of topic ===
    ${General_list}=    Get Slice From List    ${full_list}    start=${General_start}    end=${General_end}
    Should Contain X Times    ${General_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AmbientTemperature : 1    10
    Should Contain X Times    ${General_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Azimuth_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Cable_Wrap start of topic ===
    ${Azimuth_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Cable_Wrap end of topic ===
    ${Azimuth_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Cable_Wrap_start}    end=${Azimuth_Cable_Wrap_end}
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Status : LSST    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Current_Drive_1 : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Current_Drive_2 : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_AngleDif_Actual : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_AngleDif_ActualLVDT : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Angle_Setpoint : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Positive_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Negative_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ACW_Interlocks : LSST    10
    Should Contain X Times    ${Azimuth_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Azimuth_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth start of topic ===
    ${Azimuth_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth end of topic ===
    ${Azimuth_list}=    Get Slice From List    ${full_list}    start=${Azimuth_start}    end=${Azimuth_end}
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status : LSST    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Angle_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Angle_Set : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Aceleration_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Velocity_Set : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Velocity_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Torque_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Interlocks : LSST    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Azimuth_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives start of topic ===
    ${Azimuth_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives end of topic ===
    ${Azimuth_Drives_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Drives_start}    end=${Azimuth_Drives_end}
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_3 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_4 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_5 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_6 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_7 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_8 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_9 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_10 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_11 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_12 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_13 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_14 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_15 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status_Drive_16 : LSST    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_1 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_2 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_3 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_4 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_5 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_6 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_7 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_8 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_9 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_10 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_11 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_12 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_13 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_14 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_15 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Current_Drive_16 : 1    10
    Should Contain X Times    ${Azimuth_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Azimuth_Drives_Thermal_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives_Thermal start of topic ===
    ${Azimuth_Drives_Thermal_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives_Thermal end of topic ===
    ${Azimuth_Drives_Thermal_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Drives_Thermal_start}    end=${Azimuth_Drives_Thermal_end}
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
    ${OSS_start}=    Get Index From List    ${full_list}    === MTMount_OSS start of topic ===
    ${OSS_end}=    Get Index From List    ${full_list}    === MTMount_OSS end of topic ===
    ${OSS_list}=    Get Slice From List    ${full_list}    start=${OSS_start}    end=${OSS_end}
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
    ${OSS2_start}=    Get Index From List    ${full_list}    === MTMount_OSS2 start of topic ===
    ${OSS2_end}=    Get Index From List    ${full_list}    === MTMount_OSS2 end of topic ===
    ${OSS2_list}=    Get Slice From List    ${full_list}    start=${OSS2_start}    end=${OSS2_end}
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CTM_5001 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5057 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5056 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5055 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5054 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5013 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5012 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5011 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5006 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5005 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5004 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5003 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5002 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5001 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_calculated : 1    10
    ${OSS4_start}=    Get Index From List    ${full_list}    === MTMount_OSS4 start of topic ===
    ${OSS4_end}=    Get Index From List    ${full_list}    === MTMount_OSS4 end of topic ===
    ${OSS4_list}=    Get Slice From List    ${full_list}    start=${OSS4_start}    end=${OSS4_end}
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5002 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5022 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5032 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5052 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5002 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5003 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5022 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5023 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5032 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5033 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5034 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5052 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5053 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5054 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_calculated : 1    10
    ${OSS5_start}=    Get Index From List    ${full_list}    === MTMount_OSS5 start of topic ===
    ${OSS5_end}=    Get Index From List    ${full_list}    === MTMount_OSS5 end of topic ===
    ${OSS5_list}=    Get Slice From List    ${full_list}    start=${OSS5_start}    end=${OSS5_end}
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5012 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5013 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5042 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5043 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5012 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5013 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5014 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5015 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5016 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5042 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5043 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5044 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5045 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5046 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_XPos_M2_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_XNeg_M2_right_Bearing_calculated : 1    10
    ${OSS6_start}=    Get Index From List    ${full_list}    === MTMount_OSS6 start of topic ===
    ${OSS6_end}=    Get Index From List    ${full_list}    === MTMount_OSS6 end of topic ===
    ${OSS6_list}=    Get Slice From List    ${full_list}    start=${OSS6_start}    end=${OSS6_end}
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5001 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5002 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5011 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5012 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5021 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5022 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5031 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CFM_5032 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5001 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5002 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5003 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5011 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5012 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5013 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5021 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5022 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5023 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5024 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5031 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5032 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CPM_5033 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CTM_5001 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CTM_5011 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CTM_5021 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_CTM_5031 : 1    10
    Should Contain X Times    ${OSS6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Main_Power_Supply_start}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply start of topic ===
    ${Main_Power_Supply_end}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply end of topic ===
    ${Main_Power_Supply_list}=    Get Slice From List    ${full_list}    start=${Main_Power_Supply_start}    end=${Main_Power_Supply_end}
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Status : LSST    10
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Thermal_Status : LSST    10
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_DC_Voltage : 1    10
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Line_Voltage : 1    10
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Current : 1    10
    Should Contain X Times    ${Main_Power_Supply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Encoder_EIB_start}=    Get Index From List    ${full_list}    === MTMount_Encoder_EIB start of topic ===
    ${Encoder_EIB_end}=    Get Index From List    ${full_list}    === MTMount_Encoder_EIB end of topic ===
    ${Encoder_EIB_list}=    Get Slice From List    ${full_list}    start=${Encoder_EIB_start}    end=${Encoder_EIB_end}
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Actual_Encoder_Head_1 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Actual_Encoder_Head_2 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Actual_Encoder_Head_3 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Actual_Encoder_Head_4 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Actual_Encoder_Head_1 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Actual_Encoder_Head_2 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Actual_Encoder_Head_3 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Actual_Encoder_Head_4 : 1    10
    Should Contain X Times    ${Encoder_EIB_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Balancing_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Balancing_Drives start of topic ===
    ${Balancing_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Balancing_Drives end of topic ===
    ${Balancing_Drives_list}=    Get Slice From List    ${full_list}    start=${Balancing_Drives_start}    end=${Balancing_Drives_end}
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Status_Drive_3 : LSST    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Status_Drive_4 : LSST    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Current_Drive_1 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Current_Drive_2 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Current_Drive_3 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Current_Drive_4 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Position_Set_Drive_1 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Position_Set_Drive_2 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Position_Set_Drive_3 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Position_Set_Drive_4 : 1    10
    Should Contain X Times    ${Balancing_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Balancing_start}=    Get Index From List    ${full_list}    === MTMount_Balancing start of topic ===
    ${Balancing_end}=    Get Index From List    ${full_list}    === MTMount_Balancing end of topic ===
    ${Balancing_list}=    Get Slice From List    ${full_list}    start=${Balancing_start}    end=${Balancing_end}
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Status : LSST    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Actual_Position_Drive_1 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Actual_Position_Drive_2 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Actual_Position_Drive_3 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Actual_Position_Drive_4 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Positive_Limit_Switch_Drive_1 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Positive_Limit_Switch_Drive_2 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Positive_Limit_Switch_Drive_3 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Positive_Limit_Switch_Drive_4 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Negative_Limit_Switch_Drive_1 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Negative_Limit_Switch_Drive_2 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Negative_Limit_Switch_Drive_3 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Negative_Limit_Switch_Drive_4 : 1    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Balancing_Interlocks : LSST    10
    Should Contain X Times    ${Balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Elevation_start}=    Get Index From List    ${full_list}    === MTMount_Elevation start of topic ===
    ${Elevation_end}=    Get Index From List    ${full_list}    === MTMount_Elevation end of topic ===
    ${Elevation_list}=    Get Slice From List    ${full_list}    start=${Elevation_start}    end=${Elevation_end}
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status : LSST    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Angle_Actual : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Angle_Set : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Aceleration_Actual : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Velocity_Set : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Velocity_Actual : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Torque_Actual : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_Software_limit : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_Software_limit : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_Power_Off_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_Power_Off_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Positive_Operational_Directional_limit_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Negative_Operational_Directional_limit_switch : 1    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Interlocks : LSST    10
    Should Contain X Times    ${Elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Elevation_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives start of topic ===
    ${Elevation_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives end of topic ===
    ${Elevation_Drives_list}=    Get Slice From List    ${full_list}    start=${Elevation_Drives_start}    end=${Elevation_Drives_end}
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_3 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_4 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_5 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_6 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_7 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_8 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_9 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_10 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_11 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Status_Drive_12 : LSST    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_1 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_2 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_3 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_4 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_5 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_6 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_7 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_8 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_9 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_10 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_11 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Current_Drive_12 : 1    10
    Should Contain X Times    ${Elevation_Drives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Locking_Pins_start}=    Get Index From List    ${full_list}    === MTMount_Locking_Pins start of topic ===
    ${Locking_Pins_end}=    Get Index From List    ${full_list}    === MTMount_Locking_Pins end of topic ===
    ${Locking_Pins_list}=    Get Slice From List    ${full_list}    start=${Locking_Pins_start}    end=${Locking_Pins_end}
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Drive_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Drive_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Current_Drive_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Current_Drive_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Setpoint_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Setpoint_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Free_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Free_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Lock_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Lock_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Test_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Test_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Retracted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Retracted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Inserted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Inserted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Test : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Test : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Interlocks : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Camera_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    ${Camera_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Camera_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Camera_Cable_Wrap_start}    end=${Camera_Cable_Wrap_end}
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CameraRotatorPosition : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Camera_Position : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Interlocks : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Deployable_Platforms_start}=    Get Index From List    ${full_list}    === MTMount_Deployable_Platforms start of topic ===
    ${Deployable_Platforms_end}=    Get Index From List    ${full_list}    === MTMount_Deployable_Platforms end of topic ===
    ${Deployable_Platforms_list}=    Get Slice From List    ${full_list}    start=${Deployable_Platforms_start}    end=${Deployable_Platforms_end}
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Current_Drive_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Current_Drive_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Set_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Set_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Actual_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Actual_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Extended_Directional_Limit_Switch_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Extended_Directional_Limit_Switch_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Retracted_Directional_Limit_Switch_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Retracted_Directional_Limit_Switch_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Interlocks : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Elevation_Drives_Thermal_start}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives_Thermal start of topic ===
    ${Elevation_Drives_Thermal_end}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives_Thermal end of topic ===
    ${Elevation_Drives_Thermal_list}=    Get Slice From List    ${full_list}    start=${Elevation_Drives_Thermal_start}    end=${Elevation_Drives_Thermal_end}
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Thermal_Status_Group_1 : LSST    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Thermal_Status_Group_2 : LSST    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_1 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_2 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_3 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_4 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_5 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_6 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_7 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_8 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_9 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_10 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_11 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Motor_12 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_1 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_2 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_3 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_4 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_5 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_6 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_7 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_8 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_9 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_10 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_11 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Drive_12 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Setpoint_Group_1 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Surface_Temperature_Setpoint_Group_2 : 1    10
    Should Contain X Times    ${Elevation_Drives_Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Mirror_Cover_start}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover start of topic ===
    ${Mirror_Cover_end}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover end of topic ===
    ${Mirror_Cover_list}=    Get Slice From List    ${full_list}    start=${Mirror_Cover_start}    end=${Mirror_Cover_end}
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_Interlocks : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Mount_Control_Main_Cabinet_start}=    Get Index From List    ${full_list}    === MTMount_Mount_Control_Main_Cabinet start of topic ===
    ${Mount_Control_Main_Cabinet_end}=    Get Index From List    ${full_list}    === MTMount_Mount_Control_Main_Cabinet end of topic ===
    ${Mount_Control_Main_Cabinet_list}=    Get Slice From List    ${full_list}    start=${Mount_Control_Main_Cabinet_start}    end=${Mount_Control_Main_Cabinet_end}
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_Status : LSST    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_External_Temperature : 1    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_Internal_Temperature_1 : 1    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_Internal_Temperature_2 : 1    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_Setpoint_Temperature : 1    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Main_Cabinet_Doors_Open : 1    10
    Should Contain X Times    ${Mount_Control_Main_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Top_End_Chiller_start}=    Get Index From List    ${full_list}    === MTMount_Top_End_Chiller start of topic ===
    ${Top_End_Chiller_end}=    Get Index From List    ${full_list}    === MTMount_Top_End_Chiller end of topic ===
    ${Top_End_Chiller_list}=    Get Slice From List    ${full_list}    start=${Top_End_Chiller_start}    end=${Top_End_Chiller_end}
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
    ${Mirror_Cover_Locks_start}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover_Locks start of topic ===
    ${Mirror_Cover_Locks_end}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover_Locks end of topic ===
    ${Mirror_Cover_Locks_list}=    Get Slice From List    ${full_list}    start=${Mirror_Cover_Locks_start}    end=${Mirror_Cover_Locks_end}
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_Interlocks : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Main_Power_Supply_Cabinet_start}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply_Cabinet start of topic ===
    ${Main_Power_Supply_Cabinet_end}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply_Cabinet end of topic ===
    ${Main_Power_Supply_Cabinet_list}=    Get Slice From List    ${full_list}    start=${Main_Power_Supply_Cabinet_start}    end=${Main_Power_Supply_Cabinet_end}
    Should Contain X Times    ${Main_Power_Supply_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Surface_Temperature : 1    10
    Should Contain X Times    ${Main_Power_Supply_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Internal_Temperature : 1    10
    Should Contain X Times    ${Main_Power_Supply_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power_Supply_Setpoint_Temperature : 1    10
    Should Contain X Times    ${Main_Power_Supply_Cabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Auxiliary_Boxes_start}=    Get Index From List    ${full_list}    === MTMount_Auxiliary_Boxes start of topic ===
    ${Auxiliary_Boxes_end}=    Get Index From List    ${full_list}    === MTMount_Auxiliary_Boxes end of topic ===
    ${Auxiliary_Boxes_list}=    Get Slice From List    ${full_list}    start=${Auxiliary_Boxes_start}    end=${Auxiliary_Boxes_end}
    Should Contain X Times    ${Auxiliary_Boxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_TMA_AZ_PD_CBT_0001 : LSST    10
    Should Contain X Times    ${Auxiliary_Boxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_TMA_EL_PD_CBT_0001 : LSST    10
    Should Contain X Times    ${Auxiliary_Boxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Status_TMA_EL_PD_CBT_0002 : LSST    10
    Should Contain X Times    ${Auxiliary_Boxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Compressed_Air_start}=    Get Index From List    ${full_list}    === MTMount_Compressed_Air start of topic ===
    ${Compressed_Air_end}=    Get Index From List    ${full_list}    === MTMount_Compressed_Air end of topic ===
    ${Compressed_Air_list}=    Get Slice From List    ${full_list}    start=${Compressed_Air_start}    end=${Compressed_Air_end}
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_CP_CPM_0001 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_CP_CPM_0002 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_CP_CPM_0001 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_CP_CPM_0002 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_CP_CPM_0101 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_CP_CTM_0101 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Cooling_start}=    Get Index From List    ${full_list}    === MTMount_Cooling start of topic ===
    ${Cooling_end}=    Get Index From List    ${full_list}    === MTMount_Cooling end of topic ===
    ${Cooling_list}=    Get Slice From List    ${full_list}    start=${Cooling_start}    end=${Cooling_end}
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0001 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0002 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0021 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0022 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CTM_0001 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CTM_0002 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CTM_0021 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CTM_0022 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GW_CPM_0101 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GW_CPM_0102 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GW_CTM_0101 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GW_CTM_0102 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0003 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0004 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0005 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0006 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0007 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0008 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0009 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0010 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0011 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0012 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0013 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0014 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0015 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0016 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0017 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0018 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0019 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GW_CPM_0020 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_GW_CPM_0001 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_GW_CPM_0002 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_GW_CTM_0001 : 1    10
    Should Contain X Times    ${Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Dynalene_Cooling_start}=    Get Index From List    ${full_list}    === MTMount_Dynalene_Cooling start of topic ===
    ${Dynalene_Cooling_end}=    Get Index From List    ${full_list}    === MTMount_Dynalene_Cooling end of topic ===
    ${Dynalene_Cooling_list}=    Get Slice From List    ${full_list}    start=${Dynalene_Cooling_start}    end=${Dynalene_Cooling_end}
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_DY_CPM_0001 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_DY_CPM_0002 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_DY_CTM_0001 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_DY_CTM_0002 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0001 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0007 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_DY_CPM_0101 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_DY_CPM_0102 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_DY_CTM_0101 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_DY_CTM_0102 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0002 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0003 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0004 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0005 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_EL_CPM_0006 : 1    10
    Should Contain X Times    ${Dynalene_Cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${General_Purpose_Glycol_Water_start}=    Get Index From List    ${full_list}    === MTMount_General_Purpose_Glycol_Water start of topic ===
    ${General_Purpose_Glycol_Water_end}=    Get Index From List    ${full_list}    === MTMount_General_Purpose_Glycol_Water end of topic ===
    ${General_Purpose_Glycol_Water_list}=    Get Slice From List    ${full_list}    start=${General_Purpose_Glycol_Water_start}    end=${General_Purpose_Glycol_Water_end}
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GP_CPM_0001 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_GP_CPM_0002 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GP_CPM_0001 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GP_CPM_0002 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GP_CTM_0001 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_GP_CTM_0002 : 1    10
    Should Contain X Times    ${General_Purpose_Glycol_Water_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Safety_System_start}=    Get Index From List    ${full_list}    === MTMount_Safety_System start of topic ===
    ${Safety_System_end}=    Get Index From List    ${full_list}    === MTMount_Safety_System end of topic ===
    ${Safety_System_list}=    Get Slice From List    ${full_list}    start=${Safety_System_start}    end=${Safety_System_end}
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
