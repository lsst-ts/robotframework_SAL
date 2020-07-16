*** Settings ***
Documentation    CBP Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CBP
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
    Should Contain    ${output}    ===== CBP subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_status end of topic ===
    Comment    ======= Verify ${subSystem}_mask test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mask
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_mask start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mask_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_mask end of topic ===
    Comment    ======= Verify ${subSystem}_azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_altitude test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_altitude
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_altitude start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::altitude_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_altitude end of topic ===
    Comment    ======= Verify ${subSystem}_focus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_focus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_focus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::focus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_focus end of topic ===
    Comment    ======= Verify ${subSystem}_parked test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_parked
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CBP_parked start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::parked_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CBP_parked end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CBP subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${status_start}=    Get Index From List    ${full_list}    === CBP_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === CBP_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end}
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}panic : 1    10
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    10
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    10
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask : 1    10
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask_rotation : 1    10
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    10
    ${mask_start}=    Get Index From List    ${full_list}    === CBP_mask start of topic ===
    ${mask_end}=    Get Index From List    ${full_list}    === CBP_mask end of topic ===
    ${mask_list}=    Get Slice From List    ${full_list}    start=${mask_start}    end=${mask_end}
    Should Contain X Times    ${mask_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask : RO    10
    Should Contain X Times    ${mask_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask_rotation : 1    10
    ${azimuth_start}=    Get Index From List    ${full_list}    === CBP_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === CBP_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end}
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    10
    ${altitude_start}=    Get Index From List    ${full_list}    === CBP_altitude start of topic ===
    ${altitude_end}=    Get Index From List    ${full_list}    === CBP_altitude end of topic ===
    ${altitude_list}=    Get Slice From List    ${full_list}    start=${altitude_start}    end=${altitude_end}
    Should Contain X Times    ${altitude_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    10
    ${focus_start}=    Get Index From List    ${full_list}    === CBP_focus start of topic ===
    ${focus_end}=    Get Index From List    ${full_list}    === CBP_focus end of topic ===
    ${focus_list}=    Get Slice From List    ${full_list}    start=${focus_start}    end=${focus_end}
    Should Contain X Times    ${focus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    10
    ${parked_start}=    Get Index From List    ${full_list}    === CBP_parked start of topic ===
    ${parked_end}=    Get Index From List    ${full_list}    === CBP_parked end of topic ===
    ${parked_list}=    Get Slice From List    ${full_list}    start=${parked_start}    end=${parked_end}
    Should Contain X Times    ${parked_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoparked : 1    10
    Should Contain X Times    ${parked_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parked : 1    10
