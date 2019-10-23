*** Settings ***
Documentation    MTM1M3_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_accelerometerWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accelerometerWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event accelerometerWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accelerometerWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accelerometerWarning generated =
    Comment    ======= Verify ${subSystem}_airSupplyStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airSupplyStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event airSupplyStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airSupplyStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airSupplyStatus generated =
    Comment    ======= Verify ${subSystem}_airSupplyWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airSupplyWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event airSupplyWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airSupplyWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airSupplyWarning generated =
    Comment    ======= Verify ${subSystem}_appliedAberrationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAberrationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAberrationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAberrationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAberrationForces generated =
    Comment    ======= Verify ${subSystem}_appliedAccelerationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAccelerationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAccelerationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAccelerationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAccelerationForces generated =
    Comment    ======= Verify ${subSystem}_appliedActiveOpticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedActiveOpticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedActiveOpticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedActiveOpticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedActiveOpticForces generated =
    Comment    ======= Verify ${subSystem}_appliedAzimuthForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAzimuthForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAzimuthForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAzimuthForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAzimuthForces generated =
    Comment    ======= Verify ${subSystem}_appliedBalanceForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedBalanceForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedBalanceForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedBalanceForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedBalanceForces generated =
    Comment    ======= Verify ${subSystem}_appliedCylinderForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedCylinderForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedCylinderForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedCylinderForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedCylinderForces generated =
    Comment    ======= Verify ${subSystem}_appliedElevationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedElevationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedElevationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedElevationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedElevationForces generated =
    Comment    ======= Verify ${subSystem}_appliedForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedForces generated =
    Comment    ======= Verify ${subSystem}_appliedHardpointSteps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedHardpointSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedHardpointSteps iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedHardpointSteps_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedHardpointSteps generated =
    Comment    ======= Verify ${subSystem}_appliedOffsetForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedOffsetForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedOffsetForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedOffsetForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedOffsetForces generated =
    Comment    ======= Verify ${subSystem}_appliedStaticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedStaticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedStaticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedStaticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedStaticForces generated =
    Comment    ======= Verify ${subSystem}_appliedThermalForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedThermalForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedThermalForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedThermalForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedThermalForces generated =
    Comment    ======= Verify ${subSystem}_appliedVelocityForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedVelocityForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedVelocityForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedVelocityForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedVelocityForces generated =
    Comment    ======= Verify ${subSystem}_cellLightStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellLightStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellLightStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellLightStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellLightStatus generated =
    Comment    ======= Verify ${subSystem}_cellLightWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellLightWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellLightWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellLightWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellLightWarning generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_displacementSensorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_displacementSensorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event displacementSensorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_displacementSensorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event displacementSensorWarning generated =
    Comment    ======= Verify ${subSystem}_forceActuatorBackupCalibrationInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorBackupCalibrationInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorBackupCalibrationInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorBackupCalibrationInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorBackupCalibrationInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorILCInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorILCInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorILCInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorILCInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorILCInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorIdInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorIdInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorIdInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorIdInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorIdInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorMainCalibrationInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorMainCalibrationInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorMainCalibrationInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorMainCalibrationInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorMainCalibrationInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorMezzanineCalibrationInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorMezzanineCalibrationInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorMezzanineCalibrationInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorMezzanineCalibrationInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorMezzanineCalibrationInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorPositionInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorPositionInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorPositionInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorPositionInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorPositionInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorState generated =
    Comment    ======= Verify ${subSystem}_forceActuatorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorWarning generated =
    Comment    ======= Verify ${subSystem}_gyroWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_gyroWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event gyroWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_gyroWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event gyroWarning generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorInfo generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorState generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorWarning generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorInfo generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorState generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorWarning generated =
    Comment    ======= Verify ${subSystem}_inclinometerSensorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inclinometerSensorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inclinometerSensorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inclinometerSensorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inclinometerSensorWarning generated =
    Comment    ======= Verify ${subSystem}_interlockStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlockStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlockStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlockStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlockStatus generated =
    Comment    ======= Verify ${subSystem}_interlockWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlockWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlockWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlockWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlockWarning generated =
    Comment    ======= Verify ${subSystem}_modbusResponse test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_modbusResponse
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event modbusResponse iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_modbusResponse_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event modbusResponse generated =
    Comment    ======= Verify ${subSystem}_modbusWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_modbusWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event modbusWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_modbusWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event modbusWarning generated =
    Comment    ======= Verify ${subSystem}_pidInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pidInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event pidInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pidInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pidInfo generated =
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerStatus generated =
    Comment    ======= Verify ${subSystem}_powerWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerWarning generated =
    Comment    ======= Verify ${subSystem}_rejectedAberrationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedAberrationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedAberrationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedAberrationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedAberrationForces generated =
    Comment    ======= Verify ${subSystem}_rejectedAccelerationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedAccelerationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedAccelerationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedAccelerationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedAccelerationForces generated =
    Comment    ======= Verify ${subSystem}_rejectedActiveOpticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedActiveOpticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedActiveOpticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedActiveOpticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedActiveOpticForces generated =
    Comment    ======= Verify ${subSystem}_rejectedAzimuthForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedAzimuthForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedAzimuthForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedAzimuthForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedAzimuthForces generated =
    Comment    ======= Verify ${subSystem}_rejectedBalanceForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedBalanceForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedBalanceForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedBalanceForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedBalanceForces generated =
    Comment    ======= Verify ${subSystem}_rejectedCylinderForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCylinderForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCylinderForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCylinderForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCylinderForces generated =
    Comment    ======= Verify ${subSystem}_rejectedElevationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedElevationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedElevationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedElevationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedElevationForces generated =
    Comment    ======= Verify ${subSystem}_rejectedForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedForces generated =
    Comment    ======= Verify ${subSystem}_rejectedOffsetForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedOffsetForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedOffsetForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedOffsetForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedOffsetForces generated =
    Comment    ======= Verify ${subSystem}_rejectedStaticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedStaticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedStaticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedStaticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedStaticForces generated =
    Comment    ======= Verify ${subSystem}_rejectedThermalForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedThermalForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedThermalForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedThermalForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedThermalForces generated =
    Comment    ======= Verify ${subSystem}_rejectedVelocityForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedVelocityForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedVelocityForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedVelocityForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedVelocityForces generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${accelerometerWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_accelerometerWarning start of topic ===
    ${accelerometerWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_accelerometerWarning end of topic ===
    ${accelerometerWarning_list}=    Get Slice From List    ${full_list}    start=${accelerometerWarning_start}    end=${accelerometerWarning_end}
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometerFlags : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airSupplyStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_airSupplyStatus start of topic ===
    ${airSupplyStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_airSupplyStatus end of topic ===
    ${airSupplyStatus_list}=    Get Slice From List    ${full_list}    start=${airSupplyStatus_start}    end=${airSupplyStatus_end}
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airCommandedOn : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveOpened : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveClosed : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airSupplyWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_airSupplyWarning start of topic ===
    ${airSupplyWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_airSupplyWarning end of topic ===
    ${airSupplyWarning_list}=    Get Slice From List    ${full_list}    start=${airSupplyWarning_start}    end=${airSupplyWarning_end}
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airSupplyFlags : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAberrationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAberrationForces start of topic ===
    ${appliedAberrationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAberrationForces end of topic ===
    ${appliedAberrationForces_list}=    Get Slice From List    ${full_list}    start=${appliedAberrationForces_start}    end=${appliedAberrationForces_end}
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAccelerationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAccelerationForces start of topic ===
    ${appliedAccelerationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAccelerationForces end of topic ===
    ${appliedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${appliedAccelerationForces_start}    end=${appliedAccelerationForces_end}
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedActiveOpticForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedActiveOpticForces start of topic ===
    ${appliedActiveOpticForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedActiveOpticForces end of topic ===
    ${appliedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${appliedActiveOpticForces_start}    end=${appliedActiveOpticForces_end}
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAzimuthForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAzimuthForces start of topic ===
    ${appliedAzimuthForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedAzimuthForces end of topic ===
    ${appliedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${appliedAzimuthForces_start}    end=${appliedAzimuthForces_end}
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedBalanceForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedBalanceForces start of topic ===
    ${appliedBalanceForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedBalanceForces end of topic ===
    ${appliedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${appliedBalanceForces_start}    end=${appliedBalanceForces_end}
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedCylinderForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedCylinderForces start of topic ===
    ${appliedCylinderForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedCylinderForces end of topic ===
    ${appliedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${appliedCylinderForces_start}    end=${appliedCylinderForces_end}
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedElevationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedElevationForces start of topic ===
    ${appliedElevationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedElevationForces end of topic ===
    ${appliedElevationForces_list}=    Get Slice From List    ${full_list}    start=${appliedElevationForces_start}    end=${appliedElevationForces_end}
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedForces start of topic ===
    ${appliedForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedForces end of topic ===
    ${appliedForces_list}=    Get Slice From List    ${full_list}    start=${appliedForces_start}    end=${appliedForces_end}
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedHardpointSteps_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedHardpointSteps start of topic ===
    ${appliedHardpointSteps_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedHardpointSteps end of topic ===
    ${appliedHardpointSteps_list}=    Get Slice From List    ${full_list}    start=${appliedHardpointSteps_start}    end=${appliedHardpointSteps_end}
    Should Contain X Times    ${appliedHardpointSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetEncoderValues : 0    1
    Should Contain X Times    ${appliedHardpointSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}queuedSteps : 0    1
    Should Contain X Times    ${appliedHardpointSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedSteps : 0    1
    Should Contain X Times    ${appliedHardpointSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedOffsetForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedOffsetForces start of topic ===
    ${appliedOffsetForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedOffsetForces end of topic ===
    ${appliedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${appliedOffsetForces_start}    end=${appliedOffsetForces_end}
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedStaticForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedStaticForces start of topic ===
    ${appliedStaticForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedStaticForces end of topic ===
    ${appliedStaticForces_list}=    Get Slice From List    ${full_list}    start=${appliedStaticForces_start}    end=${appliedStaticForces_end}
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedThermalForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedThermalForces start of topic ===
    ${appliedThermalForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedThermalForces end of topic ===
    ${appliedThermalForces_list}=    Get Slice From List    ${full_list}    start=${appliedThermalForces_start}    end=${appliedThermalForces_end}
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedVelocityForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedVelocityForces start of topic ===
    ${appliedVelocityForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedVelocityForces end of topic ===
    ${appliedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${appliedVelocityForces_start}    end=${appliedVelocityForces_end}
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellLightStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_cellLightStatus start of topic ===
    ${cellLightStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_cellLightStatus end of topic ===
    ${cellLightStatus_list}=    Get Slice From List    ${full_list}    start=${cellLightStatus_start}    end=${cellLightStatus_end}
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsCommandedOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellLightWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_cellLightWarning start of topic ===
    ${cellLightWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_cellLightWarning end of topic ===
    ${cellLightWarning_list}=    Get Slice From List    ${full_list}    start=${cellLightWarning_start}    end=${cellLightWarning_end}
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightFlags : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${displacementSensorWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_displacementSensorWarning start of topic ===
    ${displacementSensorWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_displacementSensorWarning end of topic ===
    ${displacementSensorWarning_list}=    Get Slice From List    ${full_list}    start=${displacementSensorWarning_start}    end=${displacementSensorWarning_end}
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementSensorFlags : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorBackupCalibrationInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorBackupCalibrationInfo start of topic ===
    ${forceActuatorBackupCalibrationInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorBackupCalibrationInfo end of topic ===
    ${forceActuatorBackupCalibrationInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorBackupCalibrationInfo_start}    end=${forceActuatorBackupCalibrationInfo_end}
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCoefficient : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryOffset : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primarySensitivity : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCoefficient : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryOffset : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondarySensitivity : 0    1
    Should Contain X Times    ${forceActuatorBackupCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorILCInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorILCInfo start of topic ===
    ${forceActuatorILCInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorILCInfo end of topic ===
    ${forceActuatorILCInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorILCInfo_start}    end=${forceActuatorILCInfo_end}
    Should Contain X Times    ${forceActuatorILCInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusSubnet : 0    1
    Should Contain X Times    ${forceActuatorILCInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusAddress : 0    1
    Should Contain X Times    ${forceActuatorILCInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcStatus : 0    1
    Should Contain X Times    ${forceActuatorILCInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineStatus : 0    1
    Should Contain X Times    ${forceActuatorILCInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorIdInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorIdInfo start of topic ===
    ${forceActuatorIdInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorIdInfo end of topic ===
    ${forceActuatorIdInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorIdInfo_start}    end=${forceActuatorIdInfo_end}
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcUniqueId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineUniqueId : 0    1
    Should Contain X Times    ${forceActuatorIdInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorMainCalibrationInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorMainCalibrationInfo start of topic ===
    ${forceActuatorMainCalibrationInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorMainCalibrationInfo end of topic ===
    ${forceActuatorMainCalibrationInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorMainCalibrationInfo_start}    end=${forceActuatorMainCalibrationInfo_end}
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCoefficient : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryOffset : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primarySensitivity : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCoefficient : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryOffset : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondarySensitivity : 0    1
    Should Contain X Times    ${forceActuatorMainCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorMezzanineCalibrationInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorMezzanineCalibrationInfo start of topic ===
    ${forceActuatorMezzanineCalibrationInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorMezzanineCalibrationInfo end of topic ===
    ${forceActuatorMezzanineCalibrationInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorMezzanineCalibrationInfo_start}    end=${forceActuatorMezzanineCalibrationInfo_end}
    Should Contain X Times    ${forceActuatorMezzanineCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderGain : 0    1
    Should Contain X Times    ${forceActuatorMezzanineCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderGain : 0    1
    Should Contain X Times    ${forceActuatorMezzanineCalibrationInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorPositionInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorPositionInfo start of topic ===
    ${forceActuatorPositionInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorPositionInfo end of topic ===
    ${forceActuatorPositionInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorPositionInfo_start}    end=${forceActuatorPositionInfo_end}
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorType : 0    1
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorOrientation : 0    1
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 0    1
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 0    1
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 0    1
    Should Contain X Times    ${forceActuatorPositionInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorState_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorState start of topic ===
    ${forceActuatorState_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorState end of topic ===
    ${forceActuatorState_list}=    Get Slice From List    ${full_list}    start=${forceActuatorState_start}    end=${forceActuatorState_end}
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewFlag : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}staticForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermalForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeOpticForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aberrationForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}balanceForcesApplied : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supportPercentage : 1    1
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorWarning start of topic ===
    ${forceActuatorWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_forceActuatorWarning end of topic ===
    ${forceActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${forceActuatorWarning_start}    end=${forceActuatorWarning_end}
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}globalWarningFlags : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyForceActuatorFlags : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceActuatorFlags : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${gyroWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_gyroWarning start of topic ===
    ${gyroWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_gyroWarning end of topic ===
    ${gyroWarning_list}=    Get Slice From List    ${full_list}    start=${gyroWarning_start}    end=${gyroWarning_end}
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroSensorFlags : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorInfo start of topic ===
    ${hardpointActuatorInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorInfo end of topic ===
    ${hardpointActuatorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorInfo_start}    end=${hardpointActuatorInfo_end}
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referenceId : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referencePosition : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusSubnet : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusAddress : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcUniqueId : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcApplicationType : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeType : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcSelectedOptions : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeOptions : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorRevision : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorRevision : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}adcScanRate : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainLoadCellCoefficient : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainLoadCellOffset : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainLoadCellSensitivity : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupLoadCellCoefficient : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupLoadCellOffset : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupLoadCellSensitivity : 0    1
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorState_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorState start of topic ===
    ${hardpointActuatorState_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorState end of topic ===
    ${hardpointActuatorState_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorState_start}    end=${hardpointActuatorState_end}
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionState : 0    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorWarning start of topic ===
    ${hardpointActuatorWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointActuatorWarning end of topic ===
    ${hardpointActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorWarning_start}    end=${hardpointActuatorWarning_end}
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyHardpointActuatorFlags : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointActuatorFlags : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointMonitorInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorInfo start of topic ===
    ${hardpointMonitorInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorInfo end of topic ===
    ${hardpointMonitorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorInfo_start}    end=${hardpointMonitorInfo_end}
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referenceId : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusSubnet : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusAddress : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcUniqueId : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcApplicationType : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeType : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorRevision : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorRevision : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineUniqueId : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineFirmwareType : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineMajorRevision : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineMinorRevision : 0    1
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointMonitorState_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorState start of topic ===
    ${hardpointMonitorState_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorState end of topic ===
    ${hardpointMonitorState_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorState_start}    end=${hardpointMonitorState_end}
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointMonitorWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorWarning start of topic ===
    ${hardpointMonitorWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_hardpointMonitorWarning end of topic ===
    ${hardpointMonitorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorWarning_start}    end=${hardpointMonitorWarning_end}
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyHardpointMonitorFlags : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMonitorFlags : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inclinometerSensorWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_inclinometerSensorWarning start of topic ===
    ${inclinometerSensorWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_inclinometerSensorWarning end of topic ===
    ${inclinometerSensorWarning_list}=    Get Slice From List    ${full_list}    start=${inclinometerSensorWarning_start}    end=${inclinometerSensorWarning_end}
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerSensorFlags : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_interlockStatus start of topic ===
    ${interlockStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_interlockStatus end of topic ===
    ${interlockStatus_list}=    Get Slice From List    ${full_list}    start=${interlockStatus_start}    end=${interlockStatus_end}
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatCommandedState : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_interlockWarning start of topic ===
    ${interlockWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_interlockWarning end of topic ===
    ${interlockWarning_list}=    Get Slice From List    ${full_list}    start=${interlockWarning_start}    end=${interlockWarning_end}
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interlockSystemFlags : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${modbusResponse_start}=    Get Index From List    ${full_list}    === ${subSystem}_modbusResponse start of topic ===
    ${modbusResponse_end}=    Get Index From List    ${full_list}    === ${subSystem}_modbusResponse end of topic ===
    ${modbusResponse_list}=    Get Slice From List    ${full_list}    start=${modbusResponse_start}    end=${modbusResponse_end}
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseValid : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionCode : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataLength : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}crc : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${modbusWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_modbusWarning start of topic ===
    ${modbusWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_modbusWarning end of topic ===
    ${modbusWarning_list}=    Get Slice From List    ${full_list}    start=${modbusWarning_start}    end=${modbusWarning_end}
    Should Contain X Times    ${modbusWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${modbusWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusSystemFlags : 1    1
    Should Contain X Times    ${modbusWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySubnetFlags : 1    1
    Should Contain X Times    ${modbusWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subnetFlags : 0    1
    Should Contain X Times    ${modbusWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pidInfo_start}=    Get Index From List    ${full_list}    === ${subSystem}_pidInfo start of topic ===
    ${pidInfo_end}=    Get Index From List    ${full_list}    === ${subSystem}_pidInfo end of topic ===
    ${pidInfo_list}=    Get Slice From List    ${full_list}    start=${pidInfo_start}    end=${pidInfo_end}
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestep : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}d : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}n : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calculatedA : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calculatedB : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calculatedC : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calculatedD : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calculatedE : 0    1
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === ${subSystem}_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === ${subSystem}_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkACommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkACommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkBCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkCCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkDCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_powerWarning start of topic ===
    ${powerWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_powerWarning end of topic ===
    ${powerWarning_list}=    Get Slice From List    ${full_list}    start=${powerWarning_start}    end=${powerWarning_end}
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerSystemFlags : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedAberrationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAberrationForces start of topic ===
    ${rejectedAberrationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAberrationForces end of topic ===
    ${rejectedAberrationForces_list}=    Get Slice From List    ${full_list}    start=${rejectedAberrationForces_start}    end=${rejectedAberrationForces_end}
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedAccelerationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAccelerationForces start of topic ===
    ${rejectedAccelerationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAccelerationForces end of topic ===
    ${rejectedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${rejectedAccelerationForces_start}    end=${rejectedAccelerationForces_end}
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedActiveOpticForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedActiveOpticForces start of topic ===
    ${rejectedActiveOpticForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedActiveOpticForces end of topic ===
    ${rejectedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${rejectedActiveOpticForces_start}    end=${rejectedActiveOpticForces_end}
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedAzimuthForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAzimuthForces start of topic ===
    ${rejectedAzimuthForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedAzimuthForces end of topic ===
    ${rejectedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${rejectedAzimuthForces_start}    end=${rejectedAzimuthForces_end}
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedBalanceForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedBalanceForces start of topic ===
    ${rejectedBalanceForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedBalanceForces end of topic ===
    ${rejectedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${rejectedBalanceForces_start}    end=${rejectedBalanceForces_end}
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCylinderForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedCylinderForces start of topic ===
    ${rejectedCylinderForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedCylinderForces end of topic ===
    ${rejectedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${rejectedCylinderForces_start}    end=${rejectedCylinderForces_end}
    Should Contain X Times    ${rejectedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${rejectedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${rejectedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedElevationForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedElevationForces start of topic ===
    ${rejectedElevationForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedElevationForces end of topic ===
    ${rejectedElevationForces_list}=    Get Slice From List    ${full_list}    start=${rejectedElevationForces_start}    end=${rejectedElevationForces_end}
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedForces start of topic ===
    ${rejectedForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedForces end of topic ===
    ${rejectedForces_list}=    Get Slice From List    ${full_list}    start=${rejectedForces_start}    end=${rejectedForces_end}
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedOffsetForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedOffsetForces start of topic ===
    ${rejectedOffsetForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedOffsetForces end of topic ===
    ${rejectedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${rejectedOffsetForces_start}    end=${rejectedOffsetForces_end}
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedStaticForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedStaticForces start of topic ===
    ${rejectedStaticForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedStaticForces end of topic ===
    ${rejectedStaticForces_list}=    Get Slice From List    ${full_list}    start=${rejectedStaticForces_start}    end=${rejectedStaticForces_end}
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedThermalForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedThermalForces start of topic ===
    ${rejectedThermalForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedThermalForces end of topic ===
    ${rejectedThermalForces_list}=    Get Slice From List    ${full_list}    start=${rejectedThermalForces_start}    end=${rejectedThermalForces_end}
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedVelocityForces_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedVelocityForces start of topic ===
    ${rejectedVelocityForces_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedVelocityForces end of topic ===
    ${rejectedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${rejectedVelocityForces_start}    end=${rejectedVelocityForces_end}
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${rejectedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
