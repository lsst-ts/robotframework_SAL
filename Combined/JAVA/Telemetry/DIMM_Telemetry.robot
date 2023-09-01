*** Settings ***
Documentation    DIMM_Telemetry communications tests.
Force Tags    messaging    java    dimm    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DIMM
${component}    all
${timeout}    400s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Be Equal    ${output.returncode}   ${NONE}
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
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${sky_start}=    Get Index From List    ${full_list}    === DIMM_sky start of topic ===
    ${sky_end}=    Get Index From List    ${full_list}    === DIMM_sky end of topic ===
    ${sky_list}=    Get Slice From List    ${full_list}    start=${sky_start}    end=${sky_end + 1}
    Log Many    ${sky_list}
    Should Contain    ${sky_list}    === DIMM_sky start of topic ===
    Should Contain    ${sky_list}    === DIMM_sky end of topic ===
    Should Contain    ${sky_list}    === [sky] message sent 200
    ${meterology_start}=    Get Index From List    ${full_list}    === DIMM_meterology start of topic ===
    ${meterology_end}=    Get Index From List    ${full_list}    === DIMM_meterology end of topic ===
    ${meterology_list}=    Get Slice From List    ${full_list}    start=${meterology_start}    end=${meterology_end + 1}
    Log Many    ${meterology_list}
    Should Contain    ${meterology_list}    === DIMM_meterology start of topic ===
    Should Contain    ${meterology_list}    === DIMM_meterology end of topic ===
    Should Contain    ${meterology_list}    === [meterology] message sent 200
    ${status_start}=    Get Index From List    ${full_list}    === DIMM_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === DIMM_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end + 1}
    Log Many    ${status_list}
    Should Contain    ${status_list}    === DIMM_status start of topic ===
    Should Contain    ${status_list}    === DIMM_status end of topic ===
    Should Contain    ${status_list}    === [status] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== DIMM all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${sky_start}=    Get Index From List    ${full_list}    === DIMM_sky start of topic ===
    ${sky_end}=    Get Index From List    ${full_list}    === DIMM_sky end of topic ===
    ${sky_list}=    Get Slice From List    ${full_list}    start=${sky_start}    end=${sky_end + 1}
    Log Many    ${sky_list}
    Should Contain    ${sky_list}    === DIMM_sky start of topic ===
    Should Contain    ${sky_list}    === DIMM_sky end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${sky_list}    === [sky Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${sky_list}    === [sky Subscriber] message received :200
    ${meterology_start}=    Get Index From List    ${full_list}    === DIMM_meterology start of topic ===
    ${meterology_end}=    Get Index From List    ${full_list}    === DIMM_meterology end of topic ===
    ${meterology_list}=    Get Slice From List    ${full_list}    start=${meterology_start}    end=${meterology_end + 1}
    Log Many    ${meterology_list}
    Should Contain    ${meterology_list}    === DIMM_meterology start of topic ===
    Should Contain    ${meterology_list}    === DIMM_meterology end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${meterology_list}    === [meterology Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${meterology_list}    === [meterology Subscriber] message received :200
    ${status_start}=    Get Index From List    ${full_list}    === DIMM_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === DIMM_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end + 1}
    Log Many    ${status_list}
    Should Contain    ${status_list}    === DIMM_status start of topic ===
    Should Contain    ${status_list}    === DIMM_status end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${status_list}    === [status Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${status_list}    === [status Subscriber] message received :200
