*** Settings ***
Documentation    Rotator_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Rotator
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
    Should Contain    ${output.stdout}    ===== Rotator all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${Electrical_start}=    Get Index From List    ${full_list}    === Rotator_Electrical start of topic ===
    ${Electrical_end}=    Get Index From List    ${full_list}    === Rotator_Electrical end of topic ===
    ${Electrical_list}=    Get Slice From List    ${full_list}    start=${Electrical_start}    end=${Electrical_end + 1}
    Log Many    ${Electrical_list}
    Should Contain    ${Electrical_list}    === Rotator_Electrical start of topic ===
    Should Contain    ${Electrical_list}    === Rotator_Electrical end of topic ===
    ${Application_start}=    Get Index From List    ${full_list}    === Rotator_Application start of topic ===
    ${Application_end}=    Get Index From List    ${full_list}    === Rotator_Application end of topic ===
    ${Application_list}=    Get Slice From List    ${full_list}    start=${Application_start}    end=${Application_end + 1}
    Log Many    ${Application_list}
    Should Contain    ${Application_list}    === Rotator_Application start of topic ===
    Should Contain    ${Application_list}    === Rotator_Application end of topic ===
    ${Motors_start}=    Get Index From List    ${full_list}    === Rotator_Motors start of topic ===
    ${Motors_end}=    Get Index From List    ${full_list}    === Rotator_Motors end of topic ===
    ${Motors_list}=    Get Slice From List    ${full_list}    start=${Motors_start}    end=${Motors_end + 1}
    Log Many    ${Motors_list}
    Should Contain    ${Motors_list}    === Rotator_Motors start of topic ===
    Should Contain    ${Motors_list}    === Rotator_Motors end of topic ===
