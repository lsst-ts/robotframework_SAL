*** Settings ***
Documentation    Dome_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Should Contain    ${output.stdout}    ===== Dome all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${summary_start}=    Get Index From List    ${full_list}    === Dome_summary start of topic ===
    ${summary_end}=    Get Index From List    ${full_list}    === Dome_summary end of topic ===
    ${summary_list}=    Get Slice From List    ${full_list}    start=${summary_start}    end=${summary_end + 1}
    Log Many    ${summary_list}
    Should Contain    ${summary_list}    === Dome_summary start of topic ===
    Should Contain    ${summary_list}    === Dome_summary end of topic ===
    ${domeADB_status_start}=    Get Index From List    ${full_list}    === Dome_domeADB_status start of topic ===
    ${domeADB_status_end}=    Get Index From List    ${full_list}    === Dome_domeADB_status end of topic ===
    ${domeADB_status_list}=    Get Slice From List    ${full_list}    start=${domeADB_status_start}    end=${domeADB_status_end + 1}
    Log Many    ${domeADB_status_list}
    Should Contain    ${domeADB_status_list}    === Dome_domeADB_status start of topic ===
    Should Contain    ${domeADB_status_list}    === Dome_domeADB_status end of topic ===
    ${domeAPS_status_start}=    Get Index From List    ${full_list}    === Dome_domeAPS_status start of topic ===
    ${domeAPS_status_end}=    Get Index From List    ${full_list}    === Dome_domeAPS_status end of topic ===
    ${domeAPS_status_list}=    Get Slice From List    ${full_list}    start=${domeAPS_status_start}    end=${domeAPS_status_end + 1}
    Log Many    ${domeAPS_status_list}
    Should Contain    ${domeAPS_status_list}    === Dome_domeAPS_status start of topic ===
    Should Contain    ${domeAPS_status_list}    === Dome_domeAPS_status end of topic ===
    ${domeLouvers_status_start}=    Get Index From List    ${full_list}    === Dome_domeLouvers_status start of topic ===
    ${domeLouvers_status_end}=    Get Index From List    ${full_list}    === Dome_domeLouvers_status end of topic ===
    ${domeLouvers_status_list}=    Get Slice From List    ${full_list}    start=${domeLouvers_status_start}    end=${domeLouvers_status_end + 1}
    Log Many    ${domeLouvers_status_list}
    Should Contain    ${domeLouvers_status_list}    === Dome_domeLouvers_status start of topic ===
    Should Contain    ${domeLouvers_status_list}    === Dome_domeLouvers_status end of topic ===
    ${domeLWS_status_start}=    Get Index From List    ${full_list}    === Dome_domeLWS_status start of topic ===
    ${domeLWS_status_end}=    Get Index From List    ${full_list}    === Dome_domeLWS_status end of topic ===
    ${domeLWS_status_list}=    Get Slice From List    ${full_list}    start=${domeLWS_status_start}    end=${domeLWS_status_end + 1}
    Log Many    ${domeLWS_status_list}
    Should Contain    ${domeLWS_status_list}    === Dome_domeLWS_status start of topic ===
    Should Contain    ${domeLWS_status_list}    === Dome_domeLWS_status end of topic ===
    ${domeMONCS_status_start}=    Get Index From List    ${full_list}    === Dome_domeMONCS_status start of topic ===
    ${domeMONCS_status_end}=    Get Index From List    ${full_list}    === Dome_domeMONCS_status end of topic ===
    ${domeMONCS_status_list}=    Get Slice From List    ${full_list}    start=${domeMONCS_status_start}    end=${domeMONCS_status_end + 1}
    Log Many    ${domeMONCS_status_list}
    Should Contain    ${domeMONCS_status_list}    === Dome_domeMONCS_status start of topic ===
    Should Contain    ${domeMONCS_status_list}    === Dome_domeMONCS_status end of topic ===
    ${domeTHCS_status_start}=    Get Index From List    ${full_list}    === Dome_domeTHCS_status start of topic ===
    ${domeTHCS_status_end}=    Get Index From List    ${full_list}    === Dome_domeTHCS_status end of topic ===
    ${domeTHCS_status_list}=    Get Slice From List    ${full_list}    start=${domeTHCS_status_start}    end=${domeTHCS_status_end + 1}
    Log Many    ${domeTHCS_status_list}
    Should Contain    ${domeTHCS_status_list}    === Dome_domeTHCS_status start of topic ===
    Should Contain    ${domeTHCS_status_list}    === Dome_domeTHCS_status end of topic ===
