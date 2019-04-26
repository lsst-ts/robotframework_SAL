*** Settings ***
Documentation    MTArchiver Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTArchiver
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
    Should Contain    ${output}    ===== MTArchiver subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_sequencerHeartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sequencerHeartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTArchiver_sequencerHeartbeat start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::sequencerHeartbeat_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTArchiver_sequencerHeartbeat end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTArchiver subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${sequencerHeartbeat_start}=    Get Index From List    ${full_list}    === MTArchiver_sequencerHeartbeat start of topic ===
    ${sequencerHeartbeat_end}=    Get Index From List    ${full_list}    === MTArchiver_sequencerHeartbeat end of topic ===
    ${sequencerHeartbeat_list}=    Get Slice From List    ${full_list}    start=${sequencerHeartbeat_start}    end=${sequencerHeartbeat_end}
    Should Contain X Times    ${sequencerHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    10
    Should Contain X Times    ${sequencerHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    10
