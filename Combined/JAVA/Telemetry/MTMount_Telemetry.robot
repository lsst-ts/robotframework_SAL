*** Settings ***
Documentation    MTMount_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${Auxliary_Cabinet_Azimuth_start}=    Get Index From List    ${full_list}    === MTMount_Auxliary_Cabinet_Azimuth start of topic ===
    ${Auxliary_Cabinet_Azimuth_end}=    Get Index From List    ${full_list}    === MTMount_Auxliary_Cabinet_Azimuth end of topic ===
    ${Auxliary_Cabinet_Azimuth_list}=    Get Slice From List    ${full_list}    start=${Auxliary_Cabinet_Azimuth_start}    end=${Auxliary_Cabinet_Azimuth_end + 1}
    Log Many    ${Auxliary_Cabinet_Azimuth_list}
    Should Contain    ${Auxliary_Cabinet_Azimuth_list}    === MTMount_Auxliary_Cabinet_Azimuth start of topic ===
    Should Contain    ${Auxliary_Cabinet_Azimuth_list}    === MTMount_Auxliary_Cabinet_Azimuth end of topic ===
    ${General_start}=    Get Index From List    ${full_list}    === MTMount_General start of topic ===
    ${General_end}=    Get Index From List    ${full_list}    === MTMount_General end of topic ===
    ${General_list}=    Get Slice From List    ${full_list}    start=${General_start}    end=${General_end + 1}
    Log Many    ${General_list}
    Should Contain    ${General_list}    === MTMount_General start of topic ===
    Should Contain    ${General_list}    === MTMount_General end of topic ===
    ${Azimuth_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Cable_Wrap start of topic ===
    ${Azimuth_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Cable_Wrap end of topic ===
    ${Azimuth_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Cable_Wrap_start}    end=${Azimuth_Cable_Wrap_end + 1}
    Log Many    ${Azimuth_Cable_Wrap_list}
    Should Contain    ${Azimuth_Cable_Wrap_list}    === MTMount_Azimuth_Cable_Wrap start of topic ===
    Should Contain    ${Azimuth_Cable_Wrap_list}    === MTMount_Azimuth_Cable_Wrap end of topic ===
    ${Azimuth_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth start of topic ===
    ${Azimuth_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth end of topic ===
    ${Azimuth_list}=    Get Slice From List    ${full_list}    start=${Azimuth_start}    end=${Azimuth_end + 1}
    Log Many    ${Azimuth_list}
    Should Contain    ${Azimuth_list}    === MTMount_Azimuth start of topic ===
    Should Contain    ${Azimuth_list}    === MTMount_Azimuth end of topic ===
    ${Azimuth_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives start of topic ===
    ${Azimuth_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives end of topic ===
    ${Azimuth_Drives_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Drives_start}    end=${Azimuth_Drives_end + 1}
    Log Many    ${Azimuth_Drives_list}
    Should Contain    ${Azimuth_Drives_list}    === MTMount_Azimuth_Drives start of topic ===
    Should Contain    ${Azimuth_Drives_list}    === MTMount_Azimuth_Drives end of topic ===
    ${Azimuth_Drives_Thermal_start}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives_Thermal start of topic ===
    ${Azimuth_Drives_Thermal_end}=    Get Index From List    ${full_list}    === MTMount_Azimuth_Drives_Thermal end of topic ===
    ${Azimuth_Drives_Thermal_list}=    Get Slice From List    ${full_list}    start=${Azimuth_Drives_Thermal_start}    end=${Azimuth_Drives_Thermal_end + 1}
    Log Many    ${Azimuth_Drives_Thermal_list}
    Should Contain    ${Azimuth_Drives_Thermal_list}    === MTMount_Azimuth_Drives_Thermal start of topic ===
    Should Contain    ${Azimuth_Drives_Thermal_list}    === MTMount_Azimuth_Drives_Thermal end of topic ===
    ${OSS_start}=    Get Index From List    ${full_list}    === MTMount_OSS start of topic ===
    ${OSS_end}=    Get Index From List    ${full_list}    === MTMount_OSS end of topic ===
    ${OSS_list}=    Get Slice From List    ${full_list}    start=${OSS_start}    end=${OSS_end + 1}
    Log Many    ${OSS_list}
    Should Contain    ${OSS_list}    === MTMount_OSS start of topic ===
    Should Contain    ${OSS_list}    === MTMount_OSS end of topic ===
    ${OSS2_start}=    Get Index From List    ${full_list}    === MTMount_OSS2 start of topic ===
    ${OSS2_end}=    Get Index From List    ${full_list}    === MTMount_OSS2 end of topic ===
    ${OSS2_list}=    Get Slice From List    ${full_list}    start=${OSS2_start}    end=${OSS2_end + 1}
    Log Many    ${OSS2_list}
    Should Contain    ${OSS2_list}    === MTMount_OSS2 start of topic ===
    Should Contain    ${OSS2_list}    === MTMount_OSS2 end of topic ===
    ${OSS4_start}=    Get Index From List    ${full_list}    === MTMount_OSS4 start of topic ===
    ${OSS4_end}=    Get Index From List    ${full_list}    === MTMount_OSS4 end of topic ===
    ${OSS4_list}=    Get Slice From List    ${full_list}    start=${OSS4_start}    end=${OSS4_end + 1}
    Log Many    ${OSS4_list}
    Should Contain    ${OSS4_list}    === MTMount_OSS4 start of topic ===
    Should Contain    ${OSS4_list}    === MTMount_OSS4 end of topic ===
    ${OSS5_start}=    Get Index From List    ${full_list}    === MTMount_OSS5 start of topic ===
    ${OSS5_end}=    Get Index From List    ${full_list}    === MTMount_OSS5 end of topic ===
    ${OSS5_list}=    Get Slice From List    ${full_list}    start=${OSS5_start}    end=${OSS5_end + 1}
    Log Many    ${OSS5_list}
    Should Contain    ${OSS5_list}    === MTMount_OSS5 start of topic ===
    Should Contain    ${OSS5_list}    === MTMount_OSS5 end of topic ===
    ${OSS6_start}=    Get Index From List    ${full_list}    === MTMount_OSS6 start of topic ===
    ${OSS6_end}=    Get Index From List    ${full_list}    === MTMount_OSS6 end of topic ===
    ${OSS6_list}=    Get Slice From List    ${full_list}    start=${OSS6_start}    end=${OSS6_end + 1}
    Log Many    ${OSS6_list}
    Should Contain    ${OSS6_list}    === MTMount_OSS6 start of topic ===
    Should Contain    ${OSS6_list}    === MTMount_OSS6 end of topic ===
    ${Main_Power_Supply_start}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply start of topic ===
    ${Main_Power_Supply_end}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply end of topic ===
    ${Main_Power_Supply_list}=    Get Slice From List    ${full_list}    start=${Main_Power_Supply_start}    end=${Main_Power_Supply_end + 1}
    Log Many    ${Main_Power_Supply_list}
    Should Contain    ${Main_Power_Supply_list}    === MTMount_Main_Power_Supply start of topic ===
    Should Contain    ${Main_Power_Supply_list}    === MTMount_Main_Power_Supply end of topic ===
    ${Encoder_EIB_start}=    Get Index From List    ${full_list}    === MTMount_Encoder_EIB start of topic ===
    ${Encoder_EIB_end}=    Get Index From List    ${full_list}    === MTMount_Encoder_EIB end of topic ===
    ${Encoder_EIB_list}=    Get Slice From List    ${full_list}    start=${Encoder_EIB_start}    end=${Encoder_EIB_end + 1}
    Log Many    ${Encoder_EIB_list}
    Should Contain    ${Encoder_EIB_list}    === MTMount_Encoder_EIB start of topic ===
    Should Contain    ${Encoder_EIB_list}    === MTMount_Encoder_EIB end of topic ===
    ${Balancing_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Balancing_Drives start of topic ===
    ${Balancing_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Balancing_Drives end of topic ===
    ${Balancing_Drives_list}=    Get Slice From List    ${full_list}    start=${Balancing_Drives_start}    end=${Balancing_Drives_end + 1}
    Log Many    ${Balancing_Drives_list}
    Should Contain    ${Balancing_Drives_list}    === MTMount_Balancing_Drives start of topic ===
    Should Contain    ${Balancing_Drives_list}    === MTMount_Balancing_Drives end of topic ===
    ${Balancing_start}=    Get Index From List    ${full_list}    === MTMount_Balancing start of topic ===
    ${Balancing_end}=    Get Index From List    ${full_list}    === MTMount_Balancing end of topic ===
    ${Balancing_list}=    Get Slice From List    ${full_list}    start=${Balancing_start}    end=${Balancing_end + 1}
    Log Many    ${Balancing_list}
    Should Contain    ${Balancing_list}    === MTMount_Balancing start of topic ===
    Should Contain    ${Balancing_list}    === MTMount_Balancing end of topic ===
    ${Elevation_start}=    Get Index From List    ${full_list}    === MTMount_Elevation start of topic ===
    ${Elevation_end}=    Get Index From List    ${full_list}    === MTMount_Elevation end of topic ===
    ${Elevation_list}=    Get Slice From List    ${full_list}    start=${Elevation_start}    end=${Elevation_end + 1}
    Log Many    ${Elevation_list}
    Should Contain    ${Elevation_list}    === MTMount_Elevation start of topic ===
    Should Contain    ${Elevation_list}    === MTMount_Elevation end of topic ===
    ${Elevation_Drives_start}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives start of topic ===
    ${Elevation_Drives_end}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives end of topic ===
    ${Elevation_Drives_list}=    Get Slice From List    ${full_list}    start=${Elevation_Drives_start}    end=${Elevation_Drives_end + 1}
    Log Many    ${Elevation_Drives_list}
    Should Contain    ${Elevation_Drives_list}    === MTMount_Elevation_Drives start of topic ===
    Should Contain    ${Elevation_Drives_list}    === MTMount_Elevation_Drives end of topic ===
    ${Locking_Pins_start}=    Get Index From List    ${full_list}    === MTMount_Locking_Pins start of topic ===
    ${Locking_Pins_end}=    Get Index From List    ${full_list}    === MTMount_Locking_Pins end of topic ===
    ${Locking_Pins_list}=    Get Slice From List    ${full_list}    start=${Locking_Pins_start}    end=${Locking_Pins_end + 1}
    Log Many    ${Locking_Pins_list}
    Should Contain    ${Locking_Pins_list}    === MTMount_Locking_Pins start of topic ===
    Should Contain    ${Locking_Pins_list}    === MTMount_Locking_Pins end of topic ===
    ${Camera_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    ${Camera_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Camera_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Camera_Cable_Wrap_start}    end=${Camera_Cable_Wrap_end + 1}
    Log Many    ${Camera_Cable_Wrap_list}
    Should Contain    ${Camera_Cable_Wrap_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    Should Contain    ${Camera_Cable_Wrap_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Deployable_Platforms_start}=    Get Index From List    ${full_list}    === MTMount_Deployable_Platforms start of topic ===
    ${Deployable_Platforms_end}=    Get Index From List    ${full_list}    === MTMount_Deployable_Platforms end of topic ===
    ${Deployable_Platforms_list}=    Get Slice From List    ${full_list}    start=${Deployable_Platforms_start}    end=${Deployable_Platforms_end + 1}
    Log Many    ${Deployable_Platforms_list}
    Should Contain    ${Deployable_Platforms_list}    === MTMount_Deployable_Platforms start of topic ===
    Should Contain    ${Deployable_Platforms_list}    === MTMount_Deployable_Platforms end of topic ===
    ${Elevation_Drives_Thermal_start}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives_Thermal start of topic ===
    ${Elevation_Drives_Thermal_end}=    Get Index From List    ${full_list}    === MTMount_Elevation_Drives_Thermal end of topic ===
    ${Elevation_Drives_Thermal_list}=    Get Slice From List    ${full_list}    start=${Elevation_Drives_Thermal_start}    end=${Elevation_Drives_Thermal_end + 1}
    Log Many    ${Elevation_Drives_Thermal_list}
    Should Contain    ${Elevation_Drives_Thermal_list}    === MTMount_Elevation_Drives_Thermal start of topic ===
    Should Contain    ${Elevation_Drives_Thermal_list}    === MTMount_Elevation_Drives_Thermal end of topic ===
    ${Mirror_Cover_start}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover start of topic ===
    ${Mirror_Cover_end}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover end of topic ===
    ${Mirror_Cover_list}=    Get Slice From List    ${full_list}    start=${Mirror_Cover_start}    end=${Mirror_Cover_end + 1}
    Log Many    ${Mirror_Cover_list}
    Should Contain    ${Mirror_Cover_list}    === MTMount_Mirror_Cover start of topic ===
    Should Contain    ${Mirror_Cover_list}    === MTMount_Mirror_Cover end of topic ===
    ${Mount_Control_Main_Cabinet_start}=    Get Index From List    ${full_list}    === MTMount_Mount_Control_Main_Cabinet start of topic ===
    ${Mount_Control_Main_Cabinet_end}=    Get Index From List    ${full_list}    === MTMount_Mount_Control_Main_Cabinet end of topic ===
    ${Mount_Control_Main_Cabinet_list}=    Get Slice From List    ${full_list}    start=${Mount_Control_Main_Cabinet_start}    end=${Mount_Control_Main_Cabinet_end + 1}
    Log Many    ${Mount_Control_Main_Cabinet_list}
    Should Contain    ${Mount_Control_Main_Cabinet_list}    === MTMount_Mount_Control_Main_Cabinet start of topic ===
    Should Contain    ${Mount_Control_Main_Cabinet_list}    === MTMount_Mount_Control_Main_Cabinet end of topic ===
    ${Top_End_Chiller_start}=    Get Index From List    ${full_list}    === MTMount_Top_End_Chiller start of topic ===
    ${Top_End_Chiller_end}=    Get Index From List    ${full_list}    === MTMount_Top_End_Chiller end of topic ===
    ${Top_End_Chiller_list}=    Get Slice From List    ${full_list}    start=${Top_End_Chiller_start}    end=${Top_End_Chiller_end + 1}
    Log Many    ${Top_End_Chiller_list}
    Should Contain    ${Top_End_Chiller_list}    === MTMount_Top_End_Chiller start of topic ===
    Should Contain    ${Top_End_Chiller_list}    === MTMount_Top_End_Chiller end of topic ===
    ${Mirror_Cover_Locks_start}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover_Locks start of topic ===
    ${Mirror_Cover_Locks_end}=    Get Index From List    ${full_list}    === MTMount_Mirror_Cover_Locks end of topic ===
    ${Mirror_Cover_Locks_list}=    Get Slice From List    ${full_list}    start=${Mirror_Cover_Locks_start}    end=${Mirror_Cover_Locks_end + 1}
    Log Many    ${Mirror_Cover_Locks_list}
    Should Contain    ${Mirror_Cover_Locks_list}    === MTMount_Mirror_Cover_Locks start of topic ===
    Should Contain    ${Mirror_Cover_Locks_list}    === MTMount_Mirror_Cover_Locks end of topic ===
    ${Main_Power_Supply_Cabinet_start}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply_Cabinet start of topic ===
    ${Main_Power_Supply_Cabinet_end}=    Get Index From List    ${full_list}    === MTMount_Main_Power_Supply_Cabinet end of topic ===
    ${Main_Power_Supply_Cabinet_list}=    Get Slice From List    ${full_list}    start=${Main_Power_Supply_Cabinet_start}    end=${Main_Power_Supply_Cabinet_end + 1}
    Log Many    ${Main_Power_Supply_Cabinet_list}
    Should Contain    ${Main_Power_Supply_Cabinet_list}    === MTMount_Main_Power_Supply_Cabinet start of topic ===
    Should Contain    ${Main_Power_Supply_Cabinet_list}    === MTMount_Main_Power_Supply_Cabinet end of topic ===
    ${Auxiliary_Boxes_start}=    Get Index From List    ${full_list}    === MTMount_Auxiliary_Boxes start of topic ===
    ${Auxiliary_Boxes_end}=    Get Index From List    ${full_list}    === MTMount_Auxiliary_Boxes end of topic ===
    ${Auxiliary_Boxes_list}=    Get Slice From List    ${full_list}    start=${Auxiliary_Boxes_start}    end=${Auxiliary_Boxes_end + 1}
    Log Many    ${Auxiliary_Boxes_list}
    Should Contain    ${Auxiliary_Boxes_list}    === MTMount_Auxiliary_Boxes start of topic ===
    Should Contain    ${Auxiliary_Boxes_list}    === MTMount_Auxiliary_Boxes end of topic ===
    ${Compressed_Air_start}=    Get Index From List    ${full_list}    === MTMount_Compressed_Air start of topic ===
    ${Compressed_Air_end}=    Get Index From List    ${full_list}    === MTMount_Compressed_Air end of topic ===
    ${Compressed_Air_list}=    Get Slice From List    ${full_list}    start=${Compressed_Air_start}    end=${Compressed_Air_end + 1}
    Log Many    ${Compressed_Air_list}
    Should Contain    ${Compressed_Air_list}    === MTMount_Compressed_Air start of topic ===
    Should Contain    ${Compressed_Air_list}    === MTMount_Compressed_Air end of topic ===
    ${Cooling_start}=    Get Index From List    ${full_list}    === MTMount_Cooling start of topic ===
    ${Cooling_end}=    Get Index From List    ${full_list}    === MTMount_Cooling end of topic ===
    ${Cooling_list}=    Get Slice From List    ${full_list}    start=${Cooling_start}    end=${Cooling_end + 1}
    Log Many    ${Cooling_list}
    Should Contain    ${Cooling_list}    === MTMount_Cooling start of topic ===
    Should Contain    ${Cooling_list}    === MTMount_Cooling end of topic ===
    ${Dynalene_Cooling_start}=    Get Index From List    ${full_list}    === MTMount_Dynalene_Cooling start of topic ===
    ${Dynalene_Cooling_end}=    Get Index From List    ${full_list}    === MTMount_Dynalene_Cooling end of topic ===
    ${Dynalene_Cooling_list}=    Get Slice From List    ${full_list}    start=${Dynalene_Cooling_start}    end=${Dynalene_Cooling_end + 1}
    Log Many    ${Dynalene_Cooling_list}
    Should Contain    ${Dynalene_Cooling_list}    === MTMount_Dynalene_Cooling start of topic ===
    Should Contain    ${Dynalene_Cooling_list}    === MTMount_Dynalene_Cooling end of topic ===
    ${General_Purpose_Glycol_Water_start}=    Get Index From List    ${full_list}    === MTMount_General_Purpose_Glycol_Water start of topic ===
    ${General_Purpose_Glycol_Water_end}=    Get Index From List    ${full_list}    === MTMount_General_Purpose_Glycol_Water end of topic ===
    ${General_Purpose_Glycol_Water_list}=    Get Slice From List    ${full_list}    start=${General_Purpose_Glycol_Water_start}    end=${General_Purpose_Glycol_Water_end + 1}
    Log Many    ${General_Purpose_Glycol_Water_list}
    Should Contain    ${General_Purpose_Glycol_Water_list}    === MTMount_General_Purpose_Glycol_Water start of topic ===
    Should Contain    ${General_Purpose_Glycol_Water_list}    === MTMount_General_Purpose_Glycol_Water end of topic ===
    ${Safety_System_start}=    Get Index From List    ${full_list}    === MTMount_Safety_System start of topic ===
    ${Safety_System_end}=    Get Index From List    ${full_list}    === MTMount_Safety_System end of topic ===
    ${Safety_System_list}=    Get Slice From List    ${full_list}    start=${Safety_System_start}    end=${Safety_System_end + 1}
    Log Many    ${Safety_System_list}
    Should Contain    ${Safety_System_list}    === MTMount_Safety_System start of topic ===
    Should Contain    ${Safety_System_list}    === MTMount_Safety_System end of topic ===
