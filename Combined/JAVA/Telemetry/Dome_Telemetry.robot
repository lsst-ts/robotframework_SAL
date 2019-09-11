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
    ${DomeADB_status_start}=    Get Index From List    ${full_list}    === Dome_DomeADB_status start of topic ===
    ${DomeADB_status_end}=    Get Index From List    ${full_list}    === Dome_DomeADB_status end of topic ===
    ${DomeADB_status_list}=    Get Slice From List    ${full_list}    start=${DomeADB_status_start}    end=${DomeADB_status_end + 1}
    Log Many    ${DomeADB_status_list}
    Should Contain    ${DomeADB_status_list}    === Dome_DomeADB_status start of topic ===
    Should Contain    ${DomeADB_status_list}    === Dome_DomeADB_status end of topic ===
    ${DomeAPS_status_start}=    Get Index From List    ${full_list}    === Dome_DomeAPS_status start of topic ===
    ${DomeAPS_status_end}=    Get Index From List    ${full_list}    === Dome_DomeAPS_status end of topic ===
    ${DomeAPS_status_list}=    Get Slice From List    ${full_list}    start=${DomeAPS_status_start}    end=${DomeAPS_status_end + 1}
    Log Many    ${DomeAPS_status_list}
    Should Contain    ${DomeAPS_status_list}    === Dome_DomeAPS_status start of topic ===
    Should Contain    ${DomeAPS_status_list}    === Dome_DomeAPS_status end of topic ===
    ${DomeLouvers_status_start}=    Get Index From List    ${full_list}    === Dome_DomeLouvers_status start of topic ===
    ${DomeLouvers_status_end}=    Get Index From List    ${full_list}    === Dome_DomeLouvers_status end of topic ===
    ${DomeLouvers_status_list}=    Get Slice From List    ${full_list}    start=${DomeLouvers_status_start}    end=${DomeLouvers_status_end + 1}
    Log Many    ${DomeLouvers_status_list}
    Should Contain    ${DomeLouvers_status_list}    === Dome_DomeLouvers_status start of topic ===
    Should Contain    ${DomeLouvers_status_list}    === Dome_DomeLouvers_status end of topic ===
    ${DomeLWS_status_start}=    Get Index From List    ${full_list}    === Dome_DomeLWS_status start of topic ===
    ${DomeLWS_status_end}=    Get Index From List    ${full_list}    === Dome_DomeLWS_status end of topic ===
    ${DomeLWS_status_list}=    Get Slice From List    ${full_list}    start=${DomeLWS_status_start}    end=${DomeLWS_status_end + 1}
    Log Many    ${DomeLWS_status_list}
    Should Contain    ${DomeLWS_status_list}    === Dome_DomeLWS_status start of topic ===
    Should Contain    ${DomeLWS_status_list}    === Dome_DomeLWS_status end of topic ===
    ${DomeMONCS_status_start}=    Get Index From List    ${full_list}    === Dome_DomeMONCS_status start of topic ===
    ${DomeMONCS_status_end}=    Get Index From List    ${full_list}    === Dome_DomeMONCS_status end of topic ===
    ${DomeMONCS_status_list}=    Get Slice From List    ${full_list}    start=${DomeMONCS_status_start}    end=${DomeMONCS_status_end + 1}
    Log Many    ${DomeMONCS_status_list}
    Should Contain    ${DomeMONCS_status_list}    === Dome_DomeMONCS_status start of topic ===
    Should Contain    ${DomeMONCS_status_list}    === Dome_DomeMONCS_status end of topic ===
    ${DomeTHCS_status_start}=    Get Index From List    ${full_list}    === Dome_DomeTHCS_status start of topic ===
    ${DomeTHCS_status_end}=    Get Index From List    ${full_list}    === Dome_DomeTHCS_status end of topic ===
    ${DomeTHCS_status_list}=    Get Slice From List    ${full_list}    start=${DomeTHCS_status_start}    end=${DomeTHCS_status_end + 1}
    Log Many    ${DomeTHCS_status_list}
    Should Contain    ${DomeTHCS_status_list}    === Dome_DomeTHCS_status start of topic ===
    Should Contain    ${DomeTHCS_status_list}    === Dome_DomeTHCS_status end of topic ===
