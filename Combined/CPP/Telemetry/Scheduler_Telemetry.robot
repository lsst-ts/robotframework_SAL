*** Settings ***
Documentation    Scheduler Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
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
    Should Contain    ${output}    ===== Scheduler subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_observatoryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_observatoryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === Scheduler_observatoryState start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::observatoryState_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Scheduler_observatoryState end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${observatoryState_start}=    Get Index From List    ${full_list}    === Scheduler_observatoryState start of topic ===
    ${observatoryState_end}=    Get Index From List    ${full_list}    === Scheduler_observatoryState end of topic ===
    ${observatoryState_list}=    Get Slice From List    ${full_list}    start=${observatoryState_start}    end=${observatoryState_end}
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionAngle : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallacticAngle : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracking : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeRotator : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPosition : RO    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMounted : RO    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterUnmounted : RO    10
