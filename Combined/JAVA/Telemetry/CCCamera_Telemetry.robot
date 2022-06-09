*** Settings ***
Documentation    CCCamera_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCCamera
${component}    all
${timeout}    900s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
        ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
        Sleep    3s
    END
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${fcs_start}=    Get Index From List    ${full_list}    === CCCamera_fcs start of topic ===
    ${fcs_end}=    Get Index From List    ${full_list}    === CCCamera_fcs end of topic ===
    ${fcs_list}=    Get Slice From List    ${full_list}    start=${fcs_start}    end=${fcs_end + 1}
    Log Many    ${fcs_list}
    Should Contain    ${fcs_list}    === CCCamera_fcs start of topic ===
    Should Contain    ${fcs_list}    === CCCamera_fcs end of topic ===
    Should Contain    ${fcs_list}    === [fcs] message sent 200
    ${bonn_shutter_Device_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device start of topic ===
    ${bonn_shutter_Device_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device end of topic ===
    ${bonn_shutter_Device_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_start}    end=${bonn_shutter_Device_end + 1}
    Log Many    ${bonn_shutter_Device_list}
    Should Contain    ${bonn_shutter_Device_list}    === CCCamera_bonn_shutter_Device start of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === CCCamera_bonn_shutter_Device end of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device] message sent 200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store end of topic ===
    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store] message sent 200
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end + 1}
    Log Many    ${rebpower_Reb_list}
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb start of topic ===
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb end of topic ===
    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb] message sent 200
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end + 1}
    Log Many    ${rebpower_Rebps_list}
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps start of topic ===
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps end of topic ===
    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps] message sent 200
    ${vacuum_Cold1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 start of topic ===
    ${vacuum_Cold1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 end of topic ===
    ${vacuum_Cold1_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_start}    end=${vacuum_Cold1_end + 1}
    Log Many    ${vacuum_Cold1_list}
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 start of topic ===
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 end of topic ===
    Should Contain    ${vacuum_Cold1_list}    === [vacuum_Cold1] message sent 200
    ${vacuum_Cold2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 start of topic ===
    ${vacuum_Cold2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 end of topic ===
    ${vacuum_Cold2_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_start}    end=${vacuum_Cold2_end + 1}
    Log Many    ${vacuum_Cold2_list}
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 start of topic ===
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 end of topic ===
    Should Contain    ${vacuum_Cold2_list}    === [vacuum_Cold2] message sent 200
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end + 1}
    Log Many    ${vacuum_Cryo_list}
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo start of topic ===
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo end of topic ===
    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo] message sent 200
    ${vacuum_IonPumps_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps start of topic ===
    ${vacuum_IonPumps_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps end of topic ===
    ${vacuum_IonPumps_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_start}    end=${vacuum_IonPumps_end + 1}
    Log Many    ${vacuum_IonPumps_list}
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps start of topic ===
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps end of topic ===
    Should Contain    ${vacuum_IonPumps_list}    === [vacuum_IonPumps] message sent 200
    ${vacuum_Rtds_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds start of topic ===
    ${vacuum_Rtds_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds end of topic ===
    ${vacuum_Rtds_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_start}    end=${vacuum_Rtds_end + 1}
    Log Many    ${vacuum_Rtds_list}
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds start of topic ===
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds end of topic ===
    Should Contain    ${vacuum_Rtds_list}    === [vacuum_Rtds] message sent 200
    ${vacuum_Turbo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo start of topic ===
    ${vacuum_Turbo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo end of topic ===
    ${vacuum_Turbo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_start}    end=${vacuum_Turbo_end + 1}
    Log Many    ${vacuum_Turbo_list}
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo start of topic ===
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo end of topic ===
    Should Contain    ${vacuum_Turbo_list}    === [vacuum_Turbo] message sent 200
    ${vacuum_VQMonitor_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    ${vacuum_VQMonitor_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    ${vacuum_VQMonitor_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_start}    end=${vacuum_VQMonitor_end + 1}
    Log Many    ${vacuum_VQMonitor_list}
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    Should Contain    ${vacuum_VQMonitor_list}    === [vacuum_VQMonitor] message sent 200
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end + 1}
    Log Many    ${quadbox_BFR_list}
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR start of topic ===
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR end of topic ===
    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR] message sent 200
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end + 1}
    Log Many    ${quadbox_PDU_24VC_list}
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC] message sent 200
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end + 1}
    Log Many    ${quadbox_PDU_24VD_list}
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD] message sent 200
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end + 1}
    Log Many    ${quadbox_PDU_48V_list}
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V] message sent 200
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end + 1}
    Log Many    ${quadbox_PDU_5V_list}
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V] message sent 200
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === CCCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === CCCamera_focal_plane_Ccd end of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd] message sent 200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === CCCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === CCCamera_focal_plane_Reb end of topic ===
    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb] message sent 200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === CCCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === CCCamera_focal_plane_RebTotalPower end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower] message sent 200
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === CCCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === CCCamera_focal_plane_Segment end of topic ===
    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${fcs_start}=    Get Index From List    ${full_list}    === CCCamera_fcs start of topic ===
    ${fcs_end}=    Get Index From List    ${full_list}    === CCCamera_fcs end of topic ===
    ${fcs_list}=    Get Slice From List    ${full_list}    start=${fcs_start}    end=${fcs_end + 1}
    Log Many    ${fcs_list}
    Should Contain    ${fcs_list}    === CCCamera_fcs start of topic ===
    Should Contain    ${fcs_list}    === CCCamera_fcs end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_list}    === [fcs Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_list}    === [fcs Subscriber] message received :200
    ${bonn_shutter_Device_start}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device start of topic ===
    ${bonn_shutter_Device_end}=    Get Index From List    ${full_list}    === CCCamera_bonn_shutter_Device end of topic ===
    ${bonn_shutter_Device_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_start}    end=${bonn_shutter_Device_end + 1}
    Log Many    ${bonn_shutter_Device_list}
    Should Contain    ${bonn_shutter_Device_list}    === CCCamera_bonn_shutter_Device start of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === CCCamera_bonn_shutter_Device end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device Subscriber] message received :200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :200
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end + 1}
    Log Many    ${rebpower_Reb_list}
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb start of topic ===
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb Subscriber] message received :200
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end + 1}
    Log Many    ${rebpower_Rebps_list}
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps start of topic ===
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps Subscriber] message received :200
    ${vacuum_Cold1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 start of topic ===
    ${vacuum_Cold1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 end of topic ===
    ${vacuum_Cold1_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_start}    end=${vacuum_Cold1_end + 1}
    Log Many    ${vacuum_Cold1_list}
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 start of topic ===
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cold1_list}    === [vacuum_Cold1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cold1_list}    === [vacuum_Cold1 Subscriber] message received :200
    ${vacuum_Cold2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 start of topic ===
    ${vacuum_Cold2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 end of topic ===
    ${vacuum_Cold2_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_start}    end=${vacuum_Cold2_end + 1}
    Log Many    ${vacuum_Cold2_list}
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 start of topic ===
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cold2_list}    === [vacuum_Cold2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cold2_list}    === [vacuum_Cold2 Subscriber] message received :200
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end + 1}
    Log Many    ${vacuum_Cryo_list}
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo start of topic ===
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo Subscriber] message received :200
    ${vacuum_IonPumps_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps start of topic ===
    ${vacuum_IonPumps_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps end of topic ===
    ${vacuum_IonPumps_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_start}    end=${vacuum_IonPumps_end + 1}
    Log Many    ${vacuum_IonPumps_list}
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps start of topic ===
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_IonPumps_list}    === [vacuum_IonPumps Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_IonPumps_list}    === [vacuum_IonPumps Subscriber] message received :200
    ${vacuum_Rtds_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds start of topic ===
    ${vacuum_Rtds_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds end of topic ===
    ${vacuum_Rtds_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_start}    end=${vacuum_Rtds_end + 1}
    Log Many    ${vacuum_Rtds_list}
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds start of topic ===
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Rtds_list}    === [vacuum_Rtds Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Rtds_list}    === [vacuum_Rtds Subscriber] message received :200
    ${vacuum_Turbo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo start of topic ===
    ${vacuum_Turbo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo end of topic ===
    ${vacuum_Turbo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_start}    end=${vacuum_Turbo_end + 1}
    Log Many    ${vacuum_Turbo_list}
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo start of topic ===
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Turbo_list}    === [vacuum_Turbo Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Turbo_list}    === [vacuum_Turbo Subscriber] message received :200
    ${vacuum_VQMonitor_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    ${vacuum_VQMonitor_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    ${vacuum_VQMonitor_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_start}    end=${vacuum_VQMonitor_end + 1}
    Log Many    ${vacuum_VQMonitor_list}
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_VQMonitor_list}    === [vacuum_VQMonitor Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_VQMonitor_list}    === [vacuum_VQMonitor Subscriber] message received :200
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end + 1}
    Log Many    ${quadbox_BFR_list}
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR start of topic ===
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR Subscriber] message received :200
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end + 1}
    Log Many    ${quadbox_PDU_24VC_list}
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC Subscriber] message received :200
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end + 1}
    Log Many    ${quadbox_PDU_24VD_list}
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD Subscriber] message received :200
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end + 1}
    Log Many    ${quadbox_PDU_48V_list}
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V Subscriber] message received :200
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end + 1}
    Log Many    ${quadbox_PDU_5V_list}
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V Subscriber] message received :200
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === CCCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === CCCamera_focal_plane_Ccd end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === CCCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === CCCamera_focal_plane_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === CCCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === CCCamera_focal_plane_RebTotalPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :200
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === CCCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === CCCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === CCCamera_focal_plane_Segment end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :200
