*** Settings ***
Documentation    MTMount Mirror_Cover_Locks communications tests.
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
${component}    Mirror_Cover_Locks
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Mirror_Cover_Locks
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
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_Interlocks : LSST    10
    Should Contain X Times    ${Mirror_Cover_Locks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
