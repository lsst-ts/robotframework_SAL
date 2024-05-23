*** Settings ***
Documentation    MTCamera_Telemetry communications tests.
Force Tags    messaging    java    mtcamera    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
${component}    all
${timeout}    3600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end + 1}
    Log Many    ${quadbox_BFR_list}
    Should Contain    ${quadbox_BFR_list}    === MTCamera_quadbox_BFR start of topic ===
    Should Contain    ${quadbox_BFR_list}    === MTCamera_quadbox_BFR end of topic ===
    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR] message sent 200
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end + 1}
    Log Many    ${quadbox_PDU_24VC_list}
    Should Contain    ${quadbox_PDU_24VC_list}    === MTCamera_quadbox_PDU_24VC start of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === MTCamera_quadbox_PDU_24VC end of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC] message sent 200
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end + 1}
    Log Many    ${quadbox_PDU_24VD_list}
    Should Contain    ${quadbox_PDU_24VD_list}    === MTCamera_quadbox_PDU_24VD start of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === MTCamera_quadbox_PDU_24VD end of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD] message sent 200
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end + 1}
    Log Many    ${quadbox_PDU_48V_list}
    Should Contain    ${quadbox_PDU_48V_list}    === MTCamera_quadbox_PDU_48V start of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === MTCamera_quadbox_PDU_48V end of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V] message sent 200
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end + 1}
    Log Many    ${quadbox_PDU_5V_list}
    Should Contain    ${quadbox_PDU_5V_list}    === MTCamera_quadbox_PDU_5V start of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === MTCamera_quadbox_PDU_5V end of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V] message sent 200
    ${quadbox_REB_Bulk_PS_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    ${quadbox_REB_Bulk_PS_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    ${quadbox_REB_Bulk_PS_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_start}    end=${quadbox_REB_Bulk_PS_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_list}
    Should Contain    ${quadbox_REB_Bulk_PS_list}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_list}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_list}    === [quadbox_REB_Bulk_PS] message sent 200
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end + 1}
    Log Many    ${rebpower_Reb_list}
    Should Contain    ${rebpower_Reb_list}    === MTCamera_rebpower_Reb start of topic ===
    Should Contain    ${rebpower_Reb_list}    === MTCamera_rebpower_Reb end of topic ===
    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb] message sent 200
    ${rebpower_RebTotalPower_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower start of topic ===
    ${rebpower_RebTotalPower_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower end of topic ===
    ${rebpower_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_start}    end=${rebpower_RebTotalPower_end + 1}
    Log Many    ${rebpower_RebTotalPower_list}
    Should Contain    ${rebpower_RebTotalPower_list}    === MTCamera_rebpower_RebTotalPower start of topic ===
    Should Contain    ${rebpower_RebTotalPower_list}    === MTCamera_rebpower_RebTotalPower end of topic ===
    Should Contain    ${rebpower_RebTotalPower_list}    === [rebpower_RebTotalPower] message sent 200
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end + 1}
    Log Many    ${rebpower_Rebps_list}
    Should Contain    ${rebpower_Rebps_list}    === MTCamera_rebpower_Rebps start of topic ===
    Should Contain    ${rebpower_Rebps_list}    === MTCamera_rebpower_Rebps end of topic ===
    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps] message sent 200
    ${hex_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 start of topic ===
    ${hex_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 end of topic ===
    ${hex_Cold1_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_start}    end=${hex_Cold1_end + 1}
    Log Many    ${hex_Cold1_list}
    Should Contain    ${hex_Cold1_list}    === MTCamera_hex_Cold1 start of topic ===
    Should Contain    ${hex_Cold1_list}    === MTCamera_hex_Cold1 end of topic ===
    Should Contain    ${hex_Cold1_list}    === [hex_Cold1] message sent 200
    ${hex_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 start of topic ===
    ${hex_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 end of topic ===
    ${hex_Cold2_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_start}    end=${hex_Cold2_end + 1}
    Log Many    ${hex_Cold2_list}
    Should Contain    ${hex_Cold2_list}    === MTCamera_hex_Cold2 start of topic ===
    Should Contain    ${hex_Cold2_list}    === MTCamera_hex_Cold2 end of topic ===
    Should Contain    ${hex_Cold2_list}    === [hex_Cold2] message sent 200
    ${hex_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 start of topic ===
    ${hex_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 end of topic ===
    ${hex_Cryo1_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_start}    end=${hex_Cryo1_end + 1}
    Log Many    ${hex_Cryo1_list}
    Should Contain    ${hex_Cryo1_list}    === MTCamera_hex_Cryo1 start of topic ===
    Should Contain    ${hex_Cryo1_list}    === MTCamera_hex_Cryo1 end of topic ===
    Should Contain    ${hex_Cryo1_list}    === [hex_Cryo1] message sent 200
    ${hex_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 start of topic ===
    ${hex_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 end of topic ===
    ${hex_Cryo2_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_start}    end=${hex_Cryo2_end + 1}
    Log Many    ${hex_Cryo2_list}
    Should Contain    ${hex_Cryo2_list}    === MTCamera_hex_Cryo2 start of topic ===
    Should Contain    ${hex_Cryo2_list}    === MTCamera_hex_Cryo2 end of topic ===
    Should Contain    ${hex_Cryo2_list}    === [hex_Cryo2] message sent 200
    ${hex_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 start of topic ===
    ${hex_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 end of topic ===
    ${hex_Cryo3_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_start}    end=${hex_Cryo3_end + 1}
    Log Many    ${hex_Cryo3_list}
    Should Contain    ${hex_Cryo3_list}    === MTCamera_hex_Cryo3 start of topic ===
    Should Contain    ${hex_Cryo3_list}    === MTCamera_hex_Cryo3 end of topic ===
    Should Contain    ${hex_Cryo3_list}    === [hex_Cryo3] message sent 200
    ${hex_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 start of topic ===
    ${hex_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 end of topic ===
    ${hex_Cryo4_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_start}    end=${hex_Cryo4_end + 1}
    Log Many    ${hex_Cryo4_list}
    Should Contain    ${hex_Cryo4_list}    === MTCamera_hex_Cryo4 start of topic ===
    Should Contain    ${hex_Cryo4_list}    === MTCamera_hex_Cryo4 end of topic ===
    Should Contain    ${hex_Cryo4_list}    === [hex_Cryo4] message sent 200
    ${hex_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 start of topic ===
    ${hex_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 end of topic ===
    ${hex_Cryo5_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_start}    end=${hex_Cryo5_end + 1}
    Log Many    ${hex_Cryo5_list}
    Should Contain    ${hex_Cryo5_list}    === MTCamera_hex_Cryo5 start of topic ===
    Should Contain    ${hex_Cryo5_list}    === MTCamera_hex_Cryo5 end of topic ===
    Should Contain    ${hex_Cryo5_list}    === [hex_Cryo5] message sent 200
    ${hex_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 start of topic ===
    ${hex_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 end of topic ===
    ${hex_Cryo6_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_start}    end=${hex_Cryo6_end + 1}
    Log Many    ${hex_Cryo6_list}
    Should Contain    ${hex_Cryo6_list}    === MTCamera_hex_Cryo6 start of topic ===
    Should Contain    ${hex_Cryo6_list}    === MTCamera_hex_Cryo6 end of topic ===
    Should Contain    ${hex_Cryo6_list}    === [hex_Cryo6] message sent 200
    ${refrig_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 start of topic ===
    ${refrig_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 end of topic ===
    ${refrig_Cryo1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_start}    end=${refrig_Cryo1_end + 1}
    Log Many    ${refrig_Cryo1_list}
    Should Contain    ${refrig_Cryo1_list}    === MTCamera_refrig_Cryo1 start of topic ===
    Should Contain    ${refrig_Cryo1_list}    === MTCamera_refrig_Cryo1 end of topic ===
    Should Contain    ${refrig_Cryo1_list}    === [refrig_Cryo1] message sent 200
    ${refrig_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 start of topic ===
    ${refrig_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 end of topic ===
    ${refrig_Cryo2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_start}    end=${refrig_Cryo2_end + 1}
    Log Many    ${refrig_Cryo2_list}
    Should Contain    ${refrig_Cryo2_list}    === MTCamera_refrig_Cryo2 start of topic ===
    Should Contain    ${refrig_Cryo2_list}    === MTCamera_refrig_Cryo2 end of topic ===
    Should Contain    ${refrig_Cryo2_list}    === [refrig_Cryo2] message sent 200
    ${refrig_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 start of topic ===
    ${refrig_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 end of topic ===
    ${refrig_Cryo3_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_start}    end=${refrig_Cryo3_end + 1}
    Log Many    ${refrig_Cryo3_list}
    Should Contain    ${refrig_Cryo3_list}    === MTCamera_refrig_Cryo3 start of topic ===
    Should Contain    ${refrig_Cryo3_list}    === MTCamera_refrig_Cryo3 end of topic ===
    Should Contain    ${refrig_Cryo3_list}    === [refrig_Cryo3] message sent 200
    ${refrig_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 start of topic ===
    ${refrig_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 end of topic ===
    ${refrig_Cryo4_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_start}    end=${refrig_Cryo4_end + 1}
    Log Many    ${refrig_Cryo4_list}
    Should Contain    ${refrig_Cryo4_list}    === MTCamera_refrig_Cryo4 start of topic ===
    Should Contain    ${refrig_Cryo4_list}    === MTCamera_refrig_Cryo4 end of topic ===
    Should Contain    ${refrig_Cryo4_list}    === [refrig_Cryo4] message sent 200
    ${refrig_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 start of topic ===
    ${refrig_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 end of topic ===
    ${refrig_Cryo5_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_start}    end=${refrig_Cryo5_end + 1}
    Log Many    ${refrig_Cryo5_list}
    Should Contain    ${refrig_Cryo5_list}    === MTCamera_refrig_Cryo5 start of topic ===
    Should Contain    ${refrig_Cryo5_list}    === MTCamera_refrig_Cryo5 end of topic ===
    Should Contain    ${refrig_Cryo5_list}    === [refrig_Cryo5] message sent 200
    ${refrig_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 start of topic ===
    ${refrig_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 end of topic ===
    ${refrig_Cryo6_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_start}    end=${refrig_Cryo6_end + 1}
    Log Many    ${refrig_Cryo6_list}
    Should Contain    ${refrig_Cryo6_list}    === MTCamera_refrig_Cryo6 start of topic ===
    Should Contain    ${refrig_Cryo6_list}    === MTCamera_refrig_Cryo6 end of topic ===
    Should Contain    ${refrig_Cryo6_list}    === [refrig_Cryo6] message sent 200
    ${vacuum_Cip_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip start of topic ===
    ${vacuum_Cip_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip end of topic ===
    ${vacuum_Cip_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cip_start}    end=${vacuum_Cip_end + 1}
    Log Many    ${vacuum_Cip_list}
    Should Contain    ${vacuum_Cip_list}    === MTCamera_vacuum_Cip start of topic ===
    Should Contain    ${vacuum_Cip_list}    === MTCamera_vacuum_Cip end of topic ===
    Should Contain    ${vacuum_Cip_list}    === [vacuum_Cip] message sent 200
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end + 1}
    Log Many    ${vacuum_Cryo_list}
    Should Contain    ${vacuum_Cryo_list}    === MTCamera_vacuum_Cryo start of topic ===
    Should Contain    ${vacuum_Cryo_list}    === MTCamera_vacuum_Cryo end of topic ===
    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo] message sent 200
    ${vacuum_HX_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX start of topic ===
    ${vacuum_HX_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX end of topic ===
    ${vacuum_HX_list}=    Get Slice From List    ${full_list}    start=${vacuum_HX_start}    end=${vacuum_HX_end + 1}
    Log Many    ${vacuum_HX_list}
    Should Contain    ${vacuum_HX_list}    === MTCamera_vacuum_HX start of topic ===
    Should Contain    ${vacuum_HX_list}    === MTCamera_vacuum_HX end of topic ===
    Should Contain    ${vacuum_HX_list}    === [vacuum_HX] message sent 200
    ${vacuum_Hip_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip start of topic ===
    ${vacuum_Hip_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip end of topic ===
    ${vacuum_Hip_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hip_start}    end=${vacuum_Hip_end + 1}
    Log Many    ${vacuum_Hip_list}
    Should Contain    ${vacuum_Hip_list}    === MTCamera_vacuum_Hip start of topic ===
    Should Contain    ${vacuum_Hip_list}    === MTCamera_vacuum_Hip end of topic ===
    Should Contain    ${vacuum_Hip_list}    === [vacuum_Hip] message sent 200
    ${vacuum_Inst_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst start of topic ===
    ${vacuum_Inst_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst end of topic ===
    ${vacuum_Inst_list}=    Get Slice From List    ${full_list}    start=${vacuum_Inst_start}    end=${vacuum_Inst_end + 1}
    Log Many    ${vacuum_Inst_list}
    Should Contain    ${vacuum_Inst_list}    === MTCamera_vacuum_Inst start of topic ===
    Should Contain    ${vacuum_Inst_list}    === MTCamera_vacuum_Inst end of topic ===
    Should Contain    ${vacuum_Inst_list}    === [vacuum_Inst] message sent 200
    ${daq_monitor_Reb_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Reb_Trending start of topic ===
    ${daq_monitor_Reb_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Reb_Trending end of topic ===
    ${daq_monitor_Reb_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Reb_Trending_start}    end=${daq_monitor_Reb_Trending_end + 1}
    Log Many    ${daq_monitor_Reb_Trending_list}
    Should Contain    ${daq_monitor_Reb_Trending_list}    === MTCamera_daq_monitor_Reb_Trending start of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === MTCamera_daq_monitor_Reb_Trending end of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending] message sent 200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store end of topic ===
    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store] message sent 200
    ${daq_monitor_Sum_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Sum_Trending start of topic ===
    ${daq_monitor_Sum_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Sum_Trending end of topic ===
    ${daq_monitor_Sum_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Sum_Trending_start}    end=${daq_monitor_Sum_Trending_end + 1}
    Log Many    ${daq_monitor_Sum_Trending_list}
    Should Contain    ${daq_monitor_Sum_Trending_list}    === MTCamera_daq_monitor_Sum_Trending start of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === MTCamera_daq_monitor_Sum_Trending end of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending] message sent 200
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === MTCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === MTCamera_focal_plane_Ccd end of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd] message sent 200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === MTCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === MTCamera_focal_plane_Reb end of topic ===
    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb] message sent 200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === MTCamera_focal_plane_RebTotalPower end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower] message sent 200
    ${focal_plane_RebsAverageTemp6_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6 start of topic ===
    ${focal_plane_RebsAverageTemp6_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6 end of topic ===
    ${focal_plane_RebsAverageTemp6_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_start}    end=${focal_plane_RebsAverageTemp6_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === MTCamera_focal_plane_RebsAverageTemp6 start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === MTCamera_focal_plane_RebsAverageTemp6 end of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6] message sent 200
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment end of topic ===
    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment] message sent 200
    ${mpm_CLP_RTD_03_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03 start of topic ===
    ${mpm_CLP_RTD_03_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03 end of topic ===
    ${mpm_CLP_RTD_03_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_03_start}    end=${mpm_CLP_RTD_03_end + 1}
    Log Many    ${mpm_CLP_RTD_03_list}
    Should Contain    ${mpm_CLP_RTD_03_list}    === MTCamera_mpm_CLP_RTD_03 start of topic ===
    Should Contain    ${mpm_CLP_RTD_03_list}    === MTCamera_mpm_CLP_RTD_03 end of topic ===
    Should Contain    ${mpm_CLP_RTD_03_list}    === [mpm_CLP_RTD_03] message sent 200
    ${mpm_CLP_RTD_05_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05 start of topic ===
    ${mpm_CLP_RTD_05_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05 end of topic ===
    ${mpm_CLP_RTD_05_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_05_start}    end=${mpm_CLP_RTD_05_end + 1}
    Log Many    ${mpm_CLP_RTD_05_list}
    Should Contain    ${mpm_CLP_RTD_05_list}    === MTCamera_mpm_CLP_RTD_05 start of topic ===
    Should Contain    ${mpm_CLP_RTD_05_list}    === MTCamera_mpm_CLP_RTD_05 end of topic ===
    Should Contain    ${mpm_CLP_RTD_05_list}    === [mpm_CLP_RTD_05] message sent 200
    ${mpm_CLP_RTD_50_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50 start of topic ===
    ${mpm_CLP_RTD_50_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50 end of topic ===
    ${mpm_CLP_RTD_50_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_50_start}    end=${mpm_CLP_RTD_50_end + 1}
    Log Many    ${mpm_CLP_RTD_50_list}
    Should Contain    ${mpm_CLP_RTD_50_list}    === MTCamera_mpm_CLP_RTD_50 start of topic ===
    Should Contain    ${mpm_CLP_RTD_50_list}    === MTCamera_mpm_CLP_RTD_50 end of topic ===
    Should Contain    ${mpm_CLP_RTD_50_list}    === [mpm_CLP_RTD_50] message sent 200
    ${mpm_CLP_RTD_55_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55 start of topic ===
    ${mpm_CLP_RTD_55_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55 end of topic ===
    ${mpm_CLP_RTD_55_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_55_start}    end=${mpm_CLP_RTD_55_end + 1}
    Log Many    ${mpm_CLP_RTD_55_list}
    Should Contain    ${mpm_CLP_RTD_55_list}    === MTCamera_mpm_CLP_RTD_55 start of topic ===
    Should Contain    ${mpm_CLP_RTD_55_list}    === MTCamera_mpm_CLP_RTD_55 end of topic ===
    Should Contain    ${mpm_CLP_RTD_55_list}    === [mpm_CLP_RTD_55] message sent 200
    ${mpm_CYP_RTD_12_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12 start of topic ===
    ${mpm_CYP_RTD_12_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12 end of topic ===
    ${mpm_CYP_RTD_12_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_12_start}    end=${mpm_CYP_RTD_12_end + 1}
    Log Many    ${mpm_CYP_RTD_12_list}
    Should Contain    ${mpm_CYP_RTD_12_list}    === MTCamera_mpm_CYP_RTD_12 start of topic ===
    Should Contain    ${mpm_CYP_RTD_12_list}    === MTCamera_mpm_CYP_RTD_12 end of topic ===
    Should Contain    ${mpm_CYP_RTD_12_list}    === [mpm_CYP_RTD_12] message sent 200
    ${mpm_CYP_RTD_14_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14 start of topic ===
    ${mpm_CYP_RTD_14_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14 end of topic ===
    ${mpm_CYP_RTD_14_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_14_start}    end=${mpm_CYP_RTD_14_end + 1}
    Log Many    ${mpm_CYP_RTD_14_list}
    Should Contain    ${mpm_CYP_RTD_14_list}    === MTCamera_mpm_CYP_RTD_14 start of topic ===
    Should Contain    ${mpm_CYP_RTD_14_list}    === MTCamera_mpm_CYP_RTD_14 end of topic ===
    Should Contain    ${mpm_CYP_RTD_14_list}    === [mpm_CYP_RTD_14] message sent 200
    ${mpm_CYP_RTD_31_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31 start of topic ===
    ${mpm_CYP_RTD_31_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31 end of topic ===
    ${mpm_CYP_RTD_31_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_31_start}    end=${mpm_CYP_RTD_31_end + 1}
    Log Many    ${mpm_CYP_RTD_31_list}
    Should Contain    ${mpm_CYP_RTD_31_list}    === MTCamera_mpm_CYP_RTD_31 start of topic ===
    Should Contain    ${mpm_CYP_RTD_31_list}    === MTCamera_mpm_CYP_RTD_31 end of topic ===
    Should Contain    ${mpm_CYP_RTD_31_list}    === [mpm_CYP_RTD_31] message sent 200
    ${mpm_CYP_RTD_43_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43 start of topic ===
    ${mpm_CYP_RTD_43_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43 end of topic ===
    ${mpm_CYP_RTD_43_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_43_start}    end=${mpm_CYP_RTD_43_end + 1}
    Log Many    ${mpm_CYP_RTD_43_list}
    Should Contain    ${mpm_CYP_RTD_43_list}    === MTCamera_mpm_CYP_RTD_43 start of topic ===
    Should Contain    ${mpm_CYP_RTD_43_list}    === MTCamera_mpm_CYP_RTD_43 end of topic ===
    Should Contain    ${mpm_CYP_RTD_43_list}    === [mpm_CYP_RTD_43] message sent 200
    ${fcs_Autochanger_AutochangerTrucks_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending start of topic ===
    ${fcs_Autochanger_AutochangerTrucks_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending end of topic ===
    ${fcs_Autochanger_AutochangerTrucks_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_AutochangerTrucks_Trending_start}    end=${fcs_Autochanger_AutochangerTrucks_Trending_end + 1}
    Log Many    ${fcs_Autochanger_AutochangerTrucks_Trending_list}
    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending end of topic ===
    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === [fcs_Autochanger_AutochangerTrucks_Trending] message sent 200
    ${fcs_Autochanger_Latches_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Latches_Trending start of topic ===
    ${fcs_Autochanger_Latches_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Latches_Trending end of topic ===
    ${fcs_Autochanger_Latches_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_Latches_Trending_start}    end=${fcs_Autochanger_Latches_Trending_end + 1}
    Log Many    ${fcs_Autochanger_Latches_Trending_list}
    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === MTCamera_fcs_Autochanger_Latches_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === MTCamera_fcs_Autochanger_Latches_Trending end of topic ===
    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === [fcs_Autochanger_Latches_Trending] message sent 200
    ${fcs_Autochanger_OnlineClamps_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending start of topic ===
    ${fcs_Autochanger_OnlineClamps_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending end of topic ===
    ${fcs_Autochanger_OnlineClamps_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_OnlineClamps_Trending_start}    end=${fcs_Autochanger_OnlineClamps_Trending_end + 1}
    Log Many    ${fcs_Autochanger_OnlineClamps_Trending_list}
    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending end of topic ===
    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === [fcs_Autochanger_OnlineClamps_Trending] message sent 200
    ${fcs_Autochanger_Temperatures_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Temperatures start of topic ===
    ${fcs_Autochanger_Temperatures_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Temperatures end of topic ===
    ${fcs_Autochanger_Temperatures_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_Temperatures_start}    end=${fcs_Autochanger_Temperatures_end + 1}
    Log Many    ${fcs_Autochanger_Temperatures_list}
    Should Contain    ${fcs_Autochanger_Temperatures_list}    === MTCamera_fcs_Autochanger_Temperatures start of topic ===
    Should Contain    ${fcs_Autochanger_Temperatures_list}    === MTCamera_fcs_Autochanger_Temperatures end of topic ===
    Should Contain    ${fcs_Autochanger_Temperatures_list}    === [fcs_Autochanger_Temperatures] message sent 200
    ${fcs_Canbus0_AcSensorsGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending start of topic ===
    ${fcs_Canbus0_AcSensorsGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending end of topic ===
    ${fcs_Canbus0_AcSensorsGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcSensorsGateway_Trending_start}    end=${fcs_Canbus0_AcSensorsGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcSensorsGateway_Trending_list}
    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === [fcs_Canbus0_AcSensorsGateway_Trending] message sent 200
    ${fcs_Canbus0_AcTruckXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending start of topic ===
    ${fcs_Canbus0_AcTruckXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending end of topic ===
    ${fcs_Canbus0_AcTruckXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcTruckXminusController_Trending_start}    end=${fcs_Canbus0_AcTruckXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcTruckXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === [fcs_Canbus0_AcTruckXminusController_Trending] message sent 200
    ${fcs_Canbus0_AcTruckXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending start of topic ===
    ${fcs_Canbus0_AcTruckXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending end of topic ===
    ${fcs_Canbus0_AcTruckXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcTruckXplusController_Trending_start}    end=${fcs_Canbus0_AcTruckXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcTruckXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === [fcs_Canbus0_AcTruckXplusController_Trending] message sent 200
    ${fcs_Canbus0_Accelerobf_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending start of topic ===
    ${fcs_Canbus0_Accelerobf_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending end of topic ===
    ${fcs_Canbus0_Accelerobf_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Accelerobf_Trending_start}    end=${fcs_Canbus0_Accelerobf_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Accelerobf_Trending_list}
    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === [fcs_Canbus0_Accelerobf_Trending] message sent 200
    ${fcs_Canbus0_Ai814_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Ai814_Trending start of topic ===
    ${fcs_Canbus0_Ai814_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Ai814_Trending end of topic ===
    ${fcs_Canbus0_Ai814_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Ai814_Trending_start}    end=${fcs_Canbus0_Ai814_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Ai814_Trending_list}
    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === MTCamera_fcs_Canbus0_Ai814_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === MTCamera_fcs_Canbus0_Ai814_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === [fcs_Canbus0_Ai814_Trending] message sent 200
    ${fcs_Canbus0_BrakeSystemGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending start of topic ===
    ${fcs_Canbus0_BrakeSystemGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending end of topic ===
    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_BrakeSystemGateway_Trending_start}    end=${fcs_Canbus0_BrakeSystemGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}
    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === [fcs_Canbus0_BrakeSystemGateway_Trending] message sent 200
    ${fcs_Canbus0_CarouselController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending start of topic ===
    ${fcs_Canbus0_CarouselController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending end of topic ===
    ${fcs_Canbus0_CarouselController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_CarouselController_Trending_start}    end=${fcs_Canbus0_CarouselController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_CarouselController_Trending_list}
    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === [fcs_Canbus0_CarouselController_Trending] message sent 200
    ${fcs_Canbus0_ClampXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending start of topic ===
    ${fcs_Canbus0_ClampXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending end of topic ===
    ${fcs_Canbus0_ClampXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ClampXminusController_Trending_start}    end=${fcs_Canbus0_ClampXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ClampXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === [fcs_Canbus0_ClampXminusController_Trending] message sent 200
    ${fcs_Canbus0_ClampXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending start of topic ===
    ${fcs_Canbus0_ClampXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending end of topic ===
    ${fcs_Canbus0_ClampXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ClampXplusController_Trending_start}    end=${fcs_Canbus0_ClampXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ClampXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === [fcs_Canbus0_ClampXplusController_Trending] message sent 200
    ${fcs_Canbus0_Hyttc580_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending start of topic ===
    ${fcs_Canbus0_Hyttc580_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending end of topic ===
    ${fcs_Canbus0_Hyttc580_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Hyttc580_Trending_start}    end=${fcs_Canbus0_Hyttc580_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Hyttc580_Trending_list}
    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === [fcs_Canbus0_Hyttc580_Trending] message sent 200
    ${fcs_Canbus0_LatchXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending start of topic ===
    ${fcs_Canbus0_LatchXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending end of topic ===
    ${fcs_Canbus0_LatchXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_LatchXminusController_Trending_start}    end=${fcs_Canbus0_LatchXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_LatchXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === [fcs_Canbus0_LatchXminusController_Trending] message sent 200
    ${fcs_Canbus0_LatchXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending start of topic ===
    ${fcs_Canbus0_LatchXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending end of topic ===
    ${fcs_Canbus0_LatchXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_LatchXplusController_Trending_start}    end=${fcs_Canbus0_LatchXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_LatchXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === [fcs_Canbus0_LatchXplusController_Trending] message sent 200
    ${fcs_Canbus0_OnlineClampXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampXminusController_Trending_start}    end=${fcs_Canbus0_OnlineClampXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === [fcs_Canbus0_OnlineClampXminusController_Trending] message sent 200
    ${fcs_Canbus0_OnlineClampXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampXplusController_Trending_start}    end=${fcs_Canbus0_OnlineClampXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === [fcs_Canbus0_OnlineClampXplusController_Trending] message sent 200
    ${fcs_Canbus0_OnlineClampYminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampYminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampYminusController_Trending_start}    end=${fcs_Canbus0_OnlineClampYminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === [fcs_Canbus0_OnlineClampYminusController_Trending] message sent 200
    ${fcs_Canbus0_OnlineStrainGauge_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending start of topic ===
    ${fcs_Canbus0_OnlineStrainGauge_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending end of topic ===
    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineStrainGauge_Trending_start}    end=${fcs_Canbus0_OnlineStrainGauge_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === [fcs_Canbus0_OnlineStrainGauge_Trending] message sent 200
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending start of topic ===
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending end of topic ===
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ProximitySensorsDevice_Trending_start}    end=${fcs_Canbus0_ProximitySensorsDevice_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}
    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === [fcs_Canbus0_ProximitySensorsDevice_Trending] message sent 200
    ${fcs_Canbus0_Pt100_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Pt100_Trending start of topic ===
    ${fcs_Canbus0_Pt100_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Pt100_Trending end of topic ===
    ${fcs_Canbus0_Pt100_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Pt100_Trending_start}    end=${fcs_Canbus0_Pt100_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Pt100_Trending_list}
    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === MTCamera_fcs_Canbus0_Pt100_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === MTCamera_fcs_Canbus0_Pt100_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === [fcs_Canbus0_Pt100_Trending] message sent 200
    ${fcs_Canbus0_TempSensorsDevice1_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending start of topic ===
    ${fcs_Canbus0_TempSensorsDevice1_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending end of topic ===
    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_TempSensorsDevice1_Trending_start}    end=${fcs_Canbus0_TempSensorsDevice1_Trending_end + 1}
    Log Many    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}
    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === [fcs_Canbus0_TempSensorsDevice1_Trending] message sent 200
    ${fcs_Canbus0_TempSensorsDevice2_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending start of topic ===
    ${fcs_Canbus0_TempSensorsDevice2_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending end of topic ===
    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_TempSensorsDevice2_Trending_start}    end=${fcs_Canbus0_TempSensorsDevice2_Trending_end + 1}
    Log Many    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}
    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending end of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === [fcs_Canbus0_TempSensorsDevice2_Trending] message sent 200
    ${fcs_Canbus1_CarrierController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending start of topic ===
    ${fcs_Canbus1_CarrierController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending end of topic ===
    ${fcs_Canbus1_CarrierController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_CarrierController_Trending_start}    end=${fcs_Canbus1_CarrierController_Trending_end + 1}
    Log Many    ${fcs_Canbus1_CarrierController_Trending_list}
    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending end of topic ===
    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === [fcs_Canbus1_CarrierController_Trending] message sent 200
    ${fcs_Canbus1_HooksController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_HooksController_Trending start of topic ===
    ${fcs_Canbus1_HooksController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_HooksController_Trending end of topic ===
    ${fcs_Canbus1_HooksController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_HooksController_Trending_start}    end=${fcs_Canbus1_HooksController_Trending_end + 1}
    Log Many    ${fcs_Canbus1_HooksController_Trending_list}
    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === MTCamera_fcs_Canbus1_HooksController_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === MTCamera_fcs_Canbus1_HooksController_Trending end of topic ===
    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === [fcs_Canbus1_HooksController_Trending] message sent 200
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending start of topic ===
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending end of topic ===
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_LoaderPlutoGateway_Trending_start}    end=${fcs_Canbus1_LoaderPlutoGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}
    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending end of topic ===
    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === [fcs_Canbus1_LoaderPlutoGateway_Trending] message sent 200
    ${fcs_Carousel_Socket1_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket1_Trending start of topic ===
    ${fcs_Carousel_Socket1_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket1_Trending end of topic ===
    ${fcs_Carousel_Socket1_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket1_Trending_start}    end=${fcs_Carousel_Socket1_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket1_Trending_list}
    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === MTCamera_fcs_Carousel_Socket1_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === MTCamera_fcs_Carousel_Socket1_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === [fcs_Carousel_Socket1_Trending] message sent 200
    ${fcs_Carousel_Socket2_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket2_Trending start of topic ===
    ${fcs_Carousel_Socket2_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket2_Trending end of topic ===
    ${fcs_Carousel_Socket2_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket2_Trending_start}    end=${fcs_Carousel_Socket2_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket2_Trending_list}
    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === MTCamera_fcs_Carousel_Socket2_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === MTCamera_fcs_Carousel_Socket2_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === [fcs_Carousel_Socket2_Trending] message sent 200
    ${fcs_Carousel_Socket3_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket3_Trending start of topic ===
    ${fcs_Carousel_Socket3_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket3_Trending end of topic ===
    ${fcs_Carousel_Socket3_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket3_Trending_start}    end=${fcs_Carousel_Socket3_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket3_Trending_list}
    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === MTCamera_fcs_Carousel_Socket3_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === MTCamera_fcs_Carousel_Socket3_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === [fcs_Carousel_Socket3_Trending] message sent 200
    ${fcs_Carousel_Socket4_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket4_Trending start of topic ===
    ${fcs_Carousel_Socket4_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket4_Trending end of topic ===
    ${fcs_Carousel_Socket4_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket4_Trending_start}    end=${fcs_Carousel_Socket4_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket4_Trending_list}
    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === MTCamera_fcs_Carousel_Socket4_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === MTCamera_fcs_Carousel_Socket4_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === [fcs_Carousel_Socket4_Trending] message sent 200
    ${fcs_Carousel_Socket5_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket5_Trending start of topic ===
    ${fcs_Carousel_Socket5_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket5_Trending end of topic ===
    ${fcs_Carousel_Socket5_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket5_Trending_start}    end=${fcs_Carousel_Socket5_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket5_Trending_list}
    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === MTCamera_fcs_Carousel_Socket5_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === MTCamera_fcs_Carousel_Socket5_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === [fcs_Carousel_Socket5_Trending] message sent 200
    ${fcs_Carousel_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Trending start of topic ===
    ${fcs_Carousel_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Trending end of topic ===
    ${fcs_Carousel_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Trending_start}    end=${fcs_Carousel_Trending_end + 1}
    Log Many    ${fcs_Carousel_Trending_list}
    Should Contain    ${fcs_Carousel_Trending_list}    === MTCamera_fcs_Carousel_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Trending_list}    === MTCamera_fcs_Carousel_Trending end of topic ===
    Should Contain    ${fcs_Carousel_Trending_list}    === [fcs_Carousel_Trending] message sent 200
    ${fcs_Duration_Autochanger_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Autochanger_Trending start of topic ===
    ${fcs_Duration_Autochanger_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Autochanger_Trending end of topic ===
    ${fcs_Duration_Autochanger_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Autochanger_Trending_start}    end=${fcs_Duration_Autochanger_Trending_end + 1}
    Log Many    ${fcs_Duration_Autochanger_Trending_list}
    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === MTCamera_fcs_Duration_Autochanger_Trending start of topic ===
    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === MTCamera_fcs_Duration_Autochanger_Trending end of topic ===
    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === [fcs_Duration_Autochanger_Trending] message sent 200
    ${fcs_Duration_Carousel_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Carousel_Trending start of topic ===
    ${fcs_Duration_Carousel_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Carousel_Trending end of topic ===
    ${fcs_Duration_Carousel_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Carousel_Trending_start}    end=${fcs_Duration_Carousel_Trending_end + 1}
    Log Many    ${fcs_Duration_Carousel_Trending_list}
    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === MTCamera_fcs_Duration_Carousel_Trending start of topic ===
    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === MTCamera_fcs_Duration_Carousel_Trending end of topic ===
    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === [fcs_Duration_Carousel_Trending] message sent 200
    ${fcs_Duration_Loader_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Loader_Trending start of topic ===
    ${fcs_Duration_Loader_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Loader_Trending end of topic ===
    ${fcs_Duration_Loader_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Loader_Trending_start}    end=${fcs_Duration_Loader_Trending_end + 1}
    Log Many    ${fcs_Duration_Loader_Trending_list}
    Should Contain    ${fcs_Duration_Loader_Trending_list}    === MTCamera_fcs_Duration_Loader_Trending start of topic ===
    Should Contain    ${fcs_Duration_Loader_Trending_list}    === MTCamera_fcs_Duration_Loader_Trending end of topic ===
    Should Contain    ${fcs_Duration_Loader_Trending_list}    === [fcs_Duration_Loader_Trending] message sent 200
    ${fcs_Duration_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Trending start of topic ===
    ${fcs_Duration_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Trending end of topic ===
    ${fcs_Duration_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Trending_start}    end=${fcs_Duration_Trending_end + 1}
    Log Many    ${fcs_Duration_Trending_list}
    Should Contain    ${fcs_Duration_Trending_list}    === MTCamera_fcs_Duration_Trending start of topic ===
    Should Contain    ${fcs_Duration_Trending_list}    === MTCamera_fcs_Duration_Trending end of topic ===
    Should Contain    ${fcs_Duration_Trending_list}    === [fcs_Duration_Trending] message sent 200
    ${fcs_Fcs_Mcm_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Fcs_Mcm_Trending start of topic ===
    ${fcs_Fcs_Mcm_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Fcs_Mcm_Trending end of topic ===
    ${fcs_Fcs_Mcm_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Fcs_Mcm_Trending_start}    end=${fcs_Fcs_Mcm_Trending_end + 1}
    Log Many    ${fcs_Fcs_Mcm_Trending_list}
    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === MTCamera_fcs_Fcs_Mcm_Trending start of topic ===
    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === MTCamera_fcs_Fcs_Mcm_Trending end of topic ===
    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === [fcs_Fcs_Mcm_Trending] message sent 200
    ${fcs_Loader_Carrier_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Carrier_Trending start of topic ===
    ${fcs_Loader_Carrier_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Carrier_Trending end of topic ===
    ${fcs_Loader_Carrier_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_Carrier_Trending_start}    end=${fcs_Loader_Carrier_Trending_end + 1}
    Log Many    ${fcs_Loader_Carrier_Trending_list}
    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === MTCamera_fcs_Loader_Carrier_Trending start of topic ===
    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === MTCamera_fcs_Loader_Carrier_Trending end of topic ===
    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === [fcs_Loader_Carrier_Trending] message sent 200
    ${fcs_Loader_Hooks_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Hooks_Trending start of topic ===
    ${fcs_Loader_Hooks_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Hooks_Trending end of topic ===
    ${fcs_Loader_Hooks_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_Hooks_Trending_start}    end=${fcs_Loader_Hooks_Trending_end + 1}
    Log Many    ${fcs_Loader_Hooks_Trending_list}
    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === MTCamera_fcs_Loader_Hooks_Trending start of topic ===
    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === MTCamera_fcs_Loader_Hooks_Trending end of topic ===
    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === [fcs_Loader_Hooks_Trending] message sent 200
    ${fcs_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Trending start of topic ===
    ${fcs_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Trending end of topic ===
    ${fcs_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Trending_start}    end=${fcs_Trending_end + 1}
    Log Many    ${fcs_Trending_list}
    Should Contain    ${fcs_Trending_list}    === MTCamera_fcs_Trending start of topic ===
    Should Contain    ${fcs_Trending_list}    === MTCamera_fcs_Trending end of topic ===
    Should Contain    ${fcs_Trending_list}    === [fcs_Trending] message sent 200
    ${shutter_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_Trending start of topic ===
    ${shutter_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_Trending end of topic ===
    ${shutter_Trending_list}=    Get Slice From List    ${full_list}    start=${shutter_Trending_start}    end=${shutter_Trending_end + 1}
    Log Many    ${shutter_Trending_list}
    Should Contain    ${shutter_Trending_list}    === MTCamera_shutter_Trending start of topic ===
    Should Contain    ${shutter_Trending_list}    === MTCamera_shutter_Trending end of topic ===
    Should Contain    ${shutter_Trending_list}    === [shutter_Trending] message sent 200
    ${chiller_Chiller_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller start of topic ===
    ${chiller_Chiller_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller end of topic ===
    ${chiller_Chiller_list}=    Get Slice From List    ${full_list}    start=${chiller_Chiller_start}    end=${chiller_Chiller_end + 1}
    Log Many    ${chiller_Chiller_list}
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller start of topic ===
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller end of topic ===
    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller] message sent 200
    ${chiller_FParam_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_FParam_Trending start of topic ===
    ${chiller_FParam_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_FParam_Trending end of topic ===
    ${chiller_FParam_Trending_list}=    Get Slice From List    ${full_list}    start=${chiller_FParam_Trending_start}    end=${chiller_FParam_Trending_end + 1}
    Log Many    ${chiller_FParam_Trending_list}
    Should Contain    ${chiller_FParam_Trending_list}    === MTCamera_chiller_FParam_Trending start of topic ===
    Should Contain    ${chiller_FParam_Trending_list}    === MTCamera_chiller_FParam_Trending end of topic ===
    Should Contain    ${chiller_FParam_Trending_list}    === [chiller_FParam_Trending] message sent 200
    ${chiller_Maq20_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 start of topic ===
    ${chiller_Maq20_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 end of topic ===
    ${chiller_Maq20_list}=    Get Slice From List    ${full_list}    start=${chiller_Maq20_start}    end=${chiller_Maq20_end + 1}
    Log Many    ${chiller_Maq20_list}
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 start of topic ===
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 end of topic ===
    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20] message sent 200
    ${thermal_Cold_Temp_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cold_Temp start of topic ===
    ${thermal_Cold_Temp_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cold_Temp end of topic ===
    ${thermal_Cold_Temp_list}=    Get Slice From List    ${full_list}    start=${thermal_Cold_Temp_start}    end=${thermal_Cold_Temp_end + 1}
    Log Many    ${thermal_Cold_Temp_list}
    Should Contain    ${thermal_Cold_Temp_list}    === MTCamera_thermal_Cold_Temp start of topic ===
    Should Contain    ${thermal_Cold_Temp_list}    === MTCamera_thermal_Cold_Temp end of topic ===
    Should Contain    ${thermal_Cold_Temp_list}    === [thermal_Cold_Temp] message sent 200
    ${thermal_Cryo_Temp_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cryo_Temp start of topic ===
    ${thermal_Cryo_Temp_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cryo_Temp end of topic ===
    ${thermal_Cryo_Temp_list}=    Get Slice From List    ${full_list}    start=${thermal_Cryo_Temp_start}    end=${thermal_Cryo_Temp_end + 1}
    Log Many    ${thermal_Cryo_Temp_list}
    Should Contain    ${thermal_Cryo_Temp_list}    === MTCamera_thermal_Cryo_Temp start of topic ===
    Should Contain    ${thermal_Cryo_Temp_list}    === MTCamera_thermal_Cryo_Temp end of topic ===
    Should Contain    ${thermal_Cryo_Temp_list}    === [thermal_Cryo_Temp] message sent 200
    ${thermal_Rtd_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Rtd start of topic ===
    ${thermal_Rtd_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Rtd end of topic ===
    ${thermal_Rtd_list}=    Get Slice From List    ${full_list}    start=${thermal_Rtd_start}    end=${thermal_Rtd_end + 1}
    Log Many    ${thermal_Rtd_list}
    Should Contain    ${thermal_Rtd_list}    === MTCamera_thermal_Rtd start of topic ===
    Should Contain    ${thermal_Rtd_list}    === MTCamera_thermal_Rtd end of topic ===
    Should Contain    ${thermal_Rtd_list}    === [thermal_Rtd] message sent 200
    ${thermal_Trim_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim start of topic ===
    ${thermal_Trim_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim end of topic ===
    ${thermal_Trim_list}=    Get Slice From List    ${full_list}    start=${thermal_Trim_start}    end=${thermal_Trim_end + 1}
    Log Many    ${thermal_Trim_list}
    Should Contain    ${thermal_Trim_list}    === MTCamera_thermal_Trim start of topic ===
    Should Contain    ${thermal_Trim_list}    === MTCamera_thermal_Trim end of topic ===
    Should Contain    ${thermal_Trim_list}    === [thermal_Trim] message sent 200
    ${thermal_Trim_Htrs_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim_Htrs start of topic ===
    ${thermal_Trim_Htrs_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim_Htrs end of topic ===
    ${thermal_Trim_Htrs_list}=    Get Slice From List    ${full_list}    start=${thermal_Trim_Htrs_start}    end=${thermal_Trim_Htrs_end + 1}
    Log Many    ${thermal_Trim_Htrs_list}
    Should Contain    ${thermal_Trim_Htrs_list}    === MTCamera_thermal_Trim_Htrs start of topic ===
    Should Contain    ${thermal_Trim_Htrs_list}    === MTCamera_thermal_Trim_Htrs end of topic ===
    Should Contain    ${thermal_Trim_Htrs_list}    === [thermal_Trim_Htrs] message sent 200
    ${utiltrunk_Body_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body start of topic ===
    ${utiltrunk_Body_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body end of topic ===
    ${utiltrunk_Body_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_start}    end=${utiltrunk_Body_end + 1}
    Log Many    ${utiltrunk_Body_list}
    Should Contain    ${utiltrunk_Body_list}    === MTCamera_utiltrunk_Body start of topic ===
    Should Contain    ${utiltrunk_Body_list}    === MTCamera_utiltrunk_Body end of topic ===
    Should Contain    ${utiltrunk_Body_list}    === [utiltrunk_Body] message sent 200
    ${utiltrunk_MPC_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC start of topic ===
    ${utiltrunk_MPC_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC end of topic ===
    ${utiltrunk_MPC_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_start}    end=${utiltrunk_MPC_end + 1}
    Log Many    ${utiltrunk_MPC_list}
    Should Contain    ${utiltrunk_MPC_list}    === MTCamera_utiltrunk_MPC start of topic ===
    Should Contain    ${utiltrunk_MPC_list}    === MTCamera_utiltrunk_MPC end of topic ===
    Should Contain    ${utiltrunk_MPC_list}    === [utiltrunk_MPC] message sent 200
    ${utiltrunk_UT_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT start of topic ===
    ${utiltrunk_UT_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT end of topic ===
    ${utiltrunk_UT_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_start}    end=${utiltrunk_UT_end + 1}
    Log Many    ${utiltrunk_UT_list}
    Should Contain    ${utiltrunk_UT_list}    === MTCamera_utiltrunk_UT start of topic ===
    Should Contain    ${utiltrunk_UT_list}    === MTCamera_utiltrunk_UT end of topic ===
    Should Contain    ${utiltrunk_UT_list}    === [utiltrunk_UT] message sent 200
    ${utiltrunk_VPC_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC start of topic ===
    ${utiltrunk_VPC_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC end of topic ===
    ${utiltrunk_VPC_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_start}    end=${utiltrunk_VPC_end + 1}
    Log Many    ${utiltrunk_VPC_list}
    Should Contain    ${utiltrunk_VPC_list}    === MTCamera_utiltrunk_VPC start of topic ===
    Should Contain    ${utiltrunk_VPC_list}    === MTCamera_utiltrunk_VPC end of topic ===
    Should Contain    ${utiltrunk_VPC_list}    === [utiltrunk_VPC] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end + 1}
    Log Many    ${quadbox_BFR_list}
    Should Contain    ${quadbox_BFR_list}    === MTCamera_quadbox_BFR start of topic ===
    Should Contain    ${quadbox_BFR_list}    === MTCamera_quadbox_BFR end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_BFR_list}    === [quadbox_BFR Subscriber] message received :200
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end + 1}
    Log Many    ${quadbox_PDU_24VC_list}
    Should Contain    ${quadbox_PDU_24VC_list}    === MTCamera_quadbox_PDU_24VC start of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === MTCamera_quadbox_PDU_24VC end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VC_list}    === [quadbox_PDU_24VC Subscriber] message received :200
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end + 1}
    Log Many    ${quadbox_PDU_24VD_list}
    Should Contain    ${quadbox_PDU_24VD_list}    === MTCamera_quadbox_PDU_24VD start of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === MTCamera_quadbox_PDU_24VD end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_24VD_list}    === [quadbox_PDU_24VD Subscriber] message received :200
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end + 1}
    Log Many    ${quadbox_PDU_48V_list}
    Should Contain    ${quadbox_PDU_48V_list}    === MTCamera_quadbox_PDU_48V start of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === MTCamera_quadbox_PDU_48V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_48V_list}    === [quadbox_PDU_48V Subscriber] message received :200
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end + 1}
    Log Many    ${quadbox_PDU_5V_list}
    Should Contain    ${quadbox_PDU_5V_list}    === MTCamera_quadbox_PDU_5V start of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === MTCamera_quadbox_PDU_5V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_PDU_5V_list}    === [quadbox_PDU_5V Subscriber] message received :200
    ${quadbox_REB_Bulk_PS_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    ${quadbox_REB_Bulk_PS_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    ${quadbox_REB_Bulk_PS_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_start}    end=${quadbox_REB_Bulk_PS_end + 1}
    Log Many    ${quadbox_REB_Bulk_PS_list}
    Should Contain    ${quadbox_REB_Bulk_PS_list}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    Should Contain    ${quadbox_REB_Bulk_PS_list}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${quadbox_REB_Bulk_PS_list}    === [quadbox_REB_Bulk_PS Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${quadbox_REB_Bulk_PS_list}    === [quadbox_REB_Bulk_PS Subscriber] message received :200
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end + 1}
    Log Many    ${rebpower_Reb_list}
    Should Contain    ${rebpower_Reb_list}    === MTCamera_rebpower_Reb start of topic ===
    Should Contain    ${rebpower_Reb_list}    === MTCamera_rebpower_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Reb_list}    === [rebpower_Reb Subscriber] message received :200
    ${rebpower_RebTotalPower_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower start of topic ===
    ${rebpower_RebTotalPower_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_RebTotalPower end of topic ===
    ${rebpower_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebTotalPower_start}    end=${rebpower_RebTotalPower_end + 1}
    Log Many    ${rebpower_RebTotalPower_list}
    Should Contain    ${rebpower_RebTotalPower_list}    === MTCamera_rebpower_RebTotalPower start of topic ===
    Should Contain    ${rebpower_RebTotalPower_list}    === MTCamera_rebpower_RebTotalPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rebpower_RebTotalPower_list}    === [rebpower_RebTotalPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rebpower_RebTotalPower_list}    === [rebpower_RebTotalPower Subscriber] message received :200
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end + 1}
    Log Many    ${rebpower_Rebps_list}
    Should Contain    ${rebpower_Rebps_list}    === MTCamera_rebpower_Rebps start of topic ===
    Should Contain    ${rebpower_Rebps_list}    === MTCamera_rebpower_Rebps end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rebpower_Rebps_list}    === [rebpower_Rebps Subscriber] message received :200
    ${hex_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 start of topic ===
    ${hex_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 end of topic ===
    ${hex_Cold1_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_start}    end=${hex_Cold1_end + 1}
    Log Many    ${hex_Cold1_list}
    Should Contain    ${hex_Cold1_list}    === MTCamera_hex_Cold1 start of topic ===
    Should Contain    ${hex_Cold1_list}    === MTCamera_hex_Cold1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cold1_list}    === [hex_Cold1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cold1_list}    === [hex_Cold1 Subscriber] message received :200
    ${hex_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 start of topic ===
    ${hex_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 end of topic ===
    ${hex_Cold2_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_start}    end=${hex_Cold2_end + 1}
    Log Many    ${hex_Cold2_list}
    Should Contain    ${hex_Cold2_list}    === MTCamera_hex_Cold2 start of topic ===
    Should Contain    ${hex_Cold2_list}    === MTCamera_hex_Cold2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cold2_list}    === [hex_Cold2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cold2_list}    === [hex_Cold2 Subscriber] message received :200
    ${hex_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 start of topic ===
    ${hex_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 end of topic ===
    ${hex_Cryo1_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_start}    end=${hex_Cryo1_end + 1}
    Log Many    ${hex_Cryo1_list}
    Should Contain    ${hex_Cryo1_list}    === MTCamera_hex_Cryo1 start of topic ===
    Should Contain    ${hex_Cryo1_list}    === MTCamera_hex_Cryo1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo1_list}    === [hex_Cryo1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo1_list}    === [hex_Cryo1 Subscriber] message received :200
    ${hex_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 start of topic ===
    ${hex_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 end of topic ===
    ${hex_Cryo2_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_start}    end=${hex_Cryo2_end + 1}
    Log Many    ${hex_Cryo2_list}
    Should Contain    ${hex_Cryo2_list}    === MTCamera_hex_Cryo2 start of topic ===
    Should Contain    ${hex_Cryo2_list}    === MTCamera_hex_Cryo2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo2_list}    === [hex_Cryo2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo2_list}    === [hex_Cryo2 Subscriber] message received :200
    ${hex_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 start of topic ===
    ${hex_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 end of topic ===
    ${hex_Cryo3_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_start}    end=${hex_Cryo3_end + 1}
    Log Many    ${hex_Cryo3_list}
    Should Contain    ${hex_Cryo3_list}    === MTCamera_hex_Cryo3 start of topic ===
    Should Contain    ${hex_Cryo3_list}    === MTCamera_hex_Cryo3 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo3_list}    === [hex_Cryo3 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo3_list}    === [hex_Cryo3 Subscriber] message received :200
    ${hex_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 start of topic ===
    ${hex_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 end of topic ===
    ${hex_Cryo4_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_start}    end=${hex_Cryo4_end + 1}
    Log Many    ${hex_Cryo4_list}
    Should Contain    ${hex_Cryo4_list}    === MTCamera_hex_Cryo4 start of topic ===
    Should Contain    ${hex_Cryo4_list}    === MTCamera_hex_Cryo4 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo4_list}    === [hex_Cryo4 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo4_list}    === [hex_Cryo4 Subscriber] message received :200
    ${hex_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 start of topic ===
    ${hex_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 end of topic ===
    ${hex_Cryo5_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_start}    end=${hex_Cryo5_end + 1}
    Log Many    ${hex_Cryo5_list}
    Should Contain    ${hex_Cryo5_list}    === MTCamera_hex_Cryo5 start of topic ===
    Should Contain    ${hex_Cryo5_list}    === MTCamera_hex_Cryo5 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo5_list}    === [hex_Cryo5 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo5_list}    === [hex_Cryo5 Subscriber] message received :200
    ${hex_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 start of topic ===
    ${hex_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 end of topic ===
    ${hex_Cryo6_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_start}    end=${hex_Cryo6_end + 1}
    Log Many    ${hex_Cryo6_list}
    Should Contain    ${hex_Cryo6_list}    === MTCamera_hex_Cryo6 start of topic ===
    Should Contain    ${hex_Cryo6_list}    === MTCamera_hex_Cryo6 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo6_list}    === [hex_Cryo6 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${hex_Cryo6_list}    === [hex_Cryo6 Subscriber] message received :200
    ${refrig_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 start of topic ===
    ${refrig_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 end of topic ===
    ${refrig_Cryo1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_start}    end=${refrig_Cryo1_end + 1}
    Log Many    ${refrig_Cryo1_list}
    Should Contain    ${refrig_Cryo1_list}    === MTCamera_refrig_Cryo1 start of topic ===
    Should Contain    ${refrig_Cryo1_list}    === MTCamera_refrig_Cryo1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo1_list}    === [refrig_Cryo1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo1_list}    === [refrig_Cryo1 Subscriber] message received :200
    ${refrig_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 start of topic ===
    ${refrig_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 end of topic ===
    ${refrig_Cryo2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_start}    end=${refrig_Cryo2_end + 1}
    Log Many    ${refrig_Cryo2_list}
    Should Contain    ${refrig_Cryo2_list}    === MTCamera_refrig_Cryo2 start of topic ===
    Should Contain    ${refrig_Cryo2_list}    === MTCamera_refrig_Cryo2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo2_list}    === [refrig_Cryo2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo2_list}    === [refrig_Cryo2 Subscriber] message received :200
    ${refrig_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 start of topic ===
    ${refrig_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 end of topic ===
    ${refrig_Cryo3_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_start}    end=${refrig_Cryo3_end + 1}
    Log Many    ${refrig_Cryo3_list}
    Should Contain    ${refrig_Cryo3_list}    === MTCamera_refrig_Cryo3 start of topic ===
    Should Contain    ${refrig_Cryo3_list}    === MTCamera_refrig_Cryo3 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo3_list}    === [refrig_Cryo3 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo3_list}    === [refrig_Cryo3 Subscriber] message received :200
    ${refrig_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 start of topic ===
    ${refrig_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 end of topic ===
    ${refrig_Cryo4_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_start}    end=${refrig_Cryo4_end + 1}
    Log Many    ${refrig_Cryo4_list}
    Should Contain    ${refrig_Cryo4_list}    === MTCamera_refrig_Cryo4 start of topic ===
    Should Contain    ${refrig_Cryo4_list}    === MTCamera_refrig_Cryo4 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo4_list}    === [refrig_Cryo4 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo4_list}    === [refrig_Cryo4 Subscriber] message received :200
    ${refrig_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 start of topic ===
    ${refrig_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 end of topic ===
    ${refrig_Cryo5_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_start}    end=${refrig_Cryo5_end + 1}
    Log Many    ${refrig_Cryo5_list}
    Should Contain    ${refrig_Cryo5_list}    === MTCamera_refrig_Cryo5 start of topic ===
    Should Contain    ${refrig_Cryo5_list}    === MTCamera_refrig_Cryo5 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo5_list}    === [refrig_Cryo5 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo5_list}    === [refrig_Cryo5 Subscriber] message received :200
    ${refrig_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 start of topic ===
    ${refrig_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 end of topic ===
    ${refrig_Cryo6_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_start}    end=${refrig_Cryo6_end + 1}
    Log Many    ${refrig_Cryo6_list}
    Should Contain    ${refrig_Cryo6_list}    === MTCamera_refrig_Cryo6 start of topic ===
    Should Contain    ${refrig_Cryo6_list}    === MTCamera_refrig_Cryo6 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo6_list}    === [refrig_Cryo6 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cryo6_list}    === [refrig_Cryo6 Subscriber] message received :200
    ${vacuum_Cip_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip start of topic ===
    ${vacuum_Cip_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cip end of topic ===
    ${vacuum_Cip_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cip_start}    end=${vacuum_Cip_end + 1}
    Log Many    ${vacuum_Cip_list}
    Should Contain    ${vacuum_Cip_list}    === MTCamera_vacuum_Cip start of topic ===
    Should Contain    ${vacuum_Cip_list}    === MTCamera_vacuum_Cip end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cip_list}    === [vacuum_Cip Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cip_list}    === [vacuum_Cip Subscriber] message received :200
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end + 1}
    Log Many    ${vacuum_Cryo_list}
    Should Contain    ${vacuum_Cryo_list}    === MTCamera_vacuum_Cryo start of topic ===
    Should Contain    ${vacuum_Cryo_list}    === MTCamera_vacuum_Cryo end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Cryo_list}    === [vacuum_Cryo Subscriber] message received :200
    ${vacuum_HX_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX start of topic ===
    ${vacuum_HX_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_HX end of topic ===
    ${vacuum_HX_list}=    Get Slice From List    ${full_list}    start=${vacuum_HX_start}    end=${vacuum_HX_end + 1}
    Log Many    ${vacuum_HX_list}
    Should Contain    ${vacuum_HX_list}    === MTCamera_vacuum_HX start of topic ===
    Should Contain    ${vacuum_HX_list}    === MTCamera_vacuum_HX end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_HX_list}    === [vacuum_HX Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_HX_list}    === [vacuum_HX Subscriber] message received :200
    ${vacuum_Hip_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip start of topic ===
    ${vacuum_Hip_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hip end of topic ===
    ${vacuum_Hip_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hip_start}    end=${vacuum_Hip_end + 1}
    Log Many    ${vacuum_Hip_list}
    Should Contain    ${vacuum_Hip_list}    === MTCamera_vacuum_Hip start of topic ===
    Should Contain    ${vacuum_Hip_list}    === MTCamera_vacuum_Hip end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hip_list}    === [vacuum_Hip Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hip_list}    === [vacuum_Hip Subscriber] message received :200
    ${vacuum_Inst_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst start of topic ===
    ${vacuum_Inst_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Inst end of topic ===
    ${vacuum_Inst_list}=    Get Slice From List    ${full_list}    start=${vacuum_Inst_start}    end=${vacuum_Inst_end + 1}
    Log Many    ${vacuum_Inst_list}
    Should Contain    ${vacuum_Inst_list}    === MTCamera_vacuum_Inst start of topic ===
    Should Contain    ${vacuum_Inst_list}    === MTCamera_vacuum_Inst end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Inst_list}    === [vacuum_Inst Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Inst_list}    === [vacuum_Inst Subscriber] message received :200
    ${daq_monitor_Reb_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Reb_Trending start of topic ===
    ${daq_monitor_Reb_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Reb_Trending end of topic ===
    ${daq_monitor_Reb_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Reb_Trending_start}    end=${daq_monitor_Reb_Trending_end + 1}
    Log Many    ${daq_monitor_Reb_Trending_list}
    Should Contain    ${daq_monitor_Reb_Trending_list}    === MTCamera_daq_monitor_Reb_Trending start of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === MTCamera_daq_monitor_Reb_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending Subscriber] message received :200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :200
    ${daq_monitor_Sum_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Sum_Trending start of topic ===
    ${daq_monitor_Sum_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Sum_Trending end of topic ===
    ${daq_monitor_Sum_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Sum_Trending_start}    end=${daq_monitor_Sum_Trending_end + 1}
    Log Many    ${daq_monitor_Sum_Trending_list}
    Should Contain    ${daq_monitor_Sum_Trending_list}    === MTCamera_daq_monitor_Sum_Trending start of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === MTCamera_daq_monitor_Sum_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending Subscriber] message received :200
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === MTCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === MTCamera_focal_plane_Ccd end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === MTCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === MTCamera_focal_plane_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === MTCamera_focal_plane_RebTotalPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :200
    ${focal_plane_RebsAverageTemp6_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6 start of topic ===
    ${focal_plane_RebsAverageTemp6_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebsAverageTemp6 end of topic ===
    ${focal_plane_RebsAverageTemp6_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_start}    end=${focal_plane_RebsAverageTemp6_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === MTCamera_focal_plane_RebsAverageTemp6 start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === MTCamera_focal_plane_RebsAverageTemp6 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6 Subscriber] message received :200
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :200
    ${mpm_CLP_RTD_03_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03 start of topic ===
    ${mpm_CLP_RTD_03_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_03 end of topic ===
    ${mpm_CLP_RTD_03_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_03_start}    end=${mpm_CLP_RTD_03_end + 1}
    Log Many    ${mpm_CLP_RTD_03_list}
    Should Contain    ${mpm_CLP_RTD_03_list}    === MTCamera_mpm_CLP_RTD_03 start of topic ===
    Should Contain    ${mpm_CLP_RTD_03_list}    === MTCamera_mpm_CLP_RTD_03 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_03_list}    === [mpm_CLP_RTD_03 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_03_list}    === [mpm_CLP_RTD_03 Subscriber] message received :200
    ${mpm_CLP_RTD_05_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05 start of topic ===
    ${mpm_CLP_RTD_05_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_05 end of topic ===
    ${mpm_CLP_RTD_05_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_05_start}    end=${mpm_CLP_RTD_05_end + 1}
    Log Many    ${mpm_CLP_RTD_05_list}
    Should Contain    ${mpm_CLP_RTD_05_list}    === MTCamera_mpm_CLP_RTD_05 start of topic ===
    Should Contain    ${mpm_CLP_RTD_05_list}    === MTCamera_mpm_CLP_RTD_05 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_05_list}    === [mpm_CLP_RTD_05 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_05_list}    === [mpm_CLP_RTD_05 Subscriber] message received :200
    ${mpm_CLP_RTD_50_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50 start of topic ===
    ${mpm_CLP_RTD_50_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_50 end of topic ===
    ${mpm_CLP_RTD_50_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_50_start}    end=${mpm_CLP_RTD_50_end + 1}
    Log Many    ${mpm_CLP_RTD_50_list}
    Should Contain    ${mpm_CLP_RTD_50_list}    === MTCamera_mpm_CLP_RTD_50 start of topic ===
    Should Contain    ${mpm_CLP_RTD_50_list}    === MTCamera_mpm_CLP_RTD_50 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_50_list}    === [mpm_CLP_RTD_50 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_50_list}    === [mpm_CLP_RTD_50 Subscriber] message received :200
    ${mpm_CLP_RTD_55_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55 start of topic ===
    ${mpm_CLP_RTD_55_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CLP_RTD_55 end of topic ===
    ${mpm_CLP_RTD_55_list}=    Get Slice From List    ${full_list}    start=${mpm_CLP_RTD_55_start}    end=${mpm_CLP_RTD_55_end + 1}
    Log Many    ${mpm_CLP_RTD_55_list}
    Should Contain    ${mpm_CLP_RTD_55_list}    === MTCamera_mpm_CLP_RTD_55 start of topic ===
    Should Contain    ${mpm_CLP_RTD_55_list}    === MTCamera_mpm_CLP_RTD_55 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_55_list}    === [mpm_CLP_RTD_55 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CLP_RTD_55_list}    === [mpm_CLP_RTD_55 Subscriber] message received :200
    ${mpm_CYP_RTD_12_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12 start of topic ===
    ${mpm_CYP_RTD_12_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_12 end of topic ===
    ${mpm_CYP_RTD_12_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_12_start}    end=${mpm_CYP_RTD_12_end + 1}
    Log Many    ${mpm_CYP_RTD_12_list}
    Should Contain    ${mpm_CYP_RTD_12_list}    === MTCamera_mpm_CYP_RTD_12 start of topic ===
    Should Contain    ${mpm_CYP_RTD_12_list}    === MTCamera_mpm_CYP_RTD_12 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_12_list}    === [mpm_CYP_RTD_12 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_12_list}    === [mpm_CYP_RTD_12 Subscriber] message received :200
    ${mpm_CYP_RTD_14_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14 start of topic ===
    ${mpm_CYP_RTD_14_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_14 end of topic ===
    ${mpm_CYP_RTD_14_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_14_start}    end=${mpm_CYP_RTD_14_end + 1}
    Log Many    ${mpm_CYP_RTD_14_list}
    Should Contain    ${mpm_CYP_RTD_14_list}    === MTCamera_mpm_CYP_RTD_14 start of topic ===
    Should Contain    ${mpm_CYP_RTD_14_list}    === MTCamera_mpm_CYP_RTD_14 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_14_list}    === [mpm_CYP_RTD_14 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_14_list}    === [mpm_CYP_RTD_14 Subscriber] message received :200
    ${mpm_CYP_RTD_31_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31 start of topic ===
    ${mpm_CYP_RTD_31_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_31 end of topic ===
    ${mpm_CYP_RTD_31_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_31_start}    end=${mpm_CYP_RTD_31_end + 1}
    Log Many    ${mpm_CYP_RTD_31_list}
    Should Contain    ${mpm_CYP_RTD_31_list}    === MTCamera_mpm_CYP_RTD_31 start of topic ===
    Should Contain    ${mpm_CYP_RTD_31_list}    === MTCamera_mpm_CYP_RTD_31 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_31_list}    === [mpm_CYP_RTD_31 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_31_list}    === [mpm_CYP_RTD_31 Subscriber] message received :200
    ${mpm_CYP_RTD_43_start}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43 start of topic ===
    ${mpm_CYP_RTD_43_end}=    Get Index From List    ${full_list}    === MTCamera_mpm_CYP_RTD_43 end of topic ===
    ${mpm_CYP_RTD_43_list}=    Get Slice From List    ${full_list}    start=${mpm_CYP_RTD_43_start}    end=${mpm_CYP_RTD_43_end + 1}
    Log Many    ${mpm_CYP_RTD_43_list}
    Should Contain    ${mpm_CYP_RTD_43_list}    === MTCamera_mpm_CYP_RTD_43 start of topic ===
    Should Contain    ${mpm_CYP_RTD_43_list}    === MTCamera_mpm_CYP_RTD_43 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_43_list}    === [mpm_CYP_RTD_43 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${mpm_CYP_RTD_43_list}    === [mpm_CYP_RTD_43 Subscriber] message received :200
    ${fcs_Autochanger_AutochangerTrucks_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending start of topic ===
    ${fcs_Autochanger_AutochangerTrucks_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending end of topic ===
    ${fcs_Autochanger_AutochangerTrucks_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_AutochangerTrucks_Trending_start}    end=${fcs_Autochanger_AutochangerTrucks_Trending_end + 1}
    Log Many    ${fcs_Autochanger_AutochangerTrucks_Trending_list}
    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === MTCamera_fcs_Autochanger_AutochangerTrucks_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === [fcs_Autochanger_AutochangerTrucks_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_AutochangerTrucks_Trending_list}    === [fcs_Autochanger_AutochangerTrucks_Trending Subscriber] message received :200
    ${fcs_Autochanger_Latches_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Latches_Trending start of topic ===
    ${fcs_Autochanger_Latches_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Latches_Trending end of topic ===
    ${fcs_Autochanger_Latches_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_Latches_Trending_start}    end=${fcs_Autochanger_Latches_Trending_end + 1}
    Log Many    ${fcs_Autochanger_Latches_Trending_list}
    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === MTCamera_fcs_Autochanger_Latches_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === MTCamera_fcs_Autochanger_Latches_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === [fcs_Autochanger_Latches_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_Latches_Trending_list}    === [fcs_Autochanger_Latches_Trending Subscriber] message received :200
    ${fcs_Autochanger_OnlineClamps_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending start of topic ===
    ${fcs_Autochanger_OnlineClamps_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending end of topic ===
    ${fcs_Autochanger_OnlineClamps_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_OnlineClamps_Trending_start}    end=${fcs_Autochanger_OnlineClamps_Trending_end + 1}
    Log Many    ${fcs_Autochanger_OnlineClamps_Trending_list}
    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending start of topic ===
    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === MTCamera_fcs_Autochanger_OnlineClamps_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === [fcs_Autochanger_OnlineClamps_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_OnlineClamps_Trending_list}    === [fcs_Autochanger_OnlineClamps_Trending Subscriber] message received :200
    ${fcs_Autochanger_Temperatures_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Temperatures start of topic ===
    ${fcs_Autochanger_Temperatures_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger_Temperatures end of topic ===
    ${fcs_Autochanger_Temperatures_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_Temperatures_start}    end=${fcs_Autochanger_Temperatures_end + 1}
    Log Many    ${fcs_Autochanger_Temperatures_list}
    Should Contain    ${fcs_Autochanger_Temperatures_list}    === MTCamera_fcs_Autochanger_Temperatures start of topic ===
    Should Contain    ${fcs_Autochanger_Temperatures_list}    === MTCamera_fcs_Autochanger_Temperatures end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_Temperatures_list}    === [fcs_Autochanger_Temperatures Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_Temperatures_list}    === [fcs_Autochanger_Temperatures Subscriber] message received :200
    ${fcs_Canbus0_AcSensorsGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending start of topic ===
    ${fcs_Canbus0_AcSensorsGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending end of topic ===
    ${fcs_Canbus0_AcSensorsGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcSensorsGateway_Trending_start}    end=${fcs_Canbus0_AcSensorsGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcSensorsGateway_Trending_list}
    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === MTCamera_fcs_Canbus0_AcSensorsGateway_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === [fcs_Canbus0_AcSensorsGateway_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcSensorsGateway_Trending_list}    === [fcs_Canbus0_AcSensorsGateway_Trending Subscriber] message received :200
    ${fcs_Canbus0_AcTruckXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending start of topic ===
    ${fcs_Canbus0_AcTruckXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending end of topic ===
    ${fcs_Canbus0_AcTruckXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcTruckXminusController_Trending_start}    end=${fcs_Canbus0_AcTruckXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcTruckXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXminusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === [fcs_Canbus0_AcTruckXminusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcTruckXminusController_Trending_list}    === [fcs_Canbus0_AcTruckXminusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_AcTruckXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending start of topic ===
    ${fcs_Canbus0_AcTruckXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending end of topic ===
    ${fcs_Canbus0_AcTruckXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_AcTruckXplusController_Trending_start}    end=${fcs_Canbus0_AcTruckXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_AcTruckXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === MTCamera_fcs_Canbus0_AcTruckXplusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === [fcs_Canbus0_AcTruckXplusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_AcTruckXplusController_Trending_list}    === [fcs_Canbus0_AcTruckXplusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_Accelerobf_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending start of topic ===
    ${fcs_Canbus0_Accelerobf_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending end of topic ===
    ${fcs_Canbus0_Accelerobf_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Accelerobf_Trending_start}    end=${fcs_Canbus0_Accelerobf_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Accelerobf_Trending_list}
    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === MTCamera_fcs_Canbus0_Accelerobf_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === [fcs_Canbus0_Accelerobf_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Accelerobf_Trending_list}    === [fcs_Canbus0_Accelerobf_Trending Subscriber] message received :200
    ${fcs_Canbus0_Ai814_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Ai814_Trending start of topic ===
    ${fcs_Canbus0_Ai814_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Ai814_Trending end of topic ===
    ${fcs_Canbus0_Ai814_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Ai814_Trending_start}    end=${fcs_Canbus0_Ai814_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Ai814_Trending_list}
    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === MTCamera_fcs_Canbus0_Ai814_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === MTCamera_fcs_Canbus0_Ai814_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === [fcs_Canbus0_Ai814_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Ai814_Trending_list}    === [fcs_Canbus0_Ai814_Trending Subscriber] message received :200
    ${fcs_Canbus0_BrakeSystemGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending start of topic ===
    ${fcs_Canbus0_BrakeSystemGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending end of topic ===
    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_BrakeSystemGateway_Trending_start}    end=${fcs_Canbus0_BrakeSystemGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}
    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === MTCamera_fcs_Canbus0_BrakeSystemGateway_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === [fcs_Canbus0_BrakeSystemGateway_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_BrakeSystemGateway_Trending_list}    === [fcs_Canbus0_BrakeSystemGateway_Trending Subscriber] message received :200
    ${fcs_Canbus0_CarouselController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending start of topic ===
    ${fcs_Canbus0_CarouselController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending end of topic ===
    ${fcs_Canbus0_CarouselController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_CarouselController_Trending_start}    end=${fcs_Canbus0_CarouselController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_CarouselController_Trending_list}
    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === MTCamera_fcs_Canbus0_CarouselController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === [fcs_Canbus0_CarouselController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_CarouselController_Trending_list}    === [fcs_Canbus0_CarouselController_Trending Subscriber] message received :200
    ${fcs_Canbus0_ClampXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending start of topic ===
    ${fcs_Canbus0_ClampXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending end of topic ===
    ${fcs_Canbus0_ClampXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ClampXminusController_Trending_start}    end=${fcs_Canbus0_ClampXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ClampXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXminusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === [fcs_Canbus0_ClampXminusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ClampXminusController_Trending_list}    === [fcs_Canbus0_ClampXminusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_ClampXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending start of topic ===
    ${fcs_Canbus0_ClampXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending end of topic ===
    ${fcs_Canbus0_ClampXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ClampXplusController_Trending_start}    end=${fcs_Canbus0_ClampXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ClampXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_ClampXplusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === [fcs_Canbus0_ClampXplusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ClampXplusController_Trending_list}    === [fcs_Canbus0_ClampXplusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_Hyttc580_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending start of topic ===
    ${fcs_Canbus0_Hyttc580_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending end of topic ===
    ${fcs_Canbus0_Hyttc580_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Hyttc580_Trending_start}    end=${fcs_Canbus0_Hyttc580_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Hyttc580_Trending_list}
    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === MTCamera_fcs_Canbus0_Hyttc580_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === [fcs_Canbus0_Hyttc580_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Hyttc580_Trending_list}    === [fcs_Canbus0_Hyttc580_Trending Subscriber] message received :200
    ${fcs_Canbus0_LatchXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending start of topic ===
    ${fcs_Canbus0_LatchXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending end of topic ===
    ${fcs_Canbus0_LatchXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_LatchXminusController_Trending_start}    end=${fcs_Canbus0_LatchXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_LatchXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXminusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === [fcs_Canbus0_LatchXminusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_LatchXminusController_Trending_list}    === [fcs_Canbus0_LatchXminusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_LatchXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending start of topic ===
    ${fcs_Canbus0_LatchXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending end of topic ===
    ${fcs_Canbus0_LatchXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_LatchXplusController_Trending_start}    end=${fcs_Canbus0_LatchXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_LatchXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === MTCamera_fcs_Canbus0_LatchXplusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === [fcs_Canbus0_LatchXplusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_LatchXplusController_Trending_list}    === [fcs_Canbus0_LatchXplusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_OnlineClampXminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampXminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampXminusController_Trending_start}    end=${fcs_Canbus0_OnlineClampXminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXminusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === [fcs_Canbus0_OnlineClampXminusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampXminusController_Trending_list}    === [fcs_Canbus0_OnlineClampXminusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_OnlineClampXplusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampXplusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampXplusController_Trending_start}    end=${fcs_Canbus0_OnlineClampXplusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampXplusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === [fcs_Canbus0_OnlineClampXplusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampXplusController_Trending_list}    === [fcs_Canbus0_OnlineClampXplusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_OnlineClampYminusController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending start of topic ===
    ${fcs_Canbus0_OnlineClampYminusController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending end of topic ===
    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineClampYminusController_Trending_start}    end=${fcs_Canbus0_OnlineClampYminusController_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === MTCamera_fcs_Canbus0_OnlineClampYminusController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === [fcs_Canbus0_OnlineClampYminusController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineClampYminusController_Trending_list}    === [fcs_Canbus0_OnlineClampYminusController_Trending Subscriber] message received :200
    ${fcs_Canbus0_OnlineStrainGauge_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending start of topic ===
    ${fcs_Canbus0_OnlineStrainGauge_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending end of topic ===
    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_OnlineStrainGauge_Trending_start}    end=${fcs_Canbus0_OnlineStrainGauge_Trending_end + 1}
    Log Many    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}
    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === MTCamera_fcs_Canbus0_OnlineStrainGauge_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === [fcs_Canbus0_OnlineStrainGauge_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_OnlineStrainGauge_Trending_list}    === [fcs_Canbus0_OnlineStrainGauge_Trending Subscriber] message received :200
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending start of topic ===
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending end of topic ===
    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_ProximitySensorsDevice_Trending_start}    end=${fcs_Canbus0_ProximitySensorsDevice_Trending_end + 1}
    Log Many    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}
    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === MTCamera_fcs_Canbus0_ProximitySensorsDevice_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === [fcs_Canbus0_ProximitySensorsDevice_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_ProximitySensorsDevice_Trending_list}    === [fcs_Canbus0_ProximitySensorsDevice_Trending Subscriber] message received :200
    ${fcs_Canbus0_Pt100_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Pt100_Trending start of topic ===
    ${fcs_Canbus0_Pt100_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_Pt100_Trending end of topic ===
    ${fcs_Canbus0_Pt100_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_Pt100_Trending_start}    end=${fcs_Canbus0_Pt100_Trending_end + 1}
    Log Many    ${fcs_Canbus0_Pt100_Trending_list}
    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === MTCamera_fcs_Canbus0_Pt100_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === MTCamera_fcs_Canbus0_Pt100_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === [fcs_Canbus0_Pt100_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_Pt100_Trending_list}    === [fcs_Canbus0_Pt100_Trending Subscriber] message received :200
    ${fcs_Canbus0_TempSensorsDevice1_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending start of topic ===
    ${fcs_Canbus0_TempSensorsDevice1_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending end of topic ===
    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_TempSensorsDevice1_Trending_start}    end=${fcs_Canbus0_TempSensorsDevice1_Trending_end + 1}
    Log Many    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}
    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice1_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === [fcs_Canbus0_TempSensorsDevice1_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_TempSensorsDevice1_Trending_list}    === [fcs_Canbus0_TempSensorsDevice1_Trending Subscriber] message received :200
    ${fcs_Canbus0_TempSensorsDevice2_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending start of topic ===
    ${fcs_Canbus0_TempSensorsDevice2_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending end of topic ===
    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus0_TempSensorsDevice2_Trending_start}    end=${fcs_Canbus0_TempSensorsDevice2_Trending_end + 1}
    Log Many    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}
    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending start of topic ===
    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === MTCamera_fcs_Canbus0_TempSensorsDevice2_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === [fcs_Canbus0_TempSensorsDevice2_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus0_TempSensorsDevice2_Trending_list}    === [fcs_Canbus0_TempSensorsDevice2_Trending Subscriber] message received :200
    ${fcs_Canbus1_CarrierController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending start of topic ===
    ${fcs_Canbus1_CarrierController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending end of topic ===
    ${fcs_Canbus1_CarrierController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_CarrierController_Trending_start}    end=${fcs_Canbus1_CarrierController_Trending_end + 1}
    Log Many    ${fcs_Canbus1_CarrierController_Trending_list}
    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === MTCamera_fcs_Canbus1_CarrierController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === [fcs_Canbus1_CarrierController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_CarrierController_Trending_list}    === [fcs_Canbus1_CarrierController_Trending Subscriber] message received :200
    ${fcs_Canbus1_HooksController_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_HooksController_Trending start of topic ===
    ${fcs_Canbus1_HooksController_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_HooksController_Trending end of topic ===
    ${fcs_Canbus1_HooksController_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_HooksController_Trending_start}    end=${fcs_Canbus1_HooksController_Trending_end + 1}
    Log Many    ${fcs_Canbus1_HooksController_Trending_list}
    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === MTCamera_fcs_Canbus1_HooksController_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === MTCamera_fcs_Canbus1_HooksController_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === [fcs_Canbus1_HooksController_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_HooksController_Trending_list}    === [fcs_Canbus1_HooksController_Trending Subscriber] message received :200
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending start of topic ===
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending end of topic ===
    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Canbus1_LoaderPlutoGateway_Trending_start}    end=${fcs_Canbus1_LoaderPlutoGateway_Trending_end + 1}
    Log Many    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}
    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending start of topic ===
    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === MTCamera_fcs_Canbus1_LoaderPlutoGateway_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === [fcs_Canbus1_LoaderPlutoGateway_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Canbus1_LoaderPlutoGateway_Trending_list}    === [fcs_Canbus1_LoaderPlutoGateway_Trending Subscriber] message received :200
    ${fcs_Carousel_Socket1_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket1_Trending start of topic ===
    ${fcs_Carousel_Socket1_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket1_Trending end of topic ===
    ${fcs_Carousel_Socket1_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket1_Trending_start}    end=${fcs_Carousel_Socket1_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket1_Trending_list}
    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === MTCamera_fcs_Carousel_Socket1_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === MTCamera_fcs_Carousel_Socket1_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === [fcs_Carousel_Socket1_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket1_Trending_list}    === [fcs_Carousel_Socket1_Trending Subscriber] message received :200
    ${fcs_Carousel_Socket2_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket2_Trending start of topic ===
    ${fcs_Carousel_Socket2_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket2_Trending end of topic ===
    ${fcs_Carousel_Socket2_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket2_Trending_start}    end=${fcs_Carousel_Socket2_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket2_Trending_list}
    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === MTCamera_fcs_Carousel_Socket2_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === MTCamera_fcs_Carousel_Socket2_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === [fcs_Carousel_Socket2_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket2_Trending_list}    === [fcs_Carousel_Socket2_Trending Subscriber] message received :200
    ${fcs_Carousel_Socket3_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket3_Trending start of topic ===
    ${fcs_Carousel_Socket3_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket3_Trending end of topic ===
    ${fcs_Carousel_Socket3_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket3_Trending_start}    end=${fcs_Carousel_Socket3_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket3_Trending_list}
    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === MTCamera_fcs_Carousel_Socket3_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === MTCamera_fcs_Carousel_Socket3_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === [fcs_Carousel_Socket3_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket3_Trending_list}    === [fcs_Carousel_Socket3_Trending Subscriber] message received :200
    ${fcs_Carousel_Socket4_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket4_Trending start of topic ===
    ${fcs_Carousel_Socket4_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket4_Trending end of topic ===
    ${fcs_Carousel_Socket4_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket4_Trending_start}    end=${fcs_Carousel_Socket4_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket4_Trending_list}
    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === MTCamera_fcs_Carousel_Socket4_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === MTCamera_fcs_Carousel_Socket4_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === [fcs_Carousel_Socket4_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket4_Trending_list}    === [fcs_Carousel_Socket4_Trending Subscriber] message received :200
    ${fcs_Carousel_Socket5_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket5_Trending start of topic ===
    ${fcs_Carousel_Socket5_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Socket5_Trending end of topic ===
    ${fcs_Carousel_Socket5_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Socket5_Trending_start}    end=${fcs_Carousel_Socket5_Trending_end + 1}
    Log Many    ${fcs_Carousel_Socket5_Trending_list}
    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === MTCamera_fcs_Carousel_Socket5_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === MTCamera_fcs_Carousel_Socket5_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === [fcs_Carousel_Socket5_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Socket5_Trending_list}    === [fcs_Carousel_Socket5_Trending Subscriber] message received :200
    ${fcs_Carousel_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Trending start of topic ===
    ${fcs_Carousel_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel_Trending end of topic ===
    ${fcs_Carousel_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_Trending_start}    end=${fcs_Carousel_Trending_end + 1}
    Log Many    ${fcs_Carousel_Trending_list}
    Should Contain    ${fcs_Carousel_Trending_list}    === MTCamera_fcs_Carousel_Trending start of topic ===
    Should Contain    ${fcs_Carousel_Trending_list}    === MTCamera_fcs_Carousel_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Trending_list}    === [fcs_Carousel_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_Trending_list}    === [fcs_Carousel_Trending Subscriber] message received :200
    ${fcs_Duration_Autochanger_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Autochanger_Trending start of topic ===
    ${fcs_Duration_Autochanger_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Autochanger_Trending end of topic ===
    ${fcs_Duration_Autochanger_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Autochanger_Trending_start}    end=${fcs_Duration_Autochanger_Trending_end + 1}
    Log Many    ${fcs_Duration_Autochanger_Trending_list}
    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === MTCamera_fcs_Duration_Autochanger_Trending start of topic ===
    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === MTCamera_fcs_Duration_Autochanger_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === [fcs_Duration_Autochanger_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Autochanger_Trending_list}    === [fcs_Duration_Autochanger_Trending Subscriber] message received :200
    ${fcs_Duration_Carousel_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Carousel_Trending start of topic ===
    ${fcs_Duration_Carousel_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Carousel_Trending end of topic ===
    ${fcs_Duration_Carousel_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Carousel_Trending_start}    end=${fcs_Duration_Carousel_Trending_end + 1}
    Log Many    ${fcs_Duration_Carousel_Trending_list}
    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === MTCamera_fcs_Duration_Carousel_Trending start of topic ===
    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === MTCamera_fcs_Duration_Carousel_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === [fcs_Duration_Carousel_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Carousel_Trending_list}    === [fcs_Duration_Carousel_Trending Subscriber] message received :200
    ${fcs_Duration_Loader_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Loader_Trending start of topic ===
    ${fcs_Duration_Loader_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Loader_Trending end of topic ===
    ${fcs_Duration_Loader_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Loader_Trending_start}    end=${fcs_Duration_Loader_Trending_end + 1}
    Log Many    ${fcs_Duration_Loader_Trending_list}
    Should Contain    ${fcs_Duration_Loader_Trending_list}    === MTCamera_fcs_Duration_Loader_Trending start of topic ===
    Should Contain    ${fcs_Duration_Loader_Trending_list}    === MTCamera_fcs_Duration_Loader_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Loader_Trending_list}    === [fcs_Duration_Loader_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Loader_Trending_list}    === [fcs_Duration_Loader_Trending Subscriber] message received :200
    ${fcs_Duration_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Trending start of topic ===
    ${fcs_Duration_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Duration_Trending end of topic ===
    ${fcs_Duration_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Duration_Trending_start}    end=${fcs_Duration_Trending_end + 1}
    Log Many    ${fcs_Duration_Trending_list}
    Should Contain    ${fcs_Duration_Trending_list}    === MTCamera_fcs_Duration_Trending start of topic ===
    Should Contain    ${fcs_Duration_Trending_list}    === MTCamera_fcs_Duration_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Trending_list}    === [fcs_Duration_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Duration_Trending_list}    === [fcs_Duration_Trending Subscriber] message received :200
    ${fcs_Fcs_Mcm_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Fcs_Mcm_Trending start of topic ===
    ${fcs_Fcs_Mcm_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Fcs_Mcm_Trending end of topic ===
    ${fcs_Fcs_Mcm_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Fcs_Mcm_Trending_start}    end=${fcs_Fcs_Mcm_Trending_end + 1}
    Log Many    ${fcs_Fcs_Mcm_Trending_list}
    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === MTCamera_fcs_Fcs_Mcm_Trending start of topic ===
    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === MTCamera_fcs_Fcs_Mcm_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === [fcs_Fcs_Mcm_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Fcs_Mcm_Trending_list}    === [fcs_Fcs_Mcm_Trending Subscriber] message received :200
    ${fcs_Loader_Carrier_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Carrier_Trending start of topic ===
    ${fcs_Loader_Carrier_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Carrier_Trending end of topic ===
    ${fcs_Loader_Carrier_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_Carrier_Trending_start}    end=${fcs_Loader_Carrier_Trending_end + 1}
    Log Many    ${fcs_Loader_Carrier_Trending_list}
    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === MTCamera_fcs_Loader_Carrier_Trending start of topic ===
    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === MTCamera_fcs_Loader_Carrier_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === [fcs_Loader_Carrier_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_Carrier_Trending_list}    === [fcs_Loader_Carrier_Trending Subscriber] message received :200
    ${fcs_Loader_Hooks_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Hooks_Trending start of topic ===
    ${fcs_Loader_Hooks_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader_Hooks_Trending end of topic ===
    ${fcs_Loader_Hooks_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_Hooks_Trending_start}    end=${fcs_Loader_Hooks_Trending_end + 1}
    Log Many    ${fcs_Loader_Hooks_Trending_list}
    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === MTCamera_fcs_Loader_Hooks_Trending start of topic ===
    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === MTCamera_fcs_Loader_Hooks_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === [fcs_Loader_Hooks_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_Hooks_Trending_list}    === [fcs_Loader_Hooks_Trending Subscriber] message received :200
    ${fcs_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Trending start of topic ===
    ${fcs_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Trending end of topic ===
    ${fcs_Trending_list}=    Get Slice From List    ${full_list}    start=${fcs_Trending_start}    end=${fcs_Trending_end + 1}
    Log Many    ${fcs_Trending_list}
    Should Contain    ${fcs_Trending_list}    === MTCamera_fcs_Trending start of topic ===
    Should Contain    ${fcs_Trending_list}    === MTCamera_fcs_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Trending_list}    === [fcs_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Trending_list}    === [fcs_Trending Subscriber] message received :200
    ${shutter_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_shutter_Trending start of topic ===
    ${shutter_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_shutter_Trending end of topic ===
    ${shutter_Trending_list}=    Get Slice From List    ${full_list}    start=${shutter_Trending_start}    end=${shutter_Trending_end + 1}
    Log Many    ${shutter_Trending_list}
    Should Contain    ${shutter_Trending_list}    === MTCamera_shutter_Trending start of topic ===
    Should Contain    ${shutter_Trending_list}    === MTCamera_shutter_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${shutter_Trending_list}    === [shutter_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${shutter_Trending_list}    === [shutter_Trending Subscriber] message received :200
    ${chiller_Chiller_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller start of topic ===
    ${chiller_Chiller_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller end of topic ===
    ${chiller_Chiller_list}=    Get Slice From List    ${full_list}    start=${chiller_Chiller_start}    end=${chiller_Chiller_end + 1}
    Log Many    ${chiller_Chiller_list}
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller start of topic ===
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller Subscriber] message received :200
    ${chiller_FParam_Trending_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_FParam_Trending start of topic ===
    ${chiller_FParam_Trending_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_FParam_Trending end of topic ===
    ${chiller_FParam_Trending_list}=    Get Slice From List    ${full_list}    start=${chiller_FParam_Trending_start}    end=${chiller_FParam_Trending_end + 1}
    Log Many    ${chiller_FParam_Trending_list}
    Should Contain    ${chiller_FParam_Trending_list}    === MTCamera_chiller_FParam_Trending start of topic ===
    Should Contain    ${chiller_FParam_Trending_list}    === MTCamera_chiller_FParam_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${chiller_FParam_Trending_list}    === [chiller_FParam_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${chiller_FParam_Trending_list}    === [chiller_FParam_Trending Subscriber] message received :200
    ${chiller_Maq20_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 start of topic ===
    ${chiller_Maq20_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 end of topic ===
    ${chiller_Maq20_list}=    Get Slice From List    ${full_list}    start=${chiller_Maq20_start}    end=${chiller_Maq20_end + 1}
    Log Many    ${chiller_Maq20_list}
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 start of topic ===
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20 Subscriber] message received :200
    ${thermal_Cold_Temp_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cold_Temp start of topic ===
    ${thermal_Cold_Temp_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cold_Temp end of topic ===
    ${thermal_Cold_Temp_list}=    Get Slice From List    ${full_list}    start=${thermal_Cold_Temp_start}    end=${thermal_Cold_Temp_end + 1}
    Log Many    ${thermal_Cold_Temp_list}
    Should Contain    ${thermal_Cold_Temp_list}    === MTCamera_thermal_Cold_Temp start of topic ===
    Should Contain    ${thermal_Cold_Temp_list}    === MTCamera_thermal_Cold_Temp end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${thermal_Cold_Temp_list}    === [thermal_Cold_Temp Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${thermal_Cold_Temp_list}    === [thermal_Cold_Temp Subscriber] message received :200
    ${thermal_Cryo_Temp_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cryo_Temp start of topic ===
    ${thermal_Cryo_Temp_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Cryo_Temp end of topic ===
    ${thermal_Cryo_Temp_list}=    Get Slice From List    ${full_list}    start=${thermal_Cryo_Temp_start}    end=${thermal_Cryo_Temp_end + 1}
    Log Many    ${thermal_Cryo_Temp_list}
    Should Contain    ${thermal_Cryo_Temp_list}    === MTCamera_thermal_Cryo_Temp start of topic ===
    Should Contain    ${thermal_Cryo_Temp_list}    === MTCamera_thermal_Cryo_Temp end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${thermal_Cryo_Temp_list}    === [thermal_Cryo_Temp Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${thermal_Cryo_Temp_list}    === [thermal_Cryo_Temp Subscriber] message received :200
    ${thermal_Rtd_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Rtd start of topic ===
    ${thermal_Rtd_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Rtd end of topic ===
    ${thermal_Rtd_list}=    Get Slice From List    ${full_list}    start=${thermal_Rtd_start}    end=${thermal_Rtd_end + 1}
    Log Many    ${thermal_Rtd_list}
    Should Contain    ${thermal_Rtd_list}    === MTCamera_thermal_Rtd start of topic ===
    Should Contain    ${thermal_Rtd_list}    === MTCamera_thermal_Rtd end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${thermal_Rtd_list}    === [thermal_Rtd Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${thermal_Rtd_list}    === [thermal_Rtd Subscriber] message received :200
    ${thermal_Trim_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim start of topic ===
    ${thermal_Trim_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim end of topic ===
    ${thermal_Trim_list}=    Get Slice From List    ${full_list}    start=${thermal_Trim_start}    end=${thermal_Trim_end + 1}
    Log Many    ${thermal_Trim_list}
    Should Contain    ${thermal_Trim_list}    === MTCamera_thermal_Trim start of topic ===
    Should Contain    ${thermal_Trim_list}    === MTCamera_thermal_Trim end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${thermal_Trim_list}    === [thermal_Trim Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${thermal_Trim_list}    === [thermal_Trim Subscriber] message received :200
    ${thermal_Trim_Htrs_start}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim_Htrs start of topic ===
    ${thermal_Trim_Htrs_end}=    Get Index From List    ${full_list}    === MTCamera_thermal_Trim_Htrs end of topic ===
    ${thermal_Trim_Htrs_list}=    Get Slice From List    ${full_list}    start=${thermal_Trim_Htrs_start}    end=${thermal_Trim_Htrs_end + 1}
    Log Many    ${thermal_Trim_Htrs_list}
    Should Contain    ${thermal_Trim_Htrs_list}    === MTCamera_thermal_Trim_Htrs start of topic ===
    Should Contain    ${thermal_Trim_Htrs_list}    === MTCamera_thermal_Trim_Htrs end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${thermal_Trim_Htrs_list}    === [thermal_Trim_Htrs Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${thermal_Trim_Htrs_list}    === [thermal_Trim_Htrs Subscriber] message received :200
    ${utiltrunk_Body_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body start of topic ===
    ${utiltrunk_Body_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_Body end of topic ===
    ${utiltrunk_Body_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_Body_start}    end=${utiltrunk_Body_end + 1}
    Log Many    ${utiltrunk_Body_list}
    Should Contain    ${utiltrunk_Body_list}    === MTCamera_utiltrunk_Body start of topic ===
    Should Contain    ${utiltrunk_Body_list}    === MTCamera_utiltrunk_Body end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_Body_list}    === [utiltrunk_Body Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_Body_list}    === [utiltrunk_Body Subscriber] message received :200
    ${utiltrunk_MPC_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC start of topic ===
    ${utiltrunk_MPC_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_MPC end of topic ===
    ${utiltrunk_MPC_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_MPC_start}    end=${utiltrunk_MPC_end + 1}
    Log Many    ${utiltrunk_MPC_list}
    Should Contain    ${utiltrunk_MPC_list}    === MTCamera_utiltrunk_MPC start of topic ===
    Should Contain    ${utiltrunk_MPC_list}    === MTCamera_utiltrunk_MPC end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_MPC_list}    === [utiltrunk_MPC Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_MPC_list}    === [utiltrunk_MPC Subscriber] message received :200
    ${utiltrunk_UT_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT start of topic ===
    ${utiltrunk_UT_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_UT end of topic ===
    ${utiltrunk_UT_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_UT_start}    end=${utiltrunk_UT_end + 1}
    Log Many    ${utiltrunk_UT_list}
    Should Contain    ${utiltrunk_UT_list}    === MTCamera_utiltrunk_UT start of topic ===
    Should Contain    ${utiltrunk_UT_list}    === MTCamera_utiltrunk_UT end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_UT_list}    === [utiltrunk_UT Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_UT_list}    === [utiltrunk_UT Subscriber] message received :200
    ${utiltrunk_VPC_start}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC start of topic ===
    ${utiltrunk_VPC_end}=    Get Index From List    ${full_list}    === MTCamera_utiltrunk_VPC end of topic ===
    ${utiltrunk_VPC_list}=    Get Slice From List    ${full_list}    start=${utiltrunk_VPC_start}    end=${utiltrunk_VPC_end + 1}
    Log Many    ${utiltrunk_VPC_list}
    Should Contain    ${utiltrunk_VPC_list}    === MTCamera_utiltrunk_VPC start of topic ===
    Should Contain    ${utiltrunk_VPC_list}    === MTCamera_utiltrunk_VPC end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_VPC_list}    === [utiltrunk_VPC Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${utiltrunk_VPC_list}    === [utiltrunk_VPC Subscriber] message received :200
