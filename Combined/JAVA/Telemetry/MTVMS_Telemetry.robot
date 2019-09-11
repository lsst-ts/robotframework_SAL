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
    Should Contain    ${output.stdout}    ===== MTVMS all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${M1M3_start}=    Get Index From List    ${full_list}    === MTVMS_M1M3 start of topic ===
    ${M1M3_end}=    Get Index From List    ${full_list}    === MTVMS_M1M3 end of topic ===
    ${M1M3_list}=    Get Slice From List    ${full_list}    start=${M1M3_start}    end=${M1M3_end + 1}
    Log Many    ${M1M3_list}
    Should Contain    ${M1M3_list}    === MTVMS_M1M3 start of topic ===
    Should Contain    ${M1M3_list}    === MTVMS_M1M3 end of topic ===
    ${TMA_start}=    Get Index From List    ${full_list}    === MTVMS_TMA start of topic ===
    ${TMA_end}=    Get Index From List    ${full_list}    === MTVMS_TMA end of topic ===
    ${TMA_list}=    Get Slice From List    ${full_list}    start=${TMA_start}    end=${TMA_end + 1}
    Log Many    ${TMA_list}
    Should Contain    ${TMA_list}    === MTVMS_TMA start of topic ===
    Should Contain    ${TMA_list}    === MTVMS_TMA end of topic ===
    ${M2_start}=    Get Index From List    ${full_list}    === MTVMS_M2 start of topic ===
    ${M2_end}=    Get Index From List    ${full_list}    === MTVMS_M2 end of topic ===
    ${M2_list}=    Get Slice From List    ${full_list}    start=${M2_start}    end=${M2_end + 1}
    Log Many    ${M2_list}
    Should Contain    ${M2_list}    === MTVMS_M2 start of topic ===
    Should Contain    ${M2_list}    === MTVMS_M2 end of topic ===
    ${cameraRotator_start}=    Get Index From List    ${full_list}    === MTVMS_cameraRotator start of topic ===
    ${cameraRotator_end}=    Get Index From List    ${full_list}    === MTVMS_cameraRotator end of topic ===
    ${cameraRotator_list}=    Get Slice From List    ${full_list}    start=${cameraRotator_start}    end=${cameraRotator_end + 1}
    Log Many    ${cameraRotator_list}
    Should Contain    ${cameraRotator_list}    === MTVMS_cameraRotator start of topic ===
    Should Contain    ${cameraRotator_list}    === MTVMS_cameraRotator end of topic ===
