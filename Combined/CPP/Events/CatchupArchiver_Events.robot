*** Settings ***
Documentation    CatchupArchiver_Events communications tests.
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
${subSystem}    CatchupArchiver
${component}    all
${timeout}    90s

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
    Comment    ======= Verify ${subSystem}_catchuparchiverEntityStartup test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_catchuparchiverEntityStartup
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event catchuparchiverEntityStartup iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_catchuparchiverEntityStartup_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event catchuparchiverEntityStartup generated =
    Comment    ======= Verify ${subSystem}_catchuparchiverEntitySummaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_catchuparchiverEntitySummaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event catchuparchiverEntitySummaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_catchuparchiverEntitySummaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event catchuparchiverEntitySummaryState generated =
    Comment    ======= Verify ${subSystem}_catchuparchiverEntityShutdown test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_catchuparchiverEntityShutdown
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event catchuparchiverEntityShutdown iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_catchuparchiverEntityShutdown_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event catchuparchiverEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${catchuparchiverEntityStartup_start}=    Get Index From List    ${full_list}    === Event catchuparchiverEntityStartup received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${catchuparchiverEntityStartup_start}
    ${catchuparchiverEntityStartup_end}=    Evaluate    ${end}+${1}
    ${catchuparchiverEntityStartup_list}=    Get Slice From List    ${full_list}    start=${catchuparchiverEntityStartup_start}    end=${catchuparchiverEntityStartup_end}
    Should Contain X Times    ${catchuparchiverEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${catchuparchiverEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${catchuparchiverEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${catchuparchiverEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${catchuparchiverEntityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${catchuparchiverEntitySummaryState_start}=    Get Index From List    ${full_list}    === Event catchuparchiverEntitySummaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${catchuparchiverEntitySummaryState_start}
    ${catchuparchiverEntitySummaryState_end}=    Evaluate    ${end}+${1}
    ${catchuparchiverEntitySummaryState_list}=    Get Slice From List    ${full_list}    start=${catchuparchiverEntitySummaryState_start}    end=${catchuparchiverEntitySummaryState_end}
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentState : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}previousState : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}executing : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandsAvailable : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurationsAvailable : RO    1
    Should Contain X Times    ${catchuparchiverEntitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${catchuparchiverEntityShutdown_start}=    Get Index From List    ${full_list}    === Event catchuparchiverEntityShutdown received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${catchuparchiverEntityShutdown_start}
    ${catchuparchiverEntityShutdown_end}=    Evaluate    ${end}+${1}
    ${catchuparchiverEntityShutdown_list}=    Get Slice From List    ${full_list}    start=${catchuparchiverEntityShutdown_start}    end=${catchuparchiverEntityShutdown_end}
    Should Contain X Times    ${catchuparchiverEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${catchuparchiverEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${catchuparchiverEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${catchuparchiverEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${catchuparchiverEntityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
