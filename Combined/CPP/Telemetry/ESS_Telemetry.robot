*** Settings ***
Documentation    ESS Telemetry communications tests.
Force Tags    messaging    cpp    ess    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ESS
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== ESS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_airTurbulence test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_airTurbulence
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_airTurbulence start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::airTurbulence_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_airTurbulence end of topic ===
    Comment    ======= Verify ${subSystem}_airFlow test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_airFlow
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_airFlow start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::airFlow_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_airFlow end of topic ===
    Comment    ======= Verify ${subSystem}_dewPoint test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_dewPoint
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_dewPoint start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::dewPoint_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_dewPoint end of topic ===
    Comment    ======= Verify ${subSystem}_pressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_pressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::pressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_pressure end of topic ===
    Comment    ======= Verify ${subSystem}_rainRate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rainRate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_rainRate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rainRate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_rainRate end of topic ===
    Comment    ======= Verify ${subSystem}_relativeHumidity test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_relativeHumidity
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_relativeHumidity start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::relativeHumidity_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_relativeHumidity end of topic ===
    Comment    ======= Verify ${subSystem}_snowRate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_snowRate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_snowRate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::snowRate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_snowRate end of topic ===
    Comment    ======= Verify ${subSystem}_solarRadiation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_solarRadiation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_solarRadiation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::solarRadiation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_solarRadiation end of topic ===
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_temperature end of topic ===
    Comment    ======= Verify ${subSystem}_accelerometer test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_accelerometer
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_accelerometer start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::accelerometer_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_accelerometer end of topic ===
    Comment    ======= Verify ${subSystem}_accelerometerPSD test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_accelerometerPSD
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_accelerometerPSD start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::accelerometerPSD_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_accelerometerPSD end of topic ===
    Comment    ======= Verify ${subSystem}_electricFieldStrength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_electricFieldStrength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_electricFieldStrength start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::electricFieldStrength_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_electricFieldStrength end of topic ===
    Comment    ======= Verify ${subSystem}_lightningStrikeStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lightningStrikeStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_lightningStrikeStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lightningStrikeStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_lightningStrikeStatus end of topic ===
    Comment    ======= Verify ${subSystem}_spectrumAnalyzer test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_spectrumAnalyzer
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_spectrumAnalyzer start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::spectrumAnalyzer_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_spectrumAnalyzer end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeBroadBandHighGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeBroadBandHighGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeBroadBandHighGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandHighGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeBroadBandLowGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeBroadBandLowGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeBroadBandLowGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandLowGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeHighBroadBandHighGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeHighBroadBandHighGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeHighBroadBandHighGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeHighBroadBandLowGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeHighBroadBandLowGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeHighBroadBandLowGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeLongPeriodHighGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeLongPeriodHighGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeLongPeriodHighGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeLongPeriodLowGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeLongPeriodLowGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeLongPeriodLowGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeUltraLongPeriodHighGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeUltraLongPeriodHighGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeUltraLongPeriodHighGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    Comment    ======= Verify ${subSystem}_earthquakeVeryLongPeriodHighGain test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_earthquakeVeryLongPeriodHighGain
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::earthquakeVeryLongPeriodHighGain_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ESS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${airTurbulence_start}=    Get Index From List    ${full_list}    === ESS_airTurbulence start of topic ===
    ${airTurbulence_end}=    Get Index From List    ${full_list}    === ESS_airTurbulence end of topic ===
    ${airTurbulence_list}=    Get Slice From List    ${full_list}    start=${airTurbulence_start}    end=${airTurbulence_end}
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 0    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 1    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 2    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 3    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 4    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 5    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 6    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 7    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 8    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 9    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 0    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 1    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 2    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 3    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 4    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 5    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 6    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 7    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 8    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 9    1
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedMagnitude : 1    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedMaxMagnitude : 1    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sonicTemperature : 1    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sonicTemperatureStdDev : 1    10
    Should Contain X Times    ${airTurbulence_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${airFlow_start}=    Get Index From List    ${full_list}    === ESS_airFlow start of topic ===
    ${airFlow_end}=    Get Index From List    ${full_list}    === ESS_airFlow end of topic ===
    ${airFlow_list}=    Get Slice From List    ${full_list}    start=${airFlow_start}    end=${airFlow_end}
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}direction : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}directionStdDev : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedStdDev : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSpeed : 1    10
    Should Contain X Times    ${airFlow_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${dewPoint_start}=    Get Index From List    ${full_list}    === ESS_dewPoint start of topic ===
    ${dewPoint_end}=    Get Index From List    ${full_list}    === ESS_dewPoint end of topic ===
    ${dewPoint_list}=    Get Slice From List    ${full_list}    start=${dewPoint_start}    end=${dewPoint_end}
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dewPointItem : 1    10
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${pressure_start}=    Get Index From List    ${full_list}    === ESS_pressure start of topic ===
    ${pressure_end}=    Get Index From List    ${full_list}    === ESS_pressure end of topic ===
    ${pressure_list}=    Get Slice From List    ${full_list}    start=${pressure_start}    end=${pressure_end}
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numChannels : 1    10
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 0    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 1    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 2    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 3    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 4    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 5    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 6    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 7    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 8    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureItem : 9    1
    Should Contain X Times    ${pressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${rainRate_start}=    Get Index From List    ${full_list}    === ESS_rainRate start of topic ===
    ${rainRate_end}=    Get Index From List    ${full_list}    === ESS_rainRate end of topic ===
    ${rainRate_list}=    Get Slice From List    ${full_list}    start=${rainRate_start}    end=${rainRate_end}
    Should Contain X Times    ${rainRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${rainRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${rainRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rainRateItem : 1    10
    Should Contain X Times    ${rainRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${relativeHumidity_start}=    Get Index From List    ${full_list}    === ESS_relativeHumidity start of topic ===
    ${relativeHumidity_end}=    Get Index From List    ${full_list}    === ESS_relativeHumidity end of topic ===
    ${relativeHumidity_list}=    Get Slice From List    ${full_list}    start=${relativeHumidity_start}    end=${relativeHumidity_end}
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}relativeHumidityItem : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${snowRate_start}=    Get Index From List    ${full_list}    === ESS_snowRate start of topic ===
    ${snowRate_end}=    Get Index From List    ${full_list}    === ESS_snowRate end of topic ===
    ${snowRate_list}=    Get Slice From List    ${full_list}    start=${snowRate_start}    end=${snowRate_end}
    Should Contain X Times    ${snowRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${snowRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${snowRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}snowRateItem : 1    10
    Should Contain X Times    ${snowRate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${solarRadiation_start}=    Get Index From List    ${full_list}    === ESS_solarRadiation start of topic ===
    ${solarRadiation_end}=    Get Index From List    ${full_list}    === ESS_solarRadiation end of topic ===
    ${solarRadiation_list}=    Get Slice From List    ${full_list}    start=${solarRadiation_start}    end=${solarRadiation_end}
    Should Contain X Times    ${solarRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${solarRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${solarRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}solarRadiationItem : 1    10
    Should Contain X Times    ${solarRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${temperature_start}=    Get Index From List    ${full_list}    === ESS_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === ESS_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end}
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numChannels : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 0    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 1    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 2    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 3    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 4    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 5    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 6    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 7    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 8    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureItem : 9    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${accelerometer_start}=    Get Index From List    ${full_list}    === ESS_accelerometer start of topic ===
    ${accelerometer_end}=    Get Index From List    ${full_list}    === ESS_accelerometer end of topic ===
    ${accelerometer_list}=    Get Slice From List    ${full_list}    start=${accelerometer_start}    end=${accelerometer_end}
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interval : 1    10
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 0    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 1    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 2    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 3    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 4    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 5    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 6    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 7    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 8    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 9    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 0    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 1    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 2    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 3    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 4    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 5    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 6    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 7    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 8    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 9    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 0    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 1    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 2    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 3    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 4    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 5    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 6    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 7    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 8    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 9    1
    Should Contain X Times    ${accelerometer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${accelerometerPSD_start}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD start of topic ===
    ${accelerometerPSD_end}=    Get Index From List    ${full_list}    === ESS_accelerometerPSD end of topic ===
    ${accelerometerPSD_list}=    Get Slice From List    ${full_list}    start=${accelerometerPSD_start}    end=${accelerometerPSD_end}
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxPSDFrequency : 1    10
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 0    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 1    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 2    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 3    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 4    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 5    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 6    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 7    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 8    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 9    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 0    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 1    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 2    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 3    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 4    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 5    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 6    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 7    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 8    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 9    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 0    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 1    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 2    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 3    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 4    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 5    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 6    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 7    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 8    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 9    1
    Should Contain X Times    ${accelerometerPSD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${electricFieldStrength_start}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength start of topic ===
    ${electricFieldStrength_end}=    Get Index From List    ${full_list}    === ESS_electricFieldStrength end of topic ===
    ${electricFieldStrength_list}=    Get Slice From List    ${full_list}    start=${electricFieldStrength_start}    end=${electricFieldStrength_end}
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}strength : 1    10
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}strengthStdDev : 1    10
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}strengthMax : 1    10
    Should Contain X Times    ${electricFieldStrength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${lightningStrikeStatus_start}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus start of topic ===
    ${lightningStrikeStatus_end}=    Get Index From List    ${full_list}    === ESS_lightningStrikeStatus end of topic ===
    ${lightningStrikeStatus_list}=    Get Slice From List    ${full_list}    start=${lightningStrikeStatus_start}    end=${lightningStrikeStatus_end}
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeStrikeRate : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalStrikeRate : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeAlarmStatus : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}severeAlarmStatus : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heading : 1    10
    Should Contain X Times    ${lightningStrikeStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${spectrumAnalyzer_start}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer start of topic ===
    ${spectrumAnalyzer_end}=    Get Index From List    ${full_list}    === ESS_spectrumAnalyzer end of topic ===
    ${spectrumAnalyzer_list}=    Get Slice From List    ${full_list}    start=${spectrumAnalyzer_start}    end=${spectrumAnalyzer_end}
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startFrequency : 1    10
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stopFrequency : 1    10
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 0    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 1    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 2    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 3    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 4    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 5    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 6    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 7    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 8    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spectrum : 9    1
    Should Contain X Times    ${spectrumAnalyzer_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain start of topic ===
    ${earthquakeBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandHighGain end of topic ===
    ${earthquakeBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandHighGain_start}    end=${earthquakeBroadBandHighGain_end}
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 0    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 2    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 3    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 4    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 5    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 6    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 7    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 8    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 9    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 0    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 2    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 3    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 4    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 5    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 6    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 7    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 8    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 9    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 0    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 2    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 3    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 4    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 5    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 6    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 7    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 8    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 9    1
    Should Contain X Times    ${earthquakeBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain start of topic ===
    ${earthquakeBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeBroadBandLowGain end of topic ===
    ${earthquakeBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeBroadBandLowGain_start}    end=${earthquakeBroadBandLowGain_end}
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 0    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 2    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 3    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 4    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 5    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 6    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 7    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 8    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 9    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 0    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 2    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 3    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 4    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 5    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 6    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 7    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 8    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 9    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 0    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 2    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 3    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 4    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 5    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 6    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 7    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 8    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 9    1
    Should Contain X Times    ${earthquakeBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeHighBroadBandHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    ${earthquakeHighBroadBandHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    ${earthquakeHighBroadBandHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandHighGain_start}    end=${earthquakeHighBroadBandHighGain_end}
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeHighBroadBandLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    ${earthquakeHighBroadBandLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    ${earthquakeHighBroadBandLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeHighBroadBandLowGain_start}    end=${earthquakeHighBroadBandLowGain_end}
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 0    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 2    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 3    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 4    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 5    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 6    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 7    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 8    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 9    1
    Should Contain X Times    ${earthquakeHighBroadBandLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    ${earthquakeLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    ${earthquakeLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodHighGain_start}    end=${earthquakeLongPeriodHighGain_end}
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    10
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    10
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    10
    Should Contain X Times    ${earthquakeLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeLongPeriodLowGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    ${earthquakeLongPeriodLowGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    ${earthquakeLongPeriodLowGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeLongPeriodLowGain_start}    end=${earthquakeLongPeriodLowGain_end}
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    10
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    10
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    10
    Should Contain X Times    ${earthquakeLongPeriodLowGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeUltraLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    ${earthquakeUltraLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    ${earthquakeUltraLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeUltraLongPeriodHighGain_start}    end=${earthquakeUltraLongPeriodHighGain_end}
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    10
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    10
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    10
    Should Contain X Times    ${earthquakeUltraLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${earthquakeVeryLongPeriodHighGain_start}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    ${earthquakeVeryLongPeriodHighGain_end}=    Get Index From List    ${full_list}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    ${earthquakeVeryLongPeriodHighGain_list}=    Get Slice From List    ${full_list}    start=${earthquakeVeryLongPeriodHighGain_start}    end=${earthquakeVeryLongPeriodHighGain_end}
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationEastWest : 1    10
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationNorthSouth : 1    10
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZenith : 1    10
    Should Contain X Times    ${earthquakeVeryLongPeriodHighGain_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
