*** Settings ***
Documentation    MTCamera_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot
Force Tags    CAP-933

*** Variables ***
${subSystem}    MTCamera
${component}    all
${timeout}    1500s

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
    ${refrig_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 start of topic ===
    ${refrig_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 end of topic ===
    ${refrig_Cold1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_start}    end=${refrig_Cold1_end + 1}
    Log Many    ${refrig_Cold1_list}
    Should Contain    ${refrig_Cold1_list}    === MTCamera_refrig_Cold1 start of topic ===
    Should Contain    ${refrig_Cold1_list}    === MTCamera_refrig_Cold1 end of topic ===
    Should Contain    ${refrig_Cold1_list}    === [refrig_Cold1] message sent 200
    ${refrig_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 start of topic ===
    ${refrig_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 end of topic ===
    ${refrig_Cold2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_start}    end=${refrig_Cold2_end + 1}
    Log Many    ${refrig_Cold2_list}
    Should Contain    ${refrig_Cold2_list}    === MTCamera_refrig_Cold2 start of topic ===
    Should Contain    ${refrig_Cold2_list}    === MTCamera_refrig_Cold2 end of topic ===
    Should Contain    ${refrig_Cold2_list}    === [refrig_Cold2] message sent 200
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
    ${vacuum_CIP1_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_I start of topic ===
    ${vacuum_CIP1_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_I end of topic ===
    ${vacuum_CIP1_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_I_start}    end=${vacuum_CIP1_I_end + 1}
    Log Many    ${vacuum_CIP1_I_list}
    Should Contain    ${vacuum_CIP1_I_list}    === MTCamera_vacuum_CIP1_I start of topic ===
    Should Contain    ${vacuum_CIP1_I_list}    === MTCamera_vacuum_CIP1_I end of topic ===
    Should Contain    ${vacuum_CIP1_I_list}    === [vacuum_CIP1_I] message sent 200
    ${vacuum_CIP1_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_V start of topic ===
    ${vacuum_CIP1_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_V end of topic ===
    ${vacuum_CIP1_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_V_start}    end=${vacuum_CIP1_V_end + 1}
    Log Many    ${vacuum_CIP1_V_list}
    Should Contain    ${vacuum_CIP1_V_list}    === MTCamera_vacuum_CIP1_V start of topic ===
    Should Contain    ${vacuum_CIP1_V_list}    === MTCamera_vacuum_CIP1_V end of topic ===
    Should Contain    ${vacuum_CIP1_V_list}    === [vacuum_CIP1_V] message sent 200
    ${vacuum_CIP2_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_I start of topic ===
    ${vacuum_CIP2_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_I end of topic ===
    ${vacuum_CIP2_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_I_start}    end=${vacuum_CIP2_I_end + 1}
    Log Many    ${vacuum_CIP2_I_list}
    Should Contain    ${vacuum_CIP2_I_list}    === MTCamera_vacuum_CIP2_I start of topic ===
    Should Contain    ${vacuum_CIP2_I_list}    === MTCamera_vacuum_CIP2_I end of topic ===
    Should Contain    ${vacuum_CIP2_I_list}    === [vacuum_CIP2_I] message sent 200
    ${vacuum_CIP2_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_V start of topic ===
    ${vacuum_CIP2_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_V end of topic ===
    ${vacuum_CIP2_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_V_start}    end=${vacuum_CIP2_V_end + 1}
    Log Many    ${vacuum_CIP2_V_list}
    Should Contain    ${vacuum_CIP2_V_list}    === MTCamera_vacuum_CIP2_V start of topic ===
    Should Contain    ${vacuum_CIP2_V_list}    === MTCamera_vacuum_CIP2_V end of topic ===
    Should Contain    ${vacuum_CIP2_V_list}    === [vacuum_CIP2_V] message sent 200
    ${vacuum_CIP3_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_I start of topic ===
    ${vacuum_CIP3_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_I end of topic ===
    ${vacuum_CIP3_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_I_start}    end=${vacuum_CIP3_I_end + 1}
    Log Many    ${vacuum_CIP3_I_list}
    Should Contain    ${vacuum_CIP3_I_list}    === MTCamera_vacuum_CIP3_I start of topic ===
    Should Contain    ${vacuum_CIP3_I_list}    === MTCamera_vacuum_CIP3_I end of topic ===
    Should Contain    ${vacuum_CIP3_I_list}    === [vacuum_CIP3_I] message sent 200
    ${vacuum_CIP3_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_V start of topic ===
    ${vacuum_CIP3_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_V end of topic ===
    ${vacuum_CIP3_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_V_start}    end=${vacuum_CIP3_V_end + 1}
    Log Many    ${vacuum_CIP3_V_list}
    Should Contain    ${vacuum_CIP3_V_list}    === MTCamera_vacuum_CIP3_V start of topic ===
    Should Contain    ${vacuum_CIP3_V_list}    === MTCamera_vacuum_CIP3_V end of topic ===
    Should Contain    ${vacuum_CIP3_V_list}    === [vacuum_CIP3_V] message sent 200
    ${vacuum_CIP4_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_I start of topic ===
    ${vacuum_CIP4_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_I end of topic ===
    ${vacuum_CIP4_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_I_start}    end=${vacuum_CIP4_I_end + 1}
    Log Many    ${vacuum_CIP4_I_list}
    Should Contain    ${vacuum_CIP4_I_list}    === MTCamera_vacuum_CIP4_I start of topic ===
    Should Contain    ${vacuum_CIP4_I_list}    === MTCamera_vacuum_CIP4_I end of topic ===
    Should Contain    ${vacuum_CIP4_I_list}    === [vacuum_CIP4_I] message sent 200
    ${vacuum_CIP4_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_V start of topic ===
    ${vacuum_CIP4_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_V end of topic ===
    ${vacuum_CIP4_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_V_start}    end=${vacuum_CIP4_V_end + 1}
    Log Many    ${vacuum_CIP4_V_list}
    Should Contain    ${vacuum_CIP4_V_list}    === MTCamera_vacuum_CIP4_V start of topic ===
    Should Contain    ${vacuum_CIP4_V_list}    === MTCamera_vacuum_CIP4_V end of topic ===
    Should Contain    ${vacuum_CIP4_V_list}    === [vacuum_CIP4_V] message sent 200
    ${vacuum_CIP5_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_I start of topic ===
    ${vacuum_CIP5_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_I end of topic ===
    ${vacuum_CIP5_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_I_start}    end=${vacuum_CIP5_I_end + 1}
    Log Many    ${vacuum_CIP5_I_list}
    Should Contain    ${vacuum_CIP5_I_list}    === MTCamera_vacuum_CIP5_I start of topic ===
    Should Contain    ${vacuum_CIP5_I_list}    === MTCamera_vacuum_CIP5_I end of topic ===
    Should Contain    ${vacuum_CIP5_I_list}    === [vacuum_CIP5_I] message sent 200
    ${vacuum_CIP5_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_V start of topic ===
    ${vacuum_CIP5_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_V end of topic ===
    ${vacuum_CIP5_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_V_start}    end=${vacuum_CIP5_V_end + 1}
    Log Many    ${vacuum_CIP5_V_list}
    Should Contain    ${vacuum_CIP5_V_list}    === MTCamera_vacuum_CIP5_V start of topic ===
    Should Contain    ${vacuum_CIP5_V_list}    === MTCamera_vacuum_CIP5_V end of topic ===
    Should Contain    ${vacuum_CIP5_V_list}    === [vacuum_CIP5_V] message sent 200
    ${vacuum_CIP6_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_I start of topic ===
    ${vacuum_CIP6_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_I end of topic ===
    ${vacuum_CIP6_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_I_start}    end=${vacuum_CIP6_I_end + 1}
    Log Many    ${vacuum_CIP6_I_list}
    Should Contain    ${vacuum_CIP6_I_list}    === MTCamera_vacuum_CIP6_I start of topic ===
    Should Contain    ${vacuum_CIP6_I_list}    === MTCamera_vacuum_CIP6_I end of topic ===
    Should Contain    ${vacuum_CIP6_I_list}    === [vacuum_CIP6_I] message sent 200
    ${vacuum_CIP6_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_V start of topic ===
    ${vacuum_CIP6_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_V end of topic ===
    ${vacuum_CIP6_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_V_start}    end=${vacuum_CIP6_V_end + 1}
    Log Many    ${vacuum_CIP6_V_list}
    Should Contain    ${vacuum_CIP6_V_list}    === MTCamera_vacuum_CIP6_V start of topic ===
    Should Contain    ${vacuum_CIP6_V_list}    === MTCamera_vacuum_CIP6_V end of topic ===
    Should Contain    ${vacuum_CIP6_V_list}    === [vacuum_CIP6_V] message sent 200
    ${vacuum_CryoVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVac start of topic ===
    ${vacuum_CryoVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVac end of topic ===
    ${vacuum_CryoVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVac_start}    end=${vacuum_CryoVac_end + 1}
    Log Many    ${vacuum_CryoVac_list}
    Should Contain    ${vacuum_CryoVac_list}    === MTCamera_vacuum_CryoVac start of topic ===
    Should Contain    ${vacuum_CryoVac_list}    === MTCamera_vacuum_CryoVac end of topic ===
    Should Contain    ${vacuum_CryoVac_list}    === [vacuum_CryoVac] message sent 200
    ${vacuum_ForelineVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVac start of topic ===
    ${vacuum_ForelineVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVac end of topic ===
    ${vacuum_ForelineVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVac_start}    end=${vacuum_ForelineVac_end + 1}
    Log Many    ${vacuum_ForelineVac_list}
    Should Contain    ${vacuum_ForelineVac_list}    === MTCamera_vacuum_ForelineVac start of topic ===
    Should Contain    ${vacuum_ForelineVac_list}    === MTCamera_vacuum_ForelineVac end of topic ===
    Should Contain    ${vacuum_ForelineVac_list}    === [vacuum_ForelineVac] message sent 200
    ${vacuum_Hex1Vac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1Vac start of topic ===
    ${vacuum_Hex1Vac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1Vac end of topic ===
    ${vacuum_Hex1Vac_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1Vac_start}    end=${vacuum_Hex1Vac_end + 1}
    Log Many    ${vacuum_Hex1Vac_list}
    Should Contain    ${vacuum_Hex1Vac_list}    === MTCamera_vacuum_Hex1Vac start of topic ===
    Should Contain    ${vacuum_Hex1Vac_list}    === MTCamera_vacuum_Hex1Vac end of topic ===
    Should Contain    ${vacuum_Hex1Vac_list}    === [vacuum_Hex1Vac] message sent 200
    ${vacuum_Hex2Vac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2Vac start of topic ===
    ${vacuum_Hex2Vac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2Vac end of topic ===
    ${vacuum_Hex2Vac_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2Vac_start}    end=${vacuum_Hex2Vac_end + 1}
    Log Many    ${vacuum_Hex2Vac_list}
    Should Contain    ${vacuum_Hex2Vac_list}    === MTCamera_vacuum_Hex2Vac start of topic ===
    Should Contain    ${vacuum_Hex2Vac_list}    === MTCamera_vacuum_Hex2Vac end of topic ===
    Should Contain    ${vacuum_Hex2Vac_list}    === [vacuum_Hex2Vac] message sent 200
    ${vacuum_TurboCurrent_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrent start of topic ===
    ${vacuum_TurboCurrent_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrent end of topic ===
    ${vacuum_TurboCurrent_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrent_start}    end=${vacuum_TurboCurrent_end + 1}
    Log Many    ${vacuum_TurboCurrent_list}
    Should Contain    ${vacuum_TurboCurrent_list}    === MTCamera_vacuum_TurboCurrent start of topic ===
    Should Contain    ${vacuum_TurboCurrent_list}    === MTCamera_vacuum_TurboCurrent end of topic ===
    Should Contain    ${vacuum_TurboCurrent_list}    === [vacuum_TurboCurrent] message sent 200
    ${vacuum_TurboPower_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPower start of topic ===
    ${vacuum_TurboPower_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPower end of topic ===
    ${vacuum_TurboPower_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPower_start}    end=${vacuum_TurboPower_end + 1}
    Log Many    ${vacuum_TurboPower_list}
    Should Contain    ${vacuum_TurboPower_list}    === MTCamera_vacuum_TurboPower start of topic ===
    Should Contain    ${vacuum_TurboPower_list}    === MTCamera_vacuum_TurboPower end of topic ===
    Should Contain    ${vacuum_TurboPower_list}    === [vacuum_TurboPower] message sent 200
    ${vacuum_TurboPumpTemp_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTemp start of topic ===
    ${vacuum_TurboPumpTemp_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTemp end of topic ===
    ${vacuum_TurboPumpTemp_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTemp_start}    end=${vacuum_TurboPumpTemp_end + 1}
    Log Many    ${vacuum_TurboPumpTemp_list}
    Should Contain    ${vacuum_TurboPumpTemp_list}    === MTCamera_vacuum_TurboPumpTemp start of topic ===
    Should Contain    ${vacuum_TurboPumpTemp_list}    === MTCamera_vacuum_TurboPumpTemp end of topic ===
    Should Contain    ${vacuum_TurboPumpTemp_list}    === [vacuum_TurboPumpTemp] message sent 200
    ${vacuum_TurboSpeed_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeed start of topic ===
    ${vacuum_TurboSpeed_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeed end of topic ===
    ${vacuum_TurboSpeed_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeed_start}    end=${vacuum_TurboSpeed_end + 1}
    Log Many    ${vacuum_TurboSpeed_list}
    Should Contain    ${vacuum_TurboSpeed_list}    === MTCamera_vacuum_TurboSpeed start of topic ===
    Should Contain    ${vacuum_TurboSpeed_list}    === MTCamera_vacuum_TurboSpeed end of topic ===
    Should Contain    ${vacuum_TurboSpeed_list}    === [vacuum_TurboSpeed] message sent 200
    ${vacuum_TurboVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVac start of topic ===
    ${vacuum_TurboVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVac end of topic ===
    ${vacuum_TurboVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVac_start}    end=${vacuum_TurboVac_end + 1}
    Log Many    ${vacuum_TurboVac_list}
    Should Contain    ${vacuum_TurboVac_list}    === MTCamera_vacuum_TurboVac start of topic ===
    Should Contain    ${vacuum_TurboVac_list}    === MTCamera_vacuum_TurboVac end of topic ===
    Should Contain    ${vacuum_TurboVac_list}    === [vacuum_TurboVac] message sent 200
    ${vacuum_TurboVoltage_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltage start of topic ===
    ${vacuum_TurboVoltage_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltage end of topic ===
    ${vacuum_TurboVoltage_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltage_start}    end=${vacuum_TurboVoltage_end + 1}
    Log Many    ${vacuum_TurboVoltage_list}
    Should Contain    ${vacuum_TurboVoltage_list}    === MTCamera_vacuum_TurboVoltage start of topic ===
    Should Contain    ${vacuum_TurboVoltage_list}    === MTCamera_vacuum_TurboVoltage end of topic ===
    Should Contain    ${vacuum_TurboVoltage_list}    === [vacuum_TurboVoltage] message sent 200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store end of topic ===
    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store] message sent 200
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
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment end of topic ===
    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment] message sent 200
    ${fcs_start}=    Get Index From List    ${full_list}    === MTCamera_fcs start of topic ===
    ${fcs_end}=    Get Index From List    ${full_list}    === MTCamera_fcs end of topic ===
    ${fcs_list}=    Get Slice From List    ${full_list}    start=${fcs_start}    end=${fcs_end + 1}
    Log Many    ${fcs_list}
    Should Contain    ${fcs_list}    === MTCamera_fcs start of topic ===
    Should Contain    ${fcs_list}    === MTCamera_fcs end of topic ===
    Should Contain    ${fcs_list}    === [fcs] message sent 200

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
    ${refrig_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 start of topic ===
    ${refrig_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 end of topic ===
    ${refrig_Cold1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_start}    end=${refrig_Cold1_end + 1}
    Log Many    ${refrig_Cold1_list}
    Should Contain    ${refrig_Cold1_list}    === MTCamera_refrig_Cold1 start of topic ===
    Should Contain    ${refrig_Cold1_list}    === MTCamera_refrig_Cold1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cold1_list}    === [refrig_Cold1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cold1_list}    === [refrig_Cold1 Subscriber] message received :200
    ${refrig_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 start of topic ===
    ${refrig_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 end of topic ===
    ${refrig_Cold2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_start}    end=${refrig_Cold2_end + 1}
    Log Many    ${refrig_Cold2_list}
    Should Contain    ${refrig_Cold2_list}    === MTCamera_refrig_Cold2 start of topic ===
    Should Contain    ${refrig_Cold2_list}    === MTCamera_refrig_Cold2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cold2_list}    === [refrig_Cold2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${refrig_Cold2_list}    === [refrig_Cold2 Subscriber] message received :200
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
    ${vacuum_CIP1_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_I start of topic ===
    ${vacuum_CIP1_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_I end of topic ===
    ${vacuum_CIP1_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_I_start}    end=${vacuum_CIP1_I_end + 1}
    Log Many    ${vacuum_CIP1_I_list}
    Should Contain    ${vacuum_CIP1_I_list}    === MTCamera_vacuum_CIP1_I start of topic ===
    Should Contain    ${vacuum_CIP1_I_list}    === MTCamera_vacuum_CIP1_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP1_I_list}    === [vacuum_CIP1_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP1_I_list}    === [vacuum_CIP1_I Subscriber] message received :200
    ${vacuum_CIP1_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_V start of topic ===
    ${vacuum_CIP1_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP1_V end of topic ===
    ${vacuum_CIP1_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP1_V_start}    end=${vacuum_CIP1_V_end + 1}
    Log Many    ${vacuum_CIP1_V_list}
    Should Contain    ${vacuum_CIP1_V_list}    === MTCamera_vacuum_CIP1_V start of topic ===
    Should Contain    ${vacuum_CIP1_V_list}    === MTCamera_vacuum_CIP1_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP1_V_list}    === [vacuum_CIP1_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP1_V_list}    === [vacuum_CIP1_V Subscriber] message received :200
    ${vacuum_CIP2_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_I start of topic ===
    ${vacuum_CIP2_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_I end of topic ===
    ${vacuum_CIP2_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_I_start}    end=${vacuum_CIP2_I_end + 1}
    Log Many    ${vacuum_CIP2_I_list}
    Should Contain    ${vacuum_CIP2_I_list}    === MTCamera_vacuum_CIP2_I start of topic ===
    Should Contain    ${vacuum_CIP2_I_list}    === MTCamera_vacuum_CIP2_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP2_I_list}    === [vacuum_CIP2_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP2_I_list}    === [vacuum_CIP2_I Subscriber] message received :200
    ${vacuum_CIP2_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_V start of topic ===
    ${vacuum_CIP2_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP2_V end of topic ===
    ${vacuum_CIP2_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP2_V_start}    end=${vacuum_CIP2_V_end + 1}
    Log Many    ${vacuum_CIP2_V_list}
    Should Contain    ${vacuum_CIP2_V_list}    === MTCamera_vacuum_CIP2_V start of topic ===
    Should Contain    ${vacuum_CIP2_V_list}    === MTCamera_vacuum_CIP2_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP2_V_list}    === [vacuum_CIP2_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP2_V_list}    === [vacuum_CIP2_V Subscriber] message received :200
    ${vacuum_CIP3_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_I start of topic ===
    ${vacuum_CIP3_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_I end of topic ===
    ${vacuum_CIP3_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_I_start}    end=${vacuum_CIP3_I_end + 1}
    Log Many    ${vacuum_CIP3_I_list}
    Should Contain    ${vacuum_CIP3_I_list}    === MTCamera_vacuum_CIP3_I start of topic ===
    Should Contain    ${vacuum_CIP3_I_list}    === MTCamera_vacuum_CIP3_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP3_I_list}    === [vacuum_CIP3_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP3_I_list}    === [vacuum_CIP3_I Subscriber] message received :200
    ${vacuum_CIP3_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_V start of topic ===
    ${vacuum_CIP3_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP3_V end of topic ===
    ${vacuum_CIP3_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP3_V_start}    end=${vacuum_CIP3_V_end + 1}
    Log Many    ${vacuum_CIP3_V_list}
    Should Contain    ${vacuum_CIP3_V_list}    === MTCamera_vacuum_CIP3_V start of topic ===
    Should Contain    ${vacuum_CIP3_V_list}    === MTCamera_vacuum_CIP3_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP3_V_list}    === [vacuum_CIP3_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP3_V_list}    === [vacuum_CIP3_V Subscriber] message received :200
    ${vacuum_CIP4_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_I start of topic ===
    ${vacuum_CIP4_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_I end of topic ===
    ${vacuum_CIP4_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_I_start}    end=${vacuum_CIP4_I_end + 1}
    Log Many    ${vacuum_CIP4_I_list}
    Should Contain    ${vacuum_CIP4_I_list}    === MTCamera_vacuum_CIP4_I start of topic ===
    Should Contain    ${vacuum_CIP4_I_list}    === MTCamera_vacuum_CIP4_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP4_I_list}    === [vacuum_CIP4_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP4_I_list}    === [vacuum_CIP4_I Subscriber] message received :200
    ${vacuum_CIP4_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_V start of topic ===
    ${vacuum_CIP4_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP4_V end of topic ===
    ${vacuum_CIP4_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP4_V_start}    end=${vacuum_CIP4_V_end + 1}
    Log Many    ${vacuum_CIP4_V_list}
    Should Contain    ${vacuum_CIP4_V_list}    === MTCamera_vacuum_CIP4_V start of topic ===
    Should Contain    ${vacuum_CIP4_V_list}    === MTCamera_vacuum_CIP4_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP4_V_list}    === [vacuum_CIP4_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP4_V_list}    === [vacuum_CIP4_V Subscriber] message received :200
    ${vacuum_CIP5_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_I start of topic ===
    ${vacuum_CIP5_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_I end of topic ===
    ${vacuum_CIP5_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_I_start}    end=${vacuum_CIP5_I_end + 1}
    Log Many    ${vacuum_CIP5_I_list}
    Should Contain    ${vacuum_CIP5_I_list}    === MTCamera_vacuum_CIP5_I start of topic ===
    Should Contain    ${vacuum_CIP5_I_list}    === MTCamera_vacuum_CIP5_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP5_I_list}    === [vacuum_CIP5_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP5_I_list}    === [vacuum_CIP5_I Subscriber] message received :200
    ${vacuum_CIP5_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_V start of topic ===
    ${vacuum_CIP5_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP5_V end of topic ===
    ${vacuum_CIP5_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP5_V_start}    end=${vacuum_CIP5_V_end + 1}
    Log Many    ${vacuum_CIP5_V_list}
    Should Contain    ${vacuum_CIP5_V_list}    === MTCamera_vacuum_CIP5_V start of topic ===
    Should Contain    ${vacuum_CIP5_V_list}    === MTCamera_vacuum_CIP5_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP5_V_list}    === [vacuum_CIP5_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP5_V_list}    === [vacuum_CIP5_V Subscriber] message received :200
    ${vacuum_CIP6_I_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_I start of topic ===
    ${vacuum_CIP6_I_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_I end of topic ===
    ${vacuum_CIP6_I_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_I_start}    end=${vacuum_CIP6_I_end + 1}
    Log Many    ${vacuum_CIP6_I_list}
    Should Contain    ${vacuum_CIP6_I_list}    === MTCamera_vacuum_CIP6_I start of topic ===
    Should Contain    ${vacuum_CIP6_I_list}    === MTCamera_vacuum_CIP6_I end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP6_I_list}    === [vacuum_CIP6_I Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP6_I_list}    === [vacuum_CIP6_I Subscriber] message received :200
    ${vacuum_CIP6_V_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_V start of topic ===
    ${vacuum_CIP6_V_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CIP6_V end of topic ===
    ${vacuum_CIP6_V_list}=    Get Slice From List    ${full_list}    start=${vacuum_CIP6_V_start}    end=${vacuum_CIP6_V_end + 1}
    Log Many    ${vacuum_CIP6_V_list}
    Should Contain    ${vacuum_CIP6_V_list}    === MTCamera_vacuum_CIP6_V start of topic ===
    Should Contain    ${vacuum_CIP6_V_list}    === MTCamera_vacuum_CIP6_V end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP6_V_list}    === [vacuum_CIP6_V Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CIP6_V_list}    === [vacuum_CIP6_V Subscriber] message received :200
    ${vacuum_CryoVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVac start of topic ===
    ${vacuum_CryoVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVac end of topic ===
    ${vacuum_CryoVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVac_start}    end=${vacuum_CryoVac_end + 1}
    Log Many    ${vacuum_CryoVac_list}
    Should Contain    ${vacuum_CryoVac_list}    === MTCamera_vacuum_CryoVac start of topic ===
    Should Contain    ${vacuum_CryoVac_list}    === MTCamera_vacuum_CryoVac end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CryoVac_list}    === [vacuum_CryoVac Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_CryoVac_list}    === [vacuum_CryoVac Subscriber] message received :200
    ${vacuum_ForelineVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVac start of topic ===
    ${vacuum_ForelineVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVac end of topic ===
    ${vacuum_ForelineVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVac_start}    end=${vacuum_ForelineVac_end + 1}
    Log Many    ${vacuum_ForelineVac_list}
    Should Contain    ${vacuum_ForelineVac_list}    === MTCamera_vacuum_ForelineVac start of topic ===
    Should Contain    ${vacuum_ForelineVac_list}    === MTCamera_vacuum_ForelineVac end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_ForelineVac_list}    === [vacuum_ForelineVac Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_ForelineVac_list}    === [vacuum_ForelineVac Subscriber] message received :200
    ${vacuum_Hex1Vac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1Vac start of topic ===
    ${vacuum_Hex1Vac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1Vac end of topic ===
    ${vacuum_Hex1Vac_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1Vac_start}    end=${vacuum_Hex1Vac_end + 1}
    Log Many    ${vacuum_Hex1Vac_list}
    Should Contain    ${vacuum_Hex1Vac_list}    === MTCamera_vacuum_Hex1Vac start of topic ===
    Should Contain    ${vacuum_Hex1Vac_list}    === MTCamera_vacuum_Hex1Vac end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hex1Vac_list}    === [vacuum_Hex1Vac Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hex1Vac_list}    === [vacuum_Hex1Vac Subscriber] message received :200
    ${vacuum_Hex2Vac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2Vac start of topic ===
    ${vacuum_Hex2Vac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2Vac end of topic ===
    ${vacuum_Hex2Vac_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2Vac_start}    end=${vacuum_Hex2Vac_end + 1}
    Log Many    ${vacuum_Hex2Vac_list}
    Should Contain    ${vacuum_Hex2Vac_list}    === MTCamera_vacuum_Hex2Vac start of topic ===
    Should Contain    ${vacuum_Hex2Vac_list}    === MTCamera_vacuum_Hex2Vac end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hex2Vac_list}    === [vacuum_Hex2Vac Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_Hex2Vac_list}    === [vacuum_Hex2Vac Subscriber] message received :200
    ${vacuum_TurboCurrent_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrent start of topic ===
    ${vacuum_TurboCurrent_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboCurrent end of topic ===
    ${vacuum_TurboCurrent_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboCurrent_start}    end=${vacuum_TurboCurrent_end + 1}
    Log Many    ${vacuum_TurboCurrent_list}
    Should Contain    ${vacuum_TurboCurrent_list}    === MTCamera_vacuum_TurboCurrent start of topic ===
    Should Contain    ${vacuum_TurboCurrent_list}    === MTCamera_vacuum_TurboCurrent end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboCurrent_list}    === [vacuum_TurboCurrent Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboCurrent_list}    === [vacuum_TurboCurrent Subscriber] message received :200
    ${vacuum_TurboPower_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPower start of topic ===
    ${vacuum_TurboPower_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPower end of topic ===
    ${vacuum_TurboPower_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPower_start}    end=${vacuum_TurboPower_end + 1}
    Log Many    ${vacuum_TurboPower_list}
    Should Contain    ${vacuum_TurboPower_list}    === MTCamera_vacuum_TurboPower start of topic ===
    Should Contain    ${vacuum_TurboPower_list}    === MTCamera_vacuum_TurboPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboPower_list}    === [vacuum_TurboPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboPower_list}    === [vacuum_TurboPower Subscriber] message received :200
    ${vacuum_TurboPumpTemp_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTemp start of topic ===
    ${vacuum_TurboPumpTemp_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPumpTemp end of topic ===
    ${vacuum_TurboPumpTemp_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPumpTemp_start}    end=${vacuum_TurboPumpTemp_end + 1}
    Log Many    ${vacuum_TurboPumpTemp_list}
    Should Contain    ${vacuum_TurboPumpTemp_list}    === MTCamera_vacuum_TurboPumpTemp start of topic ===
    Should Contain    ${vacuum_TurboPumpTemp_list}    === MTCamera_vacuum_TurboPumpTemp end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboPumpTemp_list}    === [vacuum_TurboPumpTemp Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboPumpTemp_list}    === [vacuum_TurboPumpTemp Subscriber] message received :200
    ${vacuum_TurboSpeed_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeed start of topic ===
    ${vacuum_TurboSpeed_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboSpeed end of topic ===
    ${vacuum_TurboSpeed_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboSpeed_start}    end=${vacuum_TurboSpeed_end + 1}
    Log Many    ${vacuum_TurboSpeed_list}
    Should Contain    ${vacuum_TurboSpeed_list}    === MTCamera_vacuum_TurboSpeed start of topic ===
    Should Contain    ${vacuum_TurboSpeed_list}    === MTCamera_vacuum_TurboSpeed end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboSpeed_list}    === [vacuum_TurboSpeed Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboSpeed_list}    === [vacuum_TurboSpeed Subscriber] message received :200
    ${vacuum_TurboVac_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVac start of topic ===
    ${vacuum_TurboVac_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVac end of topic ===
    ${vacuum_TurboVac_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVac_start}    end=${vacuum_TurboVac_end + 1}
    Log Many    ${vacuum_TurboVac_list}
    Should Contain    ${vacuum_TurboVac_list}    === MTCamera_vacuum_TurboVac start of topic ===
    Should Contain    ${vacuum_TurboVac_list}    === MTCamera_vacuum_TurboVac end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboVac_list}    === [vacuum_TurboVac Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboVac_list}    === [vacuum_TurboVac Subscriber] message received :200
    ${vacuum_TurboVoltage_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltage start of topic ===
    ${vacuum_TurboVoltage_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVoltage end of topic ===
    ${vacuum_TurboVoltage_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVoltage_start}    end=${vacuum_TurboVoltage_end + 1}
    Log Many    ${vacuum_TurboVoltage_list}
    Should Contain    ${vacuum_TurboVoltage_list}    === MTCamera_vacuum_TurboVoltage start of topic ===
    Should Contain    ${vacuum_TurboVoltage_list}    === MTCamera_vacuum_TurboVoltage end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboVoltage_list}    === [vacuum_TurboVoltage Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_TurboVoltage_list}    === [vacuum_TurboVoltage Subscriber] message received :200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === MTCamera_daq_monitor_Store end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :200
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
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end + 1}
    Log Many    ${focal_plane_Segment_list}
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment start of topic ===
    Should Contain    ${focal_plane_Segment_list}    === MTCamera_focal_plane_Segment end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Segment_list}    === [focal_plane_Segment Subscriber] message received :200
    ${fcs_start}=    Get Index From List    ${full_list}    === MTCamera_fcs start of topic ===
    ${fcs_end}=    Get Index From List    ${full_list}    === MTCamera_fcs end of topic ===
    ${fcs_list}=    Get Slice From List    ${full_list}    start=${fcs_start}    end=${fcs_end + 1}
    Log Many    ${fcs_list}
    Should Contain    ${fcs_list}    === MTCamera_fcs start of topic ===
    Should Contain    ${fcs_list}    === MTCamera_fcs end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_list}    === [fcs Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_list}    === [fcs Subscriber] message received :200
