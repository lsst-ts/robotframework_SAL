*** Settings ***
Documentation    Dome_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Should Contain    ${output.stdout}    ===== Dome all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${azimuth_start}=    Get Index From List    ${full_list}    === Dome_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === Dome_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end + 1}
    Log Many    ${azimuth_list}
    Should Contain    ${azimuth_list}    === Dome_azimuth start of topic ===
    Should Contain    ${azimuth_list}    === Dome_azimuth end of topic ===
    ${lightWindScreen_start}=    Get Index From List    ${full_list}    === Dome_lightWindScreen start of topic ===
    ${lightWindScreen_end}=    Get Index From List    ${full_list}    === Dome_lightWindScreen end of topic ===
    ${lightWindScreen_list}=    Get Slice From List    ${full_list}    start=${lightWindScreen_start}    end=${lightWindScreen_end + 1}
    Log Many    ${lightWindScreen_list}
    Should Contain    ${lightWindScreen_list}    === Dome_lightWindScreen start of topic ===
    Should Contain    ${lightWindScreen_list}    === Dome_lightWindScreen end of topic ===
    ${apertureShutter_start}=    Get Index From List    ${full_list}    === Dome_apertureShutter start of topic ===
    ${apertureShutter_end}=    Get Index From List    ${full_list}    === Dome_apertureShutter end of topic ===
    ${apertureShutter_list}=    Get Slice From List    ${full_list}    start=${apertureShutter_start}    end=${apertureShutter_end + 1}
    Log Many    ${apertureShutter_list}
    Should Contain    ${apertureShutter_list}    === Dome_apertureShutter start of topic ===
    Should Contain    ${apertureShutter_list}    === Dome_apertureShutter end of topic ===
    ${louvers_start}=    Get Index From List    ${full_list}    === Dome_louvers start of topic ===
    ${louvers_end}=    Get Index From List    ${full_list}    === Dome_louvers end of topic ===
    ${louvers_list}=    Get Slice From List    ${full_list}    start=${louvers_start}    end=${louvers_end + 1}
    Log Many    ${louvers_list}
    Should Contain    ${louvers_list}    === Dome_louvers start of topic ===
    Should Contain    ${louvers_list}    === Dome_louvers end of topic ===
    ${interlocks_start}=    Get Index From List    ${full_list}    === Dome_interlocks start of topic ===
    ${interlocks_end}=    Get Index From List    ${full_list}    === Dome_interlocks end of topic ===
    ${interlocks_list}=    Get Slice From List    ${full_list}    start=${interlocks_start}    end=${interlocks_end + 1}
    Log Many    ${interlocks_list}
    Should Contain    ${interlocks_list}    === Dome_interlocks start of topic ===
    Should Contain    ${interlocks_list}    === Dome_interlocks end of topic ===
    ${thermal_start}=    Get Index From List    ${full_list}    === Dome_thermal start of topic ===
    ${thermal_end}=    Get Index From List    ${full_list}    === Dome_thermal end of topic ===
    ${thermal_list}=    Get Slice From List    ${full_list}    start=${thermal_start}    end=${thermal_end + 1}
    Log Many    ${thermal_list}
    Should Contain    ${thermal_list}    === Dome_thermal start of topic ===
    Should Contain    ${thermal_list}    === Dome_thermal end of topic ===
