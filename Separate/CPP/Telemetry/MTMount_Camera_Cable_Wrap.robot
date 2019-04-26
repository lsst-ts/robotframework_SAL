*** Settings ***
Documentation    MTMount Camera_Cable_Wrap communications tests.
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
${component}    Camera_Cable_Wrap
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== MTMount subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Camera_Cable_Wrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CameraRotatorPosition : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Angle_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Camera_Position : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Speed_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_1 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Current_2 : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCW_Interlocks : LSST    10
    Should Contain X Times    ${Camera_Cable_Wrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
