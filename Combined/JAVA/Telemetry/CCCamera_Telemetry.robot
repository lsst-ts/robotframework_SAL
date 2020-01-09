*** Settings ***
Documentation    CCCamera_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCCamera
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
    Should Contain    ${output.stdout}    ===== CCCamera all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=34
    ${filterChanger_start}=    Get Index From List    ${full_list}    === CCCamera_filterChanger start of topic ===
    ${filterChanger_end}=    Get Index From List    ${full_list}    === CCCamera_filterChanger end of topic ===
    ${filterChanger_list}=    Get Slice From List    ${full_list}    start=${filterChanger_start}    end=${filterChanger_end + 1}
    Log Many    ${filterChanger_list}
    Should Contain    ${filterChanger_list}    === CCCamera_filterChanger start of topic ===
    Should Contain    ${filterChanger_list}    === CCCamera_filterChanger end of topic ===
    ${vacuumTurboPump_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumTurboPump start of topic ===
    ${vacuumTurboPump_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumTurboPump end of topic ===
    ${vacuumTurboPump_list}=    Get Slice From List    ${full_list}    start=${vacuumTurboPump_start}    end=${vacuumTurboPump_end + 1}
    Log Many    ${vacuumTurboPump_list}
    Should Contain    ${vacuumTurboPump_list}    === CCCamera_vacuumTurboPump start of topic ===
    Should Contain    ${vacuumTurboPump_list}    === CCCamera_vacuumTurboPump end of topic ===
    ${vacuumIonPump_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumIonPump start of topic ===
    ${vacuumIonPump_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumIonPump end of topic ===
    ${vacuumIonPump_list}=    Get Slice From List    ${full_list}    start=${vacuumIonPump_start}    end=${vacuumIonPump_end + 1}
    Log Many    ${vacuumIonPump_list}
    Should Contain    ${vacuumIonPump_list}    === CCCamera_vacuumIonPump start of topic ===
    Should Contain    ${vacuumIonPump_list}    === CCCamera_vacuumIonPump end of topic ===
    ${vacuumCryoTelColdPlate1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate1 start of topic ===
    ${vacuumCryoTelColdPlate1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate1 end of topic ===
    ${vacuumCryoTelColdPlate1_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelColdPlate1_start}    end=${vacuumCryoTelColdPlate1_end + 1}
    Log Many    ${vacuumCryoTelColdPlate1_list}
    Should Contain    ${vacuumCryoTelColdPlate1_list}    === CCCamera_vacuumCryoTelColdPlate1 start of topic ===
    Should Contain    ${vacuumCryoTelColdPlate1_list}    === CCCamera_vacuumCryoTelColdPlate1 end of topic ===
    ${vacuumCryoTelColdPlate2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate2 start of topic ===
    ${vacuumCryoTelColdPlate2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate2 end of topic ===
    ${vacuumCryoTelColdPlate2_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelColdPlate2_start}    end=${vacuumCryoTelColdPlate2_end + 1}
    Log Many    ${vacuumCryoTelColdPlate2_list}
    Should Contain    ${vacuumCryoTelColdPlate2_list}    === CCCamera_vacuumCryoTelColdPlate2 start of topic ===
    Should Contain    ${vacuumCryoTelColdPlate2_list}    === CCCamera_vacuumCryoTelColdPlate2 end of topic ===
    ${vacuumCryoTelCryoPlate_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelCryoPlate start of topic ===
    ${vacuumCryoTelCryoPlate_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelCryoPlate end of topic ===
    ${vacuumCryoTelCryoPlate_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelCryoPlate_start}    end=${vacuumCryoTelCryoPlate_end + 1}
    Log Many    ${vacuumCryoTelCryoPlate_list}
    Should Contain    ${vacuumCryoTelCryoPlate_list}    === CCCamera_vacuumCryoTelCryoPlate start of topic ===
    Should Contain    ${vacuumCryoTelCryoPlate_list}    === CCCamera_vacuumCryoTelCryoPlate end of topic ===
    ${vacuumPressureGauge_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumPressureGauge start of topic ===
    ${vacuumPressureGauge_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumPressureGauge end of topic ===
    ${vacuumPressureGauge_list}=    Get Slice From List    ${full_list}    start=${vacuumPressureGauge_start}    end=${vacuumPressureGauge_end + 1}
    Log Many    ${vacuumPressureGauge_list}
    Should Contain    ${vacuumPressureGauge_list}    === CCCamera_vacuumPressureGauge start of topic ===
    Should Contain    ${vacuumPressureGauge_list}    === CCCamera_vacuumPressureGauge end of topic ===
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end + 1}
    Log Many    ${bonnShutter_list}
    Should Contain    ${bonnShutter_list}    === CCCamera_bonnShutter start of topic ===
    Should Contain    ${bonnShutter_list}    === CCCamera_bonnShutter end of topic ===
    ${vacuumPowerDistributionUnit_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumPowerDistributionUnit start of topic ===
    ${vacuumPowerDistributionUnit_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumPowerDistributionUnit end of topic ===
    ${vacuumPowerDistributionUnit_list}=    Get Slice From List    ${full_list}    start=${vacuumPowerDistributionUnit_start}    end=${vacuumPowerDistributionUnit_end + 1}
    Log Many    ${vacuumPowerDistributionUnit_list}
    Should Contain    ${vacuumPowerDistributionUnit_list}    === CCCamera_vacuumPowerDistributionUnit start of topic ===
    Should Contain    ${vacuumPowerDistributionUnit_list}    === CCCamera_vacuumPowerDistributionUnit end of topic ===
    ${vacuumStatus_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumStatus start of topic ===
    ${vacuumStatus_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumStatus end of topic ===
    ${vacuumStatus_list}=    Get Slice From List    ${full_list}    start=${vacuumStatus_start}    end=${vacuumStatus_end + 1}
    Log Many    ${vacuumStatus_list}
    Should Contain    ${vacuumStatus_list}    === CCCamera_vacuumStatus start of topic ===
    Should Contain    ${vacuumStatus_list}    === CCCamera_vacuumStatus end of topic ===
