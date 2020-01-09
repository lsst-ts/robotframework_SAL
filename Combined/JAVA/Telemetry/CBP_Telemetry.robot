*** Settings ***
Documentation    CBP_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CBP
${component}    all
${timeout}    90s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${subscriberOutput}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Subscriber    stdout=${EXECDIR}${/}stdoutSubscriber.txt    stderr=${EXECDIR}${/}stderrSubscriber.txt
    Log    ${subscriberOutput}
    Should Contain    "${subscriberOutput}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${publisherOutput}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Publisher    stdout=${EXECDIR}${/}stdoutPublisher.txt    stderr=${EXECDIR}${/}stderrPublisher.txt
    Log    ${publisherOutput.stdout}
    Should Contain    ${publisherOutput.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${publisherOutput.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CBP all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${status_start}=    Get Index From List    ${full_list}    === CBP_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === CBP_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end + 1}
    Log Many    ${status_list}
    Should Contain    ${status_list}    === CBP_status start of topic ===
    Should Contain    ${status_list}    === CBP_status end of topic ===
    ${mask_start}=    Get Index From List    ${full_list}    === CBP_mask start of topic ===
    ${mask_end}=    Get Index From List    ${full_list}    === CBP_mask end of topic ===
    ${mask_list}=    Get Slice From List    ${full_list}    start=${mask_start}    end=${mask_end + 1}
    Log Many    ${mask_list}
    Should Contain    ${mask_list}    === CBP_mask start of topic ===
    Should Contain    ${mask_list}    === CBP_mask end of topic ===
    ${azimuth_start}=    Get Index From List    ${full_list}    === CBP_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === CBP_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end + 1}
    Log Many    ${azimuth_list}
    Should Contain    ${azimuth_list}    === CBP_azimuth start of topic ===
    Should Contain    ${azimuth_list}    === CBP_azimuth end of topic ===
    ${altitude_start}=    Get Index From List    ${full_list}    === CBP_altitude start of topic ===
    ${altitude_end}=    Get Index From List    ${full_list}    === CBP_altitude end of topic ===
    ${altitude_list}=    Get Slice From List    ${full_list}    start=${altitude_start}    end=${altitude_end + 1}
    Log Many    ${altitude_list}
    Should Contain    ${altitude_list}    === CBP_altitude start of topic ===
    Should Contain    ${altitude_list}    === CBP_altitude end of topic ===
    ${focus_start}=    Get Index From List    ${full_list}    === CBP_focus start of topic ===
    ${focus_end}=    Get Index From List    ${full_list}    === CBP_focus end of topic ===
    ${focus_list}=    Get Slice From List    ${full_list}    start=${focus_start}    end=${focus_end + 1}
    Log Many    ${focus_list}
    Should Contain    ${focus_list}    === CBP_focus start of topic ===
    Should Contain    ${focus_list}    === CBP_focus end of topic ===
    ${parked_start}=    Get Index From List    ${full_list}    === CBP_parked start of topic ===
    ${parked_end}=    Get Index From List    ${full_list}    === CBP_parked end of topic ===
    ${parked_list}=    Get Slice From List    ${full_list}    start=${parked_start}    end=${parked_end + 1}
    Log Many    ${parked_list}
    Should Contain    ${parked_list}    === CBP_parked start of topic ===
    Should Contain    ${parked_list}    === CBP_parked end of topic ===