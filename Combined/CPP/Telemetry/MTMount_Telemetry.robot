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
    Comment    ======= Verify ${subSystem}_cabinet0101 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cabinet0101
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_cabinet0101 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cabinet0101_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_cabinet0101 end of topic ===
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
    Comment    ======= Verify ${subSystem}_mountControlMainCabinet test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountControlMainCabinet
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_mountControlMainCabinet start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountControlMainCabinet_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_mountControlMainCabinet end of topic ===
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
    Comment    ======= Verify ${subSystem}_auxiliaryBoxes test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_auxiliaryBoxes
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTMount_auxiliaryBoxes start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::auxiliaryBoxes_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTMount_auxiliaryBoxes end of topic ===
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
    ${azimuth_start}=    Get Index From List    ${full_list}    === MTMount_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === MTMount_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end}
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${safetySystem_start}=    Get Index From List    ${full_list}    === MTMount_safetySystem start of topic ===
    ${safetySystem_end}=    Get Index From List    ${full_list}    === MTMount_safetySystem end of topic ===
    ${safetySystem_list}=    Get Slice From List    ${full_list}    start=${safetySystem_start}    end=${safetySystem_end}
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${safetySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}versionNumber : 1    10
    ${elevation_start}=    Get Index From List    ${full_list}    === MTMount_elevation start of topic ===
    ${elevation_end}=    Get Index From List    ${full_list}    === MTMount_elevation end of topic ===
    ${elevation_list}=    Get Slice From List    ${full_list}    start=${elevation_start}    end=${elevation_end}
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTorque : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${elevation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
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
    Should Contain X Times    ${deployablePlatforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cabinet0101_start}=    Get Index From List    ${full_list}    === MTMount_cabinet0101 start of topic ===
    ${cabinet0101_end}=    Get Index From List    ${full_list}    === MTMount_cabinet0101 end of topic ===
    ${cabinet0101_list}=    Get Slice From List    ${full_list}    start=${cabinet0101_start}    end=${cabinet0101_end}
    Should Contain X Times    ${cabinet0101_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature : 1    10
    Should Contain X Times    ${cabinet0101_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualValvePosition : 1    10
    Should Contain X Times    ${cabinet0101_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    10
    Should Contain X Times    ${cabinet0101_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointValvePosition : 1    10
    Should Contain X Times    ${cabinet0101_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
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
    Should Contain X Times    ${azimuthCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cameraCableWrap_start}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap start of topic ===
    ${cameraCableWrap_end}=    Get Index From List    ${full_list}    === MTMount_cameraCableWrap end of topic ===
    ${cameraCableWrap_list}=    Get Slice From List    ${full_list}    start=${cameraCableWrap_start}    end=${cameraCableWrap_end}
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualAcceleration : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualPosition : 1    10
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
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualVelocity : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandPosition : 1    10
    Should Contain X Times    ${cameraCableWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandVelocity : 1    10
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
    Should Contain X Times    ${elevationDrives_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${elevationDrivesThermal_start}=    Get Index From List    ${full_list}    === MTMount_elevationDrivesThermal start of topic ===
    ${elevationDrivesThermal_end}=    Get Index From List    ${full_list}    === MTMount_elevationDrivesThermal end of topic ===
    ${elevationDrivesThermal_list}=    Get Slice From List    ${full_list}    start=${elevationDrivesThermal_start}    end=${elevationDrivesThermal_end}
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature10 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature12 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature2 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature4 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature6 : 1    10
    Should Contain X Times    ${elevationDrivesThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperature8 : 1    10
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
    Should Contain X Times    ${encoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${mountControlMainCabinet_start}=    Get Index From List    ${full_list}    === MTMount_mountControlMainCabinet start of topic ===
    ${mountControlMainCabinet_end}=    Get Index From List    ${full_list}    === MTMount_mountControlMainCabinet end of topic ===
    ${mountControlMainCabinet_list}=    Get Slice From List    ${full_list}    start=${mountControlMainCabinet_start}    end=${mountControlMainCabinet_end}
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetExternalTemperature : 1    10
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 0    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 1    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 2    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 3    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 4    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 5    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 6    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 7    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 8    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetInternalTemperature : 9    1
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperature : 1    10
    Should Contain X Times    ${mountControlMainCabinet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
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
    Should Contain X Times    ${mirrorCover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${mainPowerSupply_start}=    Get Index From List    ${full_list}    === MTMount_mainPowerSupply start of topic ===
    ${mainPowerSupply_end}=    Get Index From List    ${full_list}    === MTMount_mainPowerSupply end of topic ===
    ${mainPowerSupply_list}=    Get Slice From List    ${full_list}    start=${mainPowerSupply_start}    end=${mainPowerSupply_end}
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyCurrent : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSupplyVoltage : 1    10
    Should Contain X Times    ${mainPowerSupply_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${topEndChiller_start}=    Get Index From List    ${full_list}    === MTMount_topEndChiller start of topic ===
    ${topEndChiller_end}=    Get Index From List    ${full_list}    === MTMount_topEndChiller end of topic ===
    ${topEndChiller_list}=    Get Slice From List    ${full_list}    start=${topEndChiller_start}    end=${topEndChiller_end}
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAmbient : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 0    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 1    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 2    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 3    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 4    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 5    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 6    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 7    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 8    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureArea : 9    1
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0501 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0502 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0504 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientRelativeHumiditySensor0505 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0502 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0504 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperatureSensor0505 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0506 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ductTemperatureSensor0507 : 1    10
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
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatExchangerSupplyTemperature : 1    10
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
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureSensor0501 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition201 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}threeWayValvePosition202 : 1    10
    Should Contain X Times    ${topEndChiller_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${auxiliaryBoxes_start}=    Get Index From List    ${full_list}    === MTMount_auxiliaryBoxes start of topic ===
    ${auxiliaryBoxes_end}=    Get Index From List    ${full_list}    === MTMount_auxiliaryBoxes end of topic ===
    ${auxiliaryBoxes_list}=    Get Slice From List    ${full_list}    start=${auxiliaryBoxes_start}    end=${auxiliaryBoxes_end}
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthDriveCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureAzimuthPowerDistributionTransformer0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actualTemperatureElevationPowerDistributionCabinet0002 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthDZCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureAzimuthPowerDistributionTransformer0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0001 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTemperatureElevationPowerDistributionCabinet0002 : 1    10
    Should Contain X Times    ${auxiliaryBoxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${oilSupplySystem_start}=    Get Index From List    ${full_list}    === MTMount_oilSupplySystem start of topic ===
    ${oilSupplySystem_end}=    Get Index From List    ${full_list}    === MTMount_oilSupplySystem end of topic ===
    ${oilSupplySystem_list}=    Get Slice From List    ${full_list}    start=${oilSupplySystem_start}    end=${oilSupplySystem_end}
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemperature : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessAzimuthBearing5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}computedOilFilmThicknessElevationBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilChillerTemperature5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5017 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5018 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5019 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5025 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5026 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5035 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5036 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5045 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5046 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5047 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5048 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5049 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5055 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessAzimuthBearing5056 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5024 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5025 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5026 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5035 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFilmThicknessElevationBearing5036 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateAzimuth5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilFlowRateElevation5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevelFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5014 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5015 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5016 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5042 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5043 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5044 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5045 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5046 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureAzimuth5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5022 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5023 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5032 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5033 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureElevation5034 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5003 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5004 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5005 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5006 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5007 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5008 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5012 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5013 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5052 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5053 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5054 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5055 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5056 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilPressureFacilities5057 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5041 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureAzimuth5051 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5021 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5031 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5101 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureElevation5111 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5001 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5002 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5011 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilTemperatureFacilities5121 : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${oilSupplySystem_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valvePositionFacilities5201 : 1    10
    ${compressedAir_start}=    Get Index From List    ${full_list}    === MTMount_compressedAir start of topic ===
    ${compressedAir_end}=    Get Index From List    ${full_list}    === MTMount_compressedAir end of topic ===
    ${compressedAir_list}=    Get Slice From List    ${full_list}    start=${compressedAir_start}    end=${compressedAir_end}
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureAzimuth0002 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureElevation0002 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressurePier0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airTemperaturePier0001 : 1    10
    Should Contain X Times    ${compressedAir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${cooling_start}=    Get Index From List    ${full_list}    === MTMount_cooling start of topic ===
    ${cooling_end}=    Get Index From List    ${full_list}    === MTMount_cooling end of topic ===
    ${cooling_list}=    Get Slice From List    ${full_list}    start=${cooling_start}    end=${cooling_end}
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0003 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0004 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0005 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0006 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0007 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0008 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0009 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0010 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0011 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0012 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0013 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0014 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0015 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0016 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0017 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0018 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0019 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0020 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0021 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0022 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureElevation0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0101 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0102 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0002 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0021 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureAzimuth0022 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperatureElevation0001 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0101 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0102 : 1    10
    Should Contain X Times    ${cooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${dynaleneCooling_start}=    Get Index From List    ${full_list}    === MTMount_dynaleneCooling start of topic ===
    ${dynaleneCooling_end}=    Get Index From List    ${full_list}    === MTMount_dynaleneCooling end of topic ===
    ${dynaleneCooling_list}=    Get Slice From List    ${full_list}    start=${dynaleneCooling_start}    end=${dynaleneCooling_end}
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureAzimuth0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0003 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0004 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0005 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0006 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressureElevation0007 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0101 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynalenePressurePier0102 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0001 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperatureAzimuth0002 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0101 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dynaleneTemperaturePier0102 : 1    10
    Should Contain X Times    ${dynaleneCooling_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${generalPurposeGlycolWater_start}=    Get Index From List    ${full_list}    === MTMount_generalPurposeGlycolWater start of topic ===
    ${generalPurposeGlycolWater_end}=    Get Index From List    ${full_list}    === MTMount_generalPurposeGlycolWater end of topic ===
    ${generalPurposeGlycolWater_list}=    Get Slice From List    ${full_list}    start=${generalPurposeGlycolWater_start}    end=${generalPurposeGlycolWater_end}
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressureAzimuth0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolPressurePier0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0001 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolTemperaturePier0002 : 1    10
    Should Contain X Times    ${generalPurposeGlycolWater_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
