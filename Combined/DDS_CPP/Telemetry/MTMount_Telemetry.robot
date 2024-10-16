*** Settings ***
Documentation    MTMount Telemetry communications tests.
Force Tags    messaging    cpp    mtmount    
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
    Comment    ======= Verify ${subSystem}_telemetryClientHeartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_telemetryClientHeartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_telemetryClientHeartbeat start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::telemetryClientHeartbeat_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_telemetryClientHeartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_safetySystem test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_safetySystem
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_safetySystem start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::safetySystem_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_safetySystem end of topic ===
    Comment    ======= Verify ${subSystem}_elevation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_elevation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_elevation start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::elevation_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_elevation end of topic ===
    Comment    ======= Verify ${subSystem}_lockingPins test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lockingPins
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_lockingPins start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lockingPins_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_lockingPins end of topic ===
    Comment    ======= Verify ${subSystem}_deployablePlatforms test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_deployablePlatforms
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_deployablePlatforms start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::deployablePlatforms_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_deployablePlatforms end of topic ===
    Comment    ======= Verify ${subSystem}_cabinet0101Thermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cabinet0101Thermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_cabinet0101Thermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cabinet0101Thermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_cabinet0101Thermal end of topic ===
    Comment    ======= Verify ${subSystem}_azimuthCableWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuthCableWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuthCableWrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuthCableWrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuthCableWrap end of topic ===
    Comment    ======= Verify ${subSystem}_cameraCableWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cameraCableWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_cameraCableWrap start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cameraCableWrap_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_cameraCableWrap end of topic ===
    Comment    ======= Verify ${subSystem}_balancing test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_balancing
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_balancing start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::balancing_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_balancing end of topic ===
    Comment    ======= Verify ${subSystem}_azimuthDrives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuthDrives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuthDrives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuthDrives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuthDrives end of topic ===
    Comment    ======= Verify ${subSystem}_azimuthDrivesThermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuthDrivesThermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_azimuthDrivesThermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuthDrivesThermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_azimuthDrivesThermal end of topic ===
    Comment    ======= Verify ${subSystem}_elevationDrives test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_elevationDrives
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_elevationDrives start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::elevationDrives_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_elevationDrives end of topic ===
    Comment    ======= Verify ${subSystem}_elevationDrivesThermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_elevationDrivesThermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_elevationDrivesThermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::elevationDrivesThermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_elevationDrivesThermal end of topic ===
    Comment    ======= Verify ${subSystem}_encoder test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_encoder
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_encoder start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::encoder_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_encoder end of topic ===
    Comment    ======= Verify ${subSystem}_mainCabinetThermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mainCabinetThermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_mainCabinetThermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mainCabinetThermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_mainCabinetThermal end of topic ===
    Comment    ======= Verify ${subSystem}_mirrorCoverLocks test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mirrorCoverLocks
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_mirrorCoverLocks start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mirrorCoverLocks_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_mirrorCoverLocks end of topic ===
    Comment    ======= Verify ${subSystem}_mirrorCover test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mirrorCover
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_mirrorCover start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mirrorCover_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_mirrorCover end of topic ===
    Comment    ======= Verify ${subSystem}_mainPowerSupply test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mainPowerSupply
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_mainPowerSupply start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mainPowerSupply_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_mainPowerSupply end of topic ===
    Comment    ======= Verify ${subSystem}_topEndChiller test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_topEndChiller
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_topEndChiller start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::topEndChiller_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_topEndChiller end of topic ===
    Comment    ======= Verify ${subSystem}_auxiliaryCabinetsThermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_auxiliaryCabinetsThermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_auxiliaryCabinetsThermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::auxiliaryCabinetsThermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_auxiliaryCabinetsThermal end of topic ===
    Comment    ======= Verify ${subSystem}_oilSupplySystem test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_oilSupplySystem
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_oilSupplySystem start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::oilSupplySystem_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_oilSupplySystem end of topic ===
    Comment    ======= Verify ${subSystem}_compressedAir test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_compressedAir
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_compressedAir start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::compressedAir_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_compressedAir end of topic ===
    Comment    ======= Verify ${subSystem}_cooling test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cooling
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_cooling start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cooling_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_cooling end of topic ===
    Comment    ======= Verify ${subSystem}_dynaleneCooling test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_dynaleneCooling
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_dynaleneCooling start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::dynaleneCooling_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_dynaleneCooling end of topic ===
    Comment    ======= Verify ${subSystem}_generalPurposeGlycolWater test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_generalPurposeGlycolWater
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_generalPurposeGlycolWater start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::generalPurposeGlycolWater_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_generalPurposeGlycolWater end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${telemetryClientHeartbeat_start}=    Get Index From List    ${full_list}    === MTMount_telemetryClientHeartbeat start of topic ===
    ${telemetryClientHeartbeat_end}=    Get Index From List    ${full_list}    === MTMount_telemetryClientHeartbeat end of topic ===
    ${telemetryClientHeartbeat_list}=    Get Slice From List    ${full_list}    start=${telemetryClientHeartbeat_start}    end=${telemetryClientHeartbeat_end}
    ${azimuth_start}=    Get Index From List    ${full_list}    === MTMount_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === MTMount_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end}
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAccelerationTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualJerk : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualJerkTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorqueTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocityTimestamp : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${safetySystem_start}=    Get Index From List    ${full_list}    === MTMount_safetySystem start of topic ===
    ${safetySystem_end}=    Get Index From List    ${full_list}    === MTMount_safetySystem end of topic ===
    ${safetySystem_list}=    Get Slice From List    ${full_list}    start=${safetySystem_start}    end=${safetySystem_end}
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 0    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 1    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 2    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 3    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 4    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 5    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 6    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 7    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 8    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAz : 9    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 0    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 1    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 2    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 3    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 4    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 5    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 6    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 7    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 8    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureAzTimestamp : 9    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 0    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 1    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 2    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 3    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 4    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 5    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 6    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 7    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 8    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureEl : 9    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 0    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 1    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 2    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 3    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 4    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 5    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 6    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 7    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 8    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakePressureElTimestamp : 9    1
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}versionNumber : 1    10
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}versionNumberTimestamp : 1    10
    ${elevation_start}=    Get Index From List    ${full_list}    === MTMount_elevation start of topic ===
    ${elevation_end}=    Get Index From List    ${full_list}    === MTMount_elevation end of topic ===
    ${elevation_list}=    Get Slice From List    ${full_list}    start=${elevation_start}    end=${elevation_end}
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAccelerationTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualJerk : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualJerkTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorqueTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocityTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationInclinometer : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationInclinometerTimestamp : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${lockingPins_start}=    Get Index From List    ${full_list}    === MTMount_lockingPins start of topic ===
    ${lockingPins_end}=    Get Index From List    ${full_list}    === MTMount_lockingPins end of topic ===
    ${lockingPins_list}=    Get Slice From List    ${full_list}    start=${lockingPins_start}    end=${lockingPins_end}
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 0    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 1    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 2    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 3    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 4    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 5    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 6    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 7    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 8    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 9    1
    Should Contain X Times    ${lockingPins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${deployablePlatforms_start}=    Get Index From List    ${full_list}    === MTMount_deployablePlatforms start of topic ===
    ${deployablePlatforms_end}=    Get Index From List    ${full_list}    === MTMount_deployablePlatforms end of topic ===
    ${deployablePlatforms_list}=    Get Slice From List    ${full_list}    start=${deployablePlatforms_start}    end=${deployablePlatforms_end}
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1Section : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform1SectionTimestamp : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2Section : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionPlatform2SectionTimestamp : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1Drive : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform1DriveTimestamp : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2Drive : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 0    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 1    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 2    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 3    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 4    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 5    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 6    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 7    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 8    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentagePlatform2DriveTimestamp : 9    1
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cabinet0101Thermal_start}=    Get Index From List    ${full_list}    === MTMount_cabinet0101Thermal start of topic ===
    ${cabinet0101Thermal_end}=    Get Index From List    ${full_list}    === MTMount_cabinet0101Thermal end of topic ===
    ${cabinet0101Thermal_list}=    Get Slice From List    ${full_list}    start=${cabinet0101Thermal_start}    end=${cabinet0101Thermal_end}
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePosition : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionTimestamp : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePosition : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionTimestamp : 1    10
    Should Contain X Times    ${cabinet0101Thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${azimuthCableWrap_start}=    Get Index From List    ${full_list}    === MTMount_azimuthCableWrap start of topic ===
    ${azimuthCableWrap_end}=    Get Index From List    ${full_list}    === MTMount_azimuthCableWrap end of topic ===
    ${azimuthCableWrap_list}=    Get Slice From List    ${full_list}    start=${azimuthCableWrap_start}    end=${azimuthCableWrap_end}
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 0    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 1    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 2    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 3    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 4    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 5    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 6    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 7    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 8    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDrive : 9    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 0    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 1    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 2    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 3    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 4    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 5    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 6    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 7    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 8    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionDriveTimestamp : 9    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 0    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 1    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 2    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 3    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 4    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 5    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 6    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 7    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 8    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDrive : 9    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 0    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 1    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 2    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 3    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 4    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 5    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 6    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 7    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 8    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityDriveTimestamp : 9    1
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cameraCableWrap_start}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap start of topic ===
    ${cameraCableWrap_end}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap end of topic ===
    ${cameraCableWrap_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrap_start}    end=${cameraCableWrap_end}
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 0    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 1    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 2    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 3    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 4    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 5    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 6    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 7    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 8    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 9    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 0    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 1    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 2    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 3    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 4    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 5    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 6    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 7    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 8    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 9    1
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPositionTimestamp : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocityTimestamp : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${balancing_start}=    Get Index From List    ${full_list}    === MTMount_balancing start of topic ===
    ${balancing_end}=    Get Index From List    ${full_list}    === MTMount_balancing end of topic ===
    ${balancing_list}=    Get Slice From List    ${full_list}    start=${balancing_start}    end=${balancing_end}
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 0    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 1    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 2    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 3    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 4    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 5    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 6    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 7    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 8    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocityTimestamp : 9    1
    Should Contain X Times    ${balancing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
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
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 0    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 1    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 2    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 3    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 4    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 5    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 6    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 7    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 8    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 9    1
    Should Contain X Times    ${azimuthDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${azimuthDrivesThermal_start}=    Get Index From List    ${full_list}    === MTMount_azimuthDrivesThermal start of topic ===
    ${azimuthDrivesThermal_end}=    Get Index From List    ${full_list}    === MTMount_azimuthDrivesThermal end of topic ===
    ${azimuthDrivesThermal_list}=    Get Slice From List    ${full_list}    start=${azimuthDrivesThermal_start}    end=${azimuthDrivesThermal_end}
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureTimestamp : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuth : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionAzimuthTimestamp : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuth : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 0    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 1    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 2    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 3    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 4    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 5    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 6    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 7    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 8    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionAzimuthTimestamp : 9    1
    Should Contain X Times    ${azimuthDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
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
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 0    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 1    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 2    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 3    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 4    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 5    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 6    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 7    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 8    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentTimestamp : 9    1
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${elevationDrivesThermal_start}=    Get Index From List    ${full_list}    === MTMount_elevationDrivesThermal start of topic ===
    ${elevationDrivesThermal_end}=    Get Index From List    ${full_list}    === MTMount_elevationDrivesThermal end of topic ===
    ${elevationDrivesThermal_list}=    Get Slice From List    ${full_list}    start=${elevationDrivesThermal_start}    end=${elevationDrivesThermal_end}
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature10 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature10Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature12 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature12Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature2 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature2Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature4 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature4Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature6 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature6Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature8 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature8Timestamp : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevation : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePositionElevationTimestamp : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevation : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 0    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 1    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 2    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 3    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 4    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 5    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 6    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 7    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 8    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePositionElevationTimestamp : 9    1
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${encoder_start}=    Get Index From List    ${full_list}    === MTMount_encoder start of topic ===
    ${encoder_end}=    Get Index From List    ${full_list}    === MTMount_encoder end of topic ===
    ${encoder_list}=    Get Slice From List    ${full_list}    start=${encoder_start}    end=${encoder_end}
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderAbsolutePositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderPositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoderRelativePositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderAbsolutePositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderPositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePosition : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRelativePositionTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZ : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceAZTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceEL : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 0    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 1    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 2    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 3    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 4    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 5    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 6    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 7    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 8    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadReadReferenceELTimestamp : 9    1
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${mainCabinetThermal_start}=    Get Index From List    ${full_list}    === MTMount_mainCabinetThermal start of topic ===
    ${mainCabinetThermal_end}=    Get Index From List    ${full_list}    === MTMount_mainCabinetThermal end of topic ===
    ${mainCabinetThermal_list}=    Get Slice From List    ${full_list}    start=${mainCabinetThermal_start}    end=${mainCabinetThermal_end}
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPxiTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPxiTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axesPxiTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axesPxiTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetExternalTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetExternalTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 0    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 1    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 2    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 3    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 4    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 5    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 6    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 7    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 8    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 9    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 0    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 1    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 2    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 3    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 4    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 5    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 6    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 7    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 8    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperatureTimestamp : 9    1
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tmaPxiTemperature : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tmaPxiTemperatureTimestamp : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveFeedback : 1    10
    Should Contain X Times    ${mainCabinetThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveFeedbackTimestamp : 1    10
    ${mirrorCoverLocks_start}=    Get Index From List    ${full_list}    === MTMount_mirrorCoverLocks start of topic ===
    ${mirrorCoverLocks_end}=    Get Index From List    ${full_list}    === MTMount_mirrorCoverLocks end of topic ===
    ${mirrorCoverLocks_list}=    Get Slice From List    ${full_list}    start=${mirrorCoverLocks_start}    end=${mirrorCoverLocks_end}
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 0    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 2    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 3    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 4    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 5    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 6    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 7    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 8    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 9    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 0    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 2    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 3    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 4    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 5    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 6    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 7    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 8    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 9    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 0    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 1    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 2    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 3    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 4    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 5    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 6    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 7    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 8    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 9    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 0    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 1    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 2    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 3    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 4    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 5    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 6    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 7    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 8    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 9    1
    Should Contain X Times    ${mirrorCoverLocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${mirrorCover_start}=    Get Index From List    ${full_list}    === MTMount_mirrorCover start of topic ===
    ${mirrorCover_end}=    Get Index From List    ${full_list}    === MTMount_mirrorCover end of topic ===
    ${mirrorCover_list}=    Get Slice From List    ${full_list}    start=${mirrorCover_start}    end=${mirrorCover_end}
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 0    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 2    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 3    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 4    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 5    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 6    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 7    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 8    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 9    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 0    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 1    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 2    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 3    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 4    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 5    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 6    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 7    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 8    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPositionTimestamp : 9    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 0    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 1    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 2    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 3    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 4    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 5    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 6    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 7    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 8    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentage : 9    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 0    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 1    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 2    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 3    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 4    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 5    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 6    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 7    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 8    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorquePercentageTimestamp : 9    1
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${mainPowerSupply_start}=    Get Index From List    ${full_list}    === MTMount_mainPowerSupply start of topic ===
    ${mainPowerSupply_end}=    Get Index From List    ${full_list}    === MTMount_mainPowerSupply end of topic ===
    ${mainPowerSupply_list}=    Get Slice From List    ${full_list}    start=${mainPowerSupply_start}    end=${mainPowerSupply_end}
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyCurrent : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyCurrentTimestamp : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyVoltage : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyVoltageTimestamp : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${topEndChiller_start}=    Get Index From List    ${full_list}    === MTMount_topEndChiller start of topic ===
    ${topEndChiller_end}=    Get Index From List    ${full_list}    === MTMount_topEndChiller end of topic ===
    ${topEndChiller_list}=    Get Slice From List    ${full_list}    start=${topEndChiller_start}    end=${topEndChiller_end}
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAmbient : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAmbientTimestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0501 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0501Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0502 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0502Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0504 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0504Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0505 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0505Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0502 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0502Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0504 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0504Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0505 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0505Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureTimestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0506 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0506Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0507 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0507Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 0    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 1    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 2    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 3    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 4    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 5    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 6    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 7    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 8    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinet : 9    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 0    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 1    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 2    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 3    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 4    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 5    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 6    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 7    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 8    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalTemperatureElectricalCabinetTimestamp : 9    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatExchangerSupplyTemperature : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatExchangerSupplyTemperatureTimestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 0    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 1    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 2    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 3    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 4    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 5    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 6    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 7    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 8    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinet : 9    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 0    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 1    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 2    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 3    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 4    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 5    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 6    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 7    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 8    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}internalTemperatureElectricalCabinetTimestamp : 9    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSensor0501 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSensor0501Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition201 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition201Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition202 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition202Timestamp : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${auxiliaryCabinetsThermal_start}=    Get Index From List    ${full_list}    === MTMount_auxiliaryCabinetsThermal start of topic ===
    ${auxiliaryCabinetsThermal_end}=    Get Index From List    ${full_list}    === MTMount_auxiliaryCabinetsThermal end of topic ===
    ${auxiliaryCabinetsThermal_list}=    Get Slice From List    ${full_list}    start=${auxiliaryCabinetsThermal_start}    end=${auxiliaryCabinetsThermal_end}
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthDriveCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthDriveCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionTransformer0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionTransformer0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0002 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0002Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthDZCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthDZCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionTransformer0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionTransformer0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0001Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0002 : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0002Timestamp : 1    10
    Should Contain X Times    ${auxiliaryCabinetsThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${oilSupplySystem_start}=    Get Index From List    ${full_list}    === MTMount_oilSupplySystem start of topic ===
    ${oilSupplySystem_end}=    Get Index From List    ${full_list}    === MTMount_oilSupplySystem end of topic ===
    ${oilSupplySystem_list}=    Get Slice From List    ${full_list}    start=${oilSupplySystem_start}    end=${oilSupplySystem_end}
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthCabinet5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthCabinet5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationCabinet5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationCabinet5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationCabinet5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationCabinet5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureTimestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5004Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5014Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5024Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5034Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5044Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5054Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5003Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5004Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5005Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5006Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5014Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5015Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5016Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5017 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5017Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5018 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5018Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5019 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5019Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5023Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5024Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5025 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5025Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5026 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5026Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5033Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5034Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5035 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5035Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5036 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5036Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5041Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5042Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5043Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5044Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5045 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5045Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5046 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5046Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5047 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5047Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5048 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5048Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5049 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5049Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5051Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5052Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5053Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5054Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5055 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5055Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5056 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5056Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5003Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5004Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5005Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5006Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5014Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5015Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5016Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5023Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5024Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5025 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5025Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5026 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5026Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5033Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5034Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5035 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5035Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5036 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5036Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5041Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5042Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5043Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5051Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5052Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevelFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevelFacilities5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5003Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5014Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5015Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5016Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5023Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5033Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5034Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5041Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5042Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5043Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5044Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5045 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5045Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5046 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5046Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5051Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5052Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5053Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5054Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5003Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5022Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5023Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5032Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5033Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5034Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5003Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5004Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5005Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5006Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5007 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5007Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5008 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5008Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5012Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5013Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5051Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5052Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5053Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5054Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5055 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5055Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5056 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5056Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5057 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5057Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5041Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5051Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5021Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5031Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5101 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5101Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5111 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5111Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5001Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5002Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5011Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5121 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5121Timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureCabinets : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureCabinetsTimestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valvePositionFacilities5201 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valvePositionFacilities5201Timestamp : 1    10
    ${compressedAir_start}=    Get Index From List    ${full_list}    === MTMount_compressedAir start of topic ===
    ${compressedAir_end}=    Get Index From List    ${full_list}    === MTMount_compressedAir end of topic ===
    ${compressedAir_list}=    Get Slice From List    ${full_list}    start=${compressedAir_start}    end=${compressedAir_end}
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0002 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0001Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0002 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0002Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressurePier0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressurePier0001Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airTemperaturePier0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airTemperaturePier0001Timestamp : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cooling_start}=    Get Index From List    ${full_list}    === MTMount_cooling start of topic ===
    ${cooling_end}=    Get Index From List    ${full_list}    === MTMount_cooling end of topic ===
    ${cooling_list}=    Get Slice From List    ${full_list}    start=${cooling_start}    end=${cooling_end}
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0003 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0003Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0004 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0004Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0005 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0005Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0006 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0006Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0007 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0007Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0008 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0008Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0009 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0009Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0010 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0010Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0011 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0011Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0012 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0012Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0013 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0013Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0014 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0014Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0015 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0015Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0016 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0016Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0017 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0017Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0018 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0018Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0019 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0019Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0020 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0020Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0021 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0021Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0022 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0022Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0001Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0002Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0101 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0101Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0102 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0102Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0021 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0021Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0022 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0022Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureElevation0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureElevation0001Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0101 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0101Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0102 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0102Timestamp : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${dynaleneCooling_start}=    Get Index From List    ${full_list}    === MTMount_dynaleneCooling start of topic ===
    ${dynaleneCooling_end}=    Get Index From List    ${full_list}    === MTMount_dynaleneCooling end of topic ===
    ${dynaleneCooling_list}=    Get Slice From List    ${full_list}    start=${dynaleneCooling_start}    end=${dynaleneCooling_end}
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0001Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0002Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0003 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0003Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0004 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0004Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0005 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0005Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0006 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0006Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0007 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0007Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0101 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0101Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0102 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0102Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0101 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0101Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0102 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0102Timestamp : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${generalPurposeGlycolWater_start}=    Get Index From List    ${full_list}    === MTMount_generalPurposeGlycolWater start of topic ===
    ${generalPurposeGlycolWater_end}=    Get Index From List    ${full_list}    === MTMount_generalPurposeGlycolWater end of topic ===
    ${generalPurposeGlycolWater_list}=    Get Slice From List    ${full_list}    start=${generalPurposeGlycolWater_start}    end=${generalPurposeGlycolWater_end}
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0001Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0002Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0001Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0002Timestamp : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
