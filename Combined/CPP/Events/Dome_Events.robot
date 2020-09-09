*** Settings ***
Documentation    Dome_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Comment    ======= Verify ${subSystem}_azEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azEnabled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azEnabled generated =
    Comment    ======= Verify ${subSystem}_elEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elEnabled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elEnabled generated =
    Comment    ======= Verify ${subSystem}_azMotion test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azMotion
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azMotion iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azMotion_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azMotion generated =
    Comment    ======= Verify ${subSystem}_elMotion test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elMotion
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elMotion iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elMotion_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elMotion generated =
    Comment    ======= Verify ${subSystem}_azTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azTarget generated =
    Comment    ======= Verify ${subSystem}_elTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elTarget generated =
    Comment    ======= Verify ${subSystem}_brakesEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_brakesEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event brakesEngaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_brakesEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event brakesEngaged generated =
    Comment    ======= Verify ${subSystem}_lockingPinsEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinsEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event lockingPinsEngaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinsEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event lockingPinsEngaged generated =
    Comment    ======= Verify ${subSystem}_interlocks test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlocks
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlocks iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlocks_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlocks generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${azEnabled_start}=    Get Index From List    ${full_list}    === Event azEnabled received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azEnabled_start}
    ${azEnabled_end}=    Evaluate    ${end}+${1}
    ${azEnabled_list}=    Get Slice From List    ${full_list}    start=${azEnabled_start}    end=${azEnabled_end}
    Should Contain X Times    ${azEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${azEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultCode : RO    1
    Should Contain X Times    ${azEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elEnabled_start}=    Get Index From List    ${full_list}    === Event elEnabled received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elEnabled_start}
    ${elEnabled_end}=    Evaluate    ${end}+${1}
    ${elEnabled_list}=    Get Slice From List    ${full_list}    start=${elEnabled_start}    end=${elEnabled_end}
    Should Contain X Times    ${elEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultCode : RO    1
    Should Contain X Times    ${elEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azMotion_start}=    Get Index From List    ${full_list}    === Event azMotion received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azMotion_start}
    ${azMotion_end}=    Evaluate    ${end}+${1}
    ${azMotion_list}=    Get Slice From List    ${full_list}    start=${azMotion_start}    end=${azMotion_end}
    Should Contain X Times    ${azMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${azMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${azMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elMotion_start}=    Get Index From List    ${full_list}    === Event elMotion received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elMotion_start}
    ${elMotion_end}=    Evaluate    ${end}+${1}
    ${elMotion_list}=    Get Slice From List    ${full_list}    start=${elMotion_start}    end=${elMotion_end}
    Should Contain X Times    ${elMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${elMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${elMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azTarget_start}=    Get Index From List    ${full_list}    === Event azTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azTarget_start}
    ${azTarget_end}=    Evaluate    ${end}+${1}
    ${azTarget_list}=    Get Slice From List    ${full_list}    start=${azTarget_start}    end=${azTarget_end}
    Should Contain X Times    ${azTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${azTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${azTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elTarget_start}=    Get Index From List    ${full_list}    === Event elTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elTarget_start}
    ${elTarget_end}=    Evaluate    ${end}+${1}
    ${elTarget_list}=    Get Slice From List    ${full_list}    start=${elTarget_start}    end=${elTarget_end}
    Should Contain X Times    ${elTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${elTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${elTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakesEngaged_start}=    Get Index From List    ${full_list}    === Event brakesEngaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${brakesEngaged_start}
    ${brakesEngaged_end}=    Evaluate    ${end}+${1}
    ${brakesEngaged_list}=    Get Slice From List    ${full_list}    start=${brakesEngaged_start}    end=${brakesEngaged_end}
    Should Contain X Times    ${brakesEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakes : 1    1
    Should Contain X Times    ${brakesEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinsEngaged_start}=    Get Index From List    ${full_list}    === Event lockingPinsEngaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${lockingPinsEngaged_start}
    ${lockingPinsEngaged_end}=    Evaluate    ${end}+${1}
    ${lockingPinsEngaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinsEngaged_start}    end=${lockingPinsEngaged_end}
    Should Contain X Times    ${lockingPinsEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    Should Contain X Times    ${lockingPinsEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlocks_start}=    Get Index From List    ${full_list}    === Event interlocks received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlocks_start}
    ${interlocks_end}=    Evaluate    ${end}+${1}
    ${interlocks_list}=    Get Slice From List    ${full_list}    start=${interlocks_start}    end=${interlocks_end}
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interlocks : 1    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
