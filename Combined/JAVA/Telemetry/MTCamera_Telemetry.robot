*** Settings ***
Documentation    MTCamera_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
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
    Should Contain    ${output.stdout}    ===== MTCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${shutter_start}=    Get Index From List    ${full_list}    === MTCamera_shutter start of topic ===
    ${shutter_end}=    Get Index From List    ${full_list}    === MTCamera_shutter end of topic ===
    ${shutter_list}=    Get Slice From List    ${full_list}    start=${shutter_start}    end=${shutter_end + 1}
    Log Many    ${shutter_list}
    Should Contain    ${shutter_list}    === MTCamera_shutter start of topic ===
    Should Contain    ${shutter_list}    === MTCamera_shutter end of topic ===
    ${prot_start}=    Get Index From List    ${full_list}    === MTCamera_prot start of topic ===
    ${prot_end}=    Get Index From List    ${full_list}    === MTCamera_prot end of topic ===
    ${prot_list}=    Get Slice From List    ${full_list}    start=${prot_start}    end=${prot_end + 1}
    Log Many    ${prot_list}
    Should Contain    ${prot_list}    === MTCamera_prot start of topic ===
    Should Contain    ${prot_list}    === MTCamera_prot end of topic ===
    ${filter_start}=    Get Index From List    ${full_list}    === MTCamera_filter start of topic ===
    ${filter_end}=    Get Index From List    ${full_list}    === MTCamera_filter end of topic ===
    ${filter_list}=    Get Slice From List    ${full_list}    start=${filter_start}    end=${filter_end + 1}
    Log Many    ${filter_list}
    Should Contain    ${filter_list}    === MTCamera_filter start of topic ===
    Should Contain    ${filter_list}    === MTCamera_filter end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTCamera_heartbeat end of topic ===
    ${was_start}=    Get Index From List    ${full_list}    === MTCamera_was start of topic ===
    ${was_end}=    Get Index From List    ${full_list}    === MTCamera_was end of topic ===
    ${was_list}=    Get Slice From List    ${full_list}    start=${was_start}    end=${was_end + 1}
    Log Many    ${was_list}
    Should Contain    ${was_list}    === MTCamera_was start of topic ===
    Should Contain    ${was_list}    === MTCamera_was end of topic ===
    ${ccs_start}=    Get Index From List    ${full_list}    === MTCamera_ccs start of topic ===
    ${ccs_end}=    Get Index From List    ${full_list}    === MTCamera_ccs end of topic ===
    ${ccs_list}=    Get Slice From List    ${full_list}    start=${ccs_start}    end=${ccs_end + 1}
    Log Many    ${ccs_list}
    Should Contain    ${ccs_list}    === MTCamera_ccs start of topic ===
    Should Contain    ${ccs_list}    === MTCamera_ccs end of topic ===
    ${clusterEncoder_start}=    Get Index From List    ${full_list}    === MTCamera_clusterEncoder start of topic ===
    ${clusterEncoder_end}=    Get Index From List    ${full_list}    === MTCamera_clusterEncoder end of topic ===
    ${clusterEncoder_list}=    Get Slice From List    ${full_list}    start=${clusterEncoder_start}    end=${clusterEncoder_end + 1}
    Log Many    ${clusterEncoder_list}
    Should Contain    ${clusterEncoder_list}    === MTCamera_clusterEncoder start of topic ===
    Should Contain    ${clusterEncoder_list}    === MTCamera_clusterEncoder end of topic ===
    ${cyro_start}=    Get Index From List    ${full_list}    === MTCamera_cyro start of topic ===
    ${cyro_end}=    Get Index From List    ${full_list}    === MTCamera_cyro end of topic ===
    ${cyro_list}=    Get Slice From List    ${full_list}    start=${cyro_start}    end=${cyro_end + 1}
    Log Many    ${cyro_list}
    Should Contain    ${cyro_list}    === MTCamera_cyro start of topic ===
    Should Contain    ${cyro_list}    === MTCamera_cyro end of topic ===
    ${purge_start}=    Get Index From List    ${full_list}    === MTCamera_purge start of topic ===
    ${purge_end}=    Get Index From List    ${full_list}    === MTCamera_purge end of topic ===
    ${purge_list}=    Get Slice From List    ${full_list}    start=${purge_start}    end=${purge_end + 1}
    Log Many    ${purge_list}
    Should Contain    ${purge_list}    === MTCamera_purge start of topic ===
    Should Contain    ${purge_list}    === MTCamera_purge end of topic ===
    ${wds_start}=    Get Index From List    ${full_list}    === MTCamera_wds start of topic ===
    ${wds_end}=    Get Index From List    ${full_list}    === MTCamera_wds end of topic ===
    ${wds_list}=    Get Slice From List    ${full_list}    start=${wds_start}    end=${wds_end + 1}
    Log Many    ${wds_list}
    Should Contain    ${wds_list}    === MTCamera_wds start of topic ===
    Should Contain    ${wds_list}    === MTCamera_wds end of topic ===
    ${gds_start}=    Get Index From List    ${full_list}    === MTCamera_gds start of topic ===
    ${gds_end}=    Get Index From List    ${full_list}    === MTCamera_gds end of topic ===
    ${gds_list}=    Get Slice From List    ${full_list}    start=${gds_start}    end=${gds_end + 1}
    Log Many    ${gds_list}
    Should Contain    ${gds_list}    === MTCamera_gds start of topic ===
    Should Contain    ${gds_list}    === MTCamera_gds end of topic ===
    ${sds_start}=    Get Index From List    ${full_list}    === MTCamera_sds start of topic ===
    ${sds_end}=    Get Index From List    ${full_list}    === MTCamera_sds end of topic ===
    ${sds_list}=    Get Slice From List    ${full_list}    start=${sds_start}    end=${sds_end + 1}
    Log Many    ${sds_list}
    Should Contain    ${sds_list}    === MTCamera_sds start of topic ===
    Should Contain    ${sds_list}    === MTCamera_sds end of topic ===
    ${gas_start}=    Get Index From List    ${full_list}    === MTCamera_gas start of topic ===
    ${gas_end}=    Get Index From List    ${full_list}    === MTCamera_gas end of topic ===
    ${gas_list}=    Get Slice From List    ${full_list}    start=${gas_start}    end=${gas_end + 1}
    Log Many    ${gas_list}
    Should Contain    ${gas_list}    === MTCamera_gas start of topic ===
    Should Contain    ${gas_list}    === MTCamera_gas end of topic ===
    ${pcms_start}=    Get Index From List    ${full_list}    === MTCamera_pcms start of topic ===
    ${pcms_end}=    Get Index From List    ${full_list}    === MTCamera_pcms end of topic ===
    ${pcms_list}=    Get Slice From List    ${full_list}    start=${pcms_start}    end=${pcms_end + 1}
    Log Many    ${pcms_list}
    Should Contain    ${pcms_list}    === MTCamera_pcms start of topic ===
    Should Contain    ${pcms_list}    === MTCamera_pcms end of topic ===
    ${sas_start}=    Get Index From List    ${full_list}    === MTCamera_sas start of topic ===
    ${sas_end}=    Get Index From List    ${full_list}    === MTCamera_sas end of topic ===
    ${sas_list}=    Get Slice From List    ${full_list}    start=${sas_start}    end=${sas_end + 1}
    Log Many    ${sas_list}
    Should Contain    ${sas_list}    === MTCamera_sas start of topic ===
    Should Contain    ${sas_list}    === MTCamera_sas end of topic ===
    ${cold_start}=    Get Index From List    ${full_list}    === MTCamera_cold start of topic ===
    ${cold_end}=    Get Index From List    ${full_list}    === MTCamera_cold end of topic ===
    ${cold_list}=    Get Slice From List    ${full_list}    start=${cold_start}    end=${cold_end + 1}
    Log Many    ${cold_list}
    Should Contain    ${cold_list}    === MTCamera_cold start of topic ===
    Should Contain    ${cold_list}    === MTCamera_cold end of topic ===
