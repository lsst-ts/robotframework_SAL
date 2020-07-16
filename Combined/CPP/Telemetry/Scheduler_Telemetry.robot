*** Settings ***
Documentation    Scheduler Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
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
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== Scheduler subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_timestamp end of topic ===
    Comment    ======= Verify ${subSystem}_nightSummary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_nightSummary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_nightSummary start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::nightSummary_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_nightSummary end of topic ===
    Comment    ======= Verify ${subSystem}_predictedSchedule test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_predictedSchedule
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_predictedSchedule start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::predictedSchedule_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_predictedSchedule end of topic ===
    Comment    ======= Verify ${subSystem}_surveyTopology test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_surveyTopology
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_surveyTopology start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::surveyTopology_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_surveyTopology end of topic ===
    Comment    ======= Verify ${subSystem}_schedulerConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_schedulerConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_schedulerConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::schedulerConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_schedulerConfig end of topic ===
    Comment    ======= Verify ${subSystem}_driverConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_driverConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_driverConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::driverConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_driverConfig end of topic ===
    Comment    ======= Verify ${subSystem}_obsSiteConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_obsSiteConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_obsSiteConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::obsSiteConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_obsSiteConfig end of topic ===
    Comment    ======= Verify ${subSystem}_telescopeConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_telescopeConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_telescopeConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::telescopeConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_telescopeConfig end of topic ===
    Comment    ======= Verify ${subSystem}_rotatorConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rotatorConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_rotatorConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rotatorConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_rotatorConfig end of topic ===
    Comment    ======= Verify ${subSystem}_domeConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_domeConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_domeConfig end of topic ===
    Comment    ======= Verify ${subSystem}_cameraConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cameraConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_cameraConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cameraConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_cameraConfig end of topic ===
    Comment    ======= Verify ${subSystem}_slewConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_slewConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_slewConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::slewConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_slewConfig end of topic ===
    Comment    ======= Verify ${subSystem}_opticsLoopCorrConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_opticsLoopCorrConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_opticsLoopCorrConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::opticsLoopCorrConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_opticsLoopCorrConfig end of topic ===
    Comment    ======= Verify ${subSystem}_parkConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_parkConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_parkConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::parkConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_parkConfig end of topic ===
    Comment    ======= Verify ${subSystem}_generalPropConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_generalPropConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_generalPropConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::generalPropConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_generalPropConfig end of topic ===
    Comment    ======= Verify ${subSystem}_sequencePropConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sequencePropConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_sequencePropConfig start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::sequencePropConfig_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_sequencePropConfig end of topic ===
    Comment    ======= Verify ${subSystem}_observatoryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_observatoryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_observatoryState start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::observatoryState_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_observatoryState end of topic ===
    Comment    ======= Verify ${subSystem}_observation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_observation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_observation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::observation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_observation end of topic ===
    Comment    ======= Verify ${subSystem}_interestedProposal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_interestedProposal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_interestedProposal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::interestedProposal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_interestedProposal end of topic ===
    Comment    ======= Verify ${subSystem}_timeHandler test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timeHandler
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_timeHandler start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timeHandler_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_timeHandler end of topic ===
    Comment    ======= Verify ${subSystem}_bulkCloud test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bulkCloud
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_bulkCloud start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bulkCloud_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_bulkCloud end of topic ===
    Comment    ======= Verify ${subSystem}_cloudMap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cloudMap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_cloudMap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cloudMap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_cloudMap end of topic ===
    Comment    ======= Verify ${subSystem}_seeing test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_seeing
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_seeing start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::seeing_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_seeing end of topic ===
    Comment    ======= Verify ${subSystem}_wind test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wind
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_wind start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wind_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_wind end of topic ===
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_temperature end of topic ===
    Comment    ======= Verify ${subSystem}_skyBrightness test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_skyBrightness
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_skyBrightness start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::skyBrightness_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_skyBrightness end of topic ===
    Comment    ======= Verify ${subSystem}_photometricQuality test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_photometricQuality
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_photometricQuality start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::photometricQuality_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_photometricQuality end of topic ===
    Comment    ======= Verify ${subSystem}_avoidanceRegions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_avoidanceRegions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_avoidanceRegions start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::avoidanceRegions_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_avoidanceRegions end of topic ===
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_downtime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Scheduler_downtime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::downtime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_downtime end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${timestamp_start}=    Get Index From List    ${full_list}    === Scheduler_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === Scheduler_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${nightSummary_start}=    Get Index From List    ${full_list}    === Scheduler_nightSummary start of topic ===
    ${nightSummary_end}=    Get Index From List    ${full_list}    === Scheduler_nightSummary end of topic ===
    ${nightSummary_list}=    Get Slice From List    ${full_list}    start=${nightSummary_start}    end=${nightSummary_end}
    Should Contain X Times    ${nightSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalVisits : 1    10
    ${predictedSchedule_start}=    Get Index From List    ${full_list}    === Scheduler_predictedSchedule start of topic ===
    ${predictedSchedule_end}=    Get Index From List    ${full_list}    === Scheduler_predictedSchedule end of topic ===
    ${predictedSchedule_list}=    Get Slice From List    ${full_list}    start=${predictedSchedule_start}    end=${predictedSchedule_end}
    Should Contain X Times    ${predictedSchedule_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${predictedSchedule_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${predictedSchedule_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    10
    Should Contain X Times    ${predictedSchedule_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitTime : 1    10
    Should Contain X Times    ${predictedSchedule_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : RO    10
    ${surveyTopology_start}=    Get Index From List    ${full_list}    === Scheduler_surveyTopology start of topic ===
    ${surveyTopology_end}=    Get Index From List    ${full_list}    === Scheduler_surveyTopology end of topic ===
    ${surveyTopology_list}=    Get Slice From List    ${full_list}    start=${surveyTopology_start}    end=${surveyTopology_end}
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGeneralProps : 1    10
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalPropos : RO    10
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSeqProps : 1    10
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencePropos : RO    10
    ${schedulerConfig_start}=    Get Index From List    ${full_list}    === Scheduler_schedulerConfig start of topic ===
    ${schedulerConfig_end}=    Get Index From List    ${full_list}    === Scheduler_schedulerConfig end of topic ===
    ${schedulerConfig_list}=    Get Slice From List    ${full_list}    start=${schedulerConfig_start}    end=${schedulerConfig_end}
    Should Contain X Times    ${schedulerConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surveyDuration : 1    10
    ${driverConfig_start}=    Get Index From List    ${full_list}    === Scheduler_driverConfig start of topic ===
    ${driverConfig_end}=    Get Index From List    ${full_list}    === Scheduler_driverConfig end of topic ===
    ${driverConfig_list}=    Get Slice From List    ${full_list}    start=${driverConfig_start}    end=${driverConfig_end}
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nightBoundary : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newMoonPhaseThreshold : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupType : RO    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupDatabase : RO    10
    ${obsSiteConfig_start}=    Get Index From List    ${full_list}    === Scheduler_obsSiteConfig start of topic ===
    ${obsSiteConfig_end}=    Get Index From List    ${full_list}    === Scheduler_obsSiteConfig end of topic ===
    ${obsSiteConfig_list}=    Get Slice From List    ${full_list}    start=${obsSiteConfig_start}    end=${obsSiteConfig_end}
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latitude : 1    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longitude : 1    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}height : 1    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}relativeHumidity : 1    10
    ${telescopeConfig_start}=    Get Index From List    ${full_list}    === Scheduler_telescopeConfig start of topic ===
    ${telescopeConfig_end}=    Get Index From List    ${full_list}    === Scheduler_telescopeConfig end of topic ===
    ${telescopeConfig_list}=    Get Slice From List    ${full_list}    start=${telescopeConfig_start}    end=${telescopeConfig_end}
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMinpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMinpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxspeed : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeAccel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeDecel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxspeed : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthAccel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDecel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settleTime : 1    10
    ${rotatorConfig_start}=    Get Index From List    ${full_list}    === Scheduler_rotatorConfig start of topic ===
    ${rotatorConfig_end}=    Get Index From List    ${full_list}    === Scheduler_rotatorConfig end of topic ===
    ${rotatorConfig_list}=    Get Slice From List    ${full_list}    start=${rotatorConfig_start}    end=${rotatorConfig_end}
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minpos : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxpos : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterChangePos : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxspeed : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accel : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decel : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}manualRotator : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}followsky : 1    10
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resumeAngle : 1    10
    ${domeConfig_start}=    Get Index From List    ${full_list}    === Scheduler_domeConfig start of topic ===
    ${domeConfig_end}=    Get Index From List    ${full_list}    === Scheduler_domeConfig end of topic ===
    ${domeConfig_list}=    Get Slice From List    ${full_list}    start=${domeConfig_start}    end=${domeConfig_end}
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxspeed : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeAccel : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeDecel : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeFreerange : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxspeed : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthAccel : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDecel : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthFreerange : 1    10
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settleTime : 1    10
    ${cameraConfig_start}=    Get Index From List    ${full_list}    === Scheduler_cameraConfig start of topic ===
    ${cameraConfig_end}=    Get Index From List    ${full_list}    === Scheduler_cameraConfig end of topic ===
    ${cameraConfig_list}=    Get Slice From List    ${full_list}    start=${cameraConfig_start}    end=${cameraConfig_end}
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readoutTime : 1    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutterTime : 1    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMountTime : 1    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterChangeTime : 1    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMounted : RO    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPos : RO    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterRemovable : RO    10
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterUnmounted : RO    10
    ${slewConfig_start}=    Get Index From List    ${full_list}    === Scheduler_slewConfig start of topic ===
    ${slewConfig_end}=    Get Index From List    ${full_list}    === Scheduler_slewConfig end of topic ===
    ${slewConfig_list}=    Get Slice From List    ${full_list}    start=${slewConfig_start}    end=${slewConfig_end}
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomalt : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomaz : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomazSettle : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelalt : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelaz : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsOpenLoop : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsClosedLoop : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelSettle : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelRot : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqFilter : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqExposures : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqReadout : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqAdc : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqInsOptics : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderPos : RO    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderAdq : RO    10
    ${opticsLoopCorrConfig_start}=    Get Index From List    ${full_list}    === Scheduler_opticsLoopCorrConfig start of topic ===
    ${opticsLoopCorrConfig_end}=    Get Index From List    ${full_list}    === Scheduler_opticsLoopCorrConfig end of topic ===
    ${opticsLoopCorrConfig_list}=    Get Slice From List    ${full_list}    start=${opticsLoopCorrConfig_start}    end=${opticsLoopCorrConfig_end}
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsOlSlope : 1    10
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 1    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 2    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 3    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 4    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 5    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 6    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 7    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 8    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 9    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 1    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 2    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 3    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 4    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 5    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 6    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 7    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 8    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 9    1
    ${parkConfig_start}=    Get Index From List    ${full_list}    === Scheduler_parkConfig start of topic ===
    ${parkConfig_end}=    Get Index From List    ${full_list}    === Scheduler_parkConfig end of topic ===
    ${parkConfig_list}=    Get Slice From List    ${full_list}    start=${parkConfig_start}    end=${parkConfig_end}
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAltitude : 1    10
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAzimuth : 1    10
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeRotator : 1    10
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAltitude : 1    10
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAzimuth : 1    10
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPosition : RO    10
    ${generalPropConfig_start}=    Get Index From List    ${full_list}    === Scheduler_generalPropConfig start of topic ===
    ${generalPropConfig_end}=    Get Index From List    ${full_list}    === Scheduler_generalPropConfig end of topic ===
    ${generalPropConfig_list}=    Get Slice From List    ${full_list}    start=${generalPropConfig_start}    end=${generalPropConfig_end}
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propId : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBoundary : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaLst : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decWindow : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxAirmass : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCloud : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDistanceMoon : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}excludePlanets : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numRegionSelections : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionTypes : RO    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionCombiners : RO    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numTimeRanges : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExclusionSelections : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionTypes : RO    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldRevisitLimit : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilters : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterNames : RO    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxNumTargets : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptSerendipity : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptConsecutiveVisits : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartLostSequences : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartCompleteSequences : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxVisitsGoal : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmassBonus : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleBonus : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleMax : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restrictGroupedVisits : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeInterval : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowStart : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowMax : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowEnd : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWeight : 1    10
    ${sequencePropConfig_start}=    Get Index From List    ${full_list}    === Scheduler_sequencePropConfig start of topic ===
    ${sequencePropConfig_end}=    Get Index From List    ${full_list}    === Scheduler_sequencePropConfig end of topic ===
    ${sequencePropConfig_list}=    Get Slice From List    ${full_list}    start=${sequencePropConfig_start}    end=${sequencePropConfig_end}
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propId : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBoundary : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaLst : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decWindow : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxAirmass : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCloud : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDistanceMoon : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}excludePlanets : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numUserRegions : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceNames : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceFilters : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceNames : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceNames : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequenceEvents : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequenceMaxMissed : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeIntervals : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowStarts : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowMaximums : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowEnds : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWeights : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceFilters : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceFilters : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceFilterVisits : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceEvents : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceMaxMissed : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeIntervals : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowStarts : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowMaximums : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowEnds : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWights : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilters : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterNames : RO    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxNumTargets : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptSerendipity : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptConsecutiveVisits : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartLostSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartCompleteSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxVisitsGoal : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmassBonus : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleBonus : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleMax : 1    10
    ${observatoryState_start}=    Get Index From List    ${full_list}    === Scheduler_observatoryState start of topic ===
    ${observatoryState_end}=    Get Index From List    ${full_list}    === Scheduler_observatoryState end of topic ===
    ${observatoryState_list}=    Get Slice From List    ${full_list}    start=${observatoryState_start}    end=${observatoryState_end}
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingRa : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingDec : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAngle : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingPa : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingRot : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracking : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeRotator : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPosition : RO    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMounted : RO    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterUnmounted : RO    10
    ${observation_start}=    Get Index From List    ${full_list}    === Scheduler_observation start of topic ===
    ${observation_end}=    Get Index From List    ${full_list}    === Scheduler_observation end of topic ===
    ${observation_list}=    Get Slice From List    ${full_list}    start=${observation_start}    end=${observation_end}
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationId : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartTime : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartMjd : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartLst : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}night : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : RO    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 0    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 1    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 2    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 3    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 4    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 5    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 6    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 7    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 8    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 9    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExposures : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 0    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 1    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 2    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 3    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 4    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 5    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 6    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 7    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 8    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 9    1
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitTime : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightness : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloud : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhm500 : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhmGeom : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhmEff : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fiveSigmaDepth : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunRa : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunDec : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}solarElong : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime : 1    10
    Should Contain X Times    ${observation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}note : RO    10
    ${interestedProposal_start}=    Get Index From List    ${full_list}    === Scheduler_interestedProposal start of topic ===
    ${interestedProposal_end}=    Get Index From List    ${full_list}    === Scheduler_interestedProposal end of topic ===
    ${interestedProposal_list}=    Get Slice From List    ${full_list}    start=${interestedProposal_start}    end=${interestedProposal_end}
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationId : 1    10
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    10
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 9    1
    ${timeHandler_start}=    Get Index From List    ${full_list}    === Scheduler_timeHandler start of topic ===
    ${timeHandler_end}=    Get Index From List    ${full_list}    === Scheduler_timeHandler end of topic ===
    ${timeHandler_list}=    Get Slice From List    ${full_list}    start=${timeHandler_start}    end=${timeHandler_end}
    Should Contain X Times    ${timeHandler_list}    ${SPACE}${SPACE}${SPACE}${SPACE}night : 1    10
    Should Contain X Times    ${timeHandler_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isDown : 1    10
    Should Contain X Times    ${timeHandler_list}    ${SPACE}${SPACE}${SPACE}${SPACE}downDuration : 1    10
    Should Contain X Times    ${timeHandler_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${bulkCloud_start}=    Get Index From List    ${full_list}    === Scheduler_bulkCloud start of topic ===
    ${bulkCloud_end}=    Get Index From List    ${full_list}    === Scheduler_bulkCloud end of topic ===
    ${bulkCloud_list}=    Get Slice From List    ${full_list}    start=${bulkCloud_start}    end=${bulkCloud_end}
    Should Contain X Times    ${bulkCloud_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bulkCloud : 1    10
    Should Contain X Times    ${bulkCloud_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cloudMap_start}=    Get Index From List    ${full_list}    === Scheduler_cloudMap start of topic ===
    ${cloudMap_end}=    Get Index From List    ${full_list}    === Scheduler_cloudMap end of topic ===
    ${cloudMap_list}=    Get Slice From List    ${full_list}    start=${cloudMap_start}    end=${cloudMap_end}
    Should Contain X Times    ${cloudMap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloudMap : 1    10
    Should Contain X Times    ${cloudMap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scale : 1    10
    Should Contain X Times    ${cloudMap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zero : 1    10
    Should Contain X Times    ${cloudMap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${seeing_start}=    Get Index From List    ${full_list}    === Scheduler_seeing start of topic ===
    ${seeing_end}=    Get Index From List    ${full_list}    === Scheduler_seeing end of topic ===
    ${seeing_list}=    Get Slice From List    ${full_list}    start=${seeing_start}    end=${seeing_end}
    Should Contain X Times    ${seeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing : 1    10
    Should Contain X Times    ${seeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${wind_start}=    Get Index From List    ${full_list}    === Scheduler_wind start of topic ===
    ${wind_end}=    Get Index From List    ${full_list}    === Scheduler_wind end of topic ===
    ${wind_list}=    Get Slice From List    ${full_list}    start=${wind_start}    end=${wind_end}
    Should Contain X Times    ${wind_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speed : 1    10
    Should Contain X Times    ${wind_list}    ${SPACE}${SPACE}${SPACE}${SPACE}direction : 1    10
    Should Contain X Times    ${wind_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${temperature_start}=    Get Index From List    ${full_list}    === Scheduler_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === Scheduler_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end}
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${skyBrightness_start}=    Get Index From List    ${full_list}    === Scheduler_skyBrightness start of topic ===
    ${skyBrightness_end}=    Get Index From List    ${full_list}    === Scheduler_skyBrightness end of topic ===
    ${skyBrightness_list}=    Get Slice From List    ${full_list}    start=${skyBrightness_start}    end=${skyBrightness_end}
    Should Contain X Times    ${skyBrightness_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightnress : 1    10
    Should Contain X Times    ${skyBrightness_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scale : 1    10
    Should Contain X Times    ${skyBrightness_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zero : 1    10
    Should Contain X Times    ${skyBrightness_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : RO    10
    Should Contain X Times    ${skyBrightness_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${photometricQuality_start}=    Get Index From List    ${full_list}    === Scheduler_photometricQuality start of topic ===
    ${photometricQuality_end}=    Get Index From List    ${full_list}    === Scheduler_photometricQuality end of topic ===
    ${photometricQuality_list}=    Get Slice From List    ${full_list}    start=${photometricQuality_start}    end=${photometricQuality_end}
    Should Contain X Times    ${photometricQuality_list}    ${SPACE}${SPACE}${SPACE}${SPACE}photometricQuality : 1    10
    Should Contain X Times    ${photometricQuality_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${avoidanceRegions_start}=    Get Index From List    ${full_list}    === Scheduler_avoidanceRegions start of topic ===
    ${avoidanceRegions_end}=    Get Index From List    ${full_list}    === Scheduler_avoidanceRegions end of topic ===
    ${avoidanceRegions_list}=    Get Slice From List    ${full_list}    start=${avoidanceRegions_start}    end=${avoidanceRegions_end}
    Should Contain X Times    ${avoidanceRegions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avoidanceRegions : 1    10
    Should Contain X Times    ${avoidanceRegions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scale : 1    10
    Should Contain X Times    ${avoidanceRegions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zero : 1    10
    Should Contain X Times    ${avoidanceRegions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${downtime_start}=    Get Index From List    ${full_list}    === Scheduler_downtime start of topic ===
    ${downtime_end}=    Get Index From List    ${full_list}    === Scheduler_downtime end of topic ===
    ${downtime_list}=    Get Slice From List    ${full_list}    start=${downtime_start}    end=${downtime_end}
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 0    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 1    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 2    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 3    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 4    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 5    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 6    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 7    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 8    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduledDowntime : 9    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 0    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 1    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 2    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 3    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 4    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 5    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 6    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 7    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 8    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unscheduledDowntimes : 9    1
    Should Contain X Times    ${downtime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
