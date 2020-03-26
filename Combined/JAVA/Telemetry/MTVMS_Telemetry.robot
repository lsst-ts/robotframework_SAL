*** Settings ***
Documentation    MTVMS_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTVMS
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    "${subscriberOutput}"   "1"
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${publisherOutput.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${publisherOutput.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTVMS all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${m1m3_start}=    Get Index From List    ${full_list}    === MTVMS_m1m3 start of topic ===
    ${m1m3_end}=    Get Index From List    ${full_list}    === MTVMS_m1m3 end of topic ===
    ${m1m3_list}=    Get Slice From List    ${full_list}    start=${m1m3_start}    end=${m1m3_end + 1}
    Log Many    ${m1m3_list}
    Should Contain    ${m1m3_list}    === MTVMS_m1m3 start of topic ===
    Should Contain    ${m1m3_list}    === MTVMS_m1m3 end of topic ===
    ${tma_start}=    Get Index From List    ${full_list}    === MTVMS_tma start of topic ===
    ${tma_end}=    Get Index From List    ${full_list}    === MTVMS_tma end of topic ===
    ${tma_list}=    Get Slice From List    ${full_list}    start=${tma_start}    end=${tma_end + 1}
    Log Many    ${tma_list}
    Should Contain    ${tma_list}    === MTVMS_tma start of topic ===
    Should Contain    ${tma_list}    === MTVMS_tma end of topic ===
    ${m2_start}=    Get Index From List    ${full_list}    === MTVMS_m2 start of topic ===
    ${m2_end}=    Get Index From List    ${full_list}    === MTVMS_m2 end of topic ===
    ${m2_list}=    Get Slice From List    ${full_list}    start=${m2_start}    end=${m2_end + 1}
    Log Many    ${m2_list}
    Should Contain    ${m2_list}    === MTVMS_m2 start of topic ===
    Should Contain    ${m2_list}    === MTVMS_m2 end of topic ===
    ${cameraRotator_start}=    Get Index From List    ${full_list}    === MTVMS_cameraRotator start of topic ===
    ${cameraRotator_end}=    Get Index From List    ${full_list}    === MTVMS_cameraRotator end of topic ===
    ${cameraRotator_list}=    Get Slice From List    ${full_list}    start=${cameraRotator_start}    end=${cameraRotator_end + 1}
    Log Many    ${cameraRotator_list}
    Should Contain    ${cameraRotator_list}    === MTVMS_cameraRotator start of topic ===
    Should Contain    ${cameraRotator_list}    === MTVMS_cameraRotator end of topic ===
