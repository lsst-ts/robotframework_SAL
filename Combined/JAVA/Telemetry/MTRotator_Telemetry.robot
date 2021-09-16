*** Settings ***
Documentation    MTRotator_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTRotator
${component}    all
${timeout}    400s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
        ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
        Sleep    3s
    END
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${ccwFollowingError_start}=    Get Index From List    ${full_list}    === MTRotator_ccwFollowingError start of topic ===
    ${ccwFollowingError_end}=    Get Index From List    ${full_list}    === MTRotator_ccwFollowingError end of topic ===
    ${ccwFollowingError_list}=    Get Slice From List    ${full_list}    start=${ccwFollowingError_start}    end=${ccwFollowingError_end + 1}
    Log Many    ${ccwFollowingError_list}
    Should Contain    ${ccwFollowingError_list}    === MTRotator_ccwFollowingError start of topic ===
    Should Contain    ${ccwFollowingError_list}    === MTRotator_ccwFollowingError end of topic ===
    Should Contain    ${ccwFollowingError_list}    === [ccwFollowingError] message sent 200
    ${rotation_start}=    Get Index From List    ${full_list}    === MTRotator_rotation start of topic ===
    ${rotation_end}=    Get Index From List    ${full_list}    === MTRotator_rotation end of topic ===
    ${rotation_list}=    Get Slice From List    ${full_list}    start=${rotation_start}    end=${rotation_end + 1}
    Log Many    ${rotation_list}
    Should Contain    ${rotation_list}    === MTRotator_rotation start of topic ===
    Should Contain    ${rotation_list}    === MTRotator_rotation end of topic ===
    Should Contain    ${rotation_list}    === [rotation] message sent 200
    ${electrical_start}=    Get Index From List    ${full_list}    === MTRotator_electrical start of topic ===
    ${electrical_end}=    Get Index From List    ${full_list}    === MTRotator_electrical end of topic ===
    ${electrical_list}=    Get Slice From List    ${full_list}    start=${electrical_start}    end=${electrical_end + 1}
    Log Many    ${electrical_list}
    Should Contain    ${electrical_list}    === MTRotator_electrical start of topic ===
    Should Contain    ${electrical_list}    === MTRotator_electrical end of topic ===
    Should Contain    ${electrical_list}    === [electrical] message sent 200
    ${motors_start}=    Get Index From List    ${full_list}    === MTRotator_motors start of topic ===
    ${motors_end}=    Get Index From List    ${full_list}    === MTRotator_motors end of topic ===
    ${motors_list}=    Get Slice From List    ${full_list}    start=${motors_start}    end=${motors_end + 1}
    Log Many    ${motors_list}
    Should Contain    ${motors_list}    === MTRotator_motors start of topic ===
    Should Contain    ${motors_list}    === MTRotator_motors end of topic ===
    Should Contain    ${motors_list}    === [motors] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTRotator all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${ccwFollowingError_start}=    Get Index From List    ${full_list}    === MTRotator_ccwFollowingError start of topic ===
    ${ccwFollowingError_end}=    Get Index From List    ${full_list}    === MTRotator_ccwFollowingError end of topic ===
    ${ccwFollowingError_list}=    Get Slice From List    ${full_list}    start=${ccwFollowingError_start}    end=${ccwFollowingError_end + 1}
    Log Many    ${ccwFollowingError_list}
    Should Contain    ${ccwFollowingError_list}    === MTRotator_ccwFollowingError start of topic ===
    Should Contain    ${ccwFollowingError_list}    === MTRotator_ccwFollowingError end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${ccwFollowingError_list}    === [ccwFollowingError Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${ccwFollowingError_list}    === [ccwFollowingError Subscriber] message received :200
    ${rotation_start}=    Get Index From List    ${full_list}    === MTRotator_rotation start of topic ===
    ${rotation_end}=    Get Index From List    ${full_list}    === MTRotator_rotation end of topic ===
    ${rotation_list}=    Get Slice From List    ${full_list}    start=${rotation_start}    end=${rotation_end + 1}
    Log Many    ${rotation_list}
    Should Contain    ${rotation_list}    === MTRotator_rotation start of topic ===
    Should Contain    ${rotation_list}    === MTRotator_rotation end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rotation_list}    === [rotation Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rotation_list}    === [rotation Subscriber] message received :200
    ${electrical_start}=    Get Index From List    ${full_list}    === MTRotator_electrical start of topic ===
    ${electrical_end}=    Get Index From List    ${full_list}    === MTRotator_electrical end of topic ===
    ${electrical_list}=    Get Slice From List    ${full_list}    start=${electrical_start}    end=${electrical_end + 1}
    Log Many    ${electrical_list}
    Should Contain    ${electrical_list}    === MTRotator_electrical start of topic ===
    Should Contain    ${electrical_list}    === MTRotator_electrical end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${electrical_list}    === [electrical Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${electrical_list}    === [electrical Subscriber] message received :200
    ${motors_start}=    Get Index From List    ${full_list}    === MTRotator_motors start of topic ===
    ${motors_end}=    Get Index From List    ${full_list}    === MTRotator_motors end of topic ===
    ${motors_list}=    Get Slice From List    ${full_list}    start=${motors_start}    end=${motors_end + 1}
    Log Many    ${motors_list}
    Should Contain    ${motors_list}    === MTRotator_motors start of topic ===
    Should Contain    ${motors_list}    === MTRotator_motors end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${motors_list}    === [motors Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${motors_list}    === [motors Subscriber] message received :200
