*** Settings ***
Documentation    MTMount Mirror_Cover_Locks communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    
${timeout}    30s

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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : LSST TEST REVCODE    10

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=10    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ${subSystem} subscriber Ready
    @{list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Status : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Status : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Status : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Status : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Actual_Position : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Actual_Position : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Actual_Position : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Actual_Position : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Current : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Current : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Current : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Current : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Unlocked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_3_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_4_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCoverLock_Interlocks : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
