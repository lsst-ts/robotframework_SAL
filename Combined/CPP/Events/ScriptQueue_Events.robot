*** Settings ***
Documentation    ScriptQueue_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ScriptQueue
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
    Comment    ======= Verify ${subSystem}_availableScripts test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_availableScripts
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event availableScripts iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_availableScripts_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event availableScripts generated =
    Comment    ======= Verify ${subSystem}_configSchema test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_configSchema
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event configSchema iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_configSchema_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event configSchema generated =
    Comment    ======= Verify ${subSystem}_nextVisit test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nextVisit
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nextVisit iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nextVisit_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nextVisit generated =
    Comment    ======= Verify ${subSystem}_nextVisitCanceled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nextVisitCanceled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nextVisitCanceled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nextVisitCanceled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nextVisitCanceled generated =
    Comment    ======= Verify ${subSystem}_script test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_script
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event script iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_script_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event script generated =
    Comment    ======= Verify ${subSystem}_queue test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_queue
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event queue iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_queue_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event queue generated =
    Comment    ======= Verify ${subSystem}_rootDirectories test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rootDirectories
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rootDirectories iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rootDirectories_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rootDirectories generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${availableScripts_start}=    Get Index From List    ${full_list}    === Event availableScripts received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${availableScripts_start}
    ${availableScripts_end}=    Evaluate    ${end}+${1}
    ${availableScripts_list}=    Get Slice From List    ${full_list}    start=${availableScripts_start}    end=${availableScripts_end}
    Should Contain X Times    ${availableScripts_list}    ${SPACE}${SPACE}${SPACE}${SPACE}standard : LSST    1
    Should Contain X Times    ${availableScripts_list}    ${SPACE}${SPACE}${SPACE}${SPACE}external : LSST    1
    Should Contain X Times    ${availableScripts_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${configSchema_start}=    Get Index From List    ${full_list}    === Event configSchema received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${configSchema_start}
    ${configSchema_end}=    Evaluate    ${end}+${1}
    ${configSchema_list}=    Get Slice From List    ${full_list}    start=${configSchema_start}    end=${configSchema_end}
    Should Contain X Times    ${configSchema_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isStandard : 1    1
    Should Contain X Times    ${configSchema_list}    ${SPACE}${SPACE}${SPACE}${SPACE}path : LSST    1
    Should Contain X Times    ${configSchema_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configSchema : LSST    1
    Should Contain X Times    ${configSchema_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nextVisit_start}=    Get Index From List    ${full_list}    === Event nextVisit received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nextVisit_start}
    ${nextVisit_end}=    Evaluate    ${end}+${1}
    ${nextVisit_list}=    Get Slice From List    ${full_list}    start=${nextVisit_start}    end=${nextVisit_end}
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salIndex : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coordinateSystem : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 0    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotationSystem : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraAngle : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filters : LSST    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dome : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}duration : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nimages : 1    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}survey : LSST    1
    Should Contain X Times    ${nextVisit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nextVisitCanceled_start}=    Get Index From List    ${full_list}    === Event nextVisitCanceled received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${nextVisitCanceled_start}
    ${nextVisitCanceled_end}=    Evaluate    ${end}+${1}
    ${nextVisitCanceled_list}=    Get Slice From List    ${full_list}    start=${nextVisitCanceled_start}    end=${nextVisitCanceled_end}
    Should Contain X Times    ${nextVisitCanceled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salIndex : 1    1
    Should Contain X Times    ${nextVisitCanceled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : LSST    1
    Should Contain X Times    ${nextVisitCanceled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${script_start}=    Get Index From List    ${full_list}    === Event script received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${script_start}
    ${script_end}=    Evaluate    ${end}+${1}
    ${script_list}=    Get Slice From List    ${full_list}    start=${script_start}    end=${script_end}
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cmdId : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salIndex : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isStandard : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}path : LSST    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampProcessStart : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampConfigureStart : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampConfigureEnd : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampRunStart : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampProcessEnd : 1    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}processState : \x01    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scriptState : \x01    1
    Should Contain X Times    ${script_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${queue_start}=    Get Index From List    ${full_list}    === Event queue received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${queue_start}
    ${queue_end}=    Evaluate    ${end}+${1}
    ${queue_list}=    Get Slice From List    ${full_list}    start=${queue_start}    end=${queue_end}
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabled : 1    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}running : 1    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentSalIndex : 1    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}length : 1    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salIndices : 0    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pastLength : 1    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pastSalIndices : 0    1
    Should Contain X Times    ${queue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rootDirectories_start}=    Get Index From List    ${full_list}    === Event rootDirectories received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rootDirectories_start}
    ${rootDirectories_end}=    Evaluate    ${end}+${1}
    ${rootDirectories_list}=    Get Slice From List    ${full_list}    start=${rootDirectories_start}    end=${rootDirectories_end}
    Should Contain X Times    ${rootDirectories_list}    ${SPACE}${SPACE}${SPACE}${SPACE}standard : LSST    1
    Should Contain X Times    ${rootDirectories_list}    ${SPACE}${SPACE}${SPACE}${SPACE}external : LSST    1
    Should Contain X Times    ${rootDirectories_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
