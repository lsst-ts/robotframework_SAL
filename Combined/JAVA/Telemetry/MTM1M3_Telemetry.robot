*** Settings ***
Documentation    MTM1M3_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
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
    Should Contain    ${output.stdout}    ===== MTM1M3 all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${forceActuatorData_start}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorData start of topic ===
    ${forceActuatorData_end}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorData end of topic ===
    ${forceActuatorData_list}=    Get Slice From List    ${full_list}    start=${forceActuatorData_start}    end=${forceActuatorData_end + 1}
    Log Many    ${forceActuatorData_list}
    Should Contain    ${forceActuatorData_list}    === MTM1M3_forceActuatorData start of topic ===
    Should Contain    ${forceActuatorData_list}    === MTM1M3_forceActuatorData end of topic ===
    ${inclinometerData_start}=    Get Index From List    ${full_list}    === MTM1M3_inclinometerData start of topic ===
    ${inclinometerData_end}=    Get Index From List    ${full_list}    === MTM1M3_inclinometerData end of topic ===
    ${inclinometerData_list}=    Get Slice From List    ${full_list}    start=${inclinometerData_start}    end=${inclinometerData_end + 1}
    Log Many    ${inclinometerData_list}
    Should Contain    ${inclinometerData_list}    === MTM1M3_inclinometerData start of topic ===
    Should Contain    ${inclinometerData_list}    === MTM1M3_inclinometerData end of topic ===
    ${outerLoopData_start}=    Get Index From List    ${full_list}    === MTM1M3_outerLoopData start of topic ===
    ${outerLoopData_end}=    Get Index From List    ${full_list}    === MTM1M3_outerLoopData end of topic ===
    ${outerLoopData_list}=    Get Slice From List    ${full_list}    start=${outerLoopData_start}    end=${outerLoopData_end + 1}
    Log Many    ${outerLoopData_list}
    Should Contain    ${outerLoopData_list}    === MTM1M3_outerLoopData start of topic ===
    Should Contain    ${outerLoopData_list}    === MTM1M3_outerLoopData end of topic ===
    ${accelerometerData_start}=    Get Index From List    ${full_list}    === MTM1M3_accelerometerData start of topic ===
    ${accelerometerData_end}=    Get Index From List    ${full_list}    === MTM1M3_accelerometerData end of topic ===
    ${accelerometerData_list}=    Get Slice From List    ${full_list}    start=${accelerometerData_start}    end=${accelerometerData_end + 1}
    Log Many    ${accelerometerData_list}
    Should Contain    ${accelerometerData_list}    === MTM1M3_accelerometerData start of topic ===
    Should Contain    ${accelerometerData_list}    === MTM1M3_accelerometerData end of topic ===
    ${hardpointActuatorData_start}=    Get Index From List    ${full_list}    === MTM1M3_hardpointActuatorData start of topic ===
    ${hardpointActuatorData_end}=    Get Index From List    ${full_list}    === MTM1M3_hardpointActuatorData end of topic ===
    ${hardpointActuatorData_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorData_start}    end=${hardpointActuatorData_end + 1}
    Log Many    ${hardpointActuatorData_list}
    Should Contain    ${hardpointActuatorData_list}    === MTM1M3_hardpointActuatorData start of topic ===
    Should Contain    ${hardpointActuatorData_list}    === MTM1M3_hardpointActuatorData end of topic ===
    ${imsData_start}=    Get Index From List    ${full_list}    === MTM1M3_imsData start of topic ===
    ${imsData_end}=    Get Index From List    ${full_list}    === MTM1M3_imsData end of topic ===
    ${imsData_list}=    Get Slice From List    ${full_list}    start=${imsData_start}    end=${imsData_end + 1}
    Log Many    ${imsData_list}
    Should Contain    ${imsData_list}    === MTM1M3_imsData start of topic ===
    Should Contain    ${imsData_list}    === MTM1M3_imsData end of topic ===
    ${gyroData_start}=    Get Index From List    ${full_list}    === MTM1M3_gyroData start of topic ===
    ${gyroData_end}=    Get Index From List    ${full_list}    === MTM1M3_gyroData end of topic ===
    ${gyroData_list}=    Get Slice From List    ${full_list}    start=${gyroData_start}    end=${gyroData_end + 1}
    Log Many    ${gyroData_list}
    Should Contain    ${gyroData_list}    === MTM1M3_gyroData start of topic ===
    Should Contain    ${gyroData_list}    === MTM1M3_gyroData end of topic ===
    ${powerSupplyData_start}=    Get Index From List    ${full_list}    === MTM1M3_powerSupplyData start of topic ===
    ${powerSupplyData_end}=    Get Index From List    ${full_list}    === MTM1M3_powerSupplyData end of topic ===
    ${powerSupplyData_list}=    Get Slice From List    ${full_list}    start=${powerSupplyData_start}    end=${powerSupplyData_end + 1}
    Log Many    ${powerSupplyData_list}
    Should Contain    ${powerSupplyData_list}    === MTM1M3_powerSupplyData start of topic ===
    Should Contain    ${powerSupplyData_list}    === MTM1M3_powerSupplyData end of topic ===
    ${pidData_start}=    Get Index From List    ${full_list}    === MTM1M3_pidData start of topic ===
    ${pidData_end}=    Get Index From List    ${full_list}    === MTM1M3_pidData end of topic ===
    ${pidData_list}=    Get Slice From List    ${full_list}    start=${pidData_start}    end=${pidData_end + 1}
    Log Many    ${pidData_list}
    Should Contain    ${pidData_list}    === MTM1M3_pidData start of topic ===
    Should Contain    ${pidData_list}    === MTM1M3_pidData end of topic ===
    ${hardpointMonitorData_start}=    Get Index From List    ${full_list}    === MTM1M3_hardpointMonitorData start of topic ===
    ${hardpointMonitorData_end}=    Get Index From List    ${full_list}    === MTM1M3_hardpointMonitorData end of topic ===
    ${hardpointMonitorData_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorData_start}    end=${hardpointMonitorData_end + 1}
    Log Many    ${hardpointMonitorData_list}
    Should Contain    ${hardpointMonitorData_list}    === MTM1M3_hardpointMonitorData start of topic ===
    Should Contain    ${hardpointMonitorData_list}    === MTM1M3_hardpointMonitorData end of topic ===
