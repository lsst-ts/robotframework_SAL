*** Settings ***
Documentation    ATHexapod Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATHexapod
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== ATHexapod subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_positionStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_positionStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATHexapod_positionStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::positionStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATHexapod_positionStatus end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATHexapod subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${positionStatus_start}=    Get Index From List    ${full_list}    === ATHexapod_positionStatus start of topic ===
    ${positionStatus_end}=    Get Index From List    ${full_list}    === ATHexapod_positionStatus end of topic ===
    ${positionStatus_list}=    Get Slice From List    ${full_list}    start=${positionStatus_start}    end=${positionStatus_end}
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 0    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 1    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 2    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 3    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 4    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 5    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 6    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 7    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 8    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointPosition : 9    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 0    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 1    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 2    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 3    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 4    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 5    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 6    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 7    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 8    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reportedPosition : 9    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 0    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 1    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 2    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 3    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 4    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 5    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 6    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 7    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 8    1
    Should Contain X Times    ${positionStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFollowingError : 9    1
