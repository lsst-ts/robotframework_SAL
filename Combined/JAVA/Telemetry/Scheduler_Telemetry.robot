*** Settings ***
Documentation    Scheduler_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${SALVersion}_${XMLVersion}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}_${XMLVersion}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}_${XMLVersion}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${timestamp_start}=    Get Index From List    ${full_list}    === Scheduler_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === Scheduler_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end + 1}
    Log Many    ${timestamp_list}
    Should Contain    ${timestamp_list}    === Scheduler_timestamp start of topic ===
    Should Contain    ${timestamp_list}    === Scheduler_timestamp end of topic ===
    ${nightSummary_start}=    Get Index From List    ${full_list}    === Scheduler_nightSummary start of topic ===
    ${nightSummary_end}=    Get Index From List    ${full_list}    === Scheduler_nightSummary end of topic ===
    ${nightSummary_list}=    Get Slice From List    ${full_list}    start=${nightSummary_start}    end=${nightSummary_end + 1}
    Log Many    ${nightSummary_list}
    Should Contain    ${nightSummary_list}    === Scheduler_nightSummary start of topic ===
    Should Contain    ${nightSummary_list}    === Scheduler_nightSummary end of topic ===
    ${predictedSchedule_start}=    Get Index From List    ${full_list}    === Scheduler_predictedSchedule start of topic ===
    ${predictedSchedule_end}=    Get Index From List    ${full_list}    === Scheduler_predictedSchedule end of topic ===
    ${predictedSchedule_list}=    Get Slice From List    ${full_list}    start=${predictedSchedule_start}    end=${predictedSchedule_end + 1}
    Log Many    ${predictedSchedule_list}
    Should Contain    ${predictedSchedule_list}    === Scheduler_predictedSchedule start of topic ===
    Should Contain    ${predictedSchedule_list}    === Scheduler_predictedSchedule end of topic ===
    ${surveyTopology_start}=    Get Index From List    ${full_list}    === Scheduler_surveyTopology start of topic ===
    ${surveyTopology_end}=    Get Index From List    ${full_list}    === Scheduler_surveyTopology end of topic ===
    ${surveyTopology_list}=    Get Slice From List    ${full_list}    start=${surveyTopology_start}    end=${surveyTopology_end + 1}
    Log Many    ${surveyTopology_list}
    Should Contain    ${surveyTopology_list}    === Scheduler_surveyTopology start of topic ===
    Should Contain    ${surveyTopology_list}    === Scheduler_surveyTopology end of topic ===
    ${schedulerConfig_start}=    Get Index From List    ${full_list}    === Scheduler_schedulerConfig start of topic ===
    ${schedulerConfig_end}=    Get Index From List    ${full_list}    === Scheduler_schedulerConfig end of topic ===
    ${schedulerConfig_list}=    Get Slice From List    ${full_list}    start=${schedulerConfig_start}    end=${schedulerConfig_end + 1}
    Log Many    ${schedulerConfig_list}
    Should Contain    ${schedulerConfig_list}    === Scheduler_schedulerConfig start of topic ===
    Should Contain    ${schedulerConfig_list}    === Scheduler_schedulerConfig end of topic ===
    ${driverConfig_start}=    Get Index From List    ${full_list}    === Scheduler_driverConfig start of topic ===
    ${driverConfig_end}=    Get Index From List    ${full_list}    === Scheduler_driverConfig end of topic ===
    ${driverConfig_list}=    Get Slice From List    ${full_list}    start=${driverConfig_start}    end=${driverConfig_end + 1}
    Log Many    ${driverConfig_list}
    Should Contain    ${driverConfig_list}    === Scheduler_driverConfig start of topic ===
    Should Contain    ${driverConfig_list}    === Scheduler_driverConfig end of topic ===
    ${obsSiteConfig_start}=    Get Index From List    ${full_list}    === Scheduler_obsSiteConfig start of topic ===
    ${obsSiteConfig_end}=    Get Index From List    ${full_list}    === Scheduler_obsSiteConfig end of topic ===
    ${obsSiteConfig_list}=    Get Slice From List    ${full_list}    start=${obsSiteConfig_start}    end=${obsSiteConfig_end + 1}
    Log Many    ${obsSiteConfig_list}
    Should Contain    ${obsSiteConfig_list}    === Scheduler_obsSiteConfig start of topic ===
    Should Contain    ${obsSiteConfig_list}    === Scheduler_obsSiteConfig end of topic ===
    ${telescopeConfig_start}=    Get Index From List    ${full_list}    === Scheduler_telescopeConfig start of topic ===
    ${telescopeConfig_end}=    Get Index From List    ${full_list}    === Scheduler_telescopeConfig end of topic ===
    ${telescopeConfig_list}=    Get Slice From List    ${full_list}    start=${telescopeConfig_start}    end=${telescopeConfig_end + 1}
    Log Many    ${telescopeConfig_list}
    Should Contain    ${telescopeConfig_list}    === Scheduler_telescopeConfig start of topic ===
    Should Contain    ${telescopeConfig_list}    === Scheduler_telescopeConfig end of topic ===
    ${rotatorConfig_start}=    Get Index From List    ${full_list}    === Scheduler_rotatorConfig start of topic ===
    ${rotatorConfig_end}=    Get Index From List    ${full_list}    === Scheduler_rotatorConfig end of topic ===
    ${rotatorConfig_list}=    Get Slice From List    ${full_list}    start=${rotatorConfig_start}    end=${rotatorConfig_end + 1}
    Log Many    ${rotatorConfig_list}
    Should Contain    ${rotatorConfig_list}    === Scheduler_rotatorConfig start of topic ===
    Should Contain    ${rotatorConfig_list}    === Scheduler_rotatorConfig end of topic ===
    ${domeConfig_start}=    Get Index From List    ${full_list}    === Scheduler_domeConfig start of topic ===
    ${domeConfig_end}=    Get Index From List    ${full_list}    === Scheduler_domeConfig end of topic ===
    ${domeConfig_list}=    Get Slice From List    ${full_list}    start=${domeConfig_start}    end=${domeConfig_end + 1}
    Log Many    ${domeConfig_list}
    Should Contain    ${domeConfig_list}    === Scheduler_domeConfig start of topic ===
    Should Contain    ${domeConfig_list}    === Scheduler_domeConfig end of topic ===
    ${cameraConfig_start}=    Get Index From List    ${full_list}    === Scheduler_cameraConfig start of topic ===
    ${cameraConfig_end}=    Get Index From List    ${full_list}    === Scheduler_cameraConfig end of topic ===
    ${cameraConfig_list}=    Get Slice From List    ${full_list}    start=${cameraConfig_start}    end=${cameraConfig_end + 1}
    Log Many    ${cameraConfig_list}
    Should Contain    ${cameraConfig_list}    === Scheduler_cameraConfig start of topic ===
    Should Contain    ${cameraConfig_list}    === Scheduler_cameraConfig end of topic ===
    ${slewConfig_start}=    Get Index From List    ${full_list}    === Scheduler_slewConfig start of topic ===
    ${slewConfig_end}=    Get Index From List    ${full_list}    === Scheduler_slewConfig end of topic ===
    ${slewConfig_list}=    Get Slice From List    ${full_list}    start=${slewConfig_start}    end=${slewConfig_end + 1}
    Log Many    ${slewConfig_list}
    Should Contain    ${slewConfig_list}    === Scheduler_slewConfig start of topic ===
    Should Contain    ${slewConfig_list}    === Scheduler_slewConfig end of topic ===
    ${opticsLoopCorrConfig_start}=    Get Index From List    ${full_list}    === Scheduler_opticsLoopCorrConfig start of topic ===
    ${opticsLoopCorrConfig_end}=    Get Index From List    ${full_list}    === Scheduler_opticsLoopCorrConfig end of topic ===
    ${opticsLoopCorrConfig_list}=    Get Slice From List    ${full_list}    start=${opticsLoopCorrConfig_start}    end=${opticsLoopCorrConfig_end + 1}
    Log Many    ${opticsLoopCorrConfig_list}
    Should Contain    ${opticsLoopCorrConfig_list}    === Scheduler_opticsLoopCorrConfig start of topic ===
    Should Contain    ${opticsLoopCorrConfig_list}    === Scheduler_opticsLoopCorrConfig end of topic ===
    ${parkConfig_start}=    Get Index From List    ${full_list}    === Scheduler_parkConfig start of topic ===
    ${parkConfig_end}=    Get Index From List    ${full_list}    === Scheduler_parkConfig end of topic ===
    ${parkConfig_list}=    Get Slice From List    ${full_list}    start=${parkConfig_start}    end=${parkConfig_end + 1}
    Log Many    ${parkConfig_list}
    Should Contain    ${parkConfig_list}    === Scheduler_parkConfig start of topic ===
    Should Contain    ${parkConfig_list}    === Scheduler_parkConfig end of topic ===
    ${generalPropConfig_start}=    Get Index From List    ${full_list}    === Scheduler_generalPropConfig start of topic ===
    ${generalPropConfig_end}=    Get Index From List    ${full_list}    === Scheduler_generalPropConfig end of topic ===
    ${generalPropConfig_list}=    Get Slice From List    ${full_list}    start=${generalPropConfig_start}    end=${generalPropConfig_end + 1}
    Log Many    ${generalPropConfig_list}
    Should Contain    ${generalPropConfig_list}    === Scheduler_generalPropConfig start of topic ===
    Should Contain    ${generalPropConfig_list}    === Scheduler_generalPropConfig end of topic ===
    ${sequencePropConfig_start}=    Get Index From List    ${full_list}    === Scheduler_sequencePropConfig start of topic ===
    ${sequencePropConfig_end}=    Get Index From List    ${full_list}    === Scheduler_sequencePropConfig end of topic ===
    ${sequencePropConfig_list}=    Get Slice From List    ${full_list}    start=${sequencePropConfig_start}    end=${sequencePropConfig_end + 1}
    Log Many    ${sequencePropConfig_list}
    Should Contain    ${sequencePropConfig_list}    === Scheduler_sequencePropConfig start of topic ===
    Should Contain    ${sequencePropConfig_list}    === Scheduler_sequencePropConfig end of topic ===
    ${observatoryState_start}=    Get Index From List    ${full_list}    === Scheduler_observatoryState start of topic ===
    ${observatoryState_end}=    Get Index From List    ${full_list}    === Scheduler_observatoryState end of topic ===
    ${observatoryState_list}=    Get Slice From List    ${full_list}    start=${observatoryState_start}    end=${observatoryState_end + 1}
    Log Many    ${observatoryState_list}
    Should Contain    ${observatoryState_list}    === Scheduler_observatoryState start of topic ===
    Should Contain    ${observatoryState_list}    === Scheduler_observatoryState end of topic ===
    ${observation_start}=    Get Index From List    ${full_list}    === Scheduler_observation start of topic ===
    ${observation_end}=    Get Index From List    ${full_list}    === Scheduler_observation end of topic ===
    ${observation_list}=    Get Slice From List    ${full_list}    start=${observation_start}    end=${observation_end + 1}
    Log Many    ${observation_list}
    Should Contain    ${observation_list}    === Scheduler_observation start of topic ===
    Should Contain    ${observation_list}    === Scheduler_observation end of topic ===
    ${interestedProposal_start}=    Get Index From List    ${full_list}    === Scheduler_interestedProposal start of topic ===
    ${interestedProposal_end}=    Get Index From List    ${full_list}    === Scheduler_interestedProposal end of topic ===
    ${interestedProposal_list}=    Get Slice From List    ${full_list}    start=${interestedProposal_start}    end=${interestedProposal_end + 1}
    Log Many    ${interestedProposal_list}
    Should Contain    ${interestedProposal_list}    === Scheduler_interestedProposal start of topic ===
    Should Contain    ${interestedProposal_list}    === Scheduler_interestedProposal end of topic ===
    ${timeHandler_start}=    Get Index From List    ${full_list}    === Scheduler_timeHandler start of topic ===
    ${timeHandler_end}=    Get Index From List    ${full_list}    === Scheduler_timeHandler end of topic ===
    ${timeHandler_list}=    Get Slice From List    ${full_list}    start=${timeHandler_start}    end=${timeHandler_end + 1}
    Log Many    ${timeHandler_list}
    Should Contain    ${timeHandler_list}    === Scheduler_timeHandler start of topic ===
    Should Contain    ${timeHandler_list}    === Scheduler_timeHandler end of topic ===
    ${bulkCloud_start}=    Get Index From List    ${full_list}    === Scheduler_bulkCloud start of topic ===
    ${bulkCloud_end}=    Get Index From List    ${full_list}    === Scheduler_bulkCloud end of topic ===
    ${bulkCloud_list}=    Get Slice From List    ${full_list}    start=${bulkCloud_start}    end=${bulkCloud_end + 1}
    Log Many    ${bulkCloud_list}
    Should Contain    ${bulkCloud_list}    === Scheduler_bulkCloud start of topic ===
    Should Contain    ${bulkCloud_list}    === Scheduler_bulkCloud end of topic ===
    ${cloudMap_start}=    Get Index From List    ${full_list}    === Scheduler_cloudMap start of topic ===
    ${cloudMap_end}=    Get Index From List    ${full_list}    === Scheduler_cloudMap end of topic ===
    ${cloudMap_list}=    Get Slice From List    ${full_list}    start=${cloudMap_start}    end=${cloudMap_end + 1}
    Log Many    ${cloudMap_list}
    Should Contain    ${cloudMap_list}    === Scheduler_cloudMap start of topic ===
    Should Contain    ${cloudMap_list}    === Scheduler_cloudMap end of topic ===
    ${seeing_start}=    Get Index From List    ${full_list}    === Scheduler_seeing start of topic ===
    ${seeing_end}=    Get Index From List    ${full_list}    === Scheduler_seeing end of topic ===
    ${seeing_list}=    Get Slice From List    ${full_list}    start=${seeing_start}    end=${seeing_end + 1}
    Log Many    ${seeing_list}
    Should Contain    ${seeing_list}    === Scheduler_seeing start of topic ===
    Should Contain    ${seeing_list}    === Scheduler_seeing end of topic ===
    ${wind_start}=    Get Index From List    ${full_list}    === Scheduler_wind start of topic ===
    ${wind_end}=    Get Index From List    ${full_list}    === Scheduler_wind end of topic ===
    ${wind_list}=    Get Slice From List    ${full_list}    start=${wind_start}    end=${wind_end + 1}
    Log Many    ${wind_list}
    Should Contain    ${wind_list}    === Scheduler_wind start of topic ===
    Should Contain    ${wind_list}    === Scheduler_wind end of topic ===
    ${temperature_start}=    Get Index From List    ${full_list}    === Scheduler_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === Scheduler_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end + 1}
    Log Many    ${temperature_list}
    Should Contain    ${temperature_list}    === Scheduler_temperature start of topic ===
    Should Contain    ${temperature_list}    === Scheduler_temperature end of topic ===
    ${skyBrightness_start}=    Get Index From List    ${full_list}    === Scheduler_skyBrightness start of topic ===
    ${skyBrightness_end}=    Get Index From List    ${full_list}    === Scheduler_skyBrightness end of topic ===
    ${skyBrightness_list}=    Get Slice From List    ${full_list}    start=${skyBrightness_start}    end=${skyBrightness_end + 1}
    Log Many    ${skyBrightness_list}
    Should Contain    ${skyBrightness_list}    === Scheduler_skyBrightness start of topic ===
    Should Contain    ${skyBrightness_list}    === Scheduler_skyBrightness end of topic ===
    ${photometricQuality_start}=    Get Index From List    ${full_list}    === Scheduler_photometricQuality start of topic ===
    ${photometricQuality_end}=    Get Index From List    ${full_list}    === Scheduler_photometricQuality end of topic ===
    ${photometricQuality_list}=    Get Slice From List    ${full_list}    start=${photometricQuality_start}    end=${photometricQuality_end + 1}
    Log Many    ${photometricQuality_list}
    Should Contain    ${photometricQuality_list}    === Scheduler_photometricQuality start of topic ===
    Should Contain    ${photometricQuality_list}    === Scheduler_photometricQuality end of topic ===
    ${avoidanceRegions_start}=    Get Index From List    ${full_list}    === Scheduler_avoidanceRegions start of topic ===
    ${avoidanceRegions_end}=    Get Index From List    ${full_list}    === Scheduler_avoidanceRegions end of topic ===
    ${avoidanceRegions_list}=    Get Slice From List    ${full_list}    start=${avoidanceRegions_start}    end=${avoidanceRegions_end + 1}
    Log Many    ${avoidanceRegions_list}
    Should Contain    ${avoidanceRegions_list}    === Scheduler_avoidanceRegions start of topic ===
    Should Contain    ${avoidanceRegions_list}    === Scheduler_avoidanceRegions end of topic ===
    ${downtime_start}=    Get Index From List    ${full_list}    === Scheduler_downtime start of topic ===
    ${downtime_end}=    Get Index From List    ${full_list}    === Scheduler_downtime end of topic ===
    ${downtime_list}=    Get Slice From List    ${full_list}    start=${downtime_start}    end=${downtime_end + 1}
    Log Many    ${downtime_list}
    Should Contain    ${downtime_list}    === Scheduler_downtime start of topic ===
    Should Contain    ${downtime_list}    === Scheduler_downtime end of topic ===
