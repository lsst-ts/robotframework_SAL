*** Settings ***
Documentation    Test_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Test
${component}    all
${timeout}    400s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    Comment    The Test CSC is not a true Java artifact and is never published as such. Remove the MavenVersion string to accommodate RPM packaging.
    Set Suite Variable    ${MavenVersion}    ${EMPTY}
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${scalars_start}=    Get Index From List    ${full_list}    === Test_scalars start of topic ===
    ${scalars_end}=    Get Index From List    ${full_list}    === Test_scalars end of topic ===
    ${scalars_list}=    Get Slice From List    ${full_list}    start=${scalars_start}    end=${scalars_end + 1}
    Log Many    ${scalars_list}
    Should Contain    ${scalars_list}    === Test_scalars start of topic ===
    Should Contain    ${scalars_list}    === Test_scalars end of topic ===
    Should Contain    ${scalars_list}    === [scalars] message sent 200
    ${arrays_start}=    Get Index From List    ${full_list}    === Test_arrays start of topic ===
    ${arrays_end}=    Get Index From List    ${full_list}    === Test_arrays end of topic ===
    ${arrays_list}=    Get Slice From List    ${full_list}    start=${arrays_start}    end=${arrays_end + 1}
    Log Many    ${arrays_list}
    Should Contain    ${arrays_list}    === Test_arrays start of topic ===
    Should Contain    ${arrays_list}    === Test_arrays end of topic ===
    Should Contain    ${arrays_list}    === [arrays] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Test all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${scalars_start}=    Get Index From List    ${full_list}    === Test_scalars start of topic ===
    ${scalars_end}=    Get Index From List    ${full_list}    === Test_scalars end of topic ===
    ${scalars_list}=    Get Slice From List    ${full_list}    start=${scalars_start}    end=${scalars_end + 1}
    Log Many    ${scalars_list}
    Should Contain    ${scalars_list}    === Test_scalars start of topic ===
    Should Contain    ${scalars_list}    === Test_scalars end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${scalars_list}    === [scalars Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${scalars_list}    === [scalars Subscriber] message received :200
    ${arrays_start}=    Get Index From List    ${full_list}    === Test_arrays start of topic ===
    ${arrays_end}=    Get Index From List    ${full_list}    === Test_arrays end of topic ===
    ${arrays_list}=    Get Slice From List    ${full_list}    start=${arrays_start}    end=${arrays_end + 1}
    Log Many    ${arrays_list}
    Should Contain    ${arrays_list}    === Test_arrays start of topic ===
    Should Contain    ${arrays_list}    === Test_arrays end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${arrays_list}    === [arrays Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${arrays_list}    === [arrays Subscriber] message received :200
