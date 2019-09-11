*** Settings ***
Documentation    ATPtg_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPtg
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
    Should Contain    ${output.stdout}    ===== ATPtg all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${prospectiveTargetStatus_start}=    Get Index From List    ${full_list}    === ATPtg_prospectiveTargetStatus start of topic ===
    ${prospectiveTargetStatus_end}=    Get Index From List    ${full_list}    === ATPtg_prospectiveTargetStatus end of topic ===
    ${prospectiveTargetStatus_list}=    Get Slice From List    ${full_list}    start=${prospectiveTargetStatus_start}    end=${prospectiveTargetStatus_end + 1}
    Log Many    ${prospectiveTargetStatus_list}
    Should Contain    ${prospectiveTargetStatus_list}    === ATPtg_prospectiveTargetStatus start of topic ===
    Should Contain    ${prospectiveTargetStatus_list}    === ATPtg_prospectiveTargetStatus end of topic ===
    ${nextTargetStatus_start}=    Get Index From List    ${full_list}    === ATPtg_nextTargetStatus start of topic ===
    ${nextTargetStatus_end}=    Get Index From List    ${full_list}    === ATPtg_nextTargetStatus end of topic ===
    ${nextTargetStatus_list}=    Get Slice From List    ${full_list}    start=${nextTargetStatus_start}    end=${nextTargetStatus_end + 1}
    Log Many    ${nextTargetStatus_list}
    Should Contain    ${nextTargetStatus_list}    === ATPtg_nextTargetStatus start of topic ===
    Should Contain    ${nextTargetStatus_list}    === ATPtg_nextTargetStatus end of topic ===
    ${currentTimesToLimits_start}=    Get Index From List    ${full_list}    === ATPtg_currentTimesToLimits start of topic ===
    ${currentTimesToLimits_end}=    Get Index From List    ${full_list}    === ATPtg_currentTimesToLimits end of topic ===
    ${currentTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${currentTimesToLimits_start}    end=${currentTimesToLimits_end + 1}
    Log Many    ${currentTimesToLimits_list}
    Should Contain    ${currentTimesToLimits_list}    === ATPtg_currentTimesToLimits start of topic ===
    Should Contain    ${currentTimesToLimits_list}    === ATPtg_currentTimesToLimits end of topic ===
    ${currentTargetStatus_start}=    Get Index From List    ${full_list}    === ATPtg_currentTargetStatus start of topic ===
    ${currentTargetStatus_end}=    Get Index From List    ${full_list}    === ATPtg_currentTargetStatus end of topic ===
    ${currentTargetStatus_list}=    Get Slice From List    ${full_list}    start=${currentTargetStatus_start}    end=${currentTargetStatus_end + 1}
    Log Many    ${currentTargetStatus_list}
    Should Contain    ${currentTargetStatus_list}    === ATPtg_currentTargetStatus start of topic ===
    Should Contain    ${currentTargetStatus_list}    === ATPtg_currentTargetStatus end of topic ===
    ${guidingAndOffsets_start}=    Get Index From List    ${full_list}    === ATPtg_guidingAndOffsets start of topic ===
    ${guidingAndOffsets_end}=    Get Index From List    ${full_list}    === ATPtg_guidingAndOffsets end of topic ===
    ${guidingAndOffsets_list}=    Get Slice From List    ${full_list}    start=${guidingAndOffsets_start}    end=${guidingAndOffsets_end + 1}
    Log Many    ${guidingAndOffsets_list}
    Should Contain    ${guidingAndOffsets_list}    === ATPtg_guidingAndOffsets start of topic ===
    Should Contain    ${guidingAndOffsets_list}    === ATPtg_guidingAndOffsets end of topic ===
    ${prospectiveTimesToLimits_start}=    Get Index From List    ${full_list}    === ATPtg_prospectiveTimesToLimits start of topic ===
    ${prospectiveTimesToLimits_end}=    Get Index From List    ${full_list}    === ATPtg_prospectiveTimesToLimits end of topic ===
    ${prospectiveTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${prospectiveTimesToLimits_start}    end=${prospectiveTimesToLimits_end + 1}
    Log Many    ${prospectiveTimesToLimits_list}
    Should Contain    ${prospectiveTimesToLimits_list}    === ATPtg_prospectiveTimesToLimits start of topic ===
    Should Contain    ${prospectiveTimesToLimits_list}    === ATPtg_prospectiveTimesToLimits end of topic ===
    ${timeAndDate_start}=    Get Index From List    ${full_list}    === ATPtg_timeAndDate start of topic ===
    ${timeAndDate_end}=    Get Index From List    ${full_list}    === ATPtg_timeAndDate end of topic ===
    ${timeAndDate_list}=    Get Slice From List    ${full_list}    start=${timeAndDate_start}    end=${timeAndDate_end + 1}
    Log Many    ${timeAndDate_list}
    Should Contain    ${timeAndDate_list}    === ATPtg_timeAndDate start of topic ===
    Should Contain    ${timeAndDate_list}    === ATPtg_timeAndDate end of topic ===
    ${mountStatus_start}=    Get Index From List    ${full_list}    === ATPtg_mountStatus start of topic ===
    ${mountStatus_end}=    Get Index From List    ${full_list}    === ATPtg_mountStatus end of topic ===
    ${mountStatus_list}=    Get Slice From List    ${full_list}    start=${mountStatus_start}    end=${mountStatus_end + 1}
    Log Many    ${mountStatus_list}
    Should Contain    ${mountStatus_list}    === ATPtg_mountStatus start of topic ===
    Should Contain    ${mountStatus_list}    === ATPtg_mountStatus end of topic ===
    ${nextTimesToLimits_start}=    Get Index From List    ${full_list}    === ATPtg_nextTimesToLimits start of topic ===
    ${nextTimesToLimits_end}=    Get Index From List    ${full_list}    === ATPtg_nextTimesToLimits end of topic ===
    ${nextTimesToLimits_list}=    Get Slice From List    ${full_list}    start=${nextTimesToLimits_start}    end=${nextTimesToLimits_end + 1}
    Log Many    ${nextTimesToLimits_list}
    Should Contain    ${nextTimesToLimits_list}    === ATPtg_nextTimesToLimits start of topic ===
    Should Contain    ${nextTimesToLimits_list}    === ATPtg_nextTimesToLimits end of topic ===
