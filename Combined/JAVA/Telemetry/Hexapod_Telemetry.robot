*** Settings ***
Documentation    Hexapod_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Hexapod
${component}    all
${timeout}    600s

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

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Hexapod all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
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
