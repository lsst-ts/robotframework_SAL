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
    Should Contain    "${output}"   "1"
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

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${filterChanger_start}=    Get Index From List    ${full_list}    === CCCamera_filterChanger start of topic ===
    ${filterChanger_end}=    Get Index From List    ${full_list}    === CCCamera_filterChanger end of topic ===
    ${filterChanger_list}=    Get Slice From List    ${full_list}    start=${filterChanger_start}    end=${filterChanger_end + 1}
    Log Many    ${filterChanger_list}
    Should Contain    ${filterChanger_list}    === CCCamera_filterChanger start of topic ===
    Should Contain    ${filterChanger_list}    === CCCamera_filterChanger end of topic ===
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end + 1}
    Log Many    ${bonnShutter_list}
    Should Contain    ${bonnShutter_list}    === CCCamera_bonnShutter start of topic ===
    Should Contain    ${bonnShutter_list}    === CCCamera_bonnShutter end of topic ===
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end + 1}
    Log Many    ${rebpower_Reb_list}
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb start of topic ===
    Should Contain    ${rebpower_Reb_list}    === CCCamera_rebpower_Reb end of topic ===
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end + 1}
    Log Many    ${rebpower_Rebps_list}
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps start of topic ===
    Should Contain    ${rebpower_Rebps_list}    === CCCamera_rebpower_Rebps end of topic ===
    ${vacuum_VQMonitor_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    ${vacuum_VQMonitor_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    ${vacuum_VQMonitor_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_start}    end=${vacuum_VQMonitor_end + 1}
    Log Many    ${vacuum_VQMonitor_list}
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    Should Contain    ${vacuum_VQMonitor_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    ${vacuum_IonPumps_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps start of topic ===
    ${vacuum_IonPumps_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps end of topic ===
    ${vacuum_IonPumps_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_start}    end=${vacuum_IonPumps_end + 1}
    Log Many    ${vacuum_IonPumps_list}
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps start of topic ===
    Should Contain    ${vacuum_IonPumps_list}    === CCCamera_vacuum_IonPumps end of topic ===
    ${vacuum_Turbo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo start of topic ===
    ${vacuum_Turbo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo end of topic ===
    ${vacuum_Turbo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_start}    end=${vacuum_Turbo_end + 1}
    Log Many    ${vacuum_Turbo_list}
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo start of topic ===
    Should Contain    ${vacuum_Turbo_list}    === CCCamera_vacuum_Turbo end of topic ===
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end + 1}
    Log Many    ${vacuum_Cryo_list}
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo start of topic ===
    Should Contain    ${vacuum_Cryo_list}    === CCCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cold2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 start of topic ===
    ${vacuum_Cold2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 end of topic ===
    ${vacuum_Cold2_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_start}    end=${vacuum_Cold2_end + 1}
    Log Many    ${vacuum_Cold2_list}
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 start of topic ===
    Should Contain    ${vacuum_Cold2_list}    === CCCamera_vacuum_Cold2 end of topic ===
    ${vacuum_Rtds_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds start of topic ===
    ${vacuum_Rtds_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds end of topic ===
    ${vacuum_Rtds_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_start}    end=${vacuum_Rtds_end + 1}
    Log Many    ${vacuum_Rtds_list}
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds start of topic ===
    Should Contain    ${vacuum_Rtds_list}    === CCCamera_vacuum_Rtds end of topic ===
    ${vacuum_Cold1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 start of topic ===
    ${vacuum_Cold1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 end of topic ===
    ${vacuum_Cold1_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_start}    end=${vacuum_Cold1_end + 1}
    Log Many    ${vacuum_Cold1_list}
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 start of topic ===
    Should Contain    ${vacuum_Cold1_list}    === CCCamera_vacuum_Cold1 end of topic ===
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end + 1}
    Log Many    ${quadbox_PDU_24VC_list}
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    Should Contain    ${quadbox_PDU_24VC_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end + 1}
    Log Many    ${quadbox_PDU_24VD_list}
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    Should Contain    ${quadbox_PDU_24VD_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end + 1}
    Log Many    ${quadbox_BFR_list}
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR start of topic ===
    Should Contain    ${quadbox_BFR_list}    === CCCamera_quadbox_BFR end of topic ===
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end + 1}
    Log Many    ${quadbox_PDU_5V_list}
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    Should Contain    ${quadbox_PDU_5V_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end + 1}
    Log Many    ${quadbox_PDU_48V_list}
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    Should Contain    ${quadbox_PDU_48V_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === CCCamera_daq_monitor_Store end of topic ===
    ${fp_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Reb start of topic ===
    ${fp_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Reb end of topic ===
    ${fp_Reb_list}=    Get Slice From List    ${full_list}    start=${fp_Reb_start}    end=${fp_Reb_end + 1}
    Log Many    ${fp_Reb_list}
    Should Contain    ${fp_Reb_list}    === CCCamera_fp_Reb start of topic ===
    Should Contain    ${fp_Reb_list}    === CCCamera_fp_Reb end of topic ===
    ${fp_Ccd_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Ccd start of topic ===
    ${fp_Ccd_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Ccd end of topic ===
    ${fp_Ccd_list}=    Get Slice From List    ${full_list}    start=${fp_Ccd_start}    end=${fp_Ccd_end + 1}
    Log Many    ${fp_Ccd_list}
    Should Contain    ${fp_Ccd_list}    === CCCamera_fp_Ccd start of topic ===
    Should Contain    ${fp_Ccd_list}    === CCCamera_fp_Ccd end of topic ===
    ${fp_Segment_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Segment start of topic ===
    ${fp_Segment_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Segment end of topic ===
    ${fp_Segment_list}=    Get Slice From List    ${full_list}    start=${fp_Segment_start}    end=${fp_Segment_end + 1}
    Log Many    ${fp_Segment_list}
    Should Contain    ${fp_Segment_list}    === CCCamera_fp_Segment start of topic ===
    Should Contain    ${fp_Segment_list}    === CCCamera_fp_Segment end of topic ===
    ${fp_RebTotalPower_start}=    Get Index From List    ${full_list}    === CCCamera_fp_RebTotalPower start of topic ===
    ${fp_RebTotalPower_end}=    Get Index From List    ${full_list}    === CCCamera_fp_RebTotalPower end of topic ===
    ${fp_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${fp_RebTotalPower_start}    end=${fp_RebTotalPower_end + 1}
    Log Many    ${fp_RebTotalPower_list}
    Should Contain    ${fp_RebTotalPower_list}    === CCCamera_fp_RebTotalPower start of topic ===
    Should Contain    ${fp_RebTotalPower_list}    === CCCamera_fp_RebTotalPower end of topic ===
