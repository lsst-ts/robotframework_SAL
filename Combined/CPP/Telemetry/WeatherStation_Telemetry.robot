*** Settings ***
Documentation    WeatherStation Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    WeatherStation
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
    Should Contain    "${output}"   Popen
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== WeatherStation subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_weather test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_weather
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_weather start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::weather_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_weather end of topic ===
    Comment    ======= Verify ${subSystem}_windDirection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_windDirection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_windDirection start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::windDirection_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_windDirection end of topic ===
    Comment    ======= Verify ${subSystem}_windGustDirection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_windGustDirection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_windGustDirection start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::windGustDirection_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_windGustDirection end of topic ===
    Comment    ======= Verify ${subSystem}_windSpeed test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_windSpeed
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_windSpeed start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::windSpeed_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_windSpeed end of topic ===
    Comment    ======= Verify ${subSystem}_airTemperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_airTemperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_airTemperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::airTemperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_airTemperature end of topic ===
    Comment    ======= Verify ${subSystem}_relativeHumidity test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_relativeHumidity
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_relativeHumidity start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::relativeHumidity_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_relativeHumidity end of topic ===
    Comment    ======= Verify ${subSystem}_dewPoint test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_dewPoint
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_dewPoint start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::dewPoint_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_dewPoint end of topic ===
    Comment    ======= Verify ${subSystem}_snowDepth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_snowDepth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_snowDepth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::snowDepth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_snowDepth end of topic ===
    Comment    ======= Verify ${subSystem}_solarNetRadiation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_solarNetRadiation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_solarNetRadiation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::solarNetRadiation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_solarNetRadiation end of topic ===
    Comment    ======= Verify ${subSystem}_airPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_airPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_airPressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::airPressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_airPressure end of topic ===
    Comment    ======= Verify ${subSystem}_precipitation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_precipitation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_precipitation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::precipitation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_precipitation end of topic ===
    Comment    ======= Verify ${subSystem}_soilTemperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_soilTemperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === WeatherStation_soilTemperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::soilTemperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === WeatherStation_soilTemperature end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== WeatherStation subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${weather_start}=    Get Index From List    ${full_list}    === WeatherStation_weather start of topic ===
    ${weather_end}=    Get Index From List    ${full_list}    === WeatherStation_weather end of topic ===
    ${weather_list}=    Get Slice From List    ${full_list}    start=${weather_start}    end=${weather_end}
    Should Contain X Times    ${weather_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambient_temp : 1    10
    Should Contain X Times    ${weather_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humidity : 1    10
    Should Contain X Times    ${weather_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    10
    ${windDirection_start}=    Get Index From List    ${full_list}    === WeatherStation_windDirection start of topic ===
    ${windDirection_end}=    Get Index From List    ${full_list}    === WeatherStation_windDirection end of topic ===
    ${windDirection_list}=    Get Slice From List    ${full_list}    start=${windDirection_start}    end=${windDirection_end}
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}value : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg2M : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max2M : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min2M : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg10M : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max10M : 1    10
    Should Contain X Times    ${windDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${windGustDirection_start}=    Get Index From List    ${full_list}    === WeatherStation_windGustDirection start of topic ===
    ${windGustDirection_end}=    Get Index From List    ${full_list}    === WeatherStation_windGustDirection end of topic ===
    ${windGustDirection_list}=    Get Slice From List    ${full_list}    start=${windGustDirection_start}    end=${windGustDirection_end}
    Should Contain X Times    ${windGustDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}value10M : 1    10
    Should Contain X Times    ${windGustDirection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${windSpeed_start}=    Get Index From List    ${full_list}    === WeatherStation_windSpeed start of topic ===
    ${windSpeed_end}=    Get Index From List    ${full_list}    === WeatherStation_windSpeed end of topic ===
    ${windSpeed_list}=    Get Slice From List    ${full_list}    start=${windSpeed_start}    end=${windSpeed_end}
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}value : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg2M : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max2M : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min2M : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg10M : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max10M : 1    10
    Should Contain X Times    ${windSpeed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${airTemperature_start}=    Get Index From List    ${full_list}    === WeatherStation_airTemperature start of topic ===
    ${airTemperature_end}=    Get Index From List    ${full_list}    === WeatherStation_airTemperature end of topic ===
    ${airTemperature_list}=    Get Slice From List    ${full_list}    start=${airTemperature_start}    end=${airTemperature_end}
    Should Contain X Times    ${airTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg24H : 1    10
    Should Contain X Times    ${airTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${airTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max24H : 1    10
    Should Contain X Times    ${airTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min24H : 1    10
    Should Contain X Times    ${airTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${relativeHumidity_start}=    Get Index From List    ${full_list}    === WeatherStation_relativeHumidity start of topic ===
    ${relativeHumidity_end}=    Get Index From List    ${full_list}    === WeatherStation_relativeHumidity end of topic ===
    ${relativeHumidity_list}=    Get Slice From List    ${full_list}    start=${relativeHumidity_start}    end=${relativeHumidity_end}
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg24H : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max24H : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min24H : 1    10
    Should Contain X Times    ${relativeHumidity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${dewPoint_start}=    Get Index From List    ${full_list}    === WeatherStation_dewPoint start of topic ===
    ${dewPoint_end}=    Get Index From List    ${full_list}    === WeatherStation_dewPoint end of topic ===
    ${dewPoint_list}=    Get Slice From List    ${full_list}    start=${dewPoint_start}    end=${dewPoint_end}
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${dewPoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${snowDepth_start}=    Get Index From List    ${full_list}    === WeatherStation_snowDepth start of topic ===
    ${snowDepth_end}=    Get Index From List    ${full_list}    === WeatherStation_snowDepth end of topic ===
    ${snowDepth_list}=    Get Slice From List    ${full_list}    start=${snowDepth_start}    end=${snowDepth_end}
    Should Contain X Times    ${snowDepth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${snowDepth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max24H : 1    10
    Should Contain X Times    ${snowDepth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min24H : 1    10
    Should Contain X Times    ${snowDepth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg24H : 1    10
    Should Contain X Times    ${snowDepth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${solarNetRadiation_start}=    Get Index From List    ${full_list}    === WeatherStation_solarNetRadiation start of topic ===
    ${solarNetRadiation_end}=    Get Index From List    ${full_list}    === WeatherStation_solarNetRadiation end of topic ===
    ${solarNetRadiation_list}=    Get Slice From List    ${full_list}    start=${solarNetRadiation_start}    end=${solarNetRadiation_end}
    Should Contain X Times    ${solarNetRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${solarNetRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max24H : 1    10
    Should Contain X Times    ${solarNetRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min24H : 1    10
    Should Contain X Times    ${solarNetRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg24H : 1    10
    Should Contain X Times    ${solarNetRadiation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${airPressure_start}=    Get Index From List    ${full_list}    === WeatherStation_airPressure start of topic ===
    ${airPressure_end}=    Get Index From List    ${full_list}    === WeatherStation_airPressure end of topic ===
    ${airPressure_list}=    Get Slice From List    ${full_list}    start=${airPressure_start}    end=${airPressure_end}
    Should Contain X Times    ${airPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}paAvg1M : 1    10
    Should Contain X Times    ${airPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}patrValue3H : 1    10
    Should Contain X Times    ${airPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pateValue3H : 1    10
    Should Contain X Times    ${airPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${precipitation_start}=    Get Index From List    ${full_list}    === WeatherStation_precipitation start of topic ===
    ${precipitation_end}=    Get Index From List    ${full_list}    === WeatherStation_precipitation end of topic ===
    ${precipitation_list}=    Get Slice From List    ${full_list}    start=${precipitation_start}    end=${precipitation_end}
    Should Contain X Times    ${precipitation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prSum1M : 1    10
    Should Contain X Times    ${precipitation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prSum1H : 1    10
    Should Contain X Times    ${precipitation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prfSum1M : 1    10
    Should Contain X Times    ${precipitation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
    ${soilTemperature_start}=    Get Index From List    ${full_list}    === WeatherStation_soilTemperature start of topic ===
    ${soilTemperature_end}=    Get Index From List    ${full_list}    === WeatherStation_soilTemperature end of topic ===
    ${soilTemperature_list}=    Get Slice From List    ${full_list}    start=${soilTemperature_start}    end=${soilTemperature_end}
    Should Contain X Times    ${soilTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg24H : 1    10
    Should Contain X Times    ${soilTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avg1M : 1    10
    Should Contain X Times    ${soilTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}max24H : 1    10
    Should Contain X Times    ${soilTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}min24H : 1    10
    Should Contain X Times    ${soilTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorName : RO    10
