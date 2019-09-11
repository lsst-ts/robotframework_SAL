*** Settings ***
Documentation    HVAC_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    HVAC
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
    Should Contain    ${output.stdout}    ===== HVAC all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${lowerAHUStatus_start}=    Get Index From List    ${full_list}    === HVAC_lowerAHUStatus start of topic ===
    ${lowerAHUStatus_end}=    Get Index From List    ${full_list}    === HVAC_lowerAHUStatus end of topic ===
    ${lowerAHUStatus_list}=    Get Slice From List    ${full_list}    start=${lowerAHUStatus_start}    end=${lowerAHUStatus_end + 1}
    Log Many    ${lowerAHUStatus_list}
    Should Contain    ${lowerAHUStatus_list}    === HVAC_lowerAHUStatus start of topic ===
    Should Contain    ${lowerAHUStatus_list}    === HVAC_lowerAHUStatus end of topic ===
    ${lowerChillerStatus_start}=    Get Index From List    ${full_list}    === HVAC_lowerChillerStatus start of topic ===
    ${lowerChillerStatus_end}=    Get Index From List    ${full_list}    === HVAC_lowerChillerStatus end of topic ===
    ${lowerChillerStatus_list}=    Get Slice From List    ${full_list}    start=${lowerChillerStatus_start}    end=${lowerChillerStatus_end + 1}
    Log Many    ${lowerChillerStatus_list}
    Should Contain    ${lowerChillerStatus_list}    === HVAC_lowerChillerStatus start of topic ===
    Should Contain    ${lowerChillerStatus_list}    === HVAC_lowerChillerStatus end of topic ===
    ${whiteRoomAHU_start}=    Get Index From List    ${full_list}    === HVAC_whiteRoomAHU start of topic ===
    ${whiteRoomAHU_end}=    Get Index From List    ${full_list}    === HVAC_whiteRoomAHU end of topic ===
    ${whiteRoomAHU_list}=    Get Slice From List    ${full_list}    start=${whiteRoomAHU_start}    end=${whiteRoomAHU_end + 1}
    Log Many    ${whiteRoomAHU_list}
    Should Contain    ${whiteRoomAHU_list}    === HVAC_whiteRoomAHU start of topic ===
    Should Contain    ${whiteRoomAHU_list}    === HVAC_whiteRoomAHU end of topic ===
