*** Settings ***
Documentation    Guider Telemetry communications tests.
Force Tags    messaging    cpp    guider    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Guider
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
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== Guider subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_offsets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_offsets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === Guider_offsets start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::offsets_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Guider_offsets end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Guider subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${offsets_start}=    Get Index From List    ${full_list}    === Guider_offsets start of topic ===
    ${offsets_end}=    Get Index From List    ${full_list}    === Guider_offsets end of topic ===
    ${offsets_list}=    Get Slice From List    ${full_list}    start=${offsets_start}    end=${offsets_end}
    Should Contain X Times    ${offsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    10
    Should Contain X Times    ${offsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    10
    Should Contain X Times    ${offsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotation : 1    10
