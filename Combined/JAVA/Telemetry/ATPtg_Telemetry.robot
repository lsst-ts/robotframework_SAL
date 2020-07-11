*** Settings ***
Documentation    ATPtg_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPtg
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}_${XMLVersion}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}_${XMLVersion}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATPtg all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
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
    ${skyEnvironment_start}=    Get Index From List    ${full_list}    === ATPtg_skyEnvironment start of topic ===
    ${skyEnvironment_end}=    Get Index From List    ${full_list}    === ATPtg_skyEnvironment end of topic ===
    ${skyEnvironment_list}=    Get Slice From List    ${full_list}    start=${skyEnvironment_start}    end=${skyEnvironment_end + 1}
    Log Many    ${skyEnvironment_list}
    Should Contain    ${skyEnvironment_list}    === ATPtg_skyEnvironment start of topic ===
    Should Contain    ${skyEnvironment_list}    === ATPtg_skyEnvironment end of topic ===
    ${namedAzEl_start}=    Get Index From List    ${full_list}    === ATPtg_namedAzEl start of topic ===
    ${namedAzEl_end}=    Get Index From List    ${full_list}    === ATPtg_namedAzEl end of topic ===
    ${namedAzEl_list}=    Get Slice From List    ${full_list}    start=${namedAzEl_start}    end=${namedAzEl_end + 1}
    Log Many    ${namedAzEl_list}
    Should Contain    ${namedAzEl_list}    === ATPtg_namedAzEl start of topic ===
    Should Contain    ${namedAzEl_list}    === ATPtg_namedAzEl end of topic ===
    ${mount_positions_start}=    Get Index From List    ${full_list}    === ATPtg_mount_positions start of topic ===
    ${mount_positions_end}=    Get Index From List    ${full_list}    === ATPtg_mount_positions end of topic ===
    ${mount_positions_list}=    Get Slice From List    ${full_list}    start=${mount_positions_start}    end=${mount_positions_end + 1}
    Log Many    ${mount_positions_list}
    Should Contain    ${mount_positions_list}    === ATPtg_mount_positions start of topic ===
    Should Contain    ${mount_positions_list}    === ATPtg_mount_positions end of topic ===
