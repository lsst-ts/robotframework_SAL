*** Settings ***
Documentation    Hexapod_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Hexapod
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
    Should Contain    ${output.stdout}    ===== Hexapod all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${actuators_start}=    Get Index From List    ${full_list}    === Hexapod_actuators start of topic ===
    ${actuators_end}=    Get Index From List    ${full_list}    === Hexapod_actuators end of topic ===
    ${actuators_list}=    Get Slice From List    ${full_list}    start=${actuators_start}    end=${actuators_end + 1}
    Log Many    ${actuators_list}
    Should Contain    ${actuators_list}    === Hexapod_actuators start of topic ===
    Should Contain    ${actuators_list}    === Hexapod_actuators end of topic ===
    ${application_start}=    Get Index From List    ${full_list}    === Hexapod_application start of topic ===
    ${application_end}=    Get Index From List    ${full_list}    === Hexapod_application end of topic ===
    ${application_list}=    Get Slice From List    ${full_list}    start=${application_start}    end=${application_end + 1}
    Log Many    ${application_list}
    Should Contain    ${application_list}    === Hexapod_application start of topic ===
    Should Contain    ${application_list}    === Hexapod_application end of topic ===
    ${electrical_start}=    Get Index From List    ${full_list}    === Hexapod_electrical start of topic ===
    ${electrical_end}=    Get Index From List    ${full_list}    === Hexapod_electrical end of topic ===
    ${electrical_list}=    Get Slice From List    ${full_list}    start=${electrical_start}    end=${electrical_end + 1}
    Log Many    ${electrical_list}
    Should Contain    ${electrical_list}    === Hexapod_electrical start of topic ===
    Should Contain    ${electrical_list}    === Hexapod_electrical end of topic ===
