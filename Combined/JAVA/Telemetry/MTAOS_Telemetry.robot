*** Settings ***
Documentation    MTAOS_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTAOS
${component}    all
${timeout}    600s
${maven}        ${SALVersion}_${XMLVersion}${MavenVersion}

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${maven}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${maven}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTAOS all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${wepDuration_start}=    Get Index From List    ${full_list}    === MTAOS_wepDuration start of topic ===
    ${wepDuration_end}=    Get Index From List    ${full_list}    === MTAOS_wepDuration end of topic ===
    ${wepDuration_list}=    Get Slice From List    ${full_list}    start=${wepDuration_start}    end=${wepDuration_end + 1}
    Log Many    ${wepDuration_list}
    Should Contain    ${wepDuration_list}    === MTAOS_wepDuration start of topic ===
    Should Contain    ${wepDuration_list}    === MTAOS_wepDuration end of topic ===
    ${ofcDuration_start}=    Get Index From List    ${full_list}    === MTAOS_ofcDuration start of topic ===
    ${ofcDuration_end}=    Get Index From List    ${full_list}    === MTAOS_ofcDuration end of topic ===
    ${ofcDuration_list}=    Get Slice From List    ${full_list}    start=${ofcDuration_start}    end=${ofcDuration_end + 1}
    Log Many    ${ofcDuration_list}
    Should Contain    ${ofcDuration_list}    === MTAOS_ofcDuration start of topic ===
    Should Contain    ${ofcDuration_list}    === MTAOS_ofcDuration end of topic ===
