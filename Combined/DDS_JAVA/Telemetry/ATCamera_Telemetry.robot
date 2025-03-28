*** Settings ***
Documentation    ATCamera_Telemetry communications tests.
Force Tags    messaging    java    atcamera    
Suite Setup    Log Many    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
${component}    all
${timeout}    1200s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === ATCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === ATCamera_focal_plane_Ccd end of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd] message sent 200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === ATCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === ATCamera_focal_plane_Reb end of topic ===
    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb] message sent 200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === ATCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === ATCamera_focal_plane_RebTotalPower end of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower] message sent 200
    ${focal_plane_RebsAverageTemp6_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6 start of topic ===
    ${focal_plane_RebsAverageTemp6_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6 end of topic ===
    ${focal_plane_RebsAverageTemp6_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_start}    end=${focal_plane_RebsAverageTemp6_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === ATCamera_focal_plane_RebsAverageTemp6 start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === ATCamera_focal_plane_RebsAverageTemp6 end of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6] message sent 200
    ${daq_monitor_Reb_Trending_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Reb_Trending start of topic ===
    ${daq_monitor_Reb_Trending_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Reb_Trending end of topic ===
    ${daq_monitor_Reb_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Reb_Trending_start}    end=${daq_monitor_Reb_Trending_end + 1}
    Log Many    ${daq_monitor_Reb_Trending_list}
    Should Contain    ${daq_monitor_Reb_Trending_list}    === ATCamera_daq_monitor_Reb_Trending start of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === ATCamera_daq_monitor_Reb_Trending end of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending] message sent 200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store end of topic ===
    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store] message sent 200
    ${daq_monitor_Sum_Trending_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Sum_Trending start of topic ===
    ${daq_monitor_Sum_Trending_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Sum_Trending end of topic ===
    ${daq_monitor_Sum_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Sum_Trending_start}    end=${daq_monitor_Sum_Trending_end + 1}
    Log Many    ${daq_monitor_Sum_Trending_list}
    Should Contain    ${daq_monitor_Sum_Trending_list}    === ATCamera_daq_monitor_Sum_Trending start of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === ATCamera_daq_monitor_Sum_Trending end of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending] message sent 200
    ${power_start}=    Get Index From List    ${full_list}    === ATCamera_power start of topic ===
    ${power_end}=    Get Index From List    ${full_list}    === ATCamera_power end of topic ===
    ${power_list}=    Get Slice From List    ${full_list}    start=${power_start}    end=${power_end + 1}
    Log Many    ${power_list}
    Should Contain    ${power_list}    === ATCamera_power start of topic ===
    Should Contain    ${power_list}    === ATCamera_power end of topic ===
    Should Contain    ${power_list}    === [power] message sent 200
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end + 1}
    Log Many    ${vacuum_list}
    Should Contain    ${vacuum_list}    === ATCamera_vacuum start of topic ===
    Should Contain    ${vacuum_list}    === ATCamera_vacuum end of topic ===
    Should Contain    ${vacuum_list}    === [vacuum] message sent 200
    ${bonn_shutter_Device_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device start of topic ===
    ${bonn_shutter_Device_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device end of topic ===
    ${bonn_shutter_Device_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_start}    end=${bonn_shutter_Device_end + 1}
    Log Many    ${bonn_shutter_Device_list}
    Should Contain    ${bonn_shutter_Device_list}    === ATCamera_bonn_shutter_Device start of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === ATCamera_bonn_shutter_Device end of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end + 1}
    Log Many    ${focal_plane_Ccd_list}
    Should Contain    ${focal_plane_Ccd_list}    === ATCamera_focal_plane_Ccd start of topic ===
    Should Contain    ${focal_plane_Ccd_list}    === ATCamera_focal_plane_Ccd end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Ccd_list}    === [focal_plane_Ccd Subscriber] message received :200
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end + 1}
    Log Many    ${focal_plane_Reb_list}
    Should Contain    ${focal_plane_Reb_list}    === ATCamera_focal_plane_Reb start of topic ===
    Should Contain    ${focal_plane_Reb_list}    === ATCamera_focal_plane_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_Reb_list}    === [focal_plane_Reb Subscriber] message received :200
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end + 1}
    Log Many    ${focal_plane_RebTotalPower_list}
    Should Contain    ${focal_plane_RebTotalPower_list}    === ATCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain    ${focal_plane_RebTotalPower_list}    === ATCamera_focal_plane_RebTotalPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebTotalPower_list}    === [focal_plane_RebTotalPower Subscriber] message received :200
    ${focal_plane_RebsAverageTemp6_start}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6 start of topic ===
    ${focal_plane_RebsAverageTemp6_end}=    Get Index From List    ${full_list}    === ATCamera_focal_plane_RebsAverageTemp6 end of topic ===
    ${focal_plane_RebsAverageTemp6_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebsAverageTemp6_start}    end=${focal_plane_RebsAverageTemp6_end + 1}
    Log Many    ${focal_plane_RebsAverageTemp6_list}
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === ATCamera_focal_plane_RebsAverageTemp6 start of topic ===
    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === ATCamera_focal_plane_RebsAverageTemp6 end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6 Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${focal_plane_RebsAverageTemp6_list}    === [focal_plane_RebsAverageTemp6 Subscriber] message received :200
    ${daq_monitor_Reb_Trending_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Reb_Trending start of topic ===
    ${daq_monitor_Reb_Trending_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Reb_Trending end of topic ===
    ${daq_monitor_Reb_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Reb_Trending_start}    end=${daq_monitor_Reb_Trending_end + 1}
    Log Many    ${daq_monitor_Reb_Trending_list}
    Should Contain    ${daq_monitor_Reb_Trending_list}    === ATCamera_daq_monitor_Reb_Trending start of topic ===
    Should Contain    ${daq_monitor_Reb_Trending_list}    === ATCamera_daq_monitor_Reb_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Reb_Trending_list}    === [daq_monitor_Reb_Trending Subscriber] message received :200
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :200
    ${daq_monitor_Sum_Trending_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Sum_Trending start of topic ===
    ${daq_monitor_Sum_Trending_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Sum_Trending end of topic ===
    ${daq_monitor_Sum_Trending_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Sum_Trending_start}    end=${daq_monitor_Sum_Trending_end + 1}
    Log Many    ${daq_monitor_Sum_Trending_list}
    Should Contain    ${daq_monitor_Sum_Trending_list}    === ATCamera_daq_monitor_Sum_Trending start of topic ===
    Should Contain    ${daq_monitor_Sum_Trending_list}    === ATCamera_daq_monitor_Sum_Trending end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Sum_Trending_list}    === [daq_monitor_Sum_Trending Subscriber] message received :200
    ${power_start}=    Get Index From List    ${full_list}    === ATCamera_power start of topic ===
    ${power_end}=    Get Index From List    ${full_list}    === ATCamera_power end of topic ===
    ${power_list}=    Get Slice From List    ${full_list}    start=${power_start}    end=${power_end + 1}
    Log Many    ${power_list}
    Should Contain    ${power_list}    === ATCamera_power start of topic ===
    Should Contain    ${power_list}    === ATCamera_power end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${power_list}    === [power Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${power_list}    === [power Subscriber] message received :200
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end + 1}
    Log Many    ${vacuum_list}
    Should Contain    ${vacuum_list}    === ATCamera_vacuum start of topic ===
    Should Contain    ${vacuum_list}    === ATCamera_vacuum end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_list}    === [vacuum Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_list}    === [vacuum Subscriber] message received :200
    ${bonn_shutter_Device_start}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device start of topic ===
    ${bonn_shutter_Device_end}=    Get Index From List    ${full_list}    === ATCamera_bonn_shutter_Device end of topic ===
    ${bonn_shutter_Device_list}=    Get Slice From List    ${full_list}    start=${bonn_shutter_Device_start}    end=${bonn_shutter_Device_end + 1}
    Log Many    ${bonn_shutter_Device_list}
    Should Contain    ${bonn_shutter_Device_list}    === ATCamera_bonn_shutter_Device start of topic ===
    Should Contain    ${bonn_shutter_Device_list}    === ATCamera_bonn_shutter_Device end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${bonn_shutter_Device_list}    === [bonn_shutter_Device Subscriber] message received :200
