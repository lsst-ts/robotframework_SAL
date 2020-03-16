*** Settings ***
Documentation    ATDome Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATDome
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
    Should Contain    ${output}    ===== ATDome subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_position test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_position
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATDome_position start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::position_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATDome_position end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATDome subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${position_start}=    Get Index From List    ${full_list}    === ATDome_position start of topic ===
    ${position_end}=    Get Index From List    ${full_list}    === ATDome_position end of topic ===
    ${position_list}=    Get Slice From List    ${full_list}    start=${position_start}    end=${position_end}
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dropoutDoorOpeningPercentage : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainDoorOpeningPercentage : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthPosition : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 1    10
