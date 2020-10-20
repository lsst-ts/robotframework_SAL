*** Settings ***
Documentation    Scheduler_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_surveyTopology test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_surveyTopology
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event surveyTopology iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_surveyTopology_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event surveyTopology generated =
    Comment    ======= Verify ${subSystem}_dependenciesVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dependenciesVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event dependenciesVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dependenciesVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dependenciesVersions generated =
    Comment    ======= Verify ${subSystem}_target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_target_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event target generated =
    Comment    ======= Verify ${subSystem}_invalidateTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_invalidateTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event invalidateTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_invalidateTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event invalidateTarget generated =
    Comment    ======= Verify ${subSystem}_needFilterSwap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_needFilterSwap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event needFilterSwap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_needFilterSwap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event needFilterSwap generated =
    Comment    ======= Verify ${subSystem}_schedulerConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_schedulerConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event schedulerConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_schedulerConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event schedulerConfig generated =
    Comment    ======= Verify ${subSystem}_driverConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driverConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event driverConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driverConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event driverConfig generated =
    Comment    ======= Verify ${subSystem}_obsSiteConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_obsSiteConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event obsSiteConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_obsSiteConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event obsSiteConfig generated =
    Comment    ======= Verify ${subSystem}_telescopeConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_telescopeConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event telescopeConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_telescopeConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event telescopeConfig generated =
    Comment    ======= Verify ${subSystem}_rotatorConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rotatorConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rotatorConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rotatorConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rotatorConfig generated =
    Comment    ======= Verify ${subSystem}_domeConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_domeConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event domeConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_domeConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event domeConfig generated =
    Comment    ======= Verify ${subSystem}_cameraConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraConfig generated =
    Comment    ======= Verify ${subSystem}_slewConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_slewConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event slewConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_slewConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event slewConfig generated =
    Comment    ======= Verify ${subSystem}_opticsLoopCorrConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_opticsLoopCorrConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event opticsLoopCorrConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_opticsLoopCorrConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event opticsLoopCorrConfig generated =
    Comment    ======= Verify ${subSystem}_parkConfig test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_parkConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event parkConfig iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_parkConfig_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event parkConfig generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${surveyTopology_start}=    Get Index From List    ${full_list}    === Event surveyTopology received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${surveyTopology_start}
    ${surveyTopology_end}=    Evaluate    ${end}+${1}
    ${surveyTopology_list}=    Get Slice From List    ${full_list}    start=${surveyTopology_start}    end=${surveyTopology_end}
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGeneralProps : 1    1
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generalPropos : RO    1
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSeqProps : 1    1
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencePropos : RO    1
    Should Contain X Times    ${surveyTopology_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dependenciesVersions_start}=    Get Index From List    ${full_list}    === Event dependenciesVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dependenciesVersions_start}
    ${dependenciesVersions_end}=    Evaluate    ${end}+${1}
    ${dependenciesVersions_list}=    Get Slice From List    ${full_list}    start=${dependenciesVersions_start}    end=${dependenciesVersions_end}
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduler : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloudModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}downtimeModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skybrightnessModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observatoryModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observatoryLocation : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${target_start}
    ${target_end}=    Evaluate    ${end}+${1}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestMjd : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExposures : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 0    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetX : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetY : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalId : 0    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isSequence : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNVisits : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceVisits : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceDuration : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightness : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloud : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunRa : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunDec : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}solarElong : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}note : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${invalidateTarget_start}=    Get Index From List    ${full_list}    === Event invalidateTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${invalidateTarget_start}
    ${invalidateTarget_end}=    Evaluate    ${end}+${1}
    ${invalidateTarget_list}=    Get Slice From List    ${full_list}    start=${invalidateTarget_start}    end=${invalidateTarget_end}
    Should Contain X Times    ${invalidateTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    1
    Should Contain X Times    ${invalidateTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${needFilterSwap_start}=    Get Index From List    ${full_list}    === Event needFilterSwap received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${needFilterSwap_start}
    ${needFilterSwap_end}=    Evaluate    ${end}+${1}
    ${needFilterSwap_list}=    Get Slice From List    ${full_list}    start=${needFilterSwap_start}    end=${needFilterSwap_end}
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}needSwap : 1    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterToMount : RO    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterToUnmount : RO    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${schedulerConfig_start}=    Get Index From List    ${full_list}    === Event schedulerConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${schedulerConfig_start}
    ${schedulerConfig_end}=    Evaluate    ${end}+${1}
    ${schedulerConfig_list}=    Get Slice From List    ${full_list}    start=${schedulerConfig_start}    end=${schedulerConfig_end}
    Should Contain X Times    ${schedulerConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surveyDuration : 1    1
    Should Contain X Times    ${schedulerConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driverConfig_start}=    Get Index From List    ${full_list}    === Event driverConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${driverConfig_start}
    ${driverConfig_end}=    Evaluate    ${end}+${1}
    ${driverConfig_list}=    Get Slice From List    ${full_list}    start=${driverConfig_start}    end=${driverConfig_end}
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nightBoundary : 1    1
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newMoonPhaseThreshold : 1    1
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupType : RO    1
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupDatabase : RO    1
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${obsSiteConfig_start}=    Get Index From List    ${full_list}    === Event obsSiteConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${obsSiteConfig_start}
    ${obsSiteConfig_end}=    Evaluate    ${end}+${1}
    ${obsSiteConfig_list}=    Get Slice From List    ${full_list}    start=${obsSiteConfig_start}    end=${obsSiteConfig_end}
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observatoryName : RO    1
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latitude : 1    1
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longitude : 1    1
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}height : 1    1
    Should Contain X Times    ${obsSiteConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${telescopeConfig_start}=    Get Index From List    ${full_list}    === Event telescopeConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${telescopeConfig_start}
    ${telescopeConfig_end}=    Evaluate    ${end}+${1}
    ${telescopeConfig_list}=    Get Slice From List    ${full_list}    start=${telescopeConfig_start}    end=${telescopeConfig_end}
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMinpos : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxpos : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMinpos : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxpos : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxspeed : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeAccel : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeDecel : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxspeed : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthAccel : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDecel : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settleTime : 1    1
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rotatorConfig_start}=    Get Index From List    ${full_list}    === Event rotatorConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rotatorConfig_start}
    ${rotatorConfig_end}=    Evaluate    ${end}+${1}
    ${rotatorConfig_list}=    Get Slice From List    ${full_list}    start=${rotatorConfig_start}    end=${rotatorConfig_end}
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionMin : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionMax : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFilterChange : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedMax : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accel : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decel : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}manualRotator : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}followSky : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resumeAngle : 1    1
    Should Contain X Times    ${rotatorConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${domeConfig_start}=    Get Index From List    ${full_list}    === Event domeConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${domeConfig_start}
    ${domeConfig_end}=    Evaluate    ${end}+${1}
    ${domeConfig_list}=    Get Slice From List    ${full_list}    start=${domeConfig_start}    end=${domeConfig_end}
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxspeed : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeAccel : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeDecel : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeFreerange : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxspeed : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthAccel : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDecel : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthFreerange : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settleTime : 1    1
    Should Contain X Times    ${domeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraConfig_start}=    Get Index From List    ${full_list}    === Event cameraConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraConfig_start}
    ${cameraConfig_end}=    Evaluate    ${end}+${1}
    ${cameraConfig_list}=    Get Slice From List    ${full_list}    start=${cameraConfig_start}    end=${cameraConfig_end}
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readoutTime : 1    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutterTime : 1    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMountTime : 1    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterChangeTime : 1    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMounted : RO    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPos : RO    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterRemovable : RO    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterUnmounted : RO    1
    Should Contain X Times    ${cameraConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${slewConfig_start}=    Get Index From List    ${full_list}    === Event slewConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${slewConfig_start}
    ${slewConfig_end}=    Evaluate    ${end}+${1}
    ${slewConfig_list}=    Get Slice From List    ${full_list}    start=${slewConfig_start}    end=${slewConfig_end}
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomalt : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomaz : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomazSettle : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelalt : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelaz : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsOpenLoop : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsClosedLoop : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelSettle : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelRot : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqFilter : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqExposures : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqReadout : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqAdc : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqInsOptics : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderPos : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderAdq : RO    1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${opticsLoopCorrConfig_start}=    Get Index From List    ${full_list}    === Event opticsLoopCorrConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${opticsLoopCorrConfig_start}
    ${opticsLoopCorrConfig_end}=    Evaluate    ${end}+${1}
    ${opticsLoopCorrConfig_list}=    Get Slice From List    ${full_list}    start=${opticsLoopCorrConfig_start}    end=${opticsLoopCorrConfig_end}
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsOlSlope : 1    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${parkConfig_start}=    Get Index From List    ${full_list}    === Event parkConfig received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${parkConfig_start}
    ${parkConfig_end}=    Evaluate    ${end}+${1}
    ${parkConfig_list}=    Get Slice From List    ${full_list}    start=${parkConfig_start}    end=${parkConfig_end}
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAltitude : 1    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAzimuth : 1    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeRotator : 1    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAltitude : 1    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAzimuth : 1    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPosition : RO    1
    Should Contain X Times    ${parkConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === Event appliedSettingsMatchStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedSettingsMatchStart_start}
    ${appliedSettingsMatchStart_end}=    Evaluate    ${end}+${1}
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logMessage_start}
    ${logMessage_end}=    Evaluate    ${end}+${1}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === Event settingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsApplied_start}
    ${settingsApplied_end}=    Evaluate    ${end}+${1}
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsVersion : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherSettingsEvents : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersions_start}
    ${softwareVersions_end}=    Evaluate    ${end}+${1}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${authList_start}
    ${authList_end}=    Evaluate    ${end}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
