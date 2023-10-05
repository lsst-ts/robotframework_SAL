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
    ${fcs_AcSensorsGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcSensorsGateway start of topic ===
    ${fcs_AcSensorsGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcSensorsGateway end of topic ===
    ${fcs_AcSensorsGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_AcSensorsGateway_start}    end=${fcs_AcSensorsGateway_end + 1}
    Log Many    ${fcs_AcSensorsGateway_list}
    Should Contain    ${fcs_AcSensorsGateway_list}    === MTCamera_fcs_AcSensorsGateway start of topic ===
    Should Contain    ${fcs_AcSensorsGateway_list}    === MTCamera_fcs_AcSensorsGateway end of topic ===
    Should Contain    ${fcs_AcSensorsGateway_list}    === [fcs_AcSensorsGateway] message sent 200
    ${fcs_AcTruckXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminus start of topic ===
    ${fcs_AcTruckXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminus end of topic ===
    ${fcs_AcTruckXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXminus_start}    end=${fcs_AcTruckXminus_end + 1}
    Log Many    ${fcs_AcTruckXminus_list}
    Should Contain    ${fcs_AcTruckXminus_list}    === MTCamera_fcs_AcTruckXminus start of topic ===
    Should Contain    ${fcs_AcTruckXminus_list}    === MTCamera_fcs_AcTruckXminus end of topic ===
    Should Contain    ${fcs_AcTruckXminus_list}    === [fcs_AcTruckXminus] message sent 200
    ${fcs_AcTruckXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminusController start of topic ===
    ${fcs_AcTruckXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminusController end of topic ===
    ${fcs_AcTruckXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXminusController_start}    end=${fcs_AcTruckXminusController_end + 1}
    Log Many    ${fcs_AcTruckXminusController_list}
    Should Contain    ${fcs_AcTruckXminusController_list}    === MTCamera_fcs_AcTruckXminusController start of topic ===
    Should Contain    ${fcs_AcTruckXminusController_list}    === MTCamera_fcs_AcTruckXminusController end of topic ===
    Should Contain    ${fcs_AcTruckXminusController_list}    === [fcs_AcTruckXminusController] message sent 200
    ${fcs_AcTruckXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplus start of topic ===
    ${fcs_AcTruckXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplus end of topic ===
    ${fcs_AcTruckXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXplus_start}    end=${fcs_AcTruckXplus_end + 1}
    Log Many    ${fcs_AcTruckXplus_list}
    Should Contain    ${fcs_AcTruckXplus_list}    === MTCamera_fcs_AcTruckXplus start of topic ===
    Should Contain    ${fcs_AcTruckXplus_list}    === MTCamera_fcs_AcTruckXplus end of topic ===
    Should Contain    ${fcs_AcTruckXplus_list}    === [fcs_AcTruckXplus] message sent 200
    ${fcs_AcTruckXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplusController start of topic ===
    ${fcs_AcTruckXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplusController end of topic ===
    ${fcs_AcTruckXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXplusController_start}    end=${fcs_AcTruckXplusController_end + 1}
    Log Many    ${fcs_AcTruckXplusController_list}
    Should Contain    ${fcs_AcTruckXplusController_list}    === MTCamera_fcs_AcTruckXplusController start of topic ===
    Should Contain    ${fcs_AcTruckXplusController_list}    === MTCamera_fcs_AcTruckXplusController end of topic ===
    Should Contain    ${fcs_AcTruckXplusController_list}    === [fcs_AcTruckXplusController] message sent 200
    ${fcs_Accelerobf_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Accelerobf start of topic ===
    ${fcs_Accelerobf_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Accelerobf end of topic ===
    ${fcs_Accelerobf_list}=    Get Slice From List    ${full_list}    start=${fcs_Accelerobf_start}    end=${fcs_Accelerobf_end + 1}
    Log Many    ${fcs_Accelerobf_list}
    Should Contain    ${fcs_Accelerobf_list}    === MTCamera_fcs_Accelerobf start of topic ===
    Should Contain    ${fcs_Accelerobf_list}    === MTCamera_fcs_Accelerobf end of topic ===
    Should Contain    ${fcs_Accelerobf_list}    === [fcs_Accelerobf] message sent 200
    ${fcs_Ai814_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Ai814 start of topic ===
    ${fcs_Ai814_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Ai814 end of topic ===
    ${fcs_Ai814_list}=    Get Slice From List    ${full_list}    start=${fcs_Ai814_start}    end=${fcs_Ai814_end + 1}
    Log Many    ${fcs_Ai814_list}
    Should Contain    ${fcs_Ai814_list}    === MTCamera_fcs_Ai814 start of topic ===
    Should Contain    ${fcs_Ai814_list}    === MTCamera_fcs_Ai814 end of topic ===
    Should Contain    ${fcs_Ai814_list}    === [fcs_Ai814] message sent 200
    ${fcs_Autochanger_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger start of topic ===
    ${fcs_Autochanger_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger end of topic ===
    ${fcs_Autochanger_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_start}    end=${fcs_Autochanger_end + 1}
    Log Many    ${fcs_Autochanger_list}
    Should Contain    ${fcs_Autochanger_list}    === MTCamera_fcs_Autochanger start of topic ===
    Should Contain    ${fcs_Autochanger_list}    === MTCamera_fcs_Autochanger end of topic ===
    Should Contain    ${fcs_Autochanger_list}    === [fcs_Autochanger] message sent 200
    ${fcs_AutochangerTrucks_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AutochangerTrucks start of topic ===
    ${fcs_AutochangerTrucks_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AutochangerTrucks end of topic ===
    ${fcs_AutochangerTrucks_list}=    Get Slice From List    ${full_list}    start=${fcs_AutochangerTrucks_start}    end=${fcs_AutochangerTrucks_end + 1}
    Log Many    ${fcs_AutochangerTrucks_list}
    Should Contain    ${fcs_AutochangerTrucks_list}    === MTCamera_fcs_AutochangerTrucks start of topic ===
    Should Contain    ${fcs_AutochangerTrucks_list}    === MTCamera_fcs_AutochangerTrucks end of topic ===
    Should Contain    ${fcs_AutochangerTrucks_list}    === [fcs_AutochangerTrucks] message sent 200
    ${fcs_BrakeSystemGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_BrakeSystemGateway start of topic ===
    ${fcs_BrakeSystemGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_BrakeSystemGateway end of topic ===
    ${fcs_BrakeSystemGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_BrakeSystemGateway_start}    end=${fcs_BrakeSystemGateway_end + 1}
    Log Many    ${fcs_BrakeSystemGateway_list}
    Should Contain    ${fcs_BrakeSystemGateway_list}    === MTCamera_fcs_BrakeSystemGateway start of topic ===
    Should Contain    ${fcs_BrakeSystemGateway_list}    === MTCamera_fcs_BrakeSystemGateway end of topic ===
    Should Contain    ${fcs_BrakeSystemGateway_list}    === [fcs_BrakeSystemGateway] message sent 200
    ${fcs_Carousel_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel start of topic ===
    ${fcs_Carousel_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel end of topic ===
    ${fcs_Carousel_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_start}    end=${fcs_Carousel_end + 1}
    Log Many    ${fcs_Carousel_list}
    Should Contain    ${fcs_Carousel_list}    === MTCamera_fcs_Carousel start of topic ===
    Should Contain    ${fcs_Carousel_list}    === MTCamera_fcs_Carousel end of topic ===
    Should Contain    ${fcs_Carousel_list}    === [fcs_Carousel] message sent 200
    ${fcs_CarouselController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarouselController start of topic ===
    ${fcs_CarouselController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarouselController end of topic ===
    ${fcs_CarouselController_list}=    Get Slice From List    ${full_list}    start=${fcs_CarouselController_start}    end=${fcs_CarouselController_end + 1}
    Log Many    ${fcs_CarouselController_list}
    Should Contain    ${fcs_CarouselController_list}    === MTCamera_fcs_CarouselController start of topic ===
    Should Contain    ${fcs_CarouselController_list}    === MTCamera_fcs_CarouselController end of topic ===
    Should Contain    ${fcs_CarouselController_list}    === [fcs_CarouselController] message sent 200
    ${fcs_Carrier_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carrier start of topic ===
    ${fcs_Carrier_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carrier end of topic ===
    ${fcs_Carrier_list}=    Get Slice From List    ${full_list}    start=${fcs_Carrier_start}    end=${fcs_Carrier_end + 1}
    Log Many    ${fcs_Carrier_list}
    Should Contain    ${fcs_Carrier_list}    === MTCamera_fcs_Carrier start of topic ===
    Should Contain    ${fcs_Carrier_list}    === MTCamera_fcs_Carrier end of topic ===
    Should Contain    ${fcs_Carrier_list}    === [fcs_Carrier] message sent 200
    ${fcs_CarrierController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarrierController start of topic ===
    ${fcs_CarrierController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarrierController end of topic ===
    ${fcs_CarrierController_list}=    Get Slice From List    ${full_list}    start=${fcs_CarrierController_start}    end=${fcs_CarrierController_end + 1}
    Log Many    ${fcs_CarrierController_list}
    Should Contain    ${fcs_CarrierController_list}    === MTCamera_fcs_CarrierController start of topic ===
    Should Contain    ${fcs_CarrierController_list}    === MTCamera_fcs_CarrierController end of topic ===
    Should Contain    ${fcs_CarrierController_list}    === [fcs_CarrierController] message sent 200
    ${fcs_CcsVersions_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CcsVersions start of topic ===
    ${fcs_CcsVersions_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CcsVersions end of topic ===
    ${fcs_CcsVersions_list}=    Get Slice From List    ${full_list}    start=${fcs_CcsVersions_start}    end=${fcs_CcsVersions_end + 1}
    Log Many    ${fcs_CcsVersions_list}
    Should Contain    ${fcs_CcsVersions_list}    === MTCamera_fcs_CcsVersions start of topic ===
    Should Contain    ${fcs_CcsVersions_list}    === MTCamera_fcs_CcsVersions end of topic ===
    Should Contain    ${fcs_CcsVersions_list}    === [fcs_CcsVersions] message sent 200
    ${fcs_ClampXminus1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus1 start of topic ===
    ${fcs_ClampXminus1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus1 end of topic ===
    ${fcs_ClampXminus1_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus1_start}    end=${fcs_ClampXminus1_end + 1}
    Log Many    ${fcs_ClampXminus1_list}
    Should Contain    ${fcs_ClampXminus1_list}    === MTCamera_fcs_ClampXminus1 start of topic ===
    Should Contain    ${fcs_ClampXminus1_list}    === MTCamera_fcs_ClampXminus1 end of topic ===
    Should Contain    ${fcs_ClampXminus1_list}    === [fcs_ClampXminus1] message sent 200
    ${fcs_ClampXminus2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus2 start of topic ===
    ${fcs_ClampXminus2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus2 end of topic ===
    ${fcs_ClampXminus2_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus2_start}    end=${fcs_ClampXminus2_end + 1}
    Log Many    ${fcs_ClampXminus2_list}
    Should Contain    ${fcs_ClampXminus2_list}    === MTCamera_fcs_ClampXminus2 start of topic ===
    Should Contain    ${fcs_ClampXminus2_list}    === MTCamera_fcs_ClampXminus2 end of topic ===
    Should Contain    ${fcs_ClampXminus2_list}    === [fcs_ClampXminus2] message sent 200
    ${fcs_ClampXminus3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus3 start of topic ===
    ${fcs_ClampXminus3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus3 end of topic ===
    ${fcs_ClampXminus3_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus3_start}    end=${fcs_ClampXminus3_end + 1}
    Log Many    ${fcs_ClampXminus3_list}
    Should Contain    ${fcs_ClampXminus3_list}    === MTCamera_fcs_ClampXminus3 start of topic ===
    Should Contain    ${fcs_ClampXminus3_list}    === MTCamera_fcs_ClampXminus3 end of topic ===
    Should Contain    ${fcs_ClampXminus3_list}    === [fcs_ClampXminus3] message sent 200
    ${fcs_ClampXminus4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus4 start of topic ===
    ${fcs_ClampXminus4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus4 end of topic ===
    ${fcs_ClampXminus4_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus4_start}    end=${fcs_ClampXminus4_end + 1}
    Log Many    ${fcs_ClampXminus4_list}
    Should Contain    ${fcs_ClampXminus4_list}    === MTCamera_fcs_ClampXminus4 start of topic ===
    Should Contain    ${fcs_ClampXminus4_list}    === MTCamera_fcs_ClampXminus4 end of topic ===
    Should Contain    ${fcs_ClampXminus4_list}    === [fcs_ClampXminus4] message sent 200
    ${fcs_ClampXminus5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus5 start of topic ===
    ${fcs_ClampXminus5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus5 end of topic ===
    ${fcs_ClampXminus5_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus5_start}    end=${fcs_ClampXminus5_end + 1}
    Log Many    ${fcs_ClampXminus5_list}
    Should Contain    ${fcs_ClampXminus5_list}    === MTCamera_fcs_ClampXminus5 start of topic ===
    Should Contain    ${fcs_ClampXminus5_list}    === MTCamera_fcs_ClampXminus5 end of topic ===
    Should Contain    ${fcs_ClampXminus5_list}    === [fcs_ClampXminus5] message sent 200
    ${fcs_ClampXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminusController start of topic ===
    ${fcs_ClampXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminusController end of topic ===
    ${fcs_ClampXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminusController_start}    end=${fcs_ClampXminusController_end + 1}
    Log Many    ${fcs_ClampXminusController_list}
    Should Contain    ${fcs_ClampXminusController_list}    === MTCamera_fcs_ClampXminusController start of topic ===
    Should Contain    ${fcs_ClampXminusController_list}    === MTCamera_fcs_ClampXminusController end of topic ===
    Should Contain    ${fcs_ClampXminusController_list}    === [fcs_ClampXminusController] message sent 200
    ${fcs_ClampXplus1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus1 start of topic ===
    ${fcs_ClampXplus1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus1 end of topic ===
    ${fcs_ClampXplus1_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus1_start}    end=${fcs_ClampXplus1_end + 1}
    Log Many    ${fcs_ClampXplus1_list}
    Should Contain    ${fcs_ClampXplus1_list}    === MTCamera_fcs_ClampXplus1 start of topic ===
    Should Contain    ${fcs_ClampXplus1_list}    === MTCamera_fcs_ClampXplus1 end of topic ===
    Should Contain    ${fcs_ClampXplus1_list}    === [fcs_ClampXplus1] message sent 200
    ${fcs_ClampXplus2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus2 start of topic ===
    ${fcs_ClampXplus2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus2 end of topic ===
    ${fcs_ClampXplus2_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus2_start}    end=${fcs_ClampXplus2_end + 1}
    Log Many    ${fcs_ClampXplus2_list}
    Should Contain    ${fcs_ClampXplus2_list}    === MTCamera_fcs_ClampXplus2 start of topic ===
    Should Contain    ${fcs_ClampXplus2_list}    === MTCamera_fcs_ClampXplus2 end of topic ===
    Should Contain    ${fcs_ClampXplus2_list}    === [fcs_ClampXplus2] message sent 200
    ${fcs_ClampXplus3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus3 start of topic ===
    ${fcs_ClampXplus3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus3 end of topic ===
    ${fcs_ClampXplus3_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus3_start}    end=${fcs_ClampXplus3_end + 1}
    Log Many    ${fcs_ClampXplus3_list}
    Should Contain    ${fcs_ClampXplus3_list}    === MTCamera_fcs_ClampXplus3 start of topic ===
    Should Contain    ${fcs_ClampXplus3_list}    === MTCamera_fcs_ClampXplus3 end of topic ===
    Should Contain    ${fcs_ClampXplus3_list}    === [fcs_ClampXplus3] message sent 200
    ${fcs_ClampXplus4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus4 start of topic ===
    ${fcs_ClampXplus4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus4 end of topic ===
    ${fcs_ClampXplus4_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus4_start}    end=${fcs_ClampXplus4_end + 1}
    Log Many    ${fcs_ClampXplus4_list}
    Should Contain    ${fcs_ClampXplus4_list}    === MTCamera_fcs_ClampXplus4 start of topic ===
    Should Contain    ${fcs_ClampXplus4_list}    === MTCamera_fcs_ClampXplus4 end of topic ===
    Should Contain    ${fcs_ClampXplus4_list}    === [fcs_ClampXplus4] message sent 200
    ${fcs_ClampXplus5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus5 start of topic ===
    ${fcs_ClampXplus5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus5 end of topic ===
    ${fcs_ClampXplus5_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus5_start}    end=${fcs_ClampXplus5_end + 1}
    Log Many    ${fcs_ClampXplus5_list}
    Should Contain    ${fcs_ClampXplus5_list}    === MTCamera_fcs_ClampXplus5 start of topic ===
    Should Contain    ${fcs_ClampXplus5_list}    === MTCamera_fcs_ClampXplus5 end of topic ===
    Should Contain    ${fcs_ClampXplus5_list}    === [fcs_ClampXplus5] message sent 200
    ${fcs_ClampXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplusController start of topic ===
    ${fcs_ClampXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplusController end of topic ===
    ${fcs_ClampXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplusController_start}    end=${fcs_ClampXplusController_end + 1}
    Log Many    ${fcs_ClampXplusController_list}
    Should Contain    ${fcs_ClampXplusController_list}    === MTCamera_fcs_ClampXplusController start of topic ===
    Should Contain    ${fcs_ClampXplusController_list}    === MTCamera_fcs_ClampXplusController end of topic ===
    Should Contain    ${fcs_ClampXplusController_list}    === [fcs_ClampXplusController] message sent 200
    ${fcs_Config_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Config start of topic ===
    ${fcs_Config_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Config end of topic ===
    ${fcs_Config_list}=    Get Slice From List    ${full_list}    start=${fcs_Config_start}    end=${fcs_Config_end + 1}
    Log Many    ${fcs_Config_list}
    Should Contain    ${fcs_Config_list}    === MTCamera_fcs_Config start of topic ===
    Should Contain    ${fcs_Config_list}    === MTCamera_fcs_Config end of topic ===
    Should Contain    ${fcs_Config_list}    === [fcs_Config] message sent 200
    ${fcs_Hooks_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hooks start of topic ===
    ${fcs_Hooks_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hooks end of topic ===
    ${fcs_Hooks_list}=    Get Slice From List    ${full_list}    start=${fcs_Hooks_start}    end=${fcs_Hooks_end + 1}
    Log Many    ${fcs_Hooks_list}
    Should Contain    ${fcs_Hooks_list}    === MTCamera_fcs_Hooks start of topic ===
    Should Contain    ${fcs_Hooks_list}    === MTCamera_fcs_Hooks end of topic ===
    Should Contain    ${fcs_Hooks_list}    === [fcs_Hooks] message sent 200
    ${fcs_HooksController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_HooksController start of topic ===
    ${fcs_HooksController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_HooksController end of topic ===
    ${fcs_HooksController_list}=    Get Slice From List    ${full_list}    start=${fcs_HooksController_start}    end=${fcs_HooksController_end + 1}
    Log Many    ${fcs_HooksController_list}
    Should Contain    ${fcs_HooksController_list}    === MTCamera_fcs_HooksController start of topic ===
    Should Contain    ${fcs_HooksController_list}    === MTCamera_fcs_HooksController end of topic ===
    Should Contain    ${fcs_HooksController_list}    === [fcs_HooksController] message sent 200
    ${fcs_Hyttc580_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hyttc580 start of topic ===
    ${fcs_Hyttc580_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hyttc580 end of topic ===
    ${fcs_Hyttc580_list}=    Get Slice From List    ${full_list}    start=${fcs_Hyttc580_start}    end=${fcs_Hyttc580_end + 1}
    Log Many    ${fcs_Hyttc580_list}
    Should Contain    ${fcs_Hyttc580_list}    === MTCamera_fcs_Hyttc580 start of topic ===
    Should Contain    ${fcs_Hyttc580_list}    === MTCamera_fcs_Hyttc580 end of topic ===
    Should Contain    ${fcs_Hyttc580_list}    === [fcs_Hyttc580] message sent 200
    ${fcs_LatchXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminus start of topic ===
    ${fcs_LatchXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminus end of topic ===
    ${fcs_LatchXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXminus_start}    end=${fcs_LatchXminus_end + 1}
    Log Many    ${fcs_LatchXminus_list}
    Should Contain    ${fcs_LatchXminus_list}    === MTCamera_fcs_LatchXminus start of topic ===
    Should Contain    ${fcs_LatchXminus_list}    === MTCamera_fcs_LatchXminus end of topic ===
    Should Contain    ${fcs_LatchXminus_list}    === [fcs_LatchXminus] message sent 200
    ${fcs_LatchXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminusController start of topic ===
    ${fcs_LatchXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminusController end of topic ===
    ${fcs_LatchXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXminusController_start}    end=${fcs_LatchXminusController_end + 1}
    Log Many    ${fcs_LatchXminusController_list}
    Should Contain    ${fcs_LatchXminusController_list}    === MTCamera_fcs_LatchXminusController start of topic ===
    Should Contain    ${fcs_LatchXminusController_list}    === MTCamera_fcs_LatchXminusController end of topic ===
    Should Contain    ${fcs_LatchXminusController_list}    === [fcs_LatchXminusController] message sent 200
    ${fcs_LatchXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplus start of topic ===
    ${fcs_LatchXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplus end of topic ===
    ${fcs_LatchXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXplus_start}    end=${fcs_LatchXplus_end + 1}
    Log Many    ${fcs_LatchXplus_list}
    Should Contain    ${fcs_LatchXplus_list}    === MTCamera_fcs_LatchXplus start of topic ===
    Should Contain    ${fcs_LatchXplus_list}    === MTCamera_fcs_LatchXplus end of topic ===
    Should Contain    ${fcs_LatchXplus_list}    === [fcs_LatchXplus] message sent 200
    ${fcs_LatchXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplusController start of topic ===
    ${fcs_LatchXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplusController end of topic ===
    ${fcs_LatchXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXplusController_start}    end=${fcs_LatchXplusController_end + 1}
    Log Many    ${fcs_LatchXplusController_list}
    Should Contain    ${fcs_LatchXplusController_list}    === MTCamera_fcs_LatchXplusController start of topic ===
    Should Contain    ${fcs_LatchXplusController_list}    === MTCamera_fcs_LatchXplusController end of topic ===
    Should Contain    ${fcs_LatchXplusController_list}    === [fcs_LatchXplusController] message sent 200
    ${fcs_Latches_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Latches start of topic ===
    ${fcs_Latches_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Latches end of topic ===
    ${fcs_Latches_list}=    Get Slice From List    ${full_list}    start=${fcs_Latches_start}    end=${fcs_Latches_end + 1}
    Log Many    ${fcs_Latches_list}
    Should Contain    ${fcs_Latches_list}    === MTCamera_fcs_Latches start of topic ===
    Should Contain    ${fcs_Latches_list}    === MTCamera_fcs_Latches end of topic ===
    Should Contain    ${fcs_Latches_list}    === [fcs_Latches] message sent 200
    ${fcs_Loader_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader start of topic ===
    ${fcs_Loader_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader end of topic ===
    ${fcs_Loader_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_start}    end=${fcs_Loader_end + 1}
    Log Many    ${fcs_Loader_list}
    Should Contain    ${fcs_Loader_list}    === MTCamera_fcs_Loader start of topic ===
    Should Contain    ${fcs_Loader_list}    === MTCamera_fcs_Loader end of topic ===
    Should Contain    ${fcs_Loader_list}    === [fcs_Loader] message sent 200
    ${fcs_LoaderPlutoGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LoaderPlutoGateway start of topic ===
    ${fcs_LoaderPlutoGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LoaderPlutoGateway end of topic ===
    ${fcs_LoaderPlutoGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_LoaderPlutoGateway_start}    end=${fcs_LoaderPlutoGateway_end + 1}
    Log Many    ${fcs_LoaderPlutoGateway_list}
    Should Contain    ${fcs_LoaderPlutoGateway_list}    === MTCamera_fcs_LoaderPlutoGateway start of topic ===
    Should Contain    ${fcs_LoaderPlutoGateway_list}    === MTCamera_fcs_LoaderPlutoGateway end of topic ===
    Should Contain    ${fcs_LoaderPlutoGateway_list}    === [fcs_LoaderPlutoGateway] message sent 200
    ${fcs_OnlineClampXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminus start of topic ===
    ${fcs_OnlineClampXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminus end of topic ===
    ${fcs_OnlineClampXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXminus_start}    end=${fcs_OnlineClampXminus_end + 1}
    Log Many    ${fcs_OnlineClampXminus_list}
    Should Contain    ${fcs_OnlineClampXminus_list}    === MTCamera_fcs_OnlineClampXminus start of topic ===
    Should Contain    ${fcs_OnlineClampXminus_list}    === MTCamera_fcs_OnlineClampXminus end of topic ===
    Should Contain    ${fcs_OnlineClampXminus_list}    === [fcs_OnlineClampXminus] message sent 200
    ${fcs_OnlineClampXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminusController start of topic ===
    ${fcs_OnlineClampXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminusController end of topic ===
    ${fcs_OnlineClampXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXminusController_start}    end=${fcs_OnlineClampXminusController_end + 1}
    Log Many    ${fcs_OnlineClampXminusController_list}
    Should Contain    ${fcs_OnlineClampXminusController_list}    === MTCamera_fcs_OnlineClampXminusController start of topic ===
    Should Contain    ${fcs_OnlineClampXminusController_list}    === MTCamera_fcs_OnlineClampXminusController end of topic ===
    Should Contain    ${fcs_OnlineClampXminusController_list}    === [fcs_OnlineClampXminusController] message sent 200
    ${fcs_OnlineClampXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplus start of topic ===
    ${fcs_OnlineClampXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplus end of topic ===
    ${fcs_OnlineClampXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXplus_start}    end=${fcs_OnlineClampXplus_end + 1}
    Log Many    ${fcs_OnlineClampXplus_list}
    Should Contain    ${fcs_OnlineClampXplus_list}    === MTCamera_fcs_OnlineClampXplus start of topic ===
    Should Contain    ${fcs_OnlineClampXplus_list}    === MTCamera_fcs_OnlineClampXplus end of topic ===
    Should Contain    ${fcs_OnlineClampXplus_list}    === [fcs_OnlineClampXplus] message sent 200
    ${fcs_OnlineClampXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplusController start of topic ===
    ${fcs_OnlineClampXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplusController end of topic ===
    ${fcs_OnlineClampXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXplusController_start}    end=${fcs_OnlineClampXplusController_end + 1}
    Log Many    ${fcs_OnlineClampXplusController_list}
    Should Contain    ${fcs_OnlineClampXplusController_list}    === MTCamera_fcs_OnlineClampXplusController start of topic ===
    Should Contain    ${fcs_OnlineClampXplusController_list}    === MTCamera_fcs_OnlineClampXplusController end of topic ===
    Should Contain    ${fcs_OnlineClampXplusController_list}    === [fcs_OnlineClampXplusController] message sent 200
    ${fcs_OnlineClampYminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminus start of topic ===
    ${fcs_OnlineClampYminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminus end of topic ===
    ${fcs_OnlineClampYminus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampYminus_start}    end=${fcs_OnlineClampYminus_end + 1}
    Log Many    ${fcs_OnlineClampYminus_list}
    Should Contain    ${fcs_OnlineClampYminus_list}    === MTCamera_fcs_OnlineClampYminus start of topic ===
    Should Contain    ${fcs_OnlineClampYminus_list}    === MTCamera_fcs_OnlineClampYminus end of topic ===
    Should Contain    ${fcs_OnlineClampYminus_list}    === [fcs_OnlineClampYminus] message sent 200
    ${fcs_OnlineClampYminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminusController start of topic ===
    ${fcs_OnlineClampYminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminusController end of topic ===
    ${fcs_OnlineClampYminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampYminusController_start}    end=${fcs_OnlineClampYminusController_end + 1}
    Log Many    ${fcs_OnlineClampYminusController_list}
    Should Contain    ${fcs_OnlineClampYminusController_list}    === MTCamera_fcs_OnlineClampYminusController start of topic ===
    Should Contain    ${fcs_OnlineClampYminusController_list}    === MTCamera_fcs_OnlineClampYminusController end of topic ===
    Should Contain    ${fcs_OnlineClampYminusController_list}    === [fcs_OnlineClampYminusController] message sent 200
    ${fcs_OnlineClamps_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClamps start of topic ===
    ${fcs_OnlineClamps_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClamps end of topic ===
    ${fcs_OnlineClamps_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClamps_start}    end=${fcs_OnlineClamps_end + 1}
    Log Many    ${fcs_OnlineClamps_list}
    Should Contain    ${fcs_OnlineClamps_list}    === MTCamera_fcs_OnlineClamps start of topic ===
    Should Contain    ${fcs_OnlineClamps_list}    === MTCamera_fcs_OnlineClamps end of topic ===
    Should Contain    ${fcs_OnlineClamps_list}    === [fcs_OnlineClamps] message sent 200
    ${fcs_OnlineStrainGauge_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineStrainGauge start of topic ===
    ${fcs_OnlineStrainGauge_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineStrainGauge end of topic ===
    ${fcs_OnlineStrainGauge_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineStrainGauge_start}    end=${fcs_OnlineStrainGauge_end + 1}
    Log Many    ${fcs_OnlineStrainGauge_list}
    Should Contain    ${fcs_OnlineStrainGauge_list}    === MTCamera_fcs_OnlineStrainGauge start of topic ===
    Should Contain    ${fcs_OnlineStrainGauge_list}    === MTCamera_fcs_OnlineStrainGauge end of topic ===
    Should Contain    ${fcs_OnlineStrainGauge_list}    === [fcs_OnlineStrainGauge] message sent 200
    ${fcs_ProximitySensorsDevice_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ProximitySensorsDevice start of topic ===
    ${fcs_ProximitySensorsDevice_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ProximitySensorsDevice end of topic ===
    ${fcs_ProximitySensorsDevice_list}=    Get Slice From List    ${full_list}    start=${fcs_ProximitySensorsDevice_start}    end=${fcs_ProximitySensorsDevice_end + 1}
    Log Many    ${fcs_ProximitySensorsDevice_list}
    Should Contain    ${fcs_ProximitySensorsDevice_list}    === MTCamera_fcs_ProximitySensorsDevice start of topic ===
    Should Contain    ${fcs_ProximitySensorsDevice_list}    === MTCamera_fcs_ProximitySensorsDevice end of topic ===
    Should Contain    ${fcs_ProximitySensorsDevice_list}    === [fcs_ProximitySensorsDevice] message sent 200
    ${fcs_Pt100_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Pt100 start of topic ===
    ${fcs_Pt100_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Pt100 end of topic ===
    ${fcs_Pt100_list}=    Get Slice From List    ${full_list}    start=${fcs_Pt100_start}    end=${fcs_Pt100_end + 1}
    Log Many    ${fcs_Pt100_list}
    Should Contain    ${fcs_Pt100_list}    === MTCamera_fcs_Pt100 start of topic ===
    Should Contain    ${fcs_Pt100_list}    === MTCamera_fcs_Pt100 end of topic ===
    Should Contain    ${fcs_Pt100_list}    === [fcs_Pt100] message sent 200
    ${fcs_RuntimeInfo_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_RuntimeInfo start of topic ===
    ${fcs_RuntimeInfo_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_RuntimeInfo end of topic ===
    ${fcs_RuntimeInfo_list}=    Get Slice From List    ${full_list}    start=${fcs_RuntimeInfo_start}    end=${fcs_RuntimeInfo_end + 1}
    Log Many    ${fcs_RuntimeInfo_list}
    Should Contain    ${fcs_RuntimeInfo_list}    === MTCamera_fcs_RuntimeInfo start of topic ===
    Should Contain    ${fcs_RuntimeInfo_list}    === MTCamera_fcs_RuntimeInfo end of topic ===
    Should Contain    ${fcs_RuntimeInfo_list}    === [fcs_RuntimeInfo] message sent 200
    ${fcs_Socket1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket1 start of topic ===
    ${fcs_Socket1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket1 end of topic ===
    ${fcs_Socket1_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket1_start}    end=${fcs_Socket1_end + 1}
    Log Many    ${fcs_Socket1_list}
    Should Contain    ${fcs_Socket1_list}    === MTCamera_fcs_Socket1 start of topic ===
    Should Contain    ${fcs_Socket1_list}    === MTCamera_fcs_Socket1 end of topic ===
    Should Contain    ${fcs_Socket1_list}    === [fcs_Socket1] message sent 200
    ${fcs_Socket2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket2 start of topic ===
    ${fcs_Socket2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket2 end of topic ===
    ${fcs_Socket2_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket2_start}    end=${fcs_Socket2_end + 1}
    Log Many    ${fcs_Socket2_list}
    Should Contain    ${fcs_Socket2_list}    === MTCamera_fcs_Socket2 start of topic ===
    Should Contain    ${fcs_Socket2_list}    === MTCamera_fcs_Socket2 end of topic ===
    Should Contain    ${fcs_Socket2_list}    === [fcs_Socket2] message sent 200
    ${fcs_Socket3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket3 start of topic ===
    ${fcs_Socket3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket3 end of topic ===
    ${fcs_Socket3_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket3_start}    end=${fcs_Socket3_end + 1}
    Log Many    ${fcs_Socket3_list}
    Should Contain    ${fcs_Socket3_list}    === MTCamera_fcs_Socket3 start of topic ===
    Should Contain    ${fcs_Socket3_list}    === MTCamera_fcs_Socket3 end of topic ===
    Should Contain    ${fcs_Socket3_list}    === [fcs_Socket3] message sent 200
    ${fcs_Socket4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket4 start of topic ===
    ${fcs_Socket4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket4 end of topic ===
    ${fcs_Socket4_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket4_start}    end=${fcs_Socket4_end + 1}
    Log Many    ${fcs_Socket4_list}
    Should Contain    ${fcs_Socket4_list}    === MTCamera_fcs_Socket4 start of topic ===
    Should Contain    ${fcs_Socket4_list}    === MTCamera_fcs_Socket4 end of topic ===
    Should Contain    ${fcs_Socket4_list}    === [fcs_Socket4] message sent 200
    ${fcs_Socket5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket5 start of topic ===
    ${fcs_Socket5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket5 end of topic ===
    ${fcs_Socket5_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket5_start}    end=${fcs_Socket5_end + 1}
    Log Many    ${fcs_Socket5_list}
    Should Contain    ${fcs_Socket5_list}    === MTCamera_fcs_Socket5 start of topic ===
    Should Contain    ${fcs_Socket5_list}    === MTCamera_fcs_Socket5 end of topic ===
    Should Contain    ${fcs_Socket5_list}    === [fcs_Socket5] message sent 200
    ${fcs_TempSensorsDevice1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice1 start of topic ===
    ${fcs_TempSensorsDevice1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice1 end of topic ===
    ${fcs_TempSensorsDevice1_list}=    Get Slice From List    ${full_list}    start=${fcs_TempSensorsDevice1_start}    end=${fcs_TempSensorsDevice1_end + 1}
    Log Many    ${fcs_TempSensorsDevice1_list}
    Should Contain    ${fcs_TempSensorsDevice1_list}    === MTCamera_fcs_TempSensorsDevice1 start of topic ===
    Should Contain    ${fcs_TempSensorsDevice1_list}    === MTCamera_fcs_TempSensorsDevice1 end of topic ===
    Should Contain    ${fcs_TempSensorsDevice1_list}    === [fcs_TempSensorsDevice1] message sent 200
    ${fcs_TempSensorsDevice2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice2 start of topic ===
    ${fcs_TempSensorsDevice2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice2 end of topic ===
    ${fcs_TempSensorsDevice2_list}=    Get Slice From List    ${full_list}    start=${fcs_TempSensorsDevice2_start}    end=${fcs_TempSensorsDevice2_end + 1}
    Log Many    ${fcs_TempSensorsDevice2_list}
    Should Contain    ${fcs_TempSensorsDevice2_list}    === MTCamera_fcs_TempSensorsDevice2 start of topic ===
    Should Contain    ${fcs_TempSensorsDevice2_list}    === MTCamera_fcs_TempSensorsDevice2 end of topic ===
    Should Contain    ${fcs_TempSensorsDevice2_list}    === [fcs_TempSensorsDevice2] message sent 200
    ${chiller_Chiller_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller start of topic ===
    ${chiller_Chiller_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller end of topic ===
    ${chiller_Chiller_list}=    Get Slice From List    ${full_list}    start=${chiller_Chiller_start}    end=${chiller_Chiller_end + 1}
    Log Many    ${chiller_Chiller_list}
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller start of topic ===
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller end of topic ===
    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller] message sent 200
    ${chiller_Maq20_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 start of topic ===
    ${chiller_Maq20_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 end of topic ===
    ${chiller_Maq20_list}=    Get Slice From List    ${full_list}    start=${chiller_Maq20_start}    end=${chiller_Maq20_end + 1}
    Log Many    ${chiller_Maq20_list}
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 start of topic ===
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 end of topic ===
    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20] message sent 200

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
    ${fcs_AcSensorsGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcSensorsGateway start of topic ===
    ${fcs_AcSensorsGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcSensorsGateway end of topic ===
    ${fcs_AcSensorsGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_AcSensorsGateway_start}    end=${fcs_AcSensorsGateway_end + 1}
    Log Many    ${fcs_AcSensorsGateway_list}
    Should Contain    ${fcs_AcSensorsGateway_list}    === MTCamera_fcs_AcSensorsGateway start of topic ===
    Should Contain    ${fcs_AcSensorsGateway_list}    === MTCamera_fcs_AcSensorsGateway end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcSensorsGateway_list}    === [fcs_AcSensorsGateway Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcSensorsGateway_list}    === [fcs_AcSensorsGateway Subscriber] message received :200
    ${fcs_AcTruckXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminus start of topic ===
    ${fcs_AcTruckXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminus end of topic ===
    ${fcs_AcTruckXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXminus_start}    end=${fcs_AcTruckXminus_end + 1}
    Log Many    ${fcs_AcTruckXminus_list}
    Should Contain    ${fcs_AcTruckXminus_list}    === MTCamera_fcs_AcTruckXminus start of topic ===
    Should Contain    ${fcs_AcTruckXminus_list}    === MTCamera_fcs_AcTruckXminus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXminus_list}    === [fcs_AcTruckXminus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXminus_list}    === [fcs_AcTruckXminus Subscriber] message received :200
    ${fcs_AcTruckXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminusController start of topic ===
    ${fcs_AcTruckXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXminusController end of topic ===
    ${fcs_AcTruckXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXminusController_start}    end=${fcs_AcTruckXminusController_end + 1}
    Log Many    ${fcs_AcTruckXminusController_list}
    Should Contain    ${fcs_AcTruckXminusController_list}    === MTCamera_fcs_AcTruckXminusController start of topic ===
    Should Contain    ${fcs_AcTruckXminusController_list}    === MTCamera_fcs_AcTruckXminusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXminusController_list}    === [fcs_AcTruckXminusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXminusController_list}    === [fcs_AcTruckXminusController Subscriber] message received :200
    ${fcs_AcTruckXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplus start of topic ===
    ${fcs_AcTruckXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplus end of topic ===
    ${fcs_AcTruckXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXplus_start}    end=${fcs_AcTruckXplus_end + 1}
    Log Many    ${fcs_AcTruckXplus_list}
    Should Contain    ${fcs_AcTruckXplus_list}    === MTCamera_fcs_AcTruckXplus start of topic ===
    Should Contain    ${fcs_AcTruckXplus_list}    === MTCamera_fcs_AcTruckXplus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXplus_list}    === [fcs_AcTruckXplus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXplus_list}    === [fcs_AcTruckXplus Subscriber] message received :200
    ${fcs_AcTruckXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplusController start of topic ===
    ${fcs_AcTruckXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AcTruckXplusController end of topic ===
    ${fcs_AcTruckXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_AcTruckXplusController_start}    end=${fcs_AcTruckXplusController_end + 1}
    Log Many    ${fcs_AcTruckXplusController_list}
    Should Contain    ${fcs_AcTruckXplusController_list}    === MTCamera_fcs_AcTruckXplusController start of topic ===
    Should Contain    ${fcs_AcTruckXplusController_list}    === MTCamera_fcs_AcTruckXplusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXplusController_list}    === [fcs_AcTruckXplusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AcTruckXplusController_list}    === [fcs_AcTruckXplusController Subscriber] message received :200
    ${fcs_Accelerobf_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Accelerobf start of topic ===
    ${fcs_Accelerobf_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Accelerobf end of topic ===
    ${fcs_Accelerobf_list}=    Get Slice From List    ${full_list}    start=${fcs_Accelerobf_start}    end=${fcs_Accelerobf_end + 1}
    Log Many    ${fcs_Accelerobf_list}
    Should Contain    ${fcs_Accelerobf_list}    === MTCamera_fcs_Accelerobf start of topic ===
    Should Contain    ${fcs_Accelerobf_list}    === MTCamera_fcs_Accelerobf end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Accelerobf_list}    === [fcs_Accelerobf Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Accelerobf_list}    === [fcs_Accelerobf Subscriber] message received :200
    ${fcs_Ai814_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Ai814 start of topic ===
    ${fcs_Ai814_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Ai814 end of topic ===
    ${fcs_Ai814_list}=    Get Slice From List    ${full_list}    start=${fcs_Ai814_start}    end=${fcs_Ai814_end + 1}
    Log Many    ${fcs_Ai814_list}
    Should Contain    ${fcs_Ai814_list}    === MTCamera_fcs_Ai814 start of topic ===
    Should Contain    ${fcs_Ai814_list}    === MTCamera_fcs_Ai814 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Ai814_list}    === [fcs_Ai814 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Ai814_list}    === [fcs_Ai814 Subscriber] message received :200
    ${fcs_Autochanger_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger start of topic ===
    ${fcs_Autochanger_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Autochanger end of topic ===
    ${fcs_Autochanger_list}=    Get Slice From List    ${full_list}    start=${fcs_Autochanger_start}    end=${fcs_Autochanger_end + 1}
    Log Many    ${fcs_Autochanger_list}
    Should Contain    ${fcs_Autochanger_list}    === MTCamera_fcs_Autochanger start of topic ===
    Should Contain    ${fcs_Autochanger_list}    === MTCamera_fcs_Autochanger end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_list}    === [fcs_Autochanger Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Autochanger_list}    === [fcs_Autochanger Subscriber] message received :200
    ${fcs_AutochangerTrucks_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_AutochangerTrucks start of topic ===
    ${fcs_AutochangerTrucks_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_AutochangerTrucks end of topic ===
    ${fcs_AutochangerTrucks_list}=    Get Slice From List    ${full_list}    start=${fcs_AutochangerTrucks_start}    end=${fcs_AutochangerTrucks_end + 1}
    Log Many    ${fcs_AutochangerTrucks_list}
    Should Contain    ${fcs_AutochangerTrucks_list}    === MTCamera_fcs_AutochangerTrucks start of topic ===
    Should Contain    ${fcs_AutochangerTrucks_list}    === MTCamera_fcs_AutochangerTrucks end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_AutochangerTrucks_list}    === [fcs_AutochangerTrucks Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_AutochangerTrucks_list}    === [fcs_AutochangerTrucks Subscriber] message received :200
    ${fcs_BrakeSystemGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_BrakeSystemGateway start of topic ===
    ${fcs_BrakeSystemGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_BrakeSystemGateway end of topic ===
    ${fcs_BrakeSystemGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_BrakeSystemGateway_start}    end=${fcs_BrakeSystemGateway_end + 1}
    Log Many    ${fcs_BrakeSystemGateway_list}
    Should Contain    ${fcs_BrakeSystemGateway_list}    === MTCamera_fcs_BrakeSystemGateway start of topic ===
    Should Contain    ${fcs_BrakeSystemGateway_list}    === MTCamera_fcs_BrakeSystemGateway end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_BrakeSystemGateway_list}    === [fcs_BrakeSystemGateway Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_BrakeSystemGateway_list}    === [fcs_BrakeSystemGateway Subscriber] message received :200
    ${fcs_Carousel_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel start of topic ===
    ${fcs_Carousel_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carousel end of topic ===
    ${fcs_Carousel_list}=    Get Slice From List    ${full_list}    start=${fcs_Carousel_start}    end=${fcs_Carousel_end + 1}
    Log Many    ${fcs_Carousel_list}
    Should Contain    ${fcs_Carousel_list}    === MTCamera_fcs_Carousel start of topic ===
    Should Contain    ${fcs_Carousel_list}    === MTCamera_fcs_Carousel end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_list}    === [fcs_Carousel Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carousel_list}    === [fcs_Carousel Subscriber] message received :200
    ${fcs_CarouselController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarouselController start of topic ===
    ${fcs_CarouselController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarouselController end of topic ===
    ${fcs_CarouselController_list}=    Get Slice From List    ${full_list}    start=${fcs_CarouselController_start}    end=${fcs_CarouselController_end + 1}
    Log Many    ${fcs_CarouselController_list}
    Should Contain    ${fcs_CarouselController_list}    === MTCamera_fcs_CarouselController start of topic ===
    Should Contain    ${fcs_CarouselController_list}    === MTCamera_fcs_CarouselController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_CarouselController_list}    === [fcs_CarouselController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_CarouselController_list}    === [fcs_CarouselController Subscriber] message received :200
    ${fcs_Carrier_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carrier start of topic ===
    ${fcs_Carrier_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Carrier end of topic ===
    ${fcs_Carrier_list}=    Get Slice From List    ${full_list}    start=${fcs_Carrier_start}    end=${fcs_Carrier_end + 1}
    Log Many    ${fcs_Carrier_list}
    Should Contain    ${fcs_Carrier_list}    === MTCamera_fcs_Carrier start of topic ===
    Should Contain    ${fcs_Carrier_list}    === MTCamera_fcs_Carrier end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carrier_list}    === [fcs_Carrier Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Carrier_list}    === [fcs_Carrier Subscriber] message received :200
    ${fcs_CarrierController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarrierController start of topic ===
    ${fcs_CarrierController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CarrierController end of topic ===
    ${fcs_CarrierController_list}=    Get Slice From List    ${full_list}    start=${fcs_CarrierController_start}    end=${fcs_CarrierController_end + 1}
    Log Many    ${fcs_CarrierController_list}
    Should Contain    ${fcs_CarrierController_list}    === MTCamera_fcs_CarrierController start of topic ===
    Should Contain    ${fcs_CarrierController_list}    === MTCamera_fcs_CarrierController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_CarrierController_list}    === [fcs_CarrierController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_CarrierController_list}    === [fcs_CarrierController Subscriber] message received :200
    ${fcs_CcsVersions_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_CcsVersions start of topic ===
    ${fcs_CcsVersions_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_CcsVersions end of topic ===
    ${fcs_CcsVersions_list}=    Get Slice From List    ${full_list}    start=${fcs_CcsVersions_start}    end=${fcs_CcsVersions_end + 1}
    Log Many    ${fcs_CcsVersions_list}
    Should Contain    ${fcs_CcsVersions_list}    === MTCamera_fcs_CcsVersions start of topic ===
    Should Contain    ${fcs_CcsVersions_list}    === MTCamera_fcs_CcsVersions end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_CcsVersions_list}    === [fcs_CcsVersions Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_CcsVersions_list}    === [fcs_CcsVersions Subscriber] message received :200
    ${fcs_ClampXminus1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus1 start of topic ===
    ${fcs_ClampXminus1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus1 end of topic ===
    ${fcs_ClampXminus1_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus1_start}    end=${fcs_ClampXminus1_end + 1}
    Log Many    ${fcs_ClampXminus1_list}
    Should Contain    ${fcs_ClampXminus1_list}    === MTCamera_fcs_ClampXminus1 start of topic ===
    Should Contain    ${fcs_ClampXminus1_list}    === MTCamera_fcs_ClampXminus1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus1_list}    === [fcs_ClampXminus1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus1_list}    === [fcs_ClampXminus1 Subscriber] message received :200
    ${fcs_ClampXminus2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus2 start of topic ===
    ${fcs_ClampXminus2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus2 end of topic ===
    ${fcs_ClampXminus2_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus2_start}    end=${fcs_ClampXminus2_end + 1}
    Log Many    ${fcs_ClampXminus2_list}
    Should Contain    ${fcs_ClampXminus2_list}    === MTCamera_fcs_ClampXminus2 start of topic ===
    Should Contain    ${fcs_ClampXminus2_list}    === MTCamera_fcs_ClampXminus2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus2_list}    === [fcs_ClampXminus2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus2_list}    === [fcs_ClampXminus2 Subscriber] message received :200
    ${fcs_ClampXminus3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus3 start of topic ===
    ${fcs_ClampXminus3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus3 end of topic ===
    ${fcs_ClampXminus3_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus3_start}    end=${fcs_ClampXminus3_end + 1}
    Log Many    ${fcs_ClampXminus3_list}
    Should Contain    ${fcs_ClampXminus3_list}    === MTCamera_fcs_ClampXminus3 start of topic ===
    Should Contain    ${fcs_ClampXminus3_list}    === MTCamera_fcs_ClampXminus3 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus3_list}    === [fcs_ClampXminus3 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus3_list}    === [fcs_ClampXminus3 Subscriber] message received :200
    ${fcs_ClampXminus4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus4 start of topic ===
    ${fcs_ClampXminus4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus4 end of topic ===
    ${fcs_ClampXminus4_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus4_start}    end=${fcs_ClampXminus4_end + 1}
    Log Many    ${fcs_ClampXminus4_list}
    Should Contain    ${fcs_ClampXminus4_list}    === MTCamera_fcs_ClampXminus4 start of topic ===
    Should Contain    ${fcs_ClampXminus4_list}    === MTCamera_fcs_ClampXminus4 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus4_list}    === [fcs_ClampXminus4 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus4_list}    === [fcs_ClampXminus4 Subscriber] message received :200
    ${fcs_ClampXminus5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus5 start of topic ===
    ${fcs_ClampXminus5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminus5 end of topic ===
    ${fcs_ClampXminus5_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminus5_start}    end=${fcs_ClampXminus5_end + 1}
    Log Many    ${fcs_ClampXminus5_list}
    Should Contain    ${fcs_ClampXminus5_list}    === MTCamera_fcs_ClampXminus5 start of topic ===
    Should Contain    ${fcs_ClampXminus5_list}    === MTCamera_fcs_ClampXminus5 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus5_list}    === [fcs_ClampXminus5 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminus5_list}    === [fcs_ClampXminus5 Subscriber] message received :200
    ${fcs_ClampXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminusController start of topic ===
    ${fcs_ClampXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXminusController end of topic ===
    ${fcs_ClampXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXminusController_start}    end=${fcs_ClampXminusController_end + 1}
    Log Many    ${fcs_ClampXminusController_list}
    Should Contain    ${fcs_ClampXminusController_list}    === MTCamera_fcs_ClampXminusController start of topic ===
    Should Contain    ${fcs_ClampXminusController_list}    === MTCamera_fcs_ClampXminusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminusController_list}    === [fcs_ClampXminusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXminusController_list}    === [fcs_ClampXminusController Subscriber] message received :200
    ${fcs_ClampXplus1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus1 start of topic ===
    ${fcs_ClampXplus1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus1 end of topic ===
    ${fcs_ClampXplus1_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus1_start}    end=${fcs_ClampXplus1_end + 1}
    Log Many    ${fcs_ClampXplus1_list}
    Should Contain    ${fcs_ClampXplus1_list}    === MTCamera_fcs_ClampXplus1 start of topic ===
    Should Contain    ${fcs_ClampXplus1_list}    === MTCamera_fcs_ClampXplus1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus1_list}    === [fcs_ClampXplus1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus1_list}    === [fcs_ClampXplus1 Subscriber] message received :200
    ${fcs_ClampXplus2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus2 start of topic ===
    ${fcs_ClampXplus2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus2 end of topic ===
    ${fcs_ClampXplus2_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus2_start}    end=${fcs_ClampXplus2_end + 1}
    Log Many    ${fcs_ClampXplus2_list}
    Should Contain    ${fcs_ClampXplus2_list}    === MTCamera_fcs_ClampXplus2 start of topic ===
    Should Contain    ${fcs_ClampXplus2_list}    === MTCamera_fcs_ClampXplus2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus2_list}    === [fcs_ClampXplus2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus2_list}    === [fcs_ClampXplus2 Subscriber] message received :200
    ${fcs_ClampXplus3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus3 start of topic ===
    ${fcs_ClampXplus3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus3 end of topic ===
    ${fcs_ClampXplus3_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus3_start}    end=${fcs_ClampXplus3_end + 1}
    Log Many    ${fcs_ClampXplus3_list}
    Should Contain    ${fcs_ClampXplus3_list}    === MTCamera_fcs_ClampXplus3 start of topic ===
    Should Contain    ${fcs_ClampXplus3_list}    === MTCamera_fcs_ClampXplus3 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus3_list}    === [fcs_ClampXplus3 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus3_list}    === [fcs_ClampXplus3 Subscriber] message received :200
    ${fcs_ClampXplus4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus4 start of topic ===
    ${fcs_ClampXplus4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus4 end of topic ===
    ${fcs_ClampXplus4_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus4_start}    end=${fcs_ClampXplus4_end + 1}
    Log Many    ${fcs_ClampXplus4_list}
    Should Contain    ${fcs_ClampXplus4_list}    === MTCamera_fcs_ClampXplus4 start of topic ===
    Should Contain    ${fcs_ClampXplus4_list}    === MTCamera_fcs_ClampXplus4 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus4_list}    === [fcs_ClampXplus4 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus4_list}    === [fcs_ClampXplus4 Subscriber] message received :200
    ${fcs_ClampXplus5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus5 start of topic ===
    ${fcs_ClampXplus5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplus5 end of topic ===
    ${fcs_ClampXplus5_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplus5_start}    end=${fcs_ClampXplus5_end + 1}
    Log Many    ${fcs_ClampXplus5_list}
    Should Contain    ${fcs_ClampXplus5_list}    === MTCamera_fcs_ClampXplus5 start of topic ===
    Should Contain    ${fcs_ClampXplus5_list}    === MTCamera_fcs_ClampXplus5 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus5_list}    === [fcs_ClampXplus5 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplus5_list}    === [fcs_ClampXplus5 Subscriber] message received :200
    ${fcs_ClampXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplusController start of topic ===
    ${fcs_ClampXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ClampXplusController end of topic ===
    ${fcs_ClampXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_ClampXplusController_start}    end=${fcs_ClampXplusController_end + 1}
    Log Many    ${fcs_ClampXplusController_list}
    Should Contain    ${fcs_ClampXplusController_list}    === MTCamera_fcs_ClampXplusController start of topic ===
    Should Contain    ${fcs_ClampXplusController_list}    === MTCamera_fcs_ClampXplusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplusController_list}    === [fcs_ClampXplusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ClampXplusController_list}    === [fcs_ClampXplusController Subscriber] message received :200
    ${fcs_Config_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Config start of topic ===
    ${fcs_Config_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Config end of topic ===
    ${fcs_Config_list}=    Get Slice From List    ${full_list}    start=${fcs_Config_start}    end=${fcs_Config_end + 1}
    Log Many    ${fcs_Config_list}
    Should Contain    ${fcs_Config_list}    === MTCamera_fcs_Config start of topic ===
    Should Contain    ${fcs_Config_list}    === MTCamera_fcs_Config end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Config_list}    === [fcs_Config Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Config_list}    === [fcs_Config Subscriber] message received :200
    ${fcs_Hooks_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hooks start of topic ===
    ${fcs_Hooks_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hooks end of topic ===
    ${fcs_Hooks_list}=    Get Slice From List    ${full_list}    start=${fcs_Hooks_start}    end=${fcs_Hooks_end + 1}
    Log Many    ${fcs_Hooks_list}
    Should Contain    ${fcs_Hooks_list}    === MTCamera_fcs_Hooks start of topic ===
    Should Contain    ${fcs_Hooks_list}    === MTCamera_fcs_Hooks end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Hooks_list}    === [fcs_Hooks Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Hooks_list}    === [fcs_Hooks Subscriber] message received :200
    ${fcs_HooksController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_HooksController start of topic ===
    ${fcs_HooksController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_HooksController end of topic ===
    ${fcs_HooksController_list}=    Get Slice From List    ${full_list}    start=${fcs_HooksController_start}    end=${fcs_HooksController_end + 1}
    Log Many    ${fcs_HooksController_list}
    Should Contain    ${fcs_HooksController_list}    === MTCamera_fcs_HooksController start of topic ===
    Should Contain    ${fcs_HooksController_list}    === MTCamera_fcs_HooksController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_HooksController_list}    === [fcs_HooksController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_HooksController_list}    === [fcs_HooksController Subscriber] message received :200
    ${fcs_Hyttc580_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hyttc580 start of topic ===
    ${fcs_Hyttc580_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Hyttc580 end of topic ===
    ${fcs_Hyttc580_list}=    Get Slice From List    ${full_list}    start=${fcs_Hyttc580_start}    end=${fcs_Hyttc580_end + 1}
    Log Many    ${fcs_Hyttc580_list}
    Should Contain    ${fcs_Hyttc580_list}    === MTCamera_fcs_Hyttc580 start of topic ===
    Should Contain    ${fcs_Hyttc580_list}    === MTCamera_fcs_Hyttc580 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Hyttc580_list}    === [fcs_Hyttc580 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Hyttc580_list}    === [fcs_Hyttc580 Subscriber] message received :200
    ${fcs_LatchXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminus start of topic ===
    ${fcs_LatchXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminus end of topic ===
    ${fcs_LatchXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXminus_start}    end=${fcs_LatchXminus_end + 1}
    Log Many    ${fcs_LatchXminus_list}
    Should Contain    ${fcs_LatchXminus_list}    === MTCamera_fcs_LatchXminus start of topic ===
    Should Contain    ${fcs_LatchXminus_list}    === MTCamera_fcs_LatchXminus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXminus_list}    === [fcs_LatchXminus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXminus_list}    === [fcs_LatchXminus Subscriber] message received :200
    ${fcs_LatchXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminusController start of topic ===
    ${fcs_LatchXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXminusController end of topic ===
    ${fcs_LatchXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXminusController_start}    end=${fcs_LatchXminusController_end + 1}
    Log Many    ${fcs_LatchXminusController_list}
    Should Contain    ${fcs_LatchXminusController_list}    === MTCamera_fcs_LatchXminusController start of topic ===
    Should Contain    ${fcs_LatchXminusController_list}    === MTCamera_fcs_LatchXminusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXminusController_list}    === [fcs_LatchXminusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXminusController_list}    === [fcs_LatchXminusController Subscriber] message received :200
    ${fcs_LatchXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplus start of topic ===
    ${fcs_LatchXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplus end of topic ===
    ${fcs_LatchXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXplus_start}    end=${fcs_LatchXplus_end + 1}
    Log Many    ${fcs_LatchXplus_list}
    Should Contain    ${fcs_LatchXplus_list}    === MTCamera_fcs_LatchXplus start of topic ===
    Should Contain    ${fcs_LatchXplus_list}    === MTCamera_fcs_LatchXplus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXplus_list}    === [fcs_LatchXplus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXplus_list}    === [fcs_LatchXplus Subscriber] message received :200
    ${fcs_LatchXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplusController start of topic ===
    ${fcs_LatchXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LatchXplusController end of topic ===
    ${fcs_LatchXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_LatchXplusController_start}    end=${fcs_LatchXplusController_end + 1}
    Log Many    ${fcs_LatchXplusController_list}
    Should Contain    ${fcs_LatchXplusController_list}    === MTCamera_fcs_LatchXplusController start of topic ===
    Should Contain    ${fcs_LatchXplusController_list}    === MTCamera_fcs_LatchXplusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXplusController_list}    === [fcs_LatchXplusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_LatchXplusController_list}    === [fcs_LatchXplusController Subscriber] message received :200
    ${fcs_Latches_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Latches start of topic ===
    ${fcs_Latches_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Latches end of topic ===
    ${fcs_Latches_list}=    Get Slice From List    ${full_list}    start=${fcs_Latches_start}    end=${fcs_Latches_end + 1}
    Log Many    ${fcs_Latches_list}
    Should Contain    ${fcs_Latches_list}    === MTCamera_fcs_Latches start of topic ===
    Should Contain    ${fcs_Latches_list}    === MTCamera_fcs_Latches end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Latches_list}    === [fcs_Latches Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Latches_list}    === [fcs_Latches Subscriber] message received :200
    ${fcs_Loader_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader start of topic ===
    ${fcs_Loader_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Loader end of topic ===
    ${fcs_Loader_list}=    Get Slice From List    ${full_list}    start=${fcs_Loader_start}    end=${fcs_Loader_end + 1}
    Log Many    ${fcs_Loader_list}
    Should Contain    ${fcs_Loader_list}    === MTCamera_fcs_Loader start of topic ===
    Should Contain    ${fcs_Loader_list}    === MTCamera_fcs_Loader end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_list}    === [fcs_Loader Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Loader_list}    === [fcs_Loader Subscriber] message received :200
    ${fcs_LoaderPlutoGateway_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_LoaderPlutoGateway start of topic ===
    ${fcs_LoaderPlutoGateway_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_LoaderPlutoGateway end of topic ===
    ${fcs_LoaderPlutoGateway_list}=    Get Slice From List    ${full_list}    start=${fcs_LoaderPlutoGateway_start}    end=${fcs_LoaderPlutoGateway_end + 1}
    Log Many    ${fcs_LoaderPlutoGateway_list}
    Should Contain    ${fcs_LoaderPlutoGateway_list}    === MTCamera_fcs_LoaderPlutoGateway start of topic ===
    Should Contain    ${fcs_LoaderPlutoGateway_list}    === MTCamera_fcs_LoaderPlutoGateway end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_LoaderPlutoGateway_list}    === [fcs_LoaderPlutoGateway Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_LoaderPlutoGateway_list}    === [fcs_LoaderPlutoGateway Subscriber] message received :200
    ${fcs_OnlineClampXminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminus start of topic ===
    ${fcs_OnlineClampXminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminus end of topic ===
    ${fcs_OnlineClampXminus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXminus_start}    end=${fcs_OnlineClampXminus_end + 1}
    Log Many    ${fcs_OnlineClampXminus_list}
    Should Contain    ${fcs_OnlineClampXminus_list}    === MTCamera_fcs_OnlineClampXminus start of topic ===
    Should Contain    ${fcs_OnlineClampXminus_list}    === MTCamera_fcs_OnlineClampXminus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXminus_list}    === [fcs_OnlineClampXminus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXminus_list}    === [fcs_OnlineClampXminus Subscriber] message received :200
    ${fcs_OnlineClampXminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminusController start of topic ===
    ${fcs_OnlineClampXminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXminusController end of topic ===
    ${fcs_OnlineClampXminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXminusController_start}    end=${fcs_OnlineClampXminusController_end + 1}
    Log Many    ${fcs_OnlineClampXminusController_list}
    Should Contain    ${fcs_OnlineClampXminusController_list}    === MTCamera_fcs_OnlineClampXminusController start of topic ===
    Should Contain    ${fcs_OnlineClampXminusController_list}    === MTCamera_fcs_OnlineClampXminusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXminusController_list}    === [fcs_OnlineClampXminusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXminusController_list}    === [fcs_OnlineClampXminusController Subscriber] message received :200
    ${fcs_OnlineClampXplus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplus start of topic ===
    ${fcs_OnlineClampXplus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplus end of topic ===
    ${fcs_OnlineClampXplus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXplus_start}    end=${fcs_OnlineClampXplus_end + 1}
    Log Many    ${fcs_OnlineClampXplus_list}
    Should Contain    ${fcs_OnlineClampXplus_list}    === MTCamera_fcs_OnlineClampXplus start of topic ===
    Should Contain    ${fcs_OnlineClampXplus_list}    === MTCamera_fcs_OnlineClampXplus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXplus_list}    === [fcs_OnlineClampXplus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXplus_list}    === [fcs_OnlineClampXplus Subscriber] message received :200
    ${fcs_OnlineClampXplusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplusController start of topic ===
    ${fcs_OnlineClampXplusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampXplusController end of topic ===
    ${fcs_OnlineClampXplusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampXplusController_start}    end=${fcs_OnlineClampXplusController_end + 1}
    Log Many    ${fcs_OnlineClampXplusController_list}
    Should Contain    ${fcs_OnlineClampXplusController_list}    === MTCamera_fcs_OnlineClampXplusController start of topic ===
    Should Contain    ${fcs_OnlineClampXplusController_list}    === MTCamera_fcs_OnlineClampXplusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXplusController_list}    === [fcs_OnlineClampXplusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampXplusController_list}    === [fcs_OnlineClampXplusController Subscriber] message received :200
    ${fcs_OnlineClampYminus_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminus start of topic ===
    ${fcs_OnlineClampYminus_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminus end of topic ===
    ${fcs_OnlineClampYminus_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampYminus_start}    end=${fcs_OnlineClampYminus_end + 1}
    Log Many    ${fcs_OnlineClampYminus_list}
    Should Contain    ${fcs_OnlineClampYminus_list}    === MTCamera_fcs_OnlineClampYminus start of topic ===
    Should Contain    ${fcs_OnlineClampYminus_list}    === MTCamera_fcs_OnlineClampYminus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampYminus_list}    === [fcs_OnlineClampYminus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampYminus_list}    === [fcs_OnlineClampYminus Subscriber] message received :200
    ${fcs_OnlineClampYminusController_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminusController start of topic ===
    ${fcs_OnlineClampYminusController_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClampYminusController end of topic ===
    ${fcs_OnlineClampYminusController_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClampYminusController_start}    end=${fcs_OnlineClampYminusController_end + 1}
    Log Many    ${fcs_OnlineClampYminusController_list}
    Should Contain    ${fcs_OnlineClampYminusController_list}    === MTCamera_fcs_OnlineClampYminusController start of topic ===
    Should Contain    ${fcs_OnlineClampYminusController_list}    === MTCamera_fcs_OnlineClampYminusController end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampYminusController_list}    === [fcs_OnlineClampYminusController Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClampYminusController_list}    === [fcs_OnlineClampYminusController Subscriber] message received :200
    ${fcs_OnlineClamps_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClamps start of topic ===
    ${fcs_OnlineClamps_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineClamps end of topic ===
    ${fcs_OnlineClamps_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineClamps_start}    end=${fcs_OnlineClamps_end + 1}
    Log Many    ${fcs_OnlineClamps_list}
    Should Contain    ${fcs_OnlineClamps_list}    === MTCamera_fcs_OnlineClamps start of topic ===
    Should Contain    ${fcs_OnlineClamps_list}    === MTCamera_fcs_OnlineClamps end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClamps_list}    === [fcs_OnlineClamps Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineClamps_list}    === [fcs_OnlineClamps Subscriber] message received :200
    ${fcs_OnlineStrainGauge_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineStrainGauge start of topic ===
    ${fcs_OnlineStrainGauge_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_OnlineStrainGauge end of topic ===
    ${fcs_OnlineStrainGauge_list}=    Get Slice From List    ${full_list}    start=${fcs_OnlineStrainGauge_start}    end=${fcs_OnlineStrainGauge_end + 1}
    Log Many    ${fcs_OnlineStrainGauge_list}
    Should Contain    ${fcs_OnlineStrainGauge_list}    === MTCamera_fcs_OnlineStrainGauge start of topic ===
    Should Contain    ${fcs_OnlineStrainGauge_list}    === MTCamera_fcs_OnlineStrainGauge end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineStrainGauge_list}    === [fcs_OnlineStrainGauge Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_OnlineStrainGauge_list}    === [fcs_OnlineStrainGauge Subscriber] message received :200
    ${fcs_ProximitySensorsDevice_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_ProximitySensorsDevice start of topic ===
    ${fcs_ProximitySensorsDevice_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_ProximitySensorsDevice end of topic ===
    ${fcs_ProximitySensorsDevice_list}=    Get Slice From List    ${full_list}    start=${fcs_ProximitySensorsDevice_start}    end=${fcs_ProximitySensorsDevice_end + 1}
    Log Many    ${fcs_ProximitySensorsDevice_list}
    Should Contain    ${fcs_ProximitySensorsDevice_list}    === MTCamera_fcs_ProximitySensorsDevice start of topic ===
    Should Contain    ${fcs_ProximitySensorsDevice_list}    === MTCamera_fcs_ProximitySensorsDevice end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_ProximitySensorsDevice_list}    === [fcs_ProximitySensorsDevice Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_ProximitySensorsDevice_list}    === [fcs_ProximitySensorsDevice Subscriber] message received :200
    ${fcs_Pt100_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Pt100 start of topic ===
    ${fcs_Pt100_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Pt100 end of topic ===
    ${fcs_Pt100_list}=    Get Slice From List    ${full_list}    start=${fcs_Pt100_start}    end=${fcs_Pt100_end + 1}
    Log Many    ${fcs_Pt100_list}
    Should Contain    ${fcs_Pt100_list}    === MTCamera_fcs_Pt100 start of topic ===
    Should Contain    ${fcs_Pt100_list}    === MTCamera_fcs_Pt100 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Pt100_list}    === [fcs_Pt100 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Pt100_list}    === [fcs_Pt100 Subscriber] message received :200
    ${fcs_RuntimeInfo_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_RuntimeInfo start of topic ===
    ${fcs_RuntimeInfo_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_RuntimeInfo end of topic ===
    ${fcs_RuntimeInfo_list}=    Get Slice From List    ${full_list}    start=${fcs_RuntimeInfo_start}    end=${fcs_RuntimeInfo_end + 1}
    Log Many    ${fcs_RuntimeInfo_list}
    Should Contain    ${fcs_RuntimeInfo_list}    === MTCamera_fcs_RuntimeInfo start of topic ===
    Should Contain    ${fcs_RuntimeInfo_list}    === MTCamera_fcs_RuntimeInfo end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_RuntimeInfo_list}    === [fcs_RuntimeInfo Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_RuntimeInfo_list}    === [fcs_RuntimeInfo Subscriber] message received :200
    ${fcs_Socket1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket1 start of topic ===
    ${fcs_Socket1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket1 end of topic ===
    ${fcs_Socket1_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket1_start}    end=${fcs_Socket1_end + 1}
    Log Many    ${fcs_Socket1_list}
    Should Contain    ${fcs_Socket1_list}    === MTCamera_fcs_Socket1 start of topic ===
    Should Contain    ${fcs_Socket1_list}    === MTCamera_fcs_Socket1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket1_list}    === [fcs_Socket1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket1_list}    === [fcs_Socket1 Subscriber] message received :200
    ${fcs_Socket2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket2 start of topic ===
    ${fcs_Socket2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket2 end of topic ===
    ${fcs_Socket2_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket2_start}    end=${fcs_Socket2_end + 1}
    Log Many    ${fcs_Socket2_list}
    Should Contain    ${fcs_Socket2_list}    === MTCamera_fcs_Socket2 start of topic ===
    Should Contain    ${fcs_Socket2_list}    === MTCamera_fcs_Socket2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket2_list}    === [fcs_Socket2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket2_list}    === [fcs_Socket2 Subscriber] message received :200
    ${fcs_Socket3_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket3 start of topic ===
    ${fcs_Socket3_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket3 end of topic ===
    ${fcs_Socket3_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket3_start}    end=${fcs_Socket3_end + 1}
    Log Many    ${fcs_Socket3_list}
    Should Contain    ${fcs_Socket3_list}    === MTCamera_fcs_Socket3 start of topic ===
    Should Contain    ${fcs_Socket3_list}    === MTCamera_fcs_Socket3 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket3_list}    === [fcs_Socket3 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket3_list}    === [fcs_Socket3 Subscriber] message received :200
    ${fcs_Socket4_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket4 start of topic ===
    ${fcs_Socket4_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket4 end of topic ===
    ${fcs_Socket4_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket4_start}    end=${fcs_Socket4_end + 1}
    Log Many    ${fcs_Socket4_list}
    Should Contain    ${fcs_Socket4_list}    === MTCamera_fcs_Socket4 start of topic ===
    Should Contain    ${fcs_Socket4_list}    === MTCamera_fcs_Socket4 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket4_list}    === [fcs_Socket4 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket4_list}    === [fcs_Socket4 Subscriber] message received :200
    ${fcs_Socket5_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket5 start of topic ===
    ${fcs_Socket5_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_Socket5 end of topic ===
    ${fcs_Socket5_list}=    Get Slice From List    ${full_list}    start=${fcs_Socket5_start}    end=${fcs_Socket5_end + 1}
    Log Many    ${fcs_Socket5_list}
    Should Contain    ${fcs_Socket5_list}    === MTCamera_fcs_Socket5 start of topic ===
    Should Contain    ${fcs_Socket5_list}    === MTCamera_fcs_Socket5 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket5_list}    === [fcs_Socket5 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_Socket5_list}    === [fcs_Socket5 Subscriber] message received :200
    ${fcs_TempSensorsDevice1_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice1 start of topic ===
    ${fcs_TempSensorsDevice1_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice1 end of topic ===
    ${fcs_TempSensorsDevice1_list}=    Get Slice From List    ${full_list}    start=${fcs_TempSensorsDevice1_start}    end=${fcs_TempSensorsDevice1_end + 1}
    Log Many    ${fcs_TempSensorsDevice1_list}
    Should Contain    ${fcs_TempSensorsDevice1_list}    === MTCamera_fcs_TempSensorsDevice1 start of topic ===
    Should Contain    ${fcs_TempSensorsDevice1_list}    === MTCamera_fcs_TempSensorsDevice1 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_TempSensorsDevice1_list}    === [fcs_TempSensorsDevice1 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_TempSensorsDevice1_list}    === [fcs_TempSensorsDevice1 Subscriber] message received :200
    ${fcs_TempSensorsDevice2_start}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice2 start of topic ===
    ${fcs_TempSensorsDevice2_end}=    Get Index From List    ${full_list}    === MTCamera_fcs_TempSensorsDevice2 end of topic ===
    ${fcs_TempSensorsDevice2_list}=    Get Slice From List    ${full_list}    start=${fcs_TempSensorsDevice2_start}    end=${fcs_TempSensorsDevice2_end + 1}
    Log Many    ${fcs_TempSensorsDevice2_list}
    Should Contain    ${fcs_TempSensorsDevice2_list}    === MTCamera_fcs_TempSensorsDevice2 start of topic ===
    Should Contain    ${fcs_TempSensorsDevice2_list}    === MTCamera_fcs_TempSensorsDevice2 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fcs_TempSensorsDevice2_list}    === [fcs_TempSensorsDevice2 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fcs_TempSensorsDevice2_list}    === [fcs_TempSensorsDevice2 Subscriber] message received :200
    ${chiller_Chiller_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller start of topic ===
    ${chiller_Chiller_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Chiller end of topic ===
    ${chiller_Chiller_list}=    Get Slice From List    ${full_list}    start=${chiller_Chiller_start}    end=${chiller_Chiller_end + 1}
    Log Many    ${chiller_Chiller_list}
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller start of topic ===
    Should Contain    ${chiller_Chiller_list}    === MTCamera_chiller_Chiller end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${chiller_Chiller_list}    === [chiller_Chiller Subscriber] message received :200
    ${chiller_Maq20_start}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 start of topic ===
    ${chiller_Maq20_end}=    Get Index From List    ${full_list}    === MTCamera_chiller_Maq20 end of topic ===
    ${chiller_Maq20_list}=    Get Slice From List    ${full_list}    start=${chiller_Maq20_start}    end=${chiller_Maq20_end + 1}
    Log Many    ${chiller_Maq20_list}
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 start of topic ===
    Should Contain    ${chiller_Maq20_list}    === MTCamera_chiller_Maq20 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${chiller_Maq20_list}    === [chiller_Maq20 Subscriber] message received :200
