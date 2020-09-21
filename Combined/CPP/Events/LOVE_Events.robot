*** Settings ***
Documentation    LOVE_Events communications tests.
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
${subSystem}    LOVE
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
    Comment    ======= Verify ${subSystem}_observingLog test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_observingLog
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event observingLog iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_observingLog_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event observingLog generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${observingLog_start}=    Get Index From List    ${full_list}    === Event observingLog received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${observingLog_start}
    ${observingLog_end}=    Evaluate    ${end}+${1}
    ${observingLog_list}=    Get Slice From List    ${full_list}    start=${observingLog_start}    end=${observingLog_end}
    Should Contain X Times    ${observingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${observingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}user : RO    1
    Should Contain X Times    ${observingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
