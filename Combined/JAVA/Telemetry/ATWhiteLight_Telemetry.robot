*** Settings ***
Documentation    ATWhiteLight_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATWhiteLight
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
    Should Contain    ${output.stdout}    ===== ATWhiteLight all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${timestamp_start}=    Get Index From List    ${full_list}    === ATWhiteLight_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === ATWhiteLight_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end + 1}
    Log Many    ${timestamp_list}
    Should Contain    ${timestamp_list}    === ATWhiteLight_timestamp start of topic ===
    Should Contain    ${timestamp_list}    === ATWhiteLight_timestamp end of topic ===
    ${loopTime_start}=    Get Index From List    ${full_list}    === ATWhiteLight_loopTime start of topic ===
    ${loopTime_end}=    Get Index From List    ${full_list}    === ATWhiteLight_loopTime end of topic ===
    ${loopTime_list}=    Get Slice From List    ${full_list}    start=${loopTime_start}    end=${loopTime_end + 1}
    Log Many    ${loopTime_list}
    Should Contain    ${loopTime_list}    === ATWhiteLight_loopTime start of topic ===
    Should Contain    ${loopTime_list}    === ATWhiteLight_loopTime end of topic ===
    ${bulbhour_start}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbhour start of topic ===
    ${bulbhour_end}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbhour end of topic ===
    ${bulbhour_list}=    Get Slice From List    ${full_list}    start=${bulbhour_start}    end=${bulbhour_end + 1}
    Log Many    ${bulbhour_list}
    Should Contain    ${bulbhour_list}    === ATWhiteLight_bulbhour start of topic ===
    Should Contain    ${bulbhour_list}    === ATWhiteLight_bulbhour end of topic ===
    ${bulbWatthour_start}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbWatthour start of topic ===
    ${bulbWatthour_end}=    Get Index From List    ${full_list}    === ATWhiteLight_bulbWatthour end of topic ===
    ${bulbWatthour_list}=    Get Slice From List    ${full_list}    start=${bulbWatthour_start}    end=${bulbWatthour_end + 1}
    Log Many    ${bulbWatthour_list}
    Should Contain    ${bulbWatthour_list}    === ATWhiteLight_bulbWatthour start of topic ===
    Should Contain    ${bulbWatthour_list}    === ATWhiteLight_bulbWatthour end of topic ===
    ${chillerFansSpeed_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerFansSpeed start of topic ===
    ${chillerFansSpeed_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerFansSpeed end of topic ===
    ${chillerFansSpeed_list}=    Get Slice From List    ${full_list}    start=${chillerFansSpeed_start}    end=${chillerFansSpeed_end + 1}
    Log Many    ${chillerFansSpeed_list}
    Should Contain    ${chillerFansSpeed_list}    === ATWhiteLight_chillerFansSpeed start of topic ===
    Should Contain    ${chillerFansSpeed_list}    === ATWhiteLight_chillerFansSpeed end of topic ===
    ${chillerUpTime_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerUpTime start of topic ===
    ${chillerUpTime_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerUpTime end of topic ===
    ${chillerUpTime_list}=    Get Slice From List    ${full_list}    start=${chillerUpTime_start}    end=${chillerUpTime_end + 1}
    Log Many    ${chillerUpTime_list}
    Should Contain    ${chillerUpTime_list}    === ATWhiteLight_chillerUpTime start of topic ===
    Should Contain    ${chillerUpTime_list}    === ATWhiteLight_chillerUpTime end of topic ===
    ${chillerTempSensors_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTempSensors start of topic ===
    ${chillerTempSensors_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTempSensors end of topic ===
    ${chillerTempSensors_list}=    Get Slice From List    ${full_list}    start=${chillerTempSensors_start}    end=${chillerTempSensors_end + 1}
    Log Many    ${chillerTempSensors_list}
    Should Contain    ${chillerTempSensors_list}    === ATWhiteLight_chillerTempSensors start of topic ===
    Should Contain    ${chillerTempSensors_list}    === ATWhiteLight_chillerTempSensors end of topic ===
    ${chillerProcessFlow_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerProcessFlow start of topic ===
    ${chillerProcessFlow_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerProcessFlow end of topic ===
    ${chillerProcessFlow_list}=    Get Slice From List    ${full_list}    start=${chillerProcessFlow_start}    end=${chillerProcessFlow_end + 1}
    Log Many    ${chillerProcessFlow_list}
    Should Contain    ${chillerProcessFlow_list}    === ATWhiteLight_chillerProcessFlow start of topic ===
    Should Contain    ${chillerProcessFlow_list}    === ATWhiteLight_chillerProcessFlow end of topic ===
    ${chillerTECBankCurrent_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTECBankCurrent start of topic ===
    ${chillerTECBankCurrent_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTECBankCurrent end of topic ===
    ${chillerTECBankCurrent_list}=    Get Slice From List    ${full_list}    start=${chillerTECBankCurrent_start}    end=${chillerTECBankCurrent_end + 1}
    Log Many    ${chillerTECBankCurrent_list}
    Should Contain    ${chillerTECBankCurrent_list}    === ATWhiteLight_chillerTECBankCurrent start of topic ===
    Should Contain    ${chillerTECBankCurrent_list}    === ATWhiteLight_chillerTECBankCurrent end of topic ===
    ${chillerTEDriveLevel_start}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTEDriveLevel start of topic ===
    ${chillerTEDriveLevel_end}=    Get Index From List    ${full_list}    === ATWhiteLight_chillerTEDriveLevel end of topic ===
    ${chillerTEDriveLevel_list}=    Get Slice From List    ${full_list}    start=${chillerTEDriveLevel_start}    end=${chillerTEDriveLevel_end + 1}
    Log Many    ${chillerTEDriveLevel_list}
    Should Contain    ${chillerTEDriveLevel_list}    === ATWhiteLight_chillerTEDriveLevel start of topic ===
    Should Contain    ${chillerTEDriveLevel_list}    === ATWhiteLight_chillerTEDriveLevel end of topic ===
