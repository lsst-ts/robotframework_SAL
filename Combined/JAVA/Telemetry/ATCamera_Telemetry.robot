*** Settings ***
Documentation    ATCamera_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
${component}    all
${timeout}    600s

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
    Should Contain    ${output.stdout}    ===== ATCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${wreb_start}=    Get Index From List    ${full_list}    === ATCamera_wreb start of topic ===
    ${wreb_end}=    Get Index From List    ${full_list}    === ATCamera_wreb end of topic ===
    ${wreb_list}=    Get Slice From List    ${full_list}    start=${wreb_start}    end=${wreb_end + 1}
    Log Many    ${wreb_list}
    Should Contain    ${wreb_list}    === ATCamera_wreb start of topic ===
    Should Contain    ${wreb_list}    === ATCamera_wreb end of topic ===
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end + 1}
    Log Many    ${bonnShutter_list}
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter start of topic ===
    Should Contain    ${bonnShutter_list}    === ATCamera_bonnShutter end of topic ===
    ${wrebPower_start}=    Get Index From List    ${full_list}    === ATCamera_wrebPower start of topic ===
    ${wrebPower_end}=    Get Index From List    ${full_list}    === ATCamera_wrebPower end of topic ===
    ${wrebPower_list}=    Get Slice From List    ${full_list}    start=${wrebPower_start}    end=${wrebPower_end + 1}
    Log Many    ${wrebPower_list}
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower start of topic ===
    Should Contain    ${wrebPower_list}    === ATCamera_wrebPower end of topic ===
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end + 1}
    Log Many    ${vacuum_list}
    Should Contain    ${vacuum_list}    === ATCamera_vacuum start of topic ===
    Should Contain    ${vacuum_list}    === ATCamera_vacuum end of topic ===
