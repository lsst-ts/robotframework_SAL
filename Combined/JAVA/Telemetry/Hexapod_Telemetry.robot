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
    ${Actuators_start}=    Get Index From List    ${full_list}    === Hexapod_Actuators start of topic ===
    ${Actuators_end}=    Get Index From List    ${full_list}    === Hexapod_Actuators end of topic ===
    ${Actuators_list}=    Get Slice From List    ${full_list}    start=${Actuators_start}    end=${Actuators_end + 1}
    Log Many    ${Actuators_list}
    Should Contain    ${Actuators_list}    === Hexapod_Actuators start of topic ===
    Should Contain    ${Actuators_list}    === Hexapod_Actuators end of topic ===
    ${Application_start}=    Get Index From List    ${full_list}    === Hexapod_Application start of topic ===
    ${Application_end}=    Get Index From List    ${full_list}    === Hexapod_Application end of topic ===
    ${Application_list}=    Get Slice From List    ${full_list}    start=${Application_start}    end=${Application_end + 1}
    Log Many    ${Application_list}
    Should Contain    ${Application_list}    === Hexapod_Application start of topic ===
    Should Contain    ${Application_list}    === Hexapod_Application end of topic ===
    ${Electrical_start}=    Get Index From List    ${full_list}    === Hexapod_Electrical start of topic ===
    ${Electrical_end}=    Get Index From List    ${full_list}    === Hexapod_Electrical end of topic ===
    ${Electrical_list}=    Get Slice From List    ${full_list}    start=${Electrical_start}    end=${Electrical_end + 1}
    Log Many    ${Electrical_list}
    Should Contain    ${Electrical_list}    === Hexapod_Electrical start of topic ===
    Should Contain    ${Electrical_list}    === Hexapod_Electrical end of topic ===
