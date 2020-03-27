*** Settings ***
Documentation    MTMount Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTMount subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Camera_Cable_Wrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Camera_Cable_Wrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Camera_Cable_Wrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Camera_Cable_Wrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Camera_Cable_Wrap end of topic ===
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Safety_System
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTMount_Safety_System start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::Safety_System_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_Safety_System end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${Camera_Cable_Wrap_start}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap start of topic ===
    ${Camera_Cable_Wrap_end}=    Get Index From List    ${full_list}    === MTMount_Camera_Cable_Wrap end of topic ===
    ${Camera_Cable_Wrap_list}=    Get Slice From List    ${full_list}    start=${Camera_Cable_Wrap_start}    end=${Camera_Cable_Wrap_end}
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AXES_PXI_Version : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PXI_Version : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Rotator_Position : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sub_Rotator_Position : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Interlocks : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${Safety_System_start}=    Get Index From List    ${full_list}    === MTMount_Safety_System start of topic ===
    ${Safety_System_end}=    Get Index From List    ${full_list}    === MTMount_Safety_System end of topic ===
    ${Safety_System_list}=    Get Slice From List    ${full_list}    start=${Safety_System_start}    end=${Safety_System_end}
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_STO : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Pull_CordPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Pull_CordNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Global_IS_Interlock : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MCS_watchdog : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Override_Monitor_CCW_Pull_CordPos : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Override_Monitor_CCW_Pull_CordNeg : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_CCWAux : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ETPB_Handheld_CCWAux : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Handheld_Enable_Pushbutton : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Safety_NO_OK : 1    10
    Should Contain X Times    ${Safety_System_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
