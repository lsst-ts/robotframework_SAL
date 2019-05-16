*** Settings ***
Documentation    Sequencer_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Sequencer
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
    Should Contain    ${output}    ===== ${subSystem} all loggers ready =====
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_sequencerEntitySummaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerEntitySummaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerEntitySummaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerEntitySummaryState end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerEntityStartup test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerEntityStartup
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerEntityStartup_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerEntityStartup end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerEntityShutdown test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerEntityShutdown
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerEntityShutdown_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerEntityShutdown end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerCommandIssued test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerCommandIssued
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerCommandIssued_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerCommandIssued end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerCommandStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerCommandStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerCommandStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerCommandStatus end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerCurrentScript test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerCurrentScript
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerCurrentScript_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerCurrentScript end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerNextScript test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerNextScript
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerNextScript_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerNextScript end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerScriptStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerScriptStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerScriptStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerScriptStart end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerScriptEnd test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerScriptEnd
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerScriptEnd_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerScriptEnd end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerScriptError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerScriptError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerScriptError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerScriptError end of topic ===
    Comment    ======= Verify ${subSystem}_sequencerScriptEntititesInUse test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sequencerScriptEntititesInUse
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sequencerScriptEntititesInUse_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_sequencerScriptEntititesInUse end of topic ===
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingVersions end of topic ===
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_errorCode end of topic ===
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_summaryState end of topic ===
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logLevel end of topic ===
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logMessage end of topic ===
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_simulationMode end of topic ===

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${sequencerEntitySummaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntitySummaryState start of topic ===
    ${sequencerEntitySummaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntitySummaryState end of topic ===
    ${sequencerEntitySummaryState_list}=    Get Slice From List    ${full_list}    start=${sequencerEntitySummaryState_start}    end=${sequencerEntitySummaryState_end}
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentState : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}previousState : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}executing : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandsAvailable : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurationsAvailable : LSST    1
    Should Contain X Times    ${sequencerEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerEntityStartup_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntityStartup start of topic ===
    ${sequencerEntityStartup_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntityStartup end of topic ===
    ${sequencerEntityStartup_list}=    Get Slice From List    ${full_list}    start=${sequencerEntityStartup_start}    end=${sequencerEntityStartup_end}
    Should Contain X Times    ${sequencerEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${sequencerEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${sequencerEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${sequencerEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${sequencerEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerEntityShutdown_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntityShutdown start of topic ===
    ${sequencerEntityShutdown_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerEntityShutdown end of topic ===
    ${sequencerEntityShutdown_list}=    Get Slice From List    ${full_list}    start=${sequencerEntityShutdown_start}    end=${sequencerEntityShutdown_end}
    Should Contain X Times    ${sequencerEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${sequencerEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${sequencerEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${sequencerEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${sequencerEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerCommandIssued_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCommandIssued start of topic ===
    ${sequencerCommandIssued_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCommandIssued end of topic ===
    ${sequencerCommandIssued_list}=    Get Slice From List    ${full_list}    start=${sequencerCommandIssued_start}    end=${sequencerCommandIssued_end}
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSource : LSST    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumber : 1    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSent : LSST    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnValue : 1    1
    Should Contain X Times    ${sequencerCommandIssued_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerCommandStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCommandStatus start of topic ===
    ${sequencerCommandStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCommandStatus end of topic ===
    ${sequencerCommandStatus_list}=    Get Slice From List    ${full_list}    start=${sequencerCommandStatus_start}    end=${sequencerCommandStatus_end}
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSource : LSST    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumber : 1    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : LSST    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSent : LSST    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusValue : 1    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : LSST    1
    Should Contain X Times    ${sequencerCommandStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerCurrentScript_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCurrentScript start of topic ===
    ${sequencerCurrentScript_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerCurrentScript end of topic ===
    ${sequencerCurrentScript_list}=    Get Slice From List    ${full_list}    start=${sequencerCurrentScript_start}    end=${sequencerCurrentScript_end}
    Should Contain X Times    ${sequencerCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerCurrentScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerNextScript_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerNextScript start of topic ===
    ${sequencerNextScript_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerNextScript end of topic ===
    ${sequencerNextScript_list}=    Get Slice From List    ${full_list}    start=${sequencerNextScript_start}    end=${sequencerNextScript_end}
    Should Contain X Times    ${sequencerNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerNextScript_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerScriptStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptStart start of topic ===
    ${sequencerScriptStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptStart end of topic ===
    ${sequencerScriptStart_list}=    Get Slice From List    ${full_list}    start=${sequencerScriptStart_start}    end=${sequencerScriptStart_end}
    Should Contain X Times    ${sequencerScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerScriptStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerScriptEnd_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptEnd start of topic ===
    ${sequencerScriptEnd_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptEnd end of topic ===
    ${sequencerScriptEnd_list}=    Get Slice From List    ${full_list}    start=${sequencerScriptEnd_start}    end=${sequencerScriptEnd_end}
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptStatusCode : 1    1
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptStatusText : LSST    1
    Should Contain X Times    ${sequencerScriptEnd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerScriptError_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptError start of topic ===
    ${sequencerScriptError_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptError end of topic ===
    ${sequencerScriptError_list}=    Get Slice From List    ${full_list}    start=${sequencerScriptError_start}    end=${sequencerScriptError_end}
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptLineNumber : 1    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptErrorCode : 1    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptErrorText : LSST    1
    Should Contain X Times    ${sequencerScriptError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sequencerScriptEntititesInUse_start}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptEntititesInUse start of topic ===
    ${sequencerScriptEntititesInUse_end}=    Get Index From List    ${full_list}    === ${subSystem}_sequencerScriptEntititesInUse end of topic ===
    ${sequencerScriptEntititesInUse_list}=    Get Slice From List    ${full_list}    start=${sequencerScriptEntititesInUse_start}    end=${sequencerScriptEntititesInUse_end}
    Should Contain X Times    ${sequencerScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptName : LSST    1
    Should Contain X Times    ${sequencerScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptIdentifier : 1    1
    Should Contain X Times    ${sequencerScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerScriptTimestamp : LSST    1
    Should Contain X Times    ${sequencerScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequencerEntititesList : LSST    1
    Should Contain X Times    ${sequencerScriptEntititesInUse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
