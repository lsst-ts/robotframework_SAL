*** Settings ***
Documentation    ATPneumatics_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPneumatics
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
    Should Contain    ${output.stdout}    ===== ATPneumatics all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${m1AirPressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_m1AirPressure start of topic ===
    ${m1AirPressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_m1AirPressure end of topic ===
    ${m1AirPressure_list}=    Get Slice From List    ${full_list}    start=${m1AirPressure_start}    end=${m1AirPressure_end + 1}
    Log Many    ${m1AirPressure_list}
    Should Contain    ${m1AirPressure_list}    === ATPneumatics_m1AirPressure start of topic ===
    Should Contain    ${m1AirPressure_list}    === ATPneumatics_m1AirPressure end of topic ===
    ${m2AirPressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_m2AirPressure start of topic ===
    ${m2AirPressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_m2AirPressure end of topic ===
    ${m2AirPressure_list}=    Get Slice From List    ${full_list}    start=${m2AirPressure_start}    end=${m2AirPressure_end + 1}
    Log Many    ${m2AirPressure_list}
    Should Contain    ${m2AirPressure_list}    === ATPneumatics_m2AirPressure start of topic ===
    Should Contain    ${m2AirPressure_list}    === ATPneumatics_m2AirPressure end of topic ===
    ${mainAirSourcePressure_start}=    Get Index From List    ${full_list}    === ATPneumatics_mainAirSourcePressure start of topic ===
    ${mainAirSourcePressure_end}=    Get Index From List    ${full_list}    === ATPneumatics_mainAirSourcePressure end of topic ===
    ${mainAirSourcePressure_list}=    Get Slice From List    ${full_list}    start=${mainAirSourcePressure_start}    end=${mainAirSourcePressure_end + 1}
    Log Many    ${mainAirSourcePressure_list}
    Should Contain    ${mainAirSourcePressure_list}    === ATPneumatics_mainAirSourcePressure start of topic ===
    Should Contain    ${mainAirSourcePressure_list}    === ATPneumatics_mainAirSourcePressure end of topic ===
    ${loadCell_start}=    Get Index From List    ${full_list}    === ATPneumatics_loadCell start of topic ===
    ${loadCell_end}=    Get Index From List    ${full_list}    === ATPneumatics_loadCell end of topic ===
    ${loadCell_list}=    Get Slice From List    ${full_list}    start=${loadCell_start}    end=${loadCell_end + 1}
    Log Many    ${loadCell_list}
    Should Contain    ${loadCell_list}    === ATPneumatics_loadCell start of topic ===
    Should Contain    ${loadCell_list}    === ATPneumatics_loadCell end of topic ===
