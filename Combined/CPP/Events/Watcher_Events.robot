*** Settings ***
Documentation    Watcher_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Watcher
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
    Comment    ======= Verify ${subSystem}_alarm test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_alarm
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event alarm iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_alarm_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event alarm generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${alarm_start}=    Get Index From List    ${full_list}    === Event alarm received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${alarm_start}
    ${alarm_end}=    Evaluate    ${end}+${1}
    ${alarm_list}=    Get Slice From List    ${full_list}    start=${alarm_start}    end=${alarm_end}
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}severity : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reason : LSST    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeverity : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acknowledged : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acknowledgedBy : LSST    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}escalated : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}escalateTo : LSST    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mutedSeverity : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mutedBy : LSST    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampSeverityOldest : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampSeverityNewest : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampMaxSeverity : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAcknowledged : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAutoAcknowledge : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampAutoUnacknowledge : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampEscalate : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampUnmute : 1    1
    Should Contain X Times    ${alarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
