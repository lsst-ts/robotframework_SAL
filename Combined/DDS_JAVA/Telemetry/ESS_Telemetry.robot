*** Settings ***
Documentation    ESS_Telemetry communications tests.
Force Tags    messaging    java    ess    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ESS
${component}    all
${timeout}    1200s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -e    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -e    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_dds-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${airTurbulence_start}=    Get Index From List    ${full_list}    === ESS_airTurbulence start of topic ===
    ${airTurbulence_end}=    Get Index From List    ${full_list}    === ESS_airTurbulence end of topic ===
    ${airTurbulence_list}=    Get Slice From List    ${full_list}    start=${airTurbulence_start}    end=${airTurbulence_end + 1}
    Log Many    ${airTurbulence_list}
    Should Contain    ${airTurbulence_list}    === ESS_airTurbulence start of topic ===
    Should Contain    ${airTurbulence_list}    === ESS_airTurbulence end of topic ===
    Should Contain    ${airTurbulence_list}    === [airTurbulence] message sent 200
    ${airFlow_start}=    Get Index From List    ${full_list}    === ESS_airFlow start of topic ===
    ${airFlow_end}=    Get Index From List    ${full_list}    === ESS_airFlow end of topic ===
    ${airFlow_list}=    Get Slice From List    ${full_list}    start=${airFlow_start}    end=${airFlow_end + 1}
    Log Many    ${airFlow_list}
    Should Contain    ${airFlow_list}    === ESS_airFlow start of topic ===
    Should Contain    ${airFlow_list}    === ESS_airFlow end of topic ===
    Should Contain    ${airFlow_list}    === [airFlow] message sent 200
    ${dewPoint_start}=    Get Index From List    ${full_list}    === ESS_dewPoint start of topic ===
    ${dewPoint_end}=    Get Index From List    ${full_list}    === ESS_dewPoint end of topic ===
    ${dewPoint_list}=    Get Slice From List    ${full_list}    start=${dewPoint_start}    end=${dewPoint_end + 1}
    Log Many    ${dewPoint_list}
    Should Contain    ${dewPoint_list}    === ESS_dewPoint start of topic ===
    Should Contain    ${dewPoint_list}    === ESS_dewPoint end of topic ===
    Should Contain    ${dewPoint_list}    === [dewPoint] message sent 200
    ${pressure_start}=    Get Index From List    ${full_list}    === ESS_pressure start of topic ===
    ${pressure_end}=    Get Index From List    ${full_list}    === ESS_pressure end of topic ===
    ${pressure_list}=    Get Slice From List    ${full_list}    start=${pressure_start}    end=${pressure_end + 1}
    Log Many    ${pressure_list}
    Should Contain    ${pressure_list}    === ESS_pressure start of topic ===
    Should Contain    ${pressure_list}    === ESS_pressure end of topic ===
    Should Contain    ${pressure_list}    === [pressure] message sent 200
    ${rainRate_start}=    Get Index From List    ${full_list}    === ESS_rainRate start of topic ===
    ${rainRate_end}=    Get Index From List    ${full_list}    === ESS_rainRate end of topic ===
    ${rainRate_list}=    Get Slice From List    ${full_list}    start=${rainRate_start}    end=${rainRate_end + 1}
    Log Many    ${rainRate_list}
    Should Contain    ${rainRate_list}    === ESS_rainRate start of topic ===
    Should Contain    ${rainRate_list}    === ESS_rainRate end of topic ===
    Should Contain    ${rainRate_list}    === [rainRate] message sent 200
    ${relativeHumidity_start}=    Get Index From List    ${full_list}    === ESS_relativeHumidity start of topic ===
    ${relativeHumidity_end}=    Get Index From List    ${full_list}    === ESS_relativeHumidity end of topic ===
    ${relativeHumidity_list}=    Get Slice From List    ${full_list}    start=${relativeHumidity_start}    end=${relativeHumidity_end + 1}
    Log Many    ${relativeHumidity_list}
    Should Contain    ${relativeHumidity_list}    === ESS_relativeHumidity start of topic ===
    Should Contain    ${relativeHumidity_list}    === ESS_relativeHumidity end of topic ===
    Should Contain    ${relativeHumidity_list}    === [relativeHumidity] message sent 200
    ${snowRate_start}=    Get Index From List    ${full_list}    === ESS_snowRate start of topic ===
    ${snowRate_end}=    Get Index From List    ${full_list}    === ESS_snowRate end of topic ===
    ${snowRate_list}=    Get Slice From List    ${full_list}    start=${snowRate_start}    end=${snowRate_end + 1}
    Log Many    ${snowRate_list}
    Should Contain    ${snowRate_list}    === ESS_snowRate start of topic ===
    Should Contain    ${snowRate_list}    === ESS_snowRate end of topic ===
    Should Contain    ${snowRate_list}    === [snowRate] message sent 200
    ${solarRadiation_start}=    Get Index From List    ${full_list}    === ESS_solarRadiation start of topic ===
    ${solarRadiation_end}=    Get Index From List    ${full_list}    === ESS_solarRadiation end of topic ===
    ${solarRadiation_list}=    Get Slice From List    ${full_list}    start=${solarRadiation_start}    end=${solarRadiation_end + 1}
    Log Many    ${solarRadiation_list}
    Should Contain    ${solarRadiation_list}    === ESS_solarRadiation start of topic ===
    Should Contain    ${solarRadiation_list}    === ESS_solarRadiation end of topic ===
    Should Contain    ${solarRadiation_list}    === [solarRadiation] message sent 200
    ${temperature_start}=    Get Index From List    ${full_list}    === ESS_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === ESS_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end + 1}
    Log Many    ${temperature_list}
    Should Contain    ${temperature_list}    === ESS_temperature start of topic ===
    Should Contain    ${temperature_list}    === ESS_temperature end of topic ===
    Should Contain    ${temperature_list}    === [temperature] message sent 200
    ${accelerometer_start}=    Get Index From List    ${full_list}    === ESS_accelerometer start of topic ===
    ${accelerometer_end}=    Get Index From List    ${full_list}    === ESS_accelerometer end of topic ===
    ${accelerometer_list}=    Get Slice From List    ${full_list}    start=${accelerometer_start}    end=${accelerometer_end + 1}
    Log Many    ${accelerometer_list}
    Should Contain    ${accelerometer_list}    === ESS_accelerometer start of topic ===
    Should Contain    ${accelerometer_list}    === ESS_accelerometer end of topic ===
    Should Contain    ${accelerometer_list}    === [accelerometer] message sent 200
    ${accelerometerPSD_start}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD start of topic ===
    ${accelerometerPSD_end}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD end of topic ===
    ${accelerometerPSD_list}=    Get Slice From List    ${full_list}    start=${accelerometerPSD_start}    end=${accelerometerPSD_end + 1}
    Log Many    ${accelerometerPSD_list}
    Should Contain    ${accelerometerPSD_list}    === ESS_accelerometerPSD start of topic ===
    Should Contain    ${accelerometerPSD_list}    === ESS_accelerometerPSD end of topic ===
    Should Contain    ${accelerometerPSD_list}    === [accelerometerPSD] message sent 200
    ${electricFieldStrength_start}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength start of topic ===
    ${electricFieldStrength_end}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength end of topic ===
    ${electricFieldStrength_list}=    Get Slice From List    ${full_list}    start=${electricFieldStrength_start}    end=${electricFieldStrength_end + 1}
    Log Many    ${electricFieldStrength_list}
    Should Contain    ${electricFieldStrength_list}    === ESS_electricFieldStrength start of topic ===
    Should Contain    ${electricFieldStrength_list}    === ESS_electricFieldStrength end of topic ===
    Should Contain    ${electricFieldStrength_list}    === [electricFieldStrength] message sent 200
    ${lightningStrikeStatus_start}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus start of topic ===
    ${lightningStrikeStatus_end}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus end of topic ===
    ${lightningStrikeStatus_list}=    Get Slice From List    ${full_list}    start=${lightningStrikeStatus_start}    end=${lightningStrikeStatus_end + 1}
    Log Many    ${lightningStrikeStatus_list}
    Should Contain    ${lightningStrikeStatus_list}    === ESS_lightningStrikeStatus start of topic ===
    Should Contain    ${lightningStrikeStatus_list}    === ESS_lightningStrikeStatus end of topic ===
    Should Contain    ${lightningStrikeStatus_list}    === [lightningStrikeStatus] message sent 200
    ${spectrumAnalyzer_start}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer start of topic ===
    ${spectrumAnalyzer_end}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer end of topic ===
    ${spectrumAnalyzer_list}=    Get Slice From List    ${full_list}    start=${spectrumAnalyzer_start}    end=${spectrumAnalyzer_end + 1}
    Log Many    ${spectrumAnalyzer_list}
    Should Contain    ${spectrumAnalyzer_list}    === ESS_spectrumAnalyzer start of topic ===
    Should Contain    ${spectrumAnalyzer_list}    === ESS_spectrumAnalyzer end of topic ===
    Should Contain    ${spectrumAnalyzer_list}    === [spectrumAnalyzer] message sent 200
    ${earthquakeBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain start of topic ===
    ${earthquakeBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain end of topic ===
    ${earthquakeBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandHighGain_start}    end=${earthquakeBroadBandHighGain_end + 1}
    Log Many    ${earthquakeBroadBandHighGain_list}
    Should Contain    ${earthquakeBroadBandHighGain_list}    === ESS_earthquakeBroadBandHighGain start of topic ===
    Should Contain    ${earthquakeBroadBandHighGain_list}    === ESS_earthquakeBroadBandHighGain end of topic ===
    Should Contain    ${earthquakeBroadBandHighGain_list}    === [earthquakeBroadBandHighGain] message sent 200
    ${earthquakeBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain start of topic ===
    ${earthquakeBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain end of topic ===
    ${earthquakeBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandLowGain_start}    end=${earthquakeBroadBandLowGain_end + 1}
    Log Many    ${earthquakeBroadBandLowGain_list}
    Should Contain    ${earthquakeBroadBandLowGain_list}    === ESS_earthquakeBroadBandLowGain start of topic ===
    Should Contain    ${earthquakeBroadBandLowGain_list}    === ESS_earthquakeBroadBandLowGain end of topic ===
    Should Contain    ${earthquakeBroadBandLowGain_list}    === [earthquakeBroadBandLowGain] message sent 200
    ${earthquakeHighBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    ${earthquakeHighBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    ${earthquakeHighBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandHighGain_start}    end=${earthquakeHighBroadBandHighGain_end + 1}
    Log Many    ${earthquakeHighBroadBandHighGain_list}
    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === [earthquakeHighBroadBandHighGain] message sent 200
    ${earthquakeHighBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    ${earthquakeHighBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    ${earthquakeHighBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandLowGain_start}    end=${earthquakeHighBroadBandLowGain_end + 1}
    Log Many    ${earthquakeHighBroadBandLowGain_list}
    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === [earthquakeHighBroadBandLowGain] message sent 200
    ${earthquakeLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    ${earthquakeLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    ${earthquakeLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodHighGain_start}    end=${earthquakeLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeLongPeriodHighGain_list}
    Should Contain    ${earthquakeLongPeriodHighGain_list}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeLongPeriodHighGain_list}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    Should Contain    ${earthquakeLongPeriodHighGain_list}    === [earthquakeLongPeriodHighGain] message sent 200
    ${earthquakeLongPeriodLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    ${earthquakeLongPeriodLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    ${earthquakeLongPeriodLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodLowGain_start}    end=${earthquakeLongPeriodLowGain_end + 1}
    Log Many    ${earthquakeLongPeriodLowGain_list}
    Should Contain    ${earthquakeLongPeriodLowGain_list}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    Should Contain    ${earthquakeLongPeriodLowGain_list}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    Should Contain    ${earthquakeLongPeriodLowGain_list}    === [earthquakeLongPeriodLowGain] message sent 200
    ${earthquakeUltraLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    ${earthquakeUltraLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    ${earthquakeUltraLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeUltraLongPeriodHighGain_start}    end=${earthquakeUltraLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeUltraLongPeriodHighGain_list}
    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === [earthquakeUltraLongPeriodHighGain] message sent 200
    ${earthquakeVeryLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    ${earthquakeVeryLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    ${earthquakeVeryLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeVeryLongPeriodHighGain_start}    end=${earthquakeVeryLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeVeryLongPeriodHighGain_list}
    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === [earthquakeVeryLongPeriodHighGain] message sent 200
    ${netbooter_start}=    Get Index From List    ${full_list}    === ESS_netbooter start of topic ===
    ${netbooter_end}=    Get Index From List    ${full_list}    === ESS_netbooter end of topic ===
    ${netbooter_list}=    Get Slice From List    ${full_list}    start=${netbooter_start}    end=${netbooter_end + 1}
    Log Many    ${netbooter_list}
    Should Contain    ${netbooter_list}    === ESS_netbooter start of topic ===
    Should Contain    ${netbooter_list}    === ESS_netbooter end of topic ===
    Should Contain    ${netbooter_list}    === [netbooter] message sent 200
    ${raritan_start}=    Get Index From List    ${full_list}    === ESS_raritan start of topic ===
    ${raritan_end}=    Get Index From List    ${full_list}    === ESS_raritan end of topic ===
    ${raritan_list}=    Get Slice From List    ${full_list}    start=${raritan_start}    end=${raritan_end + 1}
    Log Many    ${raritan_list}
    Should Contain    ${raritan_list}    === ESS_raritan start of topic ===
    Should Contain    ${raritan_list}    === ESS_raritan end of topic ===
    Should Contain    ${raritan_list}    === [raritan] message sent 200
    ${schneiderPm5xxx_start}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx start of topic ===
    ${schneiderPm5xxx_end}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx end of topic ===
    ${schneiderPm5xxx_list}=    Get Slice From List    ${full_list}    start=${schneiderPm5xxx_start}    end=${schneiderPm5xxx_end + 1}
    Log Many    ${schneiderPm5xxx_list}
    Should Contain    ${schneiderPm5xxx_list}    === ESS_schneiderPm5xxx start of topic ===
    Should Contain    ${schneiderPm5xxx_list}    === ESS_schneiderPm5xxx end of topic ===
    Should Contain    ${schneiderPm5xxx_list}    === [schneiderPm5xxx] message sent 200
    ${xups_start}=    Get Index From List    ${full_list}    === ESS_xups start of topic ===
    ${xups_end}=    Get Index From List    ${full_list}    === ESS_xups end of topic ===
    ${xups_list}=    Get Slice From List    ${full_list}    start=${xups_start}    end=${xups_end + 1}
    Log Many    ${xups_list}
    Should Contain    ${xups_list}    === ESS_xups start of topic ===
    Should Contain    ${xups_list}    === ESS_xups end of topic ===
    Should Contain    ${xups_list}    === [xups] message sent 200
    ${aircraftTrack_start}=    Get Index From List    ${full_list}    === ESS_aircraftTrack start of topic ===
    ${aircraftTrack_end}=    Get Index From List    ${full_list}    === ESS_aircraftTrack end of topic ===
    ${aircraftTrack_list}=    Get Slice From List    ${full_list}    start=${aircraftTrack_start}    end=${aircraftTrack_end + 1}
    Log Many    ${aircraftTrack_list}
    Should Contain    ${aircraftTrack_list}    === ESS_aircraftTrack start of topic ===
    Should Contain    ${aircraftTrack_list}    === ESS_aircraftTrack end of topic ===
    Should Contain    ${aircraftTrack_list}    === [aircraftTrack] message sent 200

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ESS all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${airTurbulence_start}=    Get Index From List    ${full_list}    === ESS_airTurbulence start of topic ===
    ${airTurbulence_end}=    Get Index From List    ${full_list}    === ESS_airTurbulence end of topic ===
    ${airTurbulence_list}=    Get Slice From List    ${full_list}    start=${airTurbulence_start}    end=${airTurbulence_end + 1}
    Log Many    ${airTurbulence_list}
    Should Contain    ${airTurbulence_list}    === ESS_airTurbulence start of topic ===
    Should Contain    ${airTurbulence_list}    === ESS_airTurbulence end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${airTurbulence_list}    === [airTurbulence Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${airTurbulence_list}    === [airTurbulence Subscriber] message received :200
    ${airFlow_start}=    Get Index From List    ${full_list}    === ESS_airFlow start of topic ===
    ${airFlow_end}=    Get Index From List    ${full_list}    === ESS_airFlow end of topic ===
    ${airFlow_list}=    Get Slice From List    ${full_list}    start=${airFlow_start}    end=${airFlow_end + 1}
    Log Many    ${airFlow_list}
    Should Contain    ${airFlow_list}    === ESS_airFlow start of topic ===
    Should Contain    ${airFlow_list}    === ESS_airFlow end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${airFlow_list}    === [airFlow Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${airFlow_list}    === [airFlow Subscriber] message received :200
    ${dewPoint_start}=    Get Index From List    ${full_list}    === ESS_dewPoint start of topic ===
    ${dewPoint_end}=    Get Index From List    ${full_list}    === ESS_dewPoint end of topic ===
    ${dewPoint_list}=    Get Slice From List    ${full_list}    start=${dewPoint_start}    end=${dewPoint_end + 1}
    Log Many    ${dewPoint_list}
    Should Contain    ${dewPoint_list}    === ESS_dewPoint start of topic ===
    Should Contain    ${dewPoint_list}    === ESS_dewPoint end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${dewPoint_list}    === [dewPoint Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${dewPoint_list}    === [dewPoint Subscriber] message received :200
    ${pressure_start}=    Get Index From List    ${full_list}    === ESS_pressure start of topic ===
    ${pressure_end}=    Get Index From List    ${full_list}    === ESS_pressure end of topic ===
    ${pressure_list}=    Get Slice From List    ${full_list}    start=${pressure_start}    end=${pressure_end + 1}
    Log Many    ${pressure_list}
    Should Contain    ${pressure_list}    === ESS_pressure start of topic ===
    Should Contain    ${pressure_list}    === ESS_pressure end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${pressure_list}    === [pressure Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${pressure_list}    === [pressure Subscriber] message received :200
    ${rainRate_start}=    Get Index From List    ${full_list}    === ESS_rainRate start of topic ===
    ${rainRate_end}=    Get Index From List    ${full_list}    === ESS_rainRate end of topic ===
    ${rainRate_list}=    Get Slice From List    ${full_list}    start=${rainRate_start}    end=${rainRate_end + 1}
    Log Many    ${rainRate_list}
    Should Contain    ${rainRate_list}    === ESS_rainRate start of topic ===
    Should Contain    ${rainRate_list}    === ESS_rainRate end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${rainRate_list}    === [rainRate Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${rainRate_list}    === [rainRate Subscriber] message received :200
    ${relativeHumidity_start}=    Get Index From List    ${full_list}    === ESS_relativeHumidity start of topic ===
    ${relativeHumidity_end}=    Get Index From List    ${full_list}    === ESS_relativeHumidity end of topic ===
    ${relativeHumidity_list}=    Get Slice From List    ${full_list}    start=${relativeHumidity_start}    end=${relativeHumidity_end + 1}
    Log Many    ${relativeHumidity_list}
    Should Contain    ${relativeHumidity_list}    === ESS_relativeHumidity start of topic ===
    Should Contain    ${relativeHumidity_list}    === ESS_relativeHumidity end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${relativeHumidity_list}    === [relativeHumidity Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${relativeHumidity_list}    === [relativeHumidity Subscriber] message received :200
    ${snowRate_start}=    Get Index From List    ${full_list}    === ESS_snowRate start of topic ===
    ${snowRate_end}=    Get Index From List    ${full_list}    === ESS_snowRate end of topic ===
    ${snowRate_list}=    Get Slice From List    ${full_list}    start=${snowRate_start}    end=${snowRate_end + 1}
    Log Many    ${snowRate_list}
    Should Contain    ${snowRate_list}    === ESS_snowRate start of topic ===
    Should Contain    ${snowRate_list}    === ESS_snowRate end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${snowRate_list}    === [snowRate Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${snowRate_list}    === [snowRate Subscriber] message received :200
    ${solarRadiation_start}=    Get Index From List    ${full_list}    === ESS_solarRadiation start of topic ===
    ${solarRadiation_end}=    Get Index From List    ${full_list}    === ESS_solarRadiation end of topic ===
    ${solarRadiation_list}=    Get Slice From List    ${full_list}    start=${solarRadiation_start}    end=${solarRadiation_end + 1}
    Log Many    ${solarRadiation_list}
    Should Contain    ${solarRadiation_list}    === ESS_solarRadiation start of topic ===
    Should Contain    ${solarRadiation_list}    === ESS_solarRadiation end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${solarRadiation_list}    === [solarRadiation Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${solarRadiation_list}    === [solarRadiation Subscriber] message received :200
    ${temperature_start}=    Get Index From List    ${full_list}    === ESS_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === ESS_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end + 1}
    Log Many    ${temperature_list}
    Should Contain    ${temperature_list}    === ESS_temperature start of topic ===
    Should Contain    ${temperature_list}    === ESS_temperature end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${temperature_list}    === [temperature Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${temperature_list}    === [temperature Subscriber] message received :200
    ${accelerometer_start}=    Get Index From List    ${full_list}    === ESS_accelerometer start of topic ===
    ${accelerometer_end}=    Get Index From List    ${full_list}    === ESS_accelerometer end of topic ===
    ${accelerometer_list}=    Get Slice From List    ${full_list}    start=${accelerometer_start}    end=${accelerometer_end + 1}
    Log Many    ${accelerometer_list}
    Should Contain    ${accelerometer_list}    === ESS_accelerometer start of topic ===
    Should Contain    ${accelerometer_list}    === ESS_accelerometer end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${accelerometer_list}    === [accelerometer Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${accelerometer_list}    === [accelerometer Subscriber] message received :200
    ${accelerometerPSD_start}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD start of topic ===
    ${accelerometerPSD_end}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD end of topic ===
    ${accelerometerPSD_list}=    Get Slice From List    ${full_list}    start=${accelerometerPSD_start}    end=${accelerometerPSD_end + 1}
    Log Many    ${accelerometerPSD_list}
    Should Contain    ${accelerometerPSD_list}    === ESS_accelerometerPSD start of topic ===
    Should Contain    ${accelerometerPSD_list}    === ESS_accelerometerPSD end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${accelerometerPSD_list}    === [accelerometerPSD Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${accelerometerPSD_list}    === [accelerometerPSD Subscriber] message received :200
    ${electricFieldStrength_start}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength start of topic ===
    ${electricFieldStrength_end}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength end of topic ===
    ${electricFieldStrength_list}=    Get Slice From List    ${full_list}    start=${electricFieldStrength_start}    end=${electricFieldStrength_end + 1}
    Log Many    ${electricFieldStrength_list}
    Should Contain    ${electricFieldStrength_list}    === ESS_electricFieldStrength start of topic ===
    Should Contain    ${electricFieldStrength_list}    === ESS_electricFieldStrength end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${electricFieldStrength_list}    === [electricFieldStrength Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${electricFieldStrength_list}    === [electricFieldStrength Subscriber] message received :200
    ${lightningStrikeStatus_start}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus start of topic ===
    ${lightningStrikeStatus_end}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus end of topic ===
    ${lightningStrikeStatus_list}=    Get Slice From List    ${full_list}    start=${lightningStrikeStatus_start}    end=${lightningStrikeStatus_end + 1}
    Log Many    ${lightningStrikeStatus_list}
    Should Contain    ${lightningStrikeStatus_list}    === ESS_lightningStrikeStatus start of topic ===
    Should Contain    ${lightningStrikeStatus_list}    === ESS_lightningStrikeStatus end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${lightningStrikeStatus_list}    === [lightningStrikeStatus Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${lightningStrikeStatus_list}    === [lightningStrikeStatus Subscriber] message received :200
    ${spectrumAnalyzer_start}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer start of topic ===
    ${spectrumAnalyzer_end}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer end of topic ===
    ${spectrumAnalyzer_list}=    Get Slice From List    ${full_list}    start=${spectrumAnalyzer_start}    end=${spectrumAnalyzer_end + 1}
    Log Many    ${spectrumAnalyzer_list}
    Should Contain    ${spectrumAnalyzer_list}    === ESS_spectrumAnalyzer start of topic ===
    Should Contain    ${spectrumAnalyzer_list}    === ESS_spectrumAnalyzer end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${spectrumAnalyzer_list}    === [spectrumAnalyzer Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${spectrumAnalyzer_list}    === [spectrumAnalyzer Subscriber] message received :200
    ${earthquakeBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain start of topic ===
    ${earthquakeBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain end of topic ===
    ${earthquakeBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandHighGain_start}    end=${earthquakeBroadBandHighGain_end + 1}
    Log Many    ${earthquakeBroadBandHighGain_list}
    Should Contain    ${earthquakeBroadBandHighGain_list}    === ESS_earthquakeBroadBandHighGain start of topic ===
    Should Contain    ${earthquakeBroadBandHighGain_list}    === ESS_earthquakeBroadBandHighGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeBroadBandHighGain_list}    === [earthquakeBroadBandHighGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeBroadBandHighGain_list}    === [earthquakeBroadBandHighGain Subscriber] message received :200
    ${earthquakeBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain start of topic ===
    ${earthquakeBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain end of topic ===
    ${earthquakeBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandLowGain_start}    end=${earthquakeBroadBandLowGain_end + 1}
    Log Many    ${earthquakeBroadBandLowGain_list}
    Should Contain    ${earthquakeBroadBandLowGain_list}    === ESS_earthquakeBroadBandLowGain start of topic ===
    Should Contain    ${earthquakeBroadBandLowGain_list}    === ESS_earthquakeBroadBandLowGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeBroadBandLowGain_list}    === [earthquakeBroadBandLowGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeBroadBandLowGain_list}    === [earthquakeBroadBandLowGain Subscriber] message received :200
    ${earthquakeHighBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    ${earthquakeHighBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    ${earthquakeHighBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandHighGain_start}    end=${earthquakeHighBroadBandHighGain_end + 1}
    Log Many    ${earthquakeHighBroadBandHighGain_list}
    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === [earthquakeHighBroadBandHighGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeHighBroadBandHighGain_list}    === [earthquakeHighBroadBandHighGain Subscriber] message received :200
    ${earthquakeHighBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    ${earthquakeHighBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    ${earthquakeHighBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandLowGain_start}    end=${earthquakeHighBroadBandLowGain_end + 1}
    Log Many    ${earthquakeHighBroadBandLowGain_list}
    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === [earthquakeHighBroadBandLowGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeHighBroadBandLowGain_list}    === [earthquakeHighBroadBandLowGain Subscriber] message received :200
    ${earthquakeLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    ${earthquakeLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    ${earthquakeLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodHighGain_start}    end=${earthquakeLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeLongPeriodHighGain_list}
    Should Contain    ${earthquakeLongPeriodHighGain_list}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeLongPeriodHighGain_list}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeLongPeriodHighGain_list}    === [earthquakeLongPeriodHighGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeLongPeriodHighGain_list}    === [earthquakeLongPeriodHighGain Subscriber] message received :200
    ${earthquakeLongPeriodLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    ${earthquakeLongPeriodLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    ${earthquakeLongPeriodLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodLowGain_start}    end=${earthquakeLongPeriodLowGain_end + 1}
    Log Many    ${earthquakeLongPeriodLowGain_list}
    Should Contain    ${earthquakeLongPeriodLowGain_list}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    Should Contain    ${earthquakeLongPeriodLowGain_list}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeLongPeriodLowGain_list}    === [earthquakeLongPeriodLowGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeLongPeriodLowGain_list}    === [earthquakeLongPeriodLowGain Subscriber] message received :200
    ${earthquakeUltraLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    ${earthquakeUltraLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    ${earthquakeUltraLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeUltraLongPeriodHighGain_start}    end=${earthquakeUltraLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeUltraLongPeriodHighGain_list}
    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === [earthquakeUltraLongPeriodHighGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeUltraLongPeriodHighGain_list}    === [earthquakeUltraLongPeriodHighGain Subscriber] message received :200
    ${earthquakeVeryLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    ${earthquakeVeryLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    ${earthquakeVeryLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeVeryLongPeriodHighGain_start}    end=${earthquakeVeryLongPeriodHighGain_end + 1}
    Log Many    ${earthquakeVeryLongPeriodHighGain_list}
    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === [earthquakeVeryLongPeriodHighGain Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${earthquakeVeryLongPeriodHighGain_list}    === [earthquakeVeryLongPeriodHighGain Subscriber] message received :200
    ${netbooter_start}=    Get Index From List    ${full_list}    === ESS_netbooter start of topic ===
    ${netbooter_end}=    Get Index From List    ${full_list}    === ESS_netbooter end of topic ===
    ${netbooter_list}=    Get Slice From List    ${full_list}    start=${netbooter_start}    end=${netbooter_end + 1}
    Log Many    ${netbooter_list}
    Should Contain    ${netbooter_list}    === ESS_netbooter start of topic ===
    Should Contain    ${netbooter_list}    === ESS_netbooter end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${netbooter_list}    === [netbooter Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${netbooter_list}    === [netbooter Subscriber] message received :200
    ${raritan_start}=    Get Index From List    ${full_list}    === ESS_raritan start of topic ===
    ${raritan_end}=    Get Index From List    ${full_list}    === ESS_raritan end of topic ===
    ${raritan_list}=    Get Slice From List    ${full_list}    start=${raritan_start}    end=${raritan_end + 1}
    Log Many    ${raritan_list}
    Should Contain    ${raritan_list}    === ESS_raritan start of topic ===
    Should Contain    ${raritan_list}    === ESS_raritan end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${raritan_list}    === [raritan Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${raritan_list}    === [raritan Subscriber] message received :200
    ${schneiderPm5xxx_start}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx start of topic ===
    ${schneiderPm5xxx_end}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx end of topic ===
    ${schneiderPm5xxx_list}=    Get Slice From List    ${full_list}    start=${schneiderPm5xxx_start}    end=${schneiderPm5xxx_end + 1}
    Log Many    ${schneiderPm5xxx_list}
    Should Contain    ${schneiderPm5xxx_list}    === ESS_schneiderPm5xxx start of topic ===
    Should Contain    ${schneiderPm5xxx_list}    === ESS_schneiderPm5xxx end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${schneiderPm5xxx_list}    === [schneiderPm5xxx Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${schneiderPm5xxx_list}    === [schneiderPm5xxx Subscriber] message received :200
    ${xups_start}=    Get Index From List    ${full_list}    === ESS_xups start of topic ===
    ${xups_end}=    Get Index From List    ${full_list}    === ESS_xups end of topic ===
    ${xups_list}=    Get Slice From List    ${full_list}    start=${xups_start}    end=${xups_end + 1}
    Log Many    ${xups_list}
    Should Contain    ${xups_list}    === ESS_xups start of topic ===
    Should Contain    ${xups_list}    === ESS_xups end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${xups_list}    === [xups Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${xups_list}    === [xups Subscriber] message received :200
    ${aircraftTrack_start}=    Get Index From List    ${full_list}    === ESS_aircraftTrack start of topic ===
    ${aircraftTrack_end}=    Get Index From List    ${full_list}    === ESS_aircraftTrack end of topic ===
    ${aircraftTrack_list}=    Get Slice From List    ${full_list}    start=${aircraftTrack_start}    end=${aircraftTrack_end + 1}
    Log Many    ${aircraftTrack_list}
    Should Contain    ${aircraftTrack_list}    === ESS_aircraftTrack start of topic ===
    Should Contain    ${aircraftTrack_list}    === ESS_aircraftTrack end of topic ===
    Run Keyword And Ignore Error    Should Contain    ${aircraftTrack_list}    === [aircraftTrack Subscriber] message received :10
    Run Keyword And Ignore Error    Should Contain    ${aircraftTrack_list}    === [aircraftTrack Subscriber] message received :200
