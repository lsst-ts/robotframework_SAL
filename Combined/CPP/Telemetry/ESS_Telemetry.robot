*** Settings ***
Documentation    ESS Telemetry communications tests.
Force Tags    messaging    cpp    ess    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ESS
${component}    all
${timeout}    300s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional    subscriber
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    60s    10    File Should Contain    ${EXECDIR}${/}${subSystem}_stdout.txt    ===== ESS subscribers ready =====

Start Publisher
    [Tags]    functional    publisher    robot:continue-on-failure
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "airTurbulence"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_airTurbulence test messages =======
    Should Contain    ${output.stdout}    === ESS_airTurbulence start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.airTurbulence writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_airTurbulence end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "airFlow"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_airFlow test messages =======
    Should Contain    ${output.stdout}    === ESS_airFlow start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.airFlow writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_airFlow end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "dewPoint"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_dewPoint test messages =======
    Should Contain    ${output.stdout}    === ESS_dewPoint start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.dewPoint writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_dewPoint end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "pressure"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_pressure test messages =======
    Should Contain    ${output.stdout}    === ESS_pressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.pressure writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_pressure end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "rainRate"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_rainRate test messages =======
    Should Contain    ${output.stdout}    === ESS_rainRate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.rainRate writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_rainRate end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "relativeHumidity"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_relativeHumidity test messages =======
    Should Contain    ${output.stdout}    === ESS_relativeHumidity start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.relativeHumidity writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_relativeHumidity end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "snowRate"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_snowRate test messages =======
    Should Contain    ${output.stdout}    === ESS_snowRate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.snowRate writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_snowRate end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "solarRadiation"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_solarRadiation test messages =======
    Should Contain    ${output.stdout}    === ESS_solarRadiation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.solarRadiation writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_solarRadiation end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "temperature"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    Should Contain    ${output.stdout}    === ESS_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.temperature writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_temperature end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "accelerometer"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_accelerometer test messages =======
    Should Contain    ${output.stdout}    === ESS_accelerometer start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.accelerometer writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_accelerometer end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "accelerometerPSD"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_accelerometerPSD test messages =======
    Should Contain    ${output.stdout}    === ESS_accelerometerPSD start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.accelerometerPSD writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_accelerometerPSD end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "electricFieldStrength"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_electricFieldStrength test messages =======
    Should Contain    ${output.stdout}    === ESS_electricFieldStrength start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.electricFieldStrength writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_electricFieldStrength end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "lightningStrikeStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_lightningStrikeStatus test messages =======
    Should Contain    ${output.stdout}    === ESS_lightningStrikeStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.lightningStrikeStatus writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_lightningStrikeStatus end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "spectrumAnalyzer"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_spectrumAnalyzer test messages =======
    Should Contain    ${output.stdout}    === ESS_spectrumAnalyzer start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.spectrumAnalyzer writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_spectrumAnalyzer end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeBroadBandHighGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeBroadBandHighGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeBroadBandHighGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandHighGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeBroadBandLowGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeBroadBandLowGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeBroadBandLowGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeBroadBandLowGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeHighBroadBandHighGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeHighBroadBandHighGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeHighBroadBandHighGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandHighGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeHighBroadBandLowGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeHighBroadBandLowGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeHighBroadBandLowGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeHighBroadBandLowGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeLongPeriodHighGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeLongPeriodHighGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeLongPeriodHighGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodHighGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeLongPeriodLowGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeLongPeriodLowGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodLowGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeLongPeriodLowGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeLongPeriodLowGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeUltraLongPeriodHighGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeUltraLongPeriodHighGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeUltraLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeUltraLongPeriodHighGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeUltraLongPeriodHighGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "earthquakeVeryLongPeriodHighGain"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_earthquakeVeryLongPeriodHighGain test messages =======
    Should Contain    ${output.stdout}    === ESS_earthquakeVeryLongPeriodHighGain start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.earthquakeVeryLongPeriodHighGain writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_earthquakeVeryLongPeriodHighGain end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "netbooter"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_netbooter test messages =======
    Should Contain    ${output.stdout}    === ESS_netbooter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.netbooter writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_netbooter end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "raritan"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_raritan test messages =======
    Should Contain    ${output.stdout}    === ESS_raritan start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.raritan writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_raritan end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "schneiderPm5xxx"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_schneiderPm5xxx test messages =======
    Should Contain    ${output.stdout}    === ESS_schneiderPm5xxx start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.schneiderPm5xxx writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_schneiderPm5xxx end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "xups"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_xups test messages =======
    Should Contain    ${output.stdout}    === ESS_xups start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.xups writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_xups end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "aircraftTrack"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_aircraftTrack test messages =======
    Should Contain    ${output.stdout}    === ESS_aircraftTrack start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.aircraftTrack writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_aircraftTrack end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "agcGenset150"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_agcGenset150 test messages =======
    Should Contain    ${output.stdout}    === ESS_agcGenset150 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.agcGenset150 writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_agcGenset150 end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "particleMeasurements"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_particleMeasurements test messages =======
    Should Contain    ${output.stdout}    === ESS_particleMeasurements start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.particleMeasurements writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ESS_particleMeasurements end of topic ===

Read Subscriber
    [Tags]    functional    subscriber    robot:continue-on-failure
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
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
    ${netbooter_start}=    Get Index From List    ${full_list}    === ESS_netbooter start of topic ===
    ${netbooter_end}=    Get Index From List    ${full_list}    === ESS_netbooter end of topic ===
    ${netbooter_list}=    Get Slice From List    ${full_list}    start=${netbooter_start}    end=${netbooter_end}
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemDescription : RO    10
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acCurrentDraw : 1    10
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acMaxDraw : 1    10
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 0    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 1    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 2    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 3    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 4    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 5    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 6    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 7    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 8    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerOutletStatus : 9    1
    Should Contain X Times    ${netbooter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${raritan_start}=    Get Index From List    ${full_list}    === ESS_raritan start of topic ===
    ${raritan_end}=    Get Index From List    ${full_list}    === ESS_raritan end of topic ===
    ${raritan_list}=    Get Slice From List    ${full_list}    start=${raritan_start}    end=${raritan_end}
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemDescription : RO    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletRmsCurrent : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletUnbalancedCurrent : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletRmsVoltage : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletActivePower : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletApparentPower : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletPowerFactor : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletActiveEnergy : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletFrequency : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletUnbalancedVoltage : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inletUnbalancedLineLineVoltage : 1    10
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsCurrent : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletRmsVoltage : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActivePower : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletApparentPower : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletPowerFactor : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletActiveEnergy : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletOnOff : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletOnOff : 1    9
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 0    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 1    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 2    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 3    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 4    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 5    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 6    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 7    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 8    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outletFrequency : 9    1
    Should Contain X Times    ${raritan_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${schneiderPm5xxx_start}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx start of topic ===
    ${schneiderPm5xxx_end}=    Get Index From List    ${full_list}    === ESS_schneiderPm5xxx end of topic ===
    ${schneiderPm5xxx_list}=    Get Slice From List    ${full_list}    start=${schneiderPm5xxx_start}    end=${schneiderPm5xxx_end}
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemDescription : RO    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serialNumber : RO    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVan : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVbn : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVcn : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVab : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVbc : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredLineVoltageVca : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loadCurrentA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loadCurrentB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loadCurrentC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}neutralCurrent : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemFrequency : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activePowerA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activePowerB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activePowerC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reactivePowerA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reactivePowerB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reactivePowerC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}apparentPowerA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}apparentPowerB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}apparentPowerC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerFactorA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerFactorB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerFactorC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementPowerFactorA : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementPowerFactorB : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementPowerFactorC : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalPowerFactor : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalDisplacementPowerFactor : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalActivePower : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalReactivePower : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalApparentPower : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeEnergyDelivered : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reactiveEnergyDelivered : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}apparentEnergyDelivered : 1    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resetDateTime : RO    10
    Should Contain X Times    ${schneiderPm5xxx_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${xups_start}=    Get Index From List    ${full_list}    === ESS_xups start of topic ===
    ${xups_end}=    Get Index From List    ${full_list}    === ESS_xups end of topic ===
    ${xups_list}=    Get Slice From List    ${full_list}    start=${xups_start}    end=${xups_end}
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}systemDescription : RO    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryCapacity : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryTimeRemaining : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryVoltage : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}envAmbientTemp : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryCurrent : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputCurrent : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputPower : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputVoltage : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputFrequency : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputPower : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputFrequency : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputLoad : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 0    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 1    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 2    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 3    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 4    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 5    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 6    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 7    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 8    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassVoltage : 9    1
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassFrequency : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryAbmStatus : 1    10
    Should Contain X Times    ${xups_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${aircraftTrack_start}=    Get Index From List    ${full_list}    === ESS_aircraftTrack start of topic ===
    ${aircraftTrack_end}=    Get Index From List    ${full_list}    === ESS_aircraftTrack end of topic ===
    ${aircraftTrack_list}=    Get Slice From List    ${full_list}    start=${aircraftTrack_start}    end=${aircraftTrack_end}
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}track : RO    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}transponder : RO    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latitude : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longitude : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityX : 1    10
    Should Contain X Times    ${aircraftTrack_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityY : 1    10
    ${agcGenset150_start}=    Get Index From List    ${full_list}    === ESS_agcGenset150 start of topic ===
    ${agcGenset150_end}=    Get Index From List    ${full_list}    === ESS_agcGenset150 end of topic ===
    ${agcGenset150_list}=    Get Slice From List    ${full_list}    start=${agcGenset150_start}    end=${agcGenset150_end}
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gbPositionOn : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mbPositionOn : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}running : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageFrequencyOk : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainFailure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blockMode : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}manualMode : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}semiAutoMode : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoMode : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testMode : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gbPositionOff : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mbPositionOff : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}island : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}automaticMainsFailure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}peakShaving : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fixedPower : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainsPowerExport : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loadTakeover : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerManagement : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAlarmPMS : 0    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAlarmPMS : 1    9
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAlarmMains : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}batteryTest : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readyAutoStartDG : 0    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readyAutoStartDG : 1    9
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainSyncInhibit : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMainsSyncInhibit : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationVersion : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL1L2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL2L3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL3L1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL1N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL2N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltageL3N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorFrequencyL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorFrequencyL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorFrequencyL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltagePhaseAngleL1L2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltagePhaseAngleL2L3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorVoltagePhaseAngleL3L1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorCurrentL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorCurrentL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorCurrentL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorPowerL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorPowerL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorPowerL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorPower : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorReactivePowerL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorReactivePowerL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorReactivePowerL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorReactivePower : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorApparentPowerL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorApparentPowerL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorApparentPowerL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorApparentPower : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorExportReactiveEnergyCounterTotal : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorExportActiveEnergyCounterDay : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorExportActiveEnergyCounterWeek : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorExportActiveEnergyCounterMonth : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorExportActiveEnergyCounterTotal : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generatorPF : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL1L2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL2L3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL3L1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL1N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL2N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltageL3N : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBFrequencyL1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBFrequencyL2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBFrequencyL3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltagePhaseAngleL1L2 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltagePhaseAngleL2L3 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busBVoltagePhaseAngleL3L1 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uBBL1uGENL1PhaseAngle : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uBBL2uGENL2PhaseAngle : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uBBL3uGENL3PhaseAngle : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteRunningHours : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}relativeRunningHours : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberAlarms : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberUnacknowledgedAlarms : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberActiveAcknowledgedAlarms : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberGBOperations : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberMBOperations : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startAttempts : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dcSupplyTerm12 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serviceTimer1RunningHours : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serviceTimer1RunningDays : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serviceTimer2RunningHours : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}serviceTimer2RunningDays : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cosPhi : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cosPhiType : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rpm : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}runningHoursLoadProfile : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}multiInput20 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}multiInput21 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}multiInput22 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}multiInput23 : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainsPower : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineSpeed : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineCoolantTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineOilPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberActualFaults : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineOilTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fuelTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeManifold1Pressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airInletTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolantLevel : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fuelRate : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}chargeAirPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeManifold1Temperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driversDemandEnginePercentTorque : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualEnginePercentTorque : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceleratorPedalPosition : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}percentLoadCurrentSpeed : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airInletPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustGasTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineHours : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineOilFilterDifferentialPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}keyswitchBatteryPotential : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fuelDeliveryPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineOilLevel : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}crankcasePressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolantPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInFuel : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blowbyFlow : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fuelRailPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingRailPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aftercoolerWaterInletTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboOilTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particulateTrapInletPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airFilterDifferentialPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolantFilterDifferentialPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atmosphericPressure : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientAirTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatureRight : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatureLeft : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 0    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 1    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 2    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 3    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 4    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 5    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 6    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 7    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 8    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}windingTemperature : 9    1
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxiliaryAnalogInfo : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineTurbocharger1CompressorOutletTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineIntercoolerTemperature : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineTripFuel : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineTotalFuel : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tripFuelGasseous : 1    10
    Should Contain X Times    ${agcGenset150_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalFuelGasseous : 1    10
    ${particleMeasurements_start}=    Get Index From List    ${full_list}    === ESS_particleMeasurements start of topic ===
    ${particleMeasurements_end}=    Get Index From List    ${full_list}    === ESS_particleMeasurements end of topic ===
    ${particleMeasurements_list}=    Get Slice From List    ${full_list}    start=${particleMeasurements_start}    end=${particleMeasurements_end}
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 0    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 1    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 2    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 3    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 4    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 5    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 6    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 7    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 8    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}particleSizes : 9    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 0    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 1    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 2    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 3    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 4    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 5    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 6    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 7    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 8    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}matterConcentration : 9    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 0    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 1    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 2    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 3    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 4    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 5    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 6    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 7    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 8    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberConcentration : 9    1
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}typicalParticleSize : 1    10
    Should Contain X Times    ${particleMeasurements_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
