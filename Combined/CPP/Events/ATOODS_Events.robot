*** Settings ***
Documentation    ATOODS_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATOODS
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
    Comment    ======= Verify ${subSystem}_imageInOODS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_imageInOODS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event imageInOODS iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_imageInOODS_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event imageInOODS generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${imageInOODS_start}=    Get Index From List    ${full_list}    === Event imageInOODS received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${imageInOODS_start}
    ${imageInOODS_end}=    Evaluate    ${end}+${1}
    ${imageInOODS_list}=    Get Slice From List    ${full_list}    start=${imageInOODS_start}    end=${imageInOODS_end}
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}camera : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}obsid : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raft : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}archiverName : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusCode : 1    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}description : RO    1
    Should Contain X Times    ${imageInOODS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
