*** Settings ***
Documentation    Environment_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Environment
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Environment all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${weather_start}=    Get Index From List    ${full_list}    === Environment_weather start of topic ===
    ${weather_end}=    Get Index From List    ${full_list}    === Environment_weather end of topic ===
    ${weather_list}=    Get Slice From List    ${full_list}    start=${weather_start}    end=${weather_end + 1}
    Log Many    ${weather_list}
    Should Contain    ${weather_list}    === Environment_weather start of topic ===
    Should Contain    ${weather_list}    === Environment_weather end of topic ===
    ${windDirection_start}=    Get Index From List    ${full_list}    === Environment_windDirection start of topic ===
    ${windDirection_end}=    Get Index From List    ${full_list}    === Environment_windDirection end of topic ===
    ${windDirection_list}=    Get Slice From List    ${full_list}    start=${windDirection_start}    end=${windDirection_end + 1}
    Log Many    ${windDirection_list}
    Should Contain    ${windDirection_list}    === Environment_windDirection start of topic ===
    Should Contain    ${windDirection_list}    === Environment_windDirection end of topic ===
    ${windGustDirection_start}=    Get Index From List    ${full_list}    === Environment_windGustDirection start of topic ===
    ${windGustDirection_end}=    Get Index From List    ${full_list}    === Environment_windGustDirection end of topic ===
    ${windGustDirection_list}=    Get Slice From List    ${full_list}    start=${windGustDirection_start}    end=${windGustDirection_end + 1}
    Log Many    ${windGustDirection_list}
    Should Contain    ${windGustDirection_list}    === Environment_windGustDirection start of topic ===
    Should Contain    ${windGustDirection_list}    === Environment_windGustDirection end of topic ===
    ${windSpeed_start}=    Get Index From List    ${full_list}    === Environment_windSpeed start of topic ===
    ${windSpeed_end}=    Get Index From List    ${full_list}    === Environment_windSpeed end of topic ===
    ${windSpeed_list}=    Get Slice From List    ${full_list}    start=${windSpeed_start}    end=${windSpeed_end + 1}
    Log Many    ${windSpeed_list}
    Should Contain    ${windSpeed_list}    === Environment_windSpeed start of topic ===
    Should Contain    ${windSpeed_list}    === Environment_windSpeed end of topic ===
    ${airTemperature_start}=    Get Index From List    ${full_list}    === Environment_airTemperature start of topic ===
    ${airTemperature_end}=    Get Index From List    ${full_list}    === Environment_airTemperature end of topic ===
    ${airTemperature_list}=    Get Slice From List    ${full_list}    start=${airTemperature_start}    end=${airTemperature_end + 1}
    Log Many    ${airTemperature_list}
    Should Contain    ${airTemperature_list}    === Environment_airTemperature start of topic ===
    Should Contain    ${airTemperature_list}    === Environment_airTemperature end of topic ===
    ${relativeHumidity_start}=    Get Index From List    ${full_list}    === Environment_relativeHumidity start of topic ===
    ${relativeHumidity_end}=    Get Index From List    ${full_list}    === Environment_relativeHumidity end of topic ===
    ${relativeHumidity_list}=    Get Slice From List    ${full_list}    start=${relativeHumidity_start}    end=${relativeHumidity_end + 1}
    Log Many    ${relativeHumidity_list}
    Should Contain    ${relativeHumidity_list}    === Environment_relativeHumidity start of topic ===
    Should Contain    ${relativeHumidity_list}    === Environment_relativeHumidity end of topic ===
    ${dewPoint_start}=    Get Index From List    ${full_list}    === Environment_dewPoint start of topic ===
    ${dewPoint_end}=    Get Index From List    ${full_list}    === Environment_dewPoint end of topic ===
    ${dewPoint_list}=    Get Slice From List    ${full_list}    start=${dewPoint_start}    end=${dewPoint_end + 1}
    Log Many    ${dewPoint_list}
    Should Contain    ${dewPoint_list}    === Environment_dewPoint start of topic ===
    Should Contain    ${dewPoint_list}    === Environment_dewPoint end of topic ===
    ${snowDepth_start}=    Get Index From List    ${full_list}    === Environment_snowDepth start of topic ===
    ${snowDepth_end}=    Get Index From List    ${full_list}    === Environment_snowDepth end of topic ===
    ${snowDepth_list}=    Get Slice From List    ${full_list}    start=${snowDepth_start}    end=${snowDepth_end + 1}
    Log Many    ${snowDepth_list}
    Should Contain    ${snowDepth_list}    === Environment_snowDepth start of topic ===
    Should Contain    ${snowDepth_list}    === Environment_snowDepth end of topic ===
    ${solarNetRadiation_start}=    Get Index From List    ${full_list}    === Environment_solarNetRadiation start of topic ===
    ${solarNetRadiation_end}=    Get Index From List    ${full_list}    === Environment_solarNetRadiation end of topic ===
    ${solarNetRadiation_list}=    Get Slice From List    ${full_list}    start=${solarNetRadiation_start}    end=${solarNetRadiation_end + 1}
    Log Many    ${solarNetRadiation_list}
    Should Contain    ${solarNetRadiation_list}    === Environment_solarNetRadiation start of topic ===
    Should Contain    ${solarNetRadiation_list}    === Environment_solarNetRadiation end of topic ===
    ${airPressure_start}=    Get Index From List    ${full_list}    === Environment_airPressure start of topic ===
    ${airPressure_end}=    Get Index From List    ${full_list}    === Environment_airPressure end of topic ===
    ${airPressure_list}=    Get Slice From List    ${full_list}    start=${airPressure_start}    end=${airPressure_end + 1}
    Log Many    ${airPressure_list}
    Should Contain    ${airPressure_list}    === Environment_airPressure start of topic ===
    Should Contain    ${airPressure_list}    === Environment_airPressure end of topic ===
    ${precipitation_start}=    Get Index From List    ${full_list}    === Environment_precipitation start of topic ===
    ${precipitation_end}=    Get Index From List    ${full_list}    === Environment_precipitation end of topic ===
    ${precipitation_list}=    Get Slice From List    ${full_list}    start=${precipitation_start}    end=${precipitation_end + 1}
    Log Many    ${precipitation_list}
    Should Contain    ${precipitation_list}    === Environment_precipitation start of topic ===
    Should Contain    ${precipitation_list}    === Environment_precipitation end of topic ===
    ${soilTemperature_start}=    Get Index From List    ${full_list}    === Environment_soilTemperature start of topic ===
    ${soilTemperature_end}=    Get Index From List    ${full_list}    === Environment_soilTemperature end of topic ===
    ${soilTemperature_list}=    Get Slice From List    ${full_list}    start=${soilTemperature_start}    end=${soilTemperature_end + 1}
    Log Many    ${soilTemperature_list}
    Should Contain    ${soilTemperature_list}    === Environment_soilTemperature start of topic ===
    Should Contain    ${soilTemperature_list}    === Environment_soilTemperature end of topic ===
