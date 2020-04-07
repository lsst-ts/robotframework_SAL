*** Settings ***
Documentation    MTMount_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
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
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_mountState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountState generated =
    Comment    ======= Verify ${subSystem}_mountWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountWarning generated =
    Comment    ======= Verify ${subSystem}_mountError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountError generated =
    Comment    ======= Verify ${subSystem}_mountInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountInPosition generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${mountState_start}=    Get Index From List    ${full_list}    === Event mountState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountState_start}
    ${mountState_end}=    Evaluate    ${end}+${1}
    ${mountState_list}=    Get Slice From List    ${full_list}    start=${mountState_start}    end=${mountState_end}
    Should Contain X Times    ${mountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : 1    1
    Should Contain X Times    ${mountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : LSST    1
    Should Contain X Times    ${mountState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountWarning_start}=    Get Index From List    ${full_list}    === Event mountWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountWarning_start}
    ${mountWarning_end}=    Evaluate    ${end}+${1}
    ${mountWarning_list}=    Get Slice From List    ${full_list}    start=${mountWarning_start}    end=${mountWarning_end}
    Should Contain X Times    ${mountWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : 1    1
    Should Contain X Times    ${mountWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : LSST    1
    Should Contain X Times    ${mountWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountError_start}=    Get Index From List    ${full_list}    === Event mountError received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountError_start}
    ${mountError_end}=    Evaluate    ${end}+${1}
    ${mountError_list}=    Get Slice From List    ${full_list}    start=${mountError_start}    end=${mountError_end}
    Should Contain X Times    ${mountError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : 1    1
    Should Contain X Times    ${mountError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}text : LSST    1
    Should Contain X Times    ${mountError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountInPosition_start}=    Get Index From List    ${full_list}    === Event mountInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountInPosition_start}
    ${mountInPosition_end}=    Evaluate    ${end}+${1}
    ${mountInPosition_list}=    Get Slice From List    ${full_list}    start=${mountInPosition_start}    end=${mountInPosition_end}
    Should Contain X Times    ${mountInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inposition : 1    1
    Should Contain X Times    ${mountInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
