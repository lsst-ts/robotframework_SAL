*** Settings ***
Documentation    ATCamera_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
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
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store end of topic ===
    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store] message sent 200
    ${fp_Reb_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Reb start of topic ===
    ${fp_Reb_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Reb end of topic ===
    ${fp_Reb_list}=    Get Slice From List    ${full_list}    start=${fp_Reb_start}    end=${fp_Reb_end + 1}
    Log Many    ${fp_Reb_list}
    Should Contain    ${fp_Reb_list}    === ATCamera_fp_Reb start of topic ===
    Should Contain    ${fp_Reb_list}    === ATCamera_fp_Reb end of topic ===
    Should Contain    ${fp_Reb_list}    === [fp_Reb] message sent 200
    ${fp_Ccd_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Ccd start of topic ===
    ${fp_Ccd_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Ccd end of topic ===
    ${fp_Ccd_list}=    Get Slice From List    ${full_list}    start=${fp_Ccd_start}    end=${fp_Ccd_end + 1}
    Log Many    ${fp_Ccd_list}
    Should Contain    ${fp_Ccd_list}    === ATCamera_fp_Ccd start of topic ===
    Should Contain    ${fp_Ccd_list}    === ATCamera_fp_Ccd end of topic ===
    Should Contain    ${fp_Ccd_list}    === [fp_Ccd] message sent 200
    ${fp_Segment_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Segment start of topic ===
    ${fp_Segment_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Segment end of topic ===
    ${fp_Segment_list}=    Get Slice From List    ${full_list}    start=${fp_Segment_start}    end=${fp_Segment_end + 1}
    Log Many    ${fp_Segment_list}
    Should Contain    ${fp_Segment_list}    === ATCamera_fp_Segment start of topic ===
    Should Contain    ${fp_Segment_list}    === ATCamera_fp_Segment end of topic ===
    Should Contain    ${fp_Segment_list}    === [fp_Segment] message sent 200
    ${fp_RebTotalPower_start}=    Get Index From List    ${full_list}    === ATCamera_fp_RebTotalPower start of topic ===
    ${fp_RebTotalPower_end}=    Get Index From List    ${full_list}    === ATCamera_fp_RebTotalPower end of topic ===
    ${fp_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${fp_RebTotalPower_start}    end=${fp_RebTotalPower_end + 1}
    Log Many    ${fp_RebTotalPower_list}
    Should Contain    ${fp_RebTotalPower_list}    === ATCamera_fp_RebTotalPower start of topic ===
    Should Contain    ${fp_RebTotalPower_list}    === ATCamera_fp_RebTotalPower end of topic ===
    Should Contain    ${fp_RebTotalPower_list}    === [fp_RebTotalPower] message sent 200
    ${wreb_start}=    Get Index From List    ${full_list}    === ATCamera_wreb start of topic ===
    ${wreb_end}=    Get Index From List    ${full_list}    === ATCamera_wreb end of topic ===
    ${wreb_list}=    Get Slice From List    ${full_list}    start=${wreb_start}    end=${wreb_end + 1}
    Log Many    ${wreb_list}
    Should Contain    ${wreb_list}    === ATCamera_wreb start of topic ===
    Should Contain    ${wreb_list}    === ATCamera_wreb end of topic ===
    Should Contain    ${wreb_list}    === [wreb] message sent 200
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end + 1}
    Log Many    ${bonnShutter_list}
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter start of topic ===
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter end of topic ===
    Should Contain    ${bonnShutter_list}    === [bonnShutter] message sent 200
    ${wrebPower_start}=    Get Index From List    ${full_list}    === ATCamera_wrebPower start of topic ===
    ${wrebPower_end}=    Get Index From List    ${full_list}    === ATCamera_wrebPower end of topic ===
    ${wrebPower_list}=    Get Slice From List    ${full_list}    start=${wrebPower_start}    end=${wrebPower_end + 1}
    Log Many    ${wrebPower_list}
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower start of topic ===
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower end of topic ===
    Should Contain    ${wrebPower_list}    === [wrebPower] message sent 200
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end + 1}
    Log Many    ${vacuum_list}
    Should Contain    ${vacuum_list}    === ATCamera_vacuum start of topic ===
    Should Contain    ${vacuum_list}    === ATCamera_vacuum end of topic ===
    Should Contain    ${vacuum_list}    === [vacuum] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === ATCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end + 1}
    Log Many    ${daq_monitor_Store_list}
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store start of topic ===
    Should Contain    ${daq_monitor_Store_list}    === ATCamera_daq_monitor_Store end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${daq_monitor_Store_list}    === [daq_monitor_Store Subscriber] message received :200
    ${fp_Reb_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Reb start of topic ===
    ${fp_Reb_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Reb end of topic ===
    ${fp_Reb_list}=    Get Slice From List    ${full_list}    start=${fp_Reb_start}    end=${fp_Reb_end + 1}
    Log Many    ${fp_Reb_list}
    Should Contain    ${fp_Reb_list}    === ATCamera_fp_Reb start of topic ===
    Should Contain    ${fp_Reb_list}    === ATCamera_fp_Reb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fp_Reb_list}    === [fp_Reb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fp_Reb_list}    === [fp_Reb Subscriber] message received :200
    ${fp_Ccd_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Ccd start of topic ===
    ${fp_Ccd_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Ccd end of topic ===
    ${fp_Ccd_list}=    Get Slice From List    ${full_list}    start=${fp_Ccd_start}    end=${fp_Ccd_end + 1}
    Log Many    ${fp_Ccd_list}
    Should Contain    ${fp_Ccd_list}    === ATCamera_fp_Ccd start of topic ===
    Should Contain    ${fp_Ccd_list}    === ATCamera_fp_Ccd end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fp_Ccd_list}    === [fp_Ccd Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fp_Ccd_list}    === [fp_Ccd Subscriber] message received :200
    ${fp_Segment_start}=    Get Index From List    ${full_list}    === ATCamera_fp_Segment start of topic ===
    ${fp_Segment_end}=    Get Index From List    ${full_list}    === ATCamera_fp_Segment end of topic ===
    ${fp_Segment_list}=    Get Slice From List    ${full_list}    start=${fp_Segment_start}    end=${fp_Segment_end + 1}
    Log Many    ${fp_Segment_list}
    Should Contain    ${fp_Segment_list}    === ATCamera_fp_Segment start of topic ===
    Should Contain    ${fp_Segment_list}    === ATCamera_fp_Segment end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fp_Segment_list}    === [fp_Segment Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fp_Segment_list}    === [fp_Segment Subscriber] message received :200
    ${fp_RebTotalPower_start}=    Get Index From List    ${full_list}    === ATCamera_fp_RebTotalPower start of topic ===
    ${fp_RebTotalPower_end}=    Get Index From List    ${full_list}    === ATCamera_fp_RebTotalPower end of topic ===
    ${fp_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${fp_RebTotalPower_start}    end=${fp_RebTotalPower_end + 1}
    Log Many    ${fp_RebTotalPower_list}
    Should Contain    ${fp_RebTotalPower_list}    === ATCamera_fp_RebTotalPower start of topic ===
    Should Contain    ${fp_RebTotalPower_list}    === ATCamera_fp_RebTotalPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${fp_RebTotalPower_list}    === [fp_RebTotalPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${fp_RebTotalPower_list}    === [fp_RebTotalPower Subscriber] message received :200
    ${wreb_start}=    Get Index From List    ${full_list}    === ATCamera_wreb start of topic ===
    ${wreb_end}=    Get Index From List    ${full_list}    === ATCamera_wreb end of topic ===
    ${wreb_list}=    Get Slice From List    ${full_list}    start=${wreb_start}    end=${wreb_end + 1}
    Log Many    ${wreb_list}
    Should Contain    ${wreb_list}    === ATCamera_wreb start of topic ===
    Should Contain    ${wreb_list}    === ATCamera_wreb end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${wreb_list}    === [wreb Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${wreb_list}    === [wreb Subscriber] message received :200
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end + 1}
    Log Many    ${bonnShutter_list}
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter start of topic ===
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${bonnShutter_list}    === [bonnShutter Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${bonnShutter_list}    === [bonnShutter Subscriber] message received :200
    ${wrebPower_start}=    Get Index From List    ${full_list}    === ATCamera_wrebPower start of topic ===
    ${wrebPower_end}=    Get Index From List    ${full_list}    === ATCamera_wrebPower end of topic ===
    ${wrebPower_list}=    Get Slice From List    ${full_list}    start=${wrebPower_start}    end=${wrebPower_end + 1}
    Log Many    ${wrebPower_list}
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower start of topic ===
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${wrebPower_list}    === [wrebPower Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${wrebPower_list}    === [wrebPower Subscriber] message received :200
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end + 1}
    Log Many    ${vacuum_list}
    Should Contain    ${vacuum_list}    === ATCamera_vacuum start of topic ===
    Should Contain    ${vacuum_list}    === ATCamera_vacuum end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${vacuum_list}    === [vacuum Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${vacuum_list}    === [vacuum Subscriber] message received :200
