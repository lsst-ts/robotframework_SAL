*** Settings ***
Documentation    MTMount_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
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
    Should Contain    ${output.stdout}    ===== MTMount all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${Camera_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    ${Camera_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Camera_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Camera_Cable_Wrap_start}    end=${Camera_Cable_Wrap_end + 1}
    Log Many    ${Camera_Cable_Wrap_list}
    Should Contain    ${Camera_Cable_Wrap_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    Should Contain    ${Camera_Cable_Wrap_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Safety_System_start}=    Get Index From List    ${full_list}    === MTMount_Safety_System start of topic ===
    ${Safety_System_end}=    Get Index From List    ${full_list}    === MTMount_Safety_System end of topic ===
    ${Safety_System_list}=    Get Slice From List    ${full_list}    start=${Safety_System_start}    end=${Safety_System_end + 1}
    Log Many    ${Safety_System_list}
    Should Contain    ${Safety_System_list}    === MTMount_Safety_System start of topic ===
    Should Contain    ${Safety_System_list}    === MTMount_Safety_System end of topic ===
