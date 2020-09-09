*** Settings ***
Documentation    PromptProcessing_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    PromptProcessing
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait to allow full output to be written to file.
    Sleep    5s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_entitySummaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_entitySummaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event entitySummaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_entitySummaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event entitySummaryState generated =
    Comment    ======= Verify ${subSystem}_entityStartup test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_entityStartup
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event entityStartup iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_entityStartup_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event entityStartup generated =
    Comment    ======= Verify ${subSystem}_entityShutdown test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_entityShutdown
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event entityShutdown iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_entityShutdown_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event entityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${entitySummaryState_start}=    Get Index From List    ${full_list}    === Event entitySummaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${entitySummaryState_start}
    ${entitySummaryState_end}=    Evaluate    ${end}+${1}
    ${entitySummaryState_list}=    Get Slice From List    ${full_list}    start=${entitySummaryState_start}    end=${entitySummaryState_end}
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentState : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}previousState : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}executing : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandsAvailable : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurationsAvailable : RO    1
    Should Contain X Times    ${entitySummaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${entityStartup_start}=    Get Index From List    ${full_list}    === Event entityStartup received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${entityStartup_start}
    ${entityStartup_end}=    Evaluate    ${end}+${1}
    ${entityStartup_list}=    Get Slice From List    ${full_list}    start=${entityStartup_start}    end=${entityStartup_end}
    Should Contain X Times    ${entityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${entityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${entityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${entityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${entityStartup_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${entityShutdown_start}=    Get Index From List    ${full_list}    === Event entityShutdown received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${entityShutdown_start}
    ${entityShutdown_end}=    Evaluate    ${end}+${1}
    ${entityShutdown_list}=    Get Slice From List    ${full_list}    start=${entityShutdown_start}    end=${entityShutdown_end}
    Should Contain X Times    ${entityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${entityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identifier : 1    1
    Should Contain X Times    ${entityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : RO    1
    Should Contain X Times    ${entityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${entityShutdown_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
