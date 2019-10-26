*** Settings ***
Documentation    OCS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    OCS
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_oCSEntitySummaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSEntitySummaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSEntitySummaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSEntitySummaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSEntitySummaryState generated =
    Comment    ======= Verify ${subSystem}_oCSEntityStartup test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSEntityStartup
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSEntityStartup iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSEntityStartup_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSEntityStartup generated =
    Comment    ======= Verify ${subSystem}_oCSEntityShutdown test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSEntityShutdown
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSEntityShutdown iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSEntityShutdown_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSEntityShutdown generated =
    Comment    ======= Verify ${subSystem}_oCSCommandIssued test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSCommandIssued
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSCommandIssued iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSCommandIssued_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSCommandIssued generated =
    Comment    ======= Verify ${subSystem}_oCSCommandStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSCommandStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSCommandStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSCommandStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSCommandStatus generated =
    Comment    ======= Verify ${subSystem}_oCSCurrentScript test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSCurrentScript
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSCurrentScript iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSCurrentScript_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSCurrentScript generated =
    Comment    ======= Verify ${subSystem}_oCSNextScript test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSNextScript
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSNextScript iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSNextScript_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSNextScript generated =
    Comment    ======= Verify ${subSystem}_oCSScriptStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSScriptStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSScriptStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSScriptStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSScriptStart generated =
    Comment    ======= Verify ${subSystem}_oCSScriptEnd test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSScriptEnd
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSScriptEnd iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSScriptEnd_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSScriptEnd generated =
    Comment    ======= Verify ${subSystem}_oCSScriptError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSScriptError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSScriptError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSScriptError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSScriptError generated =
    Comment    ======= Verify ${subSystem}_oCSScriptEntititesInUse test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_oCSScriptEntititesInUse
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event oCSScriptEntititesInUse iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_oCSScriptEntititesInUse_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event oCSScriptEntititesInUse generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${oCSEntitySummaryState_start}=    Get Index From List    ${full_list}    === Event oCSEntitySummaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSEntitySummaryState_start}
    ${oCSEntitySummaryState_end}=    Evaluate    ${end}+${1}
    ${oCSEntitySummaryState_list}=    Get Slice From List    ${full_list}    start=${oCSEntitySummaryState_start}    end=${oCSEntitySummaryState_end}
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentState : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}previousState : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}executing : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandsAvailable : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurationsAvailable : LSST    1
    Should Contain X Times    ${oCSEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSEntityStartup_start}=    Get Index From List    ${full_list}    === Event oCSEntityStartup received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSEntityStartup_start}
    ${oCSEntityStartup_end}=    Evaluate    ${end}+${1}
    ${oCSEntityStartup_list}=    Get Slice From List    ${full_list}    start=${oCSEntityStartup_start}    end=${oCSEntityStartup_end}
    Should Contain X Times    ${oCSEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${oCSEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${oCSEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${oCSEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${oCSEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSEntityShutdown_start}=    Get Index From List    ${full_list}    === Event oCSEntityShutdown received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSEntityShutdown_start}
    ${oCSEntityShutdown_end}=    Evaluate    ${end}+${1}
    ${oCSEntityShutdown_list}=    Get Slice From List    ${full_list}    start=${oCSEntityShutdown_start}    end=${oCSEntityShutdown_end}
    Should Contain X Times    ${oCSEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${oCSEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${oCSEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${oCSEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${oCSEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSCommandIssued_start}=    Get Index From List    ${full_list}    === Event oCSCommandIssued received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSCommandIssued_start}
    ${oCSCommandIssued_end}=    Evaluate    ${end}+${1}
    ${oCSCommandIssued_list}=    Get Slice From List    ${full_list}    start=${oCSCommandIssued_start}    end=${oCSCommandIssued_end}
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSource : LSST    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumber : 1    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSent : LSST    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnValue : 1    1
    Should Contain X Times    ${oCSCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSCommandStatus_start}=    Get Index From List    ${full_list}    === Event oCSCommandStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSCommandStatus_start}
    ${oCSCommandStatus_end}=    Evaluate    ${end}+${1}
    ${oCSCommandStatus_list}=    Get Slice From List    ${full_list}    start=${oCSCommandStatus_start}    end=${oCSCommandStatus_end}
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSource : LSST    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumber : 1    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSent : LSST    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusValue : 1    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : LSST    1
    Should Contain X Times    ${oCSCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSCurrentScript_start}=    Get Index From List    ${full_list}    === Event oCSCurrentScript received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSCurrentScript_start}
    ${oCSCurrentScript_end}=    Evaluate    ${end}+${1}
    ${oCSCurrentScript_list}=    Get Slice From List    ${full_list}    start=${oCSCurrentScript_start}    end=${oCSCurrentScript_end}
    Should Contain X Times    ${oCSCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSNextScript_start}=    Get Index From List    ${full_list}    === Event oCSNextScript received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSNextScript_start}
    ${oCSNextScript_end}=    Evaluate    ${end}+${1}
    ${oCSNextScript_list}=    Get Slice From List    ${full_list}    start=${oCSNextScript_start}    end=${oCSNextScript_end}
    Should Contain X Times    ${oCSNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSScriptStart_start}=    Get Index From List    ${full_list}    === Event oCSScriptStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSScriptStart_start}
    ${oCSScriptStart_end}=    Evaluate    ${end}+${1}
    ${oCSScriptStart_list}=    Get Slice From List    ${full_list}    start=${oCSScriptStart_start}    end=${oCSScriptStart_end}
    Should Contain X Times    ${oCSScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSScriptEnd_start}=    Get Index From List    ${full_list}    === Event oCSScriptEnd received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSScriptEnd_start}
    ${oCSScriptEnd_end}=    Evaluate    ${end}+${1}
    ${oCSScriptEnd_list}=    Get Slice From List    ${full_list}    start=${oCSScriptEnd_start}    end=${oCSScriptEnd_end}
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptStatusCode : 1    1
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptStatusText : LSST    1
    Should Contain X Times    ${oCSScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSScriptError_start}=    Get Index From List    ${full_list}    === Event oCSScriptError received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSScriptError_start}
    ${oCSScriptError_end}=    Evaluate    ${end}+${1}
    ${oCSScriptError_list}=    Get Slice From List    ${full_list}    start=${oCSScriptError_start}    end=${oCSScriptError_end}
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptLineNumber : 1    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptErrorCode : 1    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptErrorText : LSST    1
    Should Contain X Times    ${oCSScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${oCSScriptEntititesInUse_start}=    Get Index From List    ${full_list}    === Event oCSScriptEntititesInUse received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${oCSScriptEntititesInUse_start}
    ${oCSScriptEntititesInUse_end}=    Evaluate    ${end}+${1}
    ${oCSScriptEntititesInUse_list}=    Get Slice From List    ${full_list}    start=${oCSScriptEntititesInUse_start}    end=${oCSScriptEntititesInUse_end}
    Should Contain X Times    ${oCSScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptName : LSST    1
    Should Contain X Times    ${oCSScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptIdentifier : 1    1
    Should Contain X Times    ${oCSScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSScriptTimestamp : LSST    1
    Should Contain X Times    ${oCSScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oCSEntititesList : LSST    1
    Should Contain X Times    ${oCSScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
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
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
