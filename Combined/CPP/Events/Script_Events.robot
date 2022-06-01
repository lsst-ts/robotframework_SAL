*** Settings ***
Documentation    Script_Events communications tests.
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
${subSystem}    Script
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
    Should Contain    ${output}    Popen
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

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
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =
    Comment    ======= Verify ${subSystem}_largeFileObjectAvailable test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_largeFileObjectAvailable
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event largeFileObjectAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_largeFileObjectAvailable_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event largeFileObjectAvailable generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${checkpoints_start}=    Get Index From List    ${full_list}    === Event checkpoints received =${SPACE}
    ${end}=    Evaluate    ${checkpoints_start}+${3}
    ${checkpoints_list}=    Get Slice From List    ${full_list}    start=${checkpoints_start}    end=${end}
    Should Contain X Times    ${checkpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pause : RO    1
    Should Contain X Times    ${checkpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stop : RO    1
    ${description_start}=    Get Index From List    ${full_list}    === Event description received =${SPACE}
    ${end}=    Evaluate    ${description_start}+${5}
    ${description_list}=    Get Slice From List    ${full_list}    start=${description_start}    end=${end}
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}classname : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}description : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}help : RO    1
    Should Contain X Times    ${description_list}    ${SPACE}${SPACE}${SPACE}${SPACE}remotes : RO    1
    ${metadata_start}=    Get Index From List    ${full_list}    === Event metadata received =${SPACE}
    ${end}=    Evaluate    ${metadata_start}+${11}
    ${metadata_list}=    Get Slice From List    ${full_list}    start=${metadata_start}    end=${end}
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coordinateSystem : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 0    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotationSystem : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraAngle : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filters : RO    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dome : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}duration : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nimages : 1    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}survey : RO    1
    Should Contain X Times    ${metadata_list}    ${SPACE}${SPACE}${SPACE}${SPACE}totalCheckpoints : 1    1
    ${state_start}=    Get Index From List    ${full_list}    === Event state received =${SPACE}
    ${end}=    Evaluate    ${state_start}+${6}
    ${state_list}=    Get Slice From List    ${full_list}    start=${state_start}    end=${end}
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : \x01    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reason : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lastCheckpoint : RO    1
    Should Contain X Times    ${state_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numCheckpoints : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Evaluate    ${authList_start}+${3}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === Event largeFileObjectAvailable received =${SPACE}
    ${end}=    Evaluate    ${largeFileObjectAvailable_start}+${8}
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${end}
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generator : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byteSize : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}checkSum : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mimeType : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : RO    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${3}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${10}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${6}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
