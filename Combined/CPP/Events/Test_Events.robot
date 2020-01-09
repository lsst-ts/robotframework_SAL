*** Settings ***
Documentation    Test_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Test
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
    Comment    ======= Verify ${subSystem}_scalars test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_scalars
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event scalars iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_scalars_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event scalars generated =
    Comment    ======= Verify ${subSystem}_arrays test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_arrays
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event arrays iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_arrays_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event arrays generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${scalars_start}=    Get Index From List    ${full_list}    === Event scalars received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${scalars_start}
    ${scalars_end}=    Evaluate    ${end}+${1}
    ${scalars_list}=    Get Slice From List    ${full_list}    start=${scalars_start}    end=${scalars_end}
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x01    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}char0 : LSST    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x01    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 1    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}string0 : LSST    1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${arrays_start}=    Get Index From List    ${full_list}    === Event arrays received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${arrays_start}
    ${arrays_end}=    Evaluate    ${end}+${1}
    ${arrays_list}=    Get Slice From List    ${full_list}    start=${arrays_start}    end=${arrays_end}
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x00    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x00    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
