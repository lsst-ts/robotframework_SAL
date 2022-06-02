*** Settings ***
Documentation    MTMount Telemetry communications tests.
Force Tags    messaging    cpp    
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
    Should Be Equal    ${output.returncode}   ${NONE}
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
    Comment    ======= Verify ${subSystem}_azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_azimuthDrives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuthDrives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuthDrives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuthDrives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuthDrives end of topic ===
    Comment    ======= Verify ${subSystem}_cameraCableWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cameraCableWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_cameraCableWrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cameraCableWrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_cameraCableWrap end of topic ===
    Comment    ======= Verify ${subSystem}_elevation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_elevation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_elevation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::elevation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_elevation end of topic ===
    Comment    ======= Verify ${subSystem}_elevationDrives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_elevationDrives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_elevationDrives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::elevationDrives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_elevationDrives end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${azimuth_start}=    Get Index From List    ${full_list}    === MTMount_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === MTMount_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end}
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${azimuthDrives_start}=    Get Index From List    ${full_list}    === MTMount_azimuthDrives start of topic ===
    ${azimuthDrives_end}=    Get Index From List    ${full_list}    === MTMount_azimuthDrives end of topic ===
    ${azimuthDrives_list}=    Get Slice From List    ${full_list}    start=${azimuthDrives_start}    end=${azimuthDrives_end}
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 0    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 1    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 2    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 3    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 4    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 5    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 6    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 7    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 8    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 9    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cameraCableWrap_start}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap start of topic ===
    ${cameraCableWrap_end}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap end of topic ===
    ${cameraCableWrap_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrap_start}    end=${cameraCableWrap_end}
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${elevation_start}=    Get Index From List    ${full_list}    === MTMount_elevation start of topic ===
    ${elevation_end}=    Get Index From List    ${full_list}    === MTMount_elevation end of topic ===
    ${elevation_list}=    Get Slice From List    ${full_list}    start=${elevation_start}    end=${elevation_end}
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${elevationDrives_start}=    Get Index From List    ${full_list}    === MTMount_elevationDrives start of topic ===
    ${elevationDrives_end}=    Get Index From List    ${full_list}    === MTMount_elevationDrives end of topic ===
    ${elevationDrives_list}=    Get Slice From List    ${full_list}    start=${elevationDrives_start}    end=${elevationDrives_end}
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 0    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 1    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 2    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 3    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 4    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 5    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 6    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 7    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 8    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 9    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
