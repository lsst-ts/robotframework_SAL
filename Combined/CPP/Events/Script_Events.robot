*** Settings ***
Documentation    Script_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Script
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
    Comment    ======= Verify ${subSystem}_checkpoints test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_checkpoints
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event checkpoints iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_checkpoints_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event checkpoints generated =
    Comment    ======= Verify ${subSystem}_description test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_description
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event description iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_description_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event description generated =
    Comment    ======= Verify ${subSystem}_metadata test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_metadata
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event metadata iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_metadata_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event metadata generated =
    Comment    ======= Verify ${subSystem}_state test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_state
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event state iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_state_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event state generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${checkpoints_start}=    Get Index From List    ${full_list}    === Event checkpoints received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${checkpoints_start}
    ${checkpoints_end}=    Evaluate    ${end}+${1}
    ${checkpoints_list}=    Get Slice From List    ${full_list}    start=${checkpoints_start}    end=${checkpoints_end}
    Should Contain X Times    ${checkpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pause : RO    1
    Should Contain X Times    ${checkpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stop : RO    1
    Should Contain X Times    ${checkpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${description_start}=    Get Index From List    ${full_list}    === Event description received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${description_start}
    ${description_end}=    Evaluate    ${end}+${1}
    ${description_list}=    Get Slice From List    ${full_list}    start=${description_start}    end=${description_end}
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}classname : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}description : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}remotes : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${metadata_start}=    Get Index From List    ${full_list}    === Event metadata received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${metadata_start}
    ${metadata_end}=    Evaluate    ${end}+${1}
    ${metadata_list}=    Get Slice From List    ${full_list}    start=${metadata_start}    end=${metadata_end}
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coordinateSystem : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 0    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotationSystem : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraAngle : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filters : RO    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dome : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}duration : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nimages : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}survey : RO    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${state_start}=    Get Index From List    ${full_list}    === Event state received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${state_start}
    ${state_end}=    Evaluate    ${end}+${1}
    ${state_list}=    Get Slice From List    ${full_list}    start=${state_start}    end=${state_end}
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : \x01    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reason : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lastCheckpoint : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
