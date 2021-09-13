*** Settings ***
Documentation    MTM1M3_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorInfo generated =
    Comment    ======= Verify ${subSystem}_forceActuatorInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorInfo generated =
    Comment    ======= Verify ${subSystem}_ilcWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ilcWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event ilcWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ilcWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ilcWarning generated =
    Comment    ======= Verify ${subSystem}_interlockWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlockWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlockWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlockWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlockWarning generated =
    Comment    ======= Verify ${subSystem}_airSupplyStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airSupplyStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event airSupplyStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airSupplyStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airSupplyStatus generated =
    Comment    ======= Verify ${subSystem}_airSupplyWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airSupplyWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event airSupplyWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airSupplyWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airSupplyWarning generated =
    Comment    ======= Verify ${subSystem}_interlockStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlockStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlockStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlockStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlockStatus generated =
    Comment    ======= Verify ${subSystem}_displacementSensorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_displacementSensorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event displacementSensorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_displacementSensorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event displacementSensorWarning generated =
    Comment    ======= Verify ${subSystem}_inclinometerSensorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inclinometerSensorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inclinometerSensorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inclinometerSensorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inclinometerSensorWarning generated =
    Comment    ======= Verify ${subSystem}_accelerometerWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accelerometerWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event accelerometerWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accelerometerWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accelerometerWarning generated =
    Comment    ======= Verify ${subSystem}_forceSetpointWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceSetpointWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceSetpointWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceSetpointWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceSetpointWarning generated =
    Comment    ======= Verify ${subSystem}_forceActuatorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorState generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorInfo generated =
    Comment    ======= Verify ${subSystem}_cellLightStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellLightStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellLightStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellLightStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellLightStatus generated =
    Comment    ======= Verify ${subSystem}_cellLightWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellLightWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellLightWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellLightWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellLightWarning generated =
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerStatus generated =
    Comment    ======= Verify ${subSystem}_powerWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerWarning generated =
    Comment    ======= Verify ${subSystem}_forceActuatorForceWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorForceWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorForceWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorForceWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorForceWarning generated =
    Comment    ======= Verify ${subSystem}_gyroWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_gyroWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event gyroWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_gyroWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event gyroWarning generated =
    Comment    ======= Verify ${subSystem}_powerSupplyStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_powerSupplyStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event powerSupplyStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_powerSupplyStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event powerSupplyStatus generated =
    Comment    ======= Verify ${subSystem}_appliedOffsetForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedOffsetForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedOffsetForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedOffsetForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedOffsetForces generated =
    Comment    ======= Verify ${subSystem}_appliedStaticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedStaticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedStaticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedStaticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedStaticForces generated =
    Comment    ======= Verify ${subSystem}_appliedActiveOpticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedActiveOpticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedActiveOpticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedActiveOpticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedActiveOpticForces generated =
    Comment    ======= Verify ${subSystem}_appliedAberrationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAberrationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAberrationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAberrationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAberrationForces generated =
    Comment    ======= Verify ${subSystem}_appliedAzimuthForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAzimuthForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAzimuthForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAzimuthForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAzimuthForces generated =
    Comment    ======= Verify ${subSystem}_commandRejectionWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_commandRejectionWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event commandRejectionWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_commandRejectionWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event commandRejectionWarning generated =
    Comment    ======= Verify ${subSystem}_pidInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pidInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pidInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pidInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pidInfo generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorWarning generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorWarning generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorState generated =
    Comment    ======= Verify ${subSystem}_hardpointMonitorState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointMonitorState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointMonitorState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointMonitorState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointMonitorState generated =
    Comment    ======= Verify ${subSystem}_forceActuatorWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorWarning generated =
    Comment    ======= Verify ${subSystem}_preclippedStaticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedStaticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedStaticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedStaticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedStaticForces generated =
    Comment    ======= Verify ${subSystem}_preclippedElevationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedElevationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedElevationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedElevationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedElevationForces generated =
    Comment    ======= Verify ${subSystem}_preclippedAzimuthForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedAzimuthForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedAzimuthForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedAzimuthForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedAzimuthForces generated =
    Comment    ======= Verify ${subSystem}_preclippedThermalForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedThermalForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedThermalForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedThermalForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedThermalForces generated =
    Comment    ======= Verify ${subSystem}_preclippedActiveOpticForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedActiveOpticForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedActiveOpticForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedActiveOpticForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedActiveOpticForces generated =
    Comment    ======= Verify ${subSystem}_preclippedAberrationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedAberrationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedAberrationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedAberrationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedAberrationForces generated =
    Comment    ======= Verify ${subSystem}_preclippedBalanceForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedBalanceForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedBalanceForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedBalanceForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedBalanceForces generated =
    Comment    ======= Verify ${subSystem}_preclippedVelocityForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedVelocityForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedVelocityForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedVelocityForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedVelocityForces generated =
    Comment    ======= Verify ${subSystem}_preclippedAccelerationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedAccelerationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedAccelerationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedAccelerationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedAccelerationForces generated =
    Comment    ======= Verify ${subSystem}_preclippedOffsetForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedOffsetForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedOffsetForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedOffsetForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedOffsetForces generated =
    Comment    ======= Verify ${subSystem}_preclippedForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedForces generated =
    Comment    ======= Verify ${subSystem}_appliedElevationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedElevationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedElevationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedElevationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedElevationForces generated =
    Comment    ======= Verify ${subSystem}_appliedAccelerationForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedAccelerationForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedAccelerationForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedAccelerationForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedAccelerationForces generated =
    Comment    ======= Verify ${subSystem}_appliedThermalForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedThermalForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedThermalForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedThermalForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedThermalForces generated =
    Comment    ======= Verify ${subSystem}_appliedVelocityForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedVelocityForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedVelocityForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedVelocityForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedVelocityForces generated =
    Comment    ======= Verify ${subSystem}_appliedBalanceForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedBalanceForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedBalanceForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedBalanceForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedBalanceForces generated =
    Comment    ======= Verify ${subSystem}_appliedForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedForces generated =
    Comment    ======= Verify ${subSystem}_preclippedCylinderForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedCylinderForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedCylinderForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedCylinderForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedCylinderForces generated =
    Comment    ======= Verify ${subSystem}_appliedCylinderForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedCylinderForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedCylinderForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedCylinderForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedCylinderForces generated =
    Comment    ======= Verify ${subSystem}_modbusResponse test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_modbusResponse
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event modbusResponse iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_modbusResponse_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event modbusResponse generated =
    Comment    ======= Verify ${subSystem}_forceActuatorBumpTestStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorBumpTestStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorBumpTestStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorBumpTestStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorBumpTestStatus generated =
    Comment    ======= Verify ${subSystem}_enabledForceActuators test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_enabledForceActuators
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event enabledForceActuators iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_enabledForceActuators_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event enabledForceActuators generated =
    Comment    ======= Verify ${subSystem}_forceActuatorSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorSettings generated =
    Comment    ======= Verify ${subSystem}_hardpointActuatorSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointActuatorSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointActuatorSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointActuatorSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointActuatorSettings generated =
    Comment    ======= Verify ${subSystem}_displacementSensorSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_displacementSensorSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event displacementSensorSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_displacementSensorSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event displacementSensorSettings generated =
    Comment    ======= Verify ${subSystem}_pidSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pidSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pidSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pidSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pidSettings generated =
    Comment    ======= Verify ${subSystem}_accelerometerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accelerometerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event accelerometerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accelerometerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accelerometerSettings generated =
    Comment    ======= Verify ${subSystem}_gyroSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_gyroSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event gyroSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_gyroSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event gyroSettings generated =
    Comment    ======= Verify ${subSystem}_inclinometerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inclinometerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inclinometerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inclinometerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inclinometerSettings generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =
    Comment    ======= Verify ${subSystem}_largeFileObjectAvailable test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_largeFileObjectAvailable
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event largeFileObjectAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_largeFileObjectAvailable_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event largeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorInfo_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointActuatorInfo_start}
    ${hardpointActuatorInfo_end}=    Evaluate    ${end}+${1}
    ${hardpointActuatorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorInfo_start}    end=${hardpointActuatorInfo_end}
    Should Contain X Times    ${hardpointActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
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
    ${forceActuatorInfo_start}=    Get Index From List    ${full_list}    === Event forceActuatorInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorInfo_start}
    ${forceActuatorInfo_end}=    Evaluate    ${end}+${1}
    ${forceActuatorInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorInfo_start}    end=${forceActuatorInfo_end}
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referenceId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zDataReferenceId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorType : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorOrientation : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusSubnet : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusAddress : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcUniqueId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcApplicationType : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeType : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcSelectedOptions : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeOptions : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorRevision : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorRevision : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}adcScanRate : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainPrimaryCylinderCoefficient : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainSecondaryCylinderCoefficient : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainPrimaryCylinderLoadCellOffset : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainSecondaryCylinderLoadCellOffset : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainPrimaryCylinderLoadCellSensitivity : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainSecondaryCylinderLoadCellSensitivity : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupPrimaryCylinderCoefficient : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupSecondaryCylinderCoefficient : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupPrimaryCylinderLoadCellOffset : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupSecondaryCylinderLoadCellOffset : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupPrimaryCylinderLoadCellSensitivity : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupSecondaryCylinderLoadCellSensitivity : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzaninePrimaryCylinderGain : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineSecondaryCylinderGain : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineUniqueId : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineFirmwareType : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineMajorRevision : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineMinorRevision : 0    1
    Should Contain X Times    ${forceActuatorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ilcWarning_start}=    Get Index From List    ${full_list}    === Event ilcWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${ilcWarning_start}
    ${ilcWarning_end}=    Evaluate    ${end}+${1}
    ${ilcWarning_list}=    Get Slice From List    ${full_list}    start=${ilcWarning_start}    end=${ilcWarning_end}
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseTimeout : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidCRC : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}illegalFunction : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}illegalDataValue : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidLength : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownSubnet : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownAddress : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownFunction : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownProblem : 1    1
    Should Contain X Times    ${ilcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockWarning_start}=    Get Index From List    ${full_list}    === Event interlockWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlockWarning_start}
    ${interlockWarning_end}=    Evaluate    ${end}+${1}
    ${interlockWarning_list}=    Get Slice From List    ${full_list}    start=${interlockWarning_start}    end=${interlockWarning_end}
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatStateOutputMismatch : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworksOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermalEquipmentOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airSupplyOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tmaMotionStop : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gisHeartbeatLost : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetDoorOpen : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airSupplyStatus_start}=    Get Index From List    ${full_list}    === Event airSupplyStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${airSupplyStatus_start}
    ${airSupplyStatus_end}=    Evaluate    ${end}+${1}
    ${airSupplyStatus_list}=    Get Slice From List    ${full_list}    start=${airSupplyStatus_start}    end=${airSupplyStatus_end}
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airCommandedOn : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airCommandOutputOn : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveOpened : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveClosed : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airSupplyWarning_start}=    Get Index From List    ${full_list}    === Event airSupplyWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${airSupplyWarning_start}
    ${airSupplyWarning_end}=    Evaluate    ${end}+${1}
    ${airSupplyWarning_list}=    Get Slice From List    ${full_list}    start=${airSupplyWarning_start}    end=${airSupplyWarning_end}
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandOutputMismatch : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSensorMismatch : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockStatus_start}=    Get Index From List    ${full_list}    === Event interlockStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlockStatus_start}
    ${interlockStatus_end}=    Evaluate    ${end}+${1}
    ${interlockStatus_list}=    Get Slice From List    ${full_list}    start=${interlockStatus_start}    end=${interlockStatus_end}
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatCommandedState : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatOutputState : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${displacementSensorWarning_start}=    Get Index From List    ${full_list}    === Event displacementSensorWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${displacementSensorWarning_start}
    ${displacementSensorWarning_end}=    Evaluate    ${end}+${1}
    ${displacementSensorWarning_list}=    Get Slice From List    ${full_list}    start=${displacementSensorWarning_start}    end=${displacementSensorWarning_end}
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsInvalidCommand : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsCommunicationTimeoutError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsDataLengthError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsNumberOfParametersError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsParameterError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsCommunicationError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsIDNumberError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsExpansionLineError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsWriteControlError : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseTimeout : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidLength : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidResponse : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownCommand : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownProblem : 1    1
    Should Contain X Times    ${displacementSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inclinometerSensorWarning_start}=    Get Index From List    ${full_list}    === Event inclinometerSensorWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inclinometerSensorWarning_start}
    ${inclinometerSensorWarning_end}=    Evaluate    ${end}+${1}
    ${inclinometerSensorWarning_list}=    Get Slice From List    ${full_list}    start=${inclinometerSensorWarning_start}    end=${inclinometerSensorWarning_end}
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsIllegalFunction : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorReportsIllegalDataAddress : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseTimeout : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidCRC : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidLength : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownAddress : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownFunction : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unknownProblem : 1    1
    Should Contain X Times    ${inclinometerSensorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accelerometerWarning_start}=    Get Index From List    ${full_list}    === Event accelerometerWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${accelerometerWarning_start}
    ${accelerometerWarning_end}=    Evaluate    ${end}+${1}
    ${accelerometerWarning_list}=    Get Slice From List    ${full_list}    start=${accelerometerWarning_start}    end=${accelerometerWarning_end}
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseTimeout : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceSetpointWarning_start}=    Get Index From List    ${full_list}    === Event forceSetpointWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceSetpointWarning_start}
    ${forceSetpointWarning_end}=    Evaluate    ${end}+${1}
    ${forceSetpointWarning_list}=    Get Slice From List    ${full_list}    start=${forceSetpointWarning_start}    end=${forceSetpointWarning_end}
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySafetyLimitWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}safetyLimitWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xMomentWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yMomentWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zMomentWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyNearNeighborWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nearNeighborWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}magnitudeWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFarNeighborWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}farNeighborWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyElevationForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAzimuthForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyThermalForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermalForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBalanceForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}balanceForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAccelerationForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeOpticNetForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyActiveOpticForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activeOpticForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyStaticForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}staticForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aberrationNetForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAberrationForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aberrationForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOffsetForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyVelocityForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorState_start}=    Get Index From List    ${full_list}    === Event forceActuatorState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorState_start}
    ${forceActuatorState_end}=    Evaluate    ${end}+${1}
    ${forceActuatorState_list}=    Get Slice From List    ${full_list}    start=${forceActuatorState_start}    end=${forceActuatorState_end}
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
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
    ${hardpointMonitorInfo_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointMonitorInfo_start}
    ${hardpointMonitorInfo_end}=    Evaluate    ${end}+${1}
    ${hardpointMonitorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorInfo_start}    end=${hardpointMonitorInfo_end}
    Should Contain X Times    ${hardpointMonitorInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
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
    ${cellLightStatus_start}=    Get Index From List    ${full_list}    === Event cellLightStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cellLightStatus_start}
    ${cellLightStatus_end}=    Evaluate    ${end}+${1}
    ${cellLightStatus_list}=    Get Slice From List    ${full_list}    start=${cellLightStatus_start}    end=${cellLightStatus_end}
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsCommandedOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOutputOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellLightWarning_start}=    Get Index From List    ${full_list}    === Event cellLightWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cellLightWarning_start}
    ${cellLightWarning_end}=    Evaluate    ${end}+${1}
    ${cellLightWarning_list}=    Get Slice From List    ${full_list}    start=${cellLightWarning_start}    end=${cellLightWarning_end}
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOutputMismatch : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsSensorMismatch : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === Event powerStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${powerStatus_start}
    ${powerStatus_end}=    Evaluate    ${end}+${1}
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkACommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkAOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkACommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkAOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkBCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkBOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkCCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkCOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkDCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkDOutputOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerWarning_start}=    Get Index From List    ${full_list}    === Event powerWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${powerWarning_start}
    ${powerWarning_end}=    Evaluate    ${end}+${1}
    ${powerWarning_list}=    Get Slice From List    ${full_list}    start=${powerWarning_start}    end=${powerWarning_end}
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkAOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkAOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkBOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkCOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworkDOutputMismatch : 1    1
    Should Contain X Times    ${powerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorForceWarning_start}=    Get Index From List    ${full_list}    === Event forceActuatorForceWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorForceWarning_start}
    ${forceActuatorForceWarning_end}=    Evaluate    ${end}+${1}
    ${forceActuatorForceWarning_list}=    Get Slice From List    ${full_list}    start=${forceActuatorForceWarning_start}    end=${forceActuatorForceWarning_end}
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisMeasuredForceWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisMeasuredForceWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisMeasuredForceWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisMeasuredForceWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisFollowingErrorWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisFollowingErrorWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${gyroWarning_start}=    Get Index From List    ${full_list}    === Event gyroWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${gyroWarning_start}
    ${gyroWarning_end}=    Evaluate    ${end}+${1}
    ${gyroWarning_list}=    Get Slice From List    ${full_list}    start=${gyroWarning_start}    end=${gyroWarning_end}
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumberWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}crcMismatchWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidLengthWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}invalidHeaderWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}incompleteFrameWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXSLDWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXMODDACWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXPhaseWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXFlashWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYSLDWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYMODDACWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYPhaseWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYFlashWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZSLDWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZMODDACWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZPhaseWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZFlashWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcbTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcbDSPSPIFlashStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcbFPGASPIFlashStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dspSPIFlashStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaSPIFlashStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcb1_2VStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcb3_3VStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcb5VStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v1_2StatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v3_3StatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v5StatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcbFPGAStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hiSpeedSPORTStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxSPORTStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sufficientSoftwareResourcesWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroEOVoltsPositiveWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroEOVoltsNegativeWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXVoltsWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYVoltsWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZVoltsWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gcbADCCommsWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mSYNCExternalTimingWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${powerSupplyStatus_start}=    Get Index From List    ${full_list}    === Event powerSupplyStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${powerSupplyStatus_start}
    ${powerSupplyStatus_end}=    Evaluate    ${end}+${1}
    ${powerSupplyStatus_list}=    Get Slice From List    ${full_list}    start=${powerSupplyStatus_start}    end=${powerSupplyStatus_end}
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC1Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpCabinetUtility220VACStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpExternalEquipment220VACStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC2Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC3Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkARedundancyControlStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBRedundancyControlStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCRedundancyControlStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDRedundancyControlStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlsPowerNetworkRedundancyControlStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkAStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkARedundantStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBRedundantStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCRedundantStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDRedundantStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlsPowerNetworkStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlsPowerNetworkRedundantStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lightPowerNetworkStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}externalEquipmentPowerNetworkStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}laserTrackerPowerNetworkStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedOffsetForces_start}=    Get Index From List    ${full_list}    === Event appliedOffsetForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedOffsetForces_start}
    ${appliedOffsetForces_end}=    Evaluate    ${end}+${1}
    ${appliedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${appliedOffsetForces_start}    end=${appliedOffsetForces_end}
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedStaticForces_start}=    Get Index From List    ${full_list}    === Event appliedStaticForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedStaticForces_start}
    ${appliedStaticForces_end}=    Evaluate    ${end}+${1}
    ${appliedStaticForces_list}=    Get Slice From List    ${full_list}    start=${appliedStaticForces_start}    end=${appliedStaticForces_end}
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedActiveOpticForces_start}=    Get Index From List    ${full_list}    === Event appliedActiveOpticForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedActiveOpticForces_start}
    ${appliedActiveOpticForces_end}=    Evaluate    ${end}+${1}
    ${appliedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${appliedActiveOpticForces_start}    end=${appliedActiveOpticForces_end}
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAberrationForces_start}=    Get Index From List    ${full_list}    === Event appliedAberrationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedAberrationForces_start}
    ${appliedAberrationForces_end}=    Evaluate    ${end}+${1}
    ${appliedAberrationForces_list}=    Get Slice From List    ${full_list}    start=${appliedAberrationForces_start}    end=${appliedAberrationForces_end}
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAzimuthForces_start}=    Get Index From List    ${full_list}    === Event appliedAzimuthForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedAzimuthForces_start}
    ${appliedAzimuthForces_end}=    Evaluate    ${end}+${1}
    ${appliedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${appliedAzimuthForces_start}    end=${appliedAzimuthForces_end}
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${commandRejectionWarning_start}=    Get Index From List    ${full_list}    === Event commandRejectionWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${commandRejectionWarning_start}
    ${commandRejectionWarning_end}=    Evaluate    ${end}+${1}
    ${commandRejectionWarning_list}=    Get Slice From List    ${full_list}    start=${commandRejectionWarning_start}    end=${commandRejectionWarning_end}
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}command : RO    1
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reason : RO    1
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pidInfo_start}=    Get Index From List    ${full_list}    === Event pidInfo received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pidInfo_start}
    ${pidInfo_end}=    Evaluate    ${end}+${1}
    ${pidInfo_list}=    Get Slice From List    ${full_list}    start=${pidInfo_start}    end=${pidInfo_end}
    Should Contain X Times    ${pidInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
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
    ${hardpointActuatorWarning_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointActuatorWarning_start}
    ${hardpointActuatorWarning_end}=    Evaluate    ${end}+${1}
    ${hardpointActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorWarning_start}    end=${hardpointActuatorWarning_end}
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMajorFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMinorFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFaultOverride : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultOverride : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMainCalibrationError : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCalibrationError : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBackupCalibrationError : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupCalibrationError : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyLimitSwitch1Operated : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitSwitch1Operated : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyLimitSwitch2Operated : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitSwitch2Operated : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyUniqueIdCRCError : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uniqueIdCRCError : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationTypeMismatch : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationTypeMismatch : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationMissing : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationMissing : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationCRCMismatch : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationCRCMismatch : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWireMissing : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWireMissing : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire1Mismatch : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire1Mismatch : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire2Mismatch : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire2Mismatch : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWatchdogReset : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogReset : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBrownOut : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brownOut : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyEventTrapReset : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventTrapReset : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMotorDriverFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorDriverFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySSRPowerFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ssrPowerFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAuxPowerFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySMCPowerFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}smcPowerFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyILCFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBroadcastCounterWarning : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}broadcastCounterWarning : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointMonitorWarning_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointMonitorWarning_start}
    ${hardpointMonitorWarning_end}=    Evaluate    ${end}+${1}
    ${hardpointMonitorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorWarning_start}    end=${hardpointMonitorWarning_end}
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMajorFault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorFault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMinorFault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorFault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFaultOverride : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultOverride : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyInstrumentError : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}instrumentError : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineError : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineError : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineBootloaderActive : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineBootloaderActive : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyUniqueIdCRCError : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uniqueIdCRCError : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationTypeMismatch : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationTypeMismatch : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationMissing : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationMissing : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationCRCMismatch : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationCRCMismatch : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWireMissing : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWireMissing : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire1Mismatch : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire1Mismatch : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire2Mismatch : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire2Mismatch : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWatchdogReset : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogReset : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBrownOut : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brownOut : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyEventTrapReset : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventTrapReset : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySSRPowerFault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ssrPowerFault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAuxPowerFault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerFault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineS1AInterface1Fault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineS1AInterface1Fault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineS1ALVDT1Fault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineS1ALVDT1Fault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineS1AInterface2Fault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineS1AInterface2Fault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineS1ALVDT2Fault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineS1ALVDT2Fault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineUniqueIdCRCError : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineUniqueIdCRCError : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineEventTrapReset : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineEventTrapReset : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineDCPRS422ChipFault : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineDCPRS422ChipFault : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineApplicationMissing : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineApplicationMissing : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineApplicationCRCMismatch : 1    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineApplicationCRCMismatch : 0    1
    Should Contain X Times    ${hardpointMonitorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorState_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointActuatorState_start}
    ${hardpointActuatorState_end}=    Evaluate    ${end}+${1}
    ${hardpointActuatorState_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorState_start}    end=${hardpointActuatorState_end}
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionState : 0    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointMonitorState_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointMonitorState_start}
    ${hardpointMonitorState_end}=    Evaluate    ${end}+${1}
    ${hardpointMonitorState_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorState_start}    end=${hardpointMonitorState_end}
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorWarning_start}=    Get Index From List    ${full_list}    === Event forceActuatorWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorWarning_start}
    ${forceActuatorWarning_end}=    Evaluate    ${end}+${1}
    ${forceActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${forceActuatorWarning_start}    end=${forceActuatorWarning_end}
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMajorFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMinorFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFaultOverride : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultOverride : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMainCalibrationError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCalibrationError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBackupCalibrationError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backupCalibrationError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineBootloaderActive : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineBootloaderActive : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyUniqueIdCRCError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uniqueIdCRCError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationTypeMismatch : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationTypeMismatch : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationMissing : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationMissing : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationCRCMismatch : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationCRCMismatch : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWireMissing : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWireMissing : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire1Mismatch : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire1Mismatch : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire2Mismatch : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire2Mismatch : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWatchdogReset : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogReset : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBrownOut : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brownOut : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyEventTrapReset : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventTrapReset : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySSRPowerFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ssrPowerFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAuxPowerFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzaninePowerFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzaninePowerFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineCurrentAmp1Fault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineCurrentAmp1Fault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineCurrentAmp2Fault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineCurrentAmp2Fault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineUniqueIdCRCError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineUniqueIdCRCError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineMainCalibrationError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineMainCalibrationError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineBackupCalibrationError : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineBackupCalibrationError : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineEventTrapReset : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineEventTrapReset : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineApplicationMissing : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineApplicationMissing : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMezzanineApplicationCRCMismatch : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mezzanineApplicationCRCMismatch : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyILCFault : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBroadcastCounterWarning : 1    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}broadcastCounterWarning : 0    1
    Should Contain X Times    ${forceActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedStaticForces_start}=    Get Index From List    ${full_list}    === Event preclippedStaticForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedStaticForces_start}
    ${preclippedStaticForces_end}=    Evaluate    ${end}+${1}
    ${preclippedStaticForces_list}=    Get Slice From List    ${full_list}    start=${preclippedStaticForces_start}    end=${preclippedStaticForces_end}
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedStaticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedElevationForces_start}=    Get Index From List    ${full_list}    === Event preclippedElevationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedElevationForces_start}
    ${preclippedElevationForces_end}=    Evaluate    ${end}+${1}
    ${preclippedElevationForces_list}=    Get Slice From List    ${full_list}    start=${preclippedElevationForces_start}    end=${preclippedElevationForces_end}
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedAzimuthForces_start}=    Get Index From List    ${full_list}    === Event preclippedAzimuthForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedAzimuthForces_start}
    ${preclippedAzimuthForces_end}=    Evaluate    ${end}+${1}
    ${preclippedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${preclippedAzimuthForces_start}    end=${preclippedAzimuthForces_end}
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedThermalForces_start}=    Get Index From List    ${full_list}    === Event preclippedThermalForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedThermalForces_start}
    ${preclippedThermalForces_end}=    Evaluate    ${end}+${1}
    ${preclippedThermalForces_list}=    Get Slice From List    ${full_list}    start=${preclippedThermalForces_start}    end=${preclippedThermalForces_end}
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedActiveOpticForces_start}=    Get Index From List    ${full_list}    === Event preclippedActiveOpticForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedActiveOpticForces_start}
    ${preclippedActiveOpticForces_end}=    Evaluate    ${end}+${1}
    ${preclippedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${preclippedActiveOpticForces_start}    end=${preclippedActiveOpticForces_end}
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedAberrationForces_start}=    Get Index From List    ${full_list}    === Event preclippedAberrationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedAberrationForces_start}
    ${preclippedAberrationForces_end}=    Evaluate    ${end}+${1}
    ${preclippedAberrationForces_list}=    Get Slice From List    ${full_list}    start=${preclippedAberrationForces_start}    end=${preclippedAberrationForces_end}
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedAberrationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedBalanceForces_start}=    Get Index From List    ${full_list}    === Event preclippedBalanceForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedBalanceForces_start}
    ${preclippedBalanceForces_end}=    Evaluate    ${end}+${1}
    ${preclippedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${preclippedBalanceForces_start}    end=${preclippedBalanceForces_end}
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedVelocityForces_start}=    Get Index From List    ${full_list}    === Event preclippedVelocityForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedVelocityForces_start}
    ${preclippedVelocityForces_end}=    Evaluate    ${end}+${1}
    ${preclippedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${preclippedVelocityForces_start}    end=${preclippedVelocityForces_end}
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedAccelerationForces_start}=    Get Index From List    ${full_list}    === Event preclippedAccelerationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedAccelerationForces_start}
    ${preclippedAccelerationForces_end}=    Evaluate    ${end}+${1}
    ${preclippedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${preclippedAccelerationForces_start}    end=${preclippedAccelerationForces_end}
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedOffsetForces_start}=    Get Index From List    ${full_list}    === Event preclippedOffsetForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedOffsetForces_start}
    ${preclippedOffsetForces_end}=    Evaluate    ${end}+${1}
    ${preclippedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${preclippedOffsetForces_start}    end=${preclippedOffsetForces_end}
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedForces_start}=    Get Index From List    ${full_list}    === Event preclippedForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedForces_start}
    ${preclippedForces_end}=    Evaluate    ${end}+${1}
    ${preclippedForces_list}=    Get Slice From List    ${full_list}    start=${preclippedForces_start}    end=${preclippedForces_end}
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${preclippedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedElevationForces_start}=    Get Index From List    ${full_list}    === Event appliedElevationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedElevationForces_start}
    ${appliedElevationForces_end}=    Evaluate    ${end}+${1}
    ${appliedElevationForces_list}=    Get Slice From List    ${full_list}    start=${appliedElevationForces_start}    end=${appliedElevationForces_end}
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedAccelerationForces_start}=    Get Index From List    ${full_list}    === Event appliedAccelerationForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedAccelerationForces_start}
    ${appliedAccelerationForces_end}=    Evaluate    ${end}+${1}
    ${appliedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${appliedAccelerationForces_start}    end=${appliedAccelerationForces_end}
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedThermalForces_start}=    Get Index From List    ${full_list}    === Event appliedThermalForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedThermalForces_start}
    ${appliedThermalForces_end}=    Evaluate    ${end}+${1}
    ${appliedThermalForces_list}=    Get Slice From List    ${full_list}    start=${appliedThermalForces_start}    end=${appliedThermalForces_end}
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedVelocityForces_start}=    Get Index From List    ${full_list}    === Event appliedVelocityForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedVelocityForces_start}
    ${appliedVelocityForces_end}=    Evaluate    ${end}+${1}
    ${appliedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${appliedVelocityForces_start}    end=${appliedVelocityForces_end}
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedBalanceForces_start}=    Get Index From List    ${full_list}    === Event appliedBalanceForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedBalanceForces_start}
    ${appliedBalanceForces_end}=    Evaluate    ${end}+${1}
    ${appliedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${appliedBalanceForces_start}    end=${appliedBalanceForces_end}
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedForces_start}=    Get Index From List    ${full_list}    === Event appliedForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedForces_start}
    ${appliedForces_end}=    Evaluate    ${end}+${1}
    ${appliedForces_list}=    Get Slice From List    ${full_list}    start=${appliedForces_start}    end=${appliedForces_end}
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${preclippedCylinderForces_start}=    Get Index From List    ${full_list}    === Event preclippedCylinderForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${preclippedCylinderForces_start}
    ${preclippedCylinderForces_end}=    Evaluate    ${end}+${1}
    ${preclippedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${preclippedCylinderForces_start}    end=${preclippedCylinderForces_end}
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedCylinderForces_start}=    Get Index From List    ${full_list}    === Event appliedCylinderForces received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedCylinderForces_start}
    ${appliedCylinderForces_end}=    Evaluate    ${end}+${1}
    ${appliedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${appliedCylinderForces_start}    end=${appliedCylinderForces_end}
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${modbusResponse_start}=    Get Index From List    ${full_list}    === Event modbusResponse received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${modbusResponse_start}
    ${modbusResponse_end}=    Evaluate    ${end}+${1}
    ${modbusResponse_list}=    Get Slice From List    ${full_list}    start=${modbusResponse_start}    end=${modbusResponse_end}
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseValid : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}address : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionCode : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataLength : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}crc : 1    1
    Should Contain X Times    ${modbusResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorBumpTestStatus_start}=    Get Index From List    ${full_list}    === Event forceActuatorBumpTestStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorBumpTestStatus_start}
    ${forceActuatorBumpTestStatus_end}=    Evaluate    ${end}+${1}
    ${forceActuatorBumpTestStatus_list}=    Get Slice From List    ${full_list}    start=${forceActuatorBumpTestStatus_start}    end=${forceActuatorBumpTestStatus_end}
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryTestTimestamps : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryTest : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryTestTimestamps : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryTest : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${enabledForceActuators_start}=    Get Index From List    ${full_list}    === Event enabledForceActuators received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${enabledForceActuators_start}
    ${enabledForceActuators_end}=    Evaluate    ${end}+${1}
    ${enabledForceActuators_list}=    Get Slice From List    ${full_list}    start=${enabledForceActuators_start}    end=${enabledForceActuators_end}
    Should Contain X Times    ${enabledForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${enabledForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceActuatorEnabled : 0    1
    Should Contain X Times    ${enabledForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceActuatorSettings_start}=    Get Index From List    ${full_list}    === Event forceActuatorSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceActuatorSettings_start}
    ${forceActuatorSettings_end}=    Evaluate    ${end}+${1}
    ${forceActuatorSettings_list}=    Get Slice From List    ${full_list}    start=${forceActuatorSettings_start}    end=${forceActuatorSettings_end}
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}netAberrationForceTolerance : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}netActiveOpticForceTolerance : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabledActuators : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}useInclinometer : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorXMoment : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorYMoment : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorZMoment : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointXMomentLowLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointXMomentHighLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointYMomentLowLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointYMomentHighLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointZMomentLowLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointZMomentHighLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointNearNeighborLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointMirrorWeightLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointFarNeighborLimitFactor : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorCenterOfGravityX : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorCenterOfGravityY : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorCenterOfGravityZ : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseIncrementPercentage : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerDecrementPercentage : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseLowerFollowingErrorLimit : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bumpTestSettleTime : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bumpTestMeasurements : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointActuatorSettings_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointActuatorSettings_start}
    ${hardpointActuatorSettings_end}=    Evaluate    ${end}+${1}
    ${hardpointActuatorSettings_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorSettings_start}    end=${hardpointActuatorSettings_end}
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}micrometersPerStep : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}micrometersPerEncoder : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFaultHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFaultLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFSBWarningHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFSBWarningLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceWarningHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceWarningLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureWarningHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureWarningLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${displacementSensorSettings_start}=    Get Index From List    ${full_list}    === Event displacementSensorSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${displacementSensorSettings_start}
    ${displacementSensorSettings_end}=    Evaluate    ${end}+${1}
    ${displacementSensorSettings_list}=    Get Slice From List    ${full_list}    start=${displacementSensorSettings_start}    end=${displacementSensorSettings_end}
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotationOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotationOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotationOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pidSettings_start}=    Get Index From List    ${full_list}    === Event pidSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pidSettings_start}
    ${pidSettings_end}=    Evaluate    ${end}+${1}
    ${pidSettings_list}=    Get Slice From List    ${full_list}    start=${pidSettings_start}    end=${pidSettings_end}
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestep : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}d : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}n : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accelerometerSettings_start}=    Get Index From List    ${full_list}    === Event accelerometerSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${accelerometerSettings_start}
    ${accelerometerSettings_end}=    Evaluate    ${end}+${1}
    ${accelerometerSettings_list}=    Get Slice From List    ${full_list}    start=${accelerometerSettings_start}    end=${accelerometerSettings_end}
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationDistance : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensitivity : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometerOffset : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scalar : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsFaultLow : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsWarningLow : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsWarningHigh : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsFaultHigh : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${gyroSettings_start}=    Get Index From List    ${full_list}    === Event gyroSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${gyroSettings_start}
    ${gyroSettings_end}=    Evaluate    ${end}+${1}
    ${gyroSettings_list}=    Get Slice From List    ${full_list}    start=${gyroSettings_start}    end=${gyroSettings_end}
    Should Contain X Times    ${gyroSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataRate : 1    1
    Should Contain X Times    ${gyroSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularVelocityOffset : 0    1
    Should Contain X Times    ${gyroSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inclinometerSettings_start}=    Get Index From List    ${full_list}    === Event inclinometerSettings received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inclinometerSettings_start}
    ${inclinometerSettings_end}=    Evaluate    ${end}+${1}
    ${inclinometerSettings_list}=    Get Slice From List    ${full_list}    start=${inclinometerSettings_start}    end=${inclinometerSettings_end}
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerOffset : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultLow : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warningLow : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warningHigh : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultHigh : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === Event appliedSettingsMatchStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedSettingsMatchStart_start}
    ${appliedSettingsMatchStart_end}=    Evaluate    ${end}+${1}
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logMessage_start}
    ${logMessage_end}=    Evaluate    ${end}+${1}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === Event settingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsApplied_start}
    ${settingsApplied_end}=    Evaluate    ${end}+${1}
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsVersion : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherSettingsEvents : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersions_start}
    ${softwareVersions_end}=    Evaluate    ${end}+${1}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${authList_start}
    ${authList_end}=    Evaluate    ${end}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === Event largeFileObjectAvailable received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${largeFileObjectAvailable_start}
    ${largeFileObjectAvailable_end}=    Evaluate    ${end}+${1}
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end}
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generator : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byteSize : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}checkSum : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mimeType : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
