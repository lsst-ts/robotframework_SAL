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
    Should Be Equal    ${output.returncode}   ${NONE}
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
    Comment    ======= Verify ${subSystem}_raisingLoweringInfo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_raisingLoweringInfo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event raisingLoweringInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_raisingLoweringInfo_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event raisingLoweringInfo generated =
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
    Comment    ======= Verify ${subSystem}_forceActuatorFollowingErrorCounter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorFollowingErrorCounter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorFollowingErrorCounter iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorFollowingErrorCounter_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorFollowingErrorCounter generated =
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
    Comment    ======= Verify ${subSystem}_preclippedBalanceForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedBalanceForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedBalanceForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedBalanceForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedBalanceForces generated =
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
    Comment    ======= Verify ${subSystem}_preclippedCylinderForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_preclippedCylinderForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event preclippedCylinderForces iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_preclippedCylinderForces_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event preclippedCylinderForces generated =
    Comment    ======= Verify ${subSystem}_forceActuatorBumpTestStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceActuatorBumpTestStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceActuatorBumpTestStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceActuatorBumpTestStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceActuatorBumpTestStatus generated =
    Comment    ======= Verify ${subSystem}_hardpointTestStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointTestStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointTestStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointTestStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointTestStatus generated =
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
    Comment    ======= Verify ${subSystem}_positionControllerSettings test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_positionControllerSettings
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event positionControllerSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_positionControllerSettings_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event positionControllerSettings generated =
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
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
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
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_configurationApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_configurationApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event configurationApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_configurationApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event configurationApplied generated =
    Comment    ======= Verify ${subSystem}_configurationsAvailable test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_configurationsAvailable
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event configurationsAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_configurationsAvailable_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event configurationsAvailable generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Evaluate    ${detailedState_start}+${3}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    ${hardpointActuatorInfo_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorInfo received =${SPACE}
    ${end}=    Evaluate    ${hardpointActuatorInfo_start}+${23}
    ${hardpointActuatorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorInfo_start}    end=${end}
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
    ${forceActuatorInfo_start}=    Get Index From List    ${full_list}    === Event forceActuatorInfo received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorInfo_start}+${39}
    ${forceActuatorInfo_list}=    Get Slice From List    ${full_list}    start=${forceActuatorInfo_start}    end=${end}
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
    ${ilcWarning_start}=    Get Index From List    ${full_list}    === Event ilcWarning received =${SPACE}
    ${end}=    Evaluate    ${ilcWarning_start}+${13}
    ${ilcWarning_list}=    Get Slice From List    ${full_list}    start=${ilcWarning_start}    end=${end}
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
    ${interlockWarning_start}=    Get Index From List    ${full_list}    === Event interlockWarning received =${SPACE}
    ${end}=    Evaluate    ${interlockWarning_start}+${10}
    ${interlockWarning_list}=    Get Slice From List    ${full_list}    start=${interlockWarning_start}    end=${end}
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatStateOutputMismatch : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerNetworksOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermalEquipmentOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airSupplyOff : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tmaMotionStop : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gisHeartbeatLost : 1    1
    Should Contain X Times    ${interlockWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetDoorOpen : 1    1
    ${airSupplyStatus_start}=    Get Index From List    ${full_list}    === Event airSupplyStatus received =${SPACE}
    ${end}=    Evaluate    ${airSupplyStatus_start}+${6}
    ${airSupplyStatus_list}=    Get Slice From List    ${full_list}    start=${airSupplyStatus_start}    end=${end}
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airCommandedOn : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airCommandOutputOn : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveOpened : 1    1
    Should Contain X Times    ${airSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airValveClosed : 1    1
    ${airSupplyWarning_start}=    Get Index From List    ${full_list}    === Event airSupplyWarning received =${SPACE}
    ${end}=    Evaluate    ${airSupplyWarning_start}+${5}
    ${airSupplyWarning_list}=    Get Slice From List    ${full_list}    start=${airSupplyWarning_start}    end=${end}
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandOutputMismatch : 1    1
    Should Contain X Times    ${airSupplyWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandSensorMismatch : 1    1
    ${interlockStatus_start}=    Get Index From List    ${full_list}    === Event interlockStatus received =${SPACE}
    ${end}=    Evaluate    ${interlockStatus_start}+${4}
    ${interlockStatus_list}=    Get Slice From List    ${full_list}    start=${interlockStatus_start}    end=${end}
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatCommandedState : 1    1
    Should Contain X Times    ${interlockStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeatOutputState : 1    1
    ${displacementSensorWarning_start}=    Get Index From List    ${full_list}    === Event displacementSensorWarning received =${SPACE}
    ${end}=    Evaluate    ${displacementSensorWarning_start}+${17}
    ${displacementSensorWarning_list}=    Get Slice From List    ${full_list}    start=${displacementSensorWarning_start}    end=${end}
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
    ${inclinometerSensorWarning_start}=    Get Index From List    ${full_list}    === Event inclinometerSensorWarning received =${SPACE}
    ${end}=    Evaluate    ${inclinometerSensorWarning_start}+${11}
    ${inclinometerSensorWarning_list}=    Get Slice From List    ${full_list}    start=${inclinometerSensorWarning_start}    end=${end}
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
    ${accelerometerWarning_start}=    Get Index From List    ${full_list}    === Event accelerometerWarning received =${SPACE}
    ${end}=    Evaluate    ${accelerometerWarning_start}+${4}
    ${accelerometerWarning_list}=    Get Slice From List    ${full_list}    start=${accelerometerWarning_start}    end=${end}
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${accelerometerWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}responseTimeout : 1    1
    ${forceSetpointWarning_start}=    Get Index From List    ${full_list}    === Event forceSetpointWarning received =${SPACE}
    ${end}=    Evaluate    ${forceSetpointWarning_start}+${34}
    ${forceSetpointWarning_list}=    Get Slice From List    ${full_list}    start=${forceSetpointWarning_start}    end=${end}
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
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOffsetForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyVelocityForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityForceWarning : 0    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyForceWarning : 1    1
    Should Contain X Times    ${forceSetpointWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceWarning : 0    1
    ${raisingLoweringInfo_start}=    Get Index From List    ${full_list}    === Event raisingLoweringInfo received =${SPACE}
    ${end}=    Evaluate    ${raisingLoweringInfo_start}+${7}
    ${raisingLoweringInfo_list}=    Get Slice From List    ${full_list}    start=${raisingLoweringInfo_start}    end=${end}
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}weightSupportedPercent : 1    1
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waitAirPressure : 1    1
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waitHardpoint : 0    1
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waitZForceActuator : 0    1
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waitYForceActuator : 0    1
    Should Contain X Times    ${raisingLoweringInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waitXForceActuator : 0    1
    ${forceActuatorState_start}=    Get Index From List    ${full_list}    === Event forceActuatorState received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorState_start}+${13}
    ${forceActuatorState_list}=    Get Slice From List    ${full_list}    start=${forceActuatorState_start}    end=${end}
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
    Should Contain X Times    ${forceActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}balanceForcesApplied : 1    1
    ${hardpointMonitorInfo_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorInfo received =${SPACE}
    ${end}=    Evaluate    ${hardpointMonitorInfo_start}+${14}
    ${hardpointMonitorInfo_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorInfo_start}    end=${end}
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
    ${cellLightStatus_start}=    Get Index From List    ${full_list}    === Event cellLightStatus received =${SPACE}
    ${end}=    Evaluate    ${cellLightStatus_start}+${5}
    ${cellLightStatus_list}=    Get Slice From List    ${full_list}    start=${cellLightStatus_start}    end=${end}
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsCommandedOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOutputOn : 1    1
    Should Contain X Times    ${cellLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOn : 1    1
    ${cellLightWarning_start}=    Get Index From List    ${full_list}    === Event cellLightWarning received =${SPACE}
    ${end}=    Evaluate    ${cellLightWarning_start}+${5}
    ${cellLightWarning_list}=    Get Slice From List    ${full_list}    start=${cellLightWarning_start}    end=${end}
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsOutputMismatch : 1    1
    Should Contain X Times    ${cellLightWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cellLightsSensorMismatch : 1    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === Event powerStatus received =${SPACE}
    ${end}=    Evaluate    ${powerStatus_start}+${18}
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${end}
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
    ${powerWarning_start}=    Get Index From List    ${full_list}    === Event powerWarning received =${SPACE}
    ${end}=    Evaluate    ${powerWarning_start}+${11}
    ${powerWarning_list}=    Get Slice From List    ${full_list}    start=${powerWarning_start}    end=${end}
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
    ${forceActuatorForceWarning_start}=    Get Index From List    ${full_list}    === Event forceActuatorForceWarning received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorForceWarning_start}+${20}
    ${forceActuatorForceWarning_list}=    Get Slice From List    ${full_list}    start=${forceActuatorForceWarning_start}    end=${end}
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFault : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisMeasuredForceWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisMeasuredForceWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisMeasuredForceWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisMeasuredForceWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisFollowingErrorWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisFollowingErrorWarning : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorWarning : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisFollowingErrorCountingFault : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorCountingFault : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisFollowingErrorCountingFault : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorCountingFault : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyPrimaryAxisFollowingErrorImmediateFault : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorImmediateFault : 0    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySecondaryAxisFollowingErrorImmediateFault : 1    1
    Should Contain X Times    ${forceActuatorForceWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorImmediateFault : 0    1
    ${forceActuatorFollowingErrorCounter_start}=    Get Index From List    ${full_list}    === Event forceActuatorFollowingErrorCounter received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorFollowingErrorCounter_start}+${6}
    ${forceActuatorFollowingErrorCounter_list}=    Get Slice From List    ${full_list}    start=${forceActuatorFollowingErrorCounter_start}    end=${end}
    Should Contain X Times    ${forceActuatorFollowingErrorCounter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}counter : 1    1
    Should Contain X Times    ${forceActuatorFollowingErrorCounter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorWarningCounter : 0    1
    Should Contain X Times    ${forceActuatorFollowingErrorCounter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorWarningCounter : 0    1
    Should Contain X Times    ${forceActuatorFollowingErrorCounter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryAxisFollowingErrorCountingCounter : 0    1
    Should Contain X Times    ${forceActuatorFollowingErrorCounter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryAxisFollowingErrorCountingCounter : 0    1
    ${gyroWarning_start}=    Get Index From List    ${full_list}    === Event gyroWarning received =${SPACE}
    ${end}=    Evaluate    ${gyroWarning_start}+${60}
    ${gyroWarning_list}=    Get Slice From List    ${full_list}    start=${gyroWarning_start}    end=${end}
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
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXPZTTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYPZTTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZPZTTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroXSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroYSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroZSLDTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelXStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelYStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelZStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelXTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelYTemperatureStatusWarning : 1    1
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gyroAccelZTemperatureStatusWarning : 1    1
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
    Should Contain X Times    ${gyroWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v15StatusWarning : 1    1
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
    ${powerSupplyStatus_start}=    Get Index From List    ${full_list}    === Event powerSupplyStatus received =${SPACE}
    ${end}=    Evaluate    ${powerSupplyStatus_start}+${25}
    ${powerSupplyStatus_list}=    Get Slice From List    ${full_list}    start=${powerSupplyStatus_start}    end=${end}
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC1Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC2Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpMirrorCellUtility220VAC3Status : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpCabinetUtility220VACStatus : 1    1
    Should Contain X Times    ${powerSupplyStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcpExternalEquipment220VACStatus : 1    1
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
    ${appliedOffsetForces_start}=    Get Index From List    ${full_list}    === Event appliedOffsetForces received =${SPACE}
    ${end}=    Evaluate    ${appliedOffsetForces_start}+${12}
    ${appliedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${appliedOffsetForces_start}    end=${end}
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
    ${appliedStaticForces_start}=    Get Index From List    ${full_list}    === Event appliedStaticForces received =${SPACE}
    ${end}=    Evaluate    ${appliedStaticForces_start}+${12}
    ${appliedStaticForces_list}=    Get Slice From List    ${full_list}    start=${appliedStaticForces_start}    end=${end}
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
    ${appliedActiveOpticForces_start}=    Get Index From List    ${full_list}    === Event appliedActiveOpticForces received =${SPACE}
    ${end}=    Evaluate    ${appliedActiveOpticForces_start}+${6}
    ${appliedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${appliedActiveOpticForces_start}    end=${end}
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${appliedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    ${commandRejectionWarning_start}=    Get Index From List    ${full_list}    === Event commandRejectionWarning received =${SPACE}
    ${end}=    Evaluate    ${commandRejectionWarning_start}+${4}
    ${commandRejectionWarning_list}=    Get Slice From List    ${full_list}    start=${commandRejectionWarning_start}    end=${end}
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}command : RO    1
    Should Contain X Times    ${commandRejectionWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reason : RO    1
    ${pidInfo_start}=    Get Index From List    ${full_list}    === Event pidInfo received =${SPACE}
    ${end}=    Evaluate    ${pidInfo_start}+${12}
    ${pidInfo_list}=    Get Slice From List    ${full_list}    start=${pidInfo_start}    end=${end}
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
    ${hardpointActuatorWarning_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorWarning received =${SPACE}
    ${end}=    Evaluate    ${hardpointActuatorWarning_start}+${57}
    ${hardpointActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorWarning_start}    end=${end}
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
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyLowProximityWarning : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowProximityWarning : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyHighProximityWarning : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}highProximityWarning : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyLowAirPressureFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowAirPressureFault : 0    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyHighAirPressureFault : 1    1
    Should Contain X Times    ${hardpointActuatorWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}highAirPressureFault : 0    1
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
    ${hardpointMonitorWarning_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorWarning received =${SPACE}
    ${end}=    Evaluate    ${hardpointMonitorWarning_start}+${57}
    ${hardpointMonitorWarning_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorWarning_start}    end=${end}
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
    ${hardpointActuatorState_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorState received =${SPACE}
    ${end}=    Evaluate    ${hardpointActuatorState_start}+${4}
    ${hardpointActuatorState_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorState_start}    end=${end}
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    Should Contain X Times    ${hardpointActuatorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionState : 0    1
    ${hardpointMonitorState_start}=    Get Index From List    ${full_list}    === Event hardpointMonitorState received =${SPACE}
    ${end}=    Evaluate    ${hardpointMonitorState_start}+${3}
    ${hardpointMonitorState_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorState_start}    end=${end}
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${hardpointMonitorState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcState : 0    1
    ${forceActuatorWarning_start}=    Get Index From List    ${full_list}    === Event forceActuatorWarning received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorWarning_start}+${63}
    ${forceActuatorWarning_list}=    Get Slice From List    ${full_list}    start=${forceActuatorWarning_start}    end=${end}
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
    ${preclippedStaticForces_start}=    Get Index From List    ${full_list}    === Event preclippedStaticForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedStaticForces_start}+${12}
    ${preclippedStaticForces_list}=    Get Slice From List    ${full_list}    start=${preclippedStaticForces_start}    end=${end}
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
    ${preclippedElevationForces_start}=    Get Index From List    ${full_list}    === Event preclippedElevationForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedElevationForces_start}+${12}
    ${preclippedElevationForces_list}=    Get Slice From List    ${full_list}    start=${preclippedElevationForces_start}    end=${end}
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
    ${preclippedAzimuthForces_start}=    Get Index From List    ${full_list}    === Event preclippedAzimuthForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedAzimuthForces_start}+${12}
    ${preclippedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${preclippedAzimuthForces_start}    end=${end}
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
    ${preclippedThermalForces_start}=    Get Index From List    ${full_list}    === Event preclippedThermalForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedThermalForces_start}+${12}
    ${preclippedThermalForces_list}=    Get Slice From List    ${full_list}    start=${preclippedThermalForces_start}    end=${end}
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
    ${preclippedActiveOpticForces_start}=    Get Index From List    ${full_list}    === Event preclippedActiveOpticForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedActiveOpticForces_start}+${6}
    ${preclippedActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${preclippedActiveOpticForces_start}    end=${end}
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    1
    Should Contain X Times    ${preclippedActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    1
    ${preclippedVelocityForces_start}=    Get Index From List    ${full_list}    === Event preclippedVelocityForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedVelocityForces_start}+${12}
    ${preclippedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${preclippedVelocityForces_start}    end=${end}
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
    ${preclippedAccelerationForces_start}=    Get Index From List    ${full_list}    === Event preclippedAccelerationForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedAccelerationForces_start}+${12}
    ${preclippedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${preclippedAccelerationForces_start}    end=${end}
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
    ${preclippedBalanceForces_start}=    Get Index From List    ${full_list}    === Event preclippedBalanceForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedBalanceForces_start}+${12}
    ${preclippedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${preclippedBalanceForces_start}    end=${end}
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
    ${preclippedOffsetForces_start}=    Get Index From List    ${full_list}    === Event preclippedOffsetForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedOffsetForces_start}+${12}
    ${preclippedOffsetForces_list}=    Get Slice From List    ${full_list}    start=${preclippedOffsetForces_start}    end=${end}
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
    ${preclippedForces_start}=    Get Index From List    ${full_list}    === Event preclippedForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedForces_start}+${12}
    ${preclippedForces_list}=    Get Slice From List    ${full_list}    start=${preclippedForces_start}    end=${end}
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
    ${preclippedCylinderForces_start}=    Get Index From List    ${full_list}    === Event preclippedCylinderForces received =${SPACE}
    ${end}=    Evaluate    ${preclippedCylinderForces_start}+${4}
    ${preclippedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${preclippedCylinderForces_start}    end=${end}
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${preclippedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    ${forceActuatorBumpTestStatus_start}=    Get Index From List    ${full_list}    === Event forceActuatorBumpTestStatus received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorBumpTestStatus_start}+${7}
    ${forceActuatorBumpTestStatus_list}=    Get Slice From List    ${full_list}    start=${forceActuatorBumpTestStatus_start}    end=${end}
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryTestTimestamps : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryTest : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryTestTimestamps : 0    1
    Should Contain X Times    ${forceActuatorBumpTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryTest : 0    1
    ${hardpointTestStatus_start}=    Get Index From List    ${full_list}    === Event hardpointTestStatus received =${SPACE}
    ${end}=    Evaluate    ${hardpointTestStatus_start}+${2}
    ${hardpointTestStatus_list}=    Get Slice From List    ${full_list}    start=${hardpointTestStatus_start}    end=${end}
    Should Contain X Times    ${hardpointTestStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testState : 0    1
    ${enabledForceActuators_start}=    Get Index From List    ${full_list}    === Event enabledForceActuators received =${SPACE}
    ${end}=    Evaluate    ${enabledForceActuators_start}+${3}
    ${enabledForceActuators_list}=    Get Slice From List    ${full_list}    start=${enabledForceActuators_start}    end=${end}
    Should Contain X Times    ${enabledForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${enabledForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceActuatorEnabled : 0    1
    ${forceActuatorSettings_start}=    Get Index From List    ${full_list}    === Event forceActuatorSettings received =${SPACE}
    ${end}=    Evaluate    ${forceActuatorSettings_start}+${35}
    ${forceActuatorSettings_list}=    Get Slice From List    ${full_list}    start=${forceActuatorSettings_start}    end=${end}
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}netActiveOpticForceTolerance : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabledActuators : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderMeasuredForceLowLimit : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderMeasuredForceHighLimit : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderMeasuredForceLowLimit : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderMeasuredForceHighLimit : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredWarningPercentage : 1    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryFollowingErrorWarningThreshold : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryFollowingErrorCountingFaultThreshold : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryFollowingErrorImmediateFaultThreshold : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryFollowingErrorWarningThreshold : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryFollowingErrorCountingFaultThreshold : 0    1
    Should Contain X Times    ${forceActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryFollowingErrorImmediateFaultThreshold : 0    1
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
    ${hardpointActuatorSettings_start}=    Get Index From List    ${full_list}    === Event hardpointActuatorSettings received =${SPACE}
    ${end}=    Evaluate    ${hardpointActuatorSettings_start}+${15}
    ${hardpointActuatorSettings_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorSettings_start}    end=${end}
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}micrometersPerStep : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}micrometersPerEncoder : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFaultHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFaultLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFSBWarningHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceFSBWarningLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceWarningHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointMeasuredForceWarningLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureFaultHigh : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureFaultLow : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airPressureFaultLowRaising : 1    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderOffset : 0    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowProximityEncoder : 0    1
    Should Contain X Times    ${hardpointActuatorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}highProximityEncoder : 0    1
    ${positionControllerSettings_start}=    Get Index From List    ${full_list}    === Event positionControllerSettings received =${SPACE}
    ${end}=    Evaluate    ${positionControllerSettings_start}+${14}
    ${positionControllerSettings_list}=    Get Slice From List    ${full_list}    start=${positionControllerSettings_start}    end=${end}
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceToStepsCoefficient : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderToStepsCoefficient : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxStepsPerLoop : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseHPForceLimitLow : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseHPForceLimitHigh : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseHPForceMargin : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raiseTimeout : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerHPForceLimitLow : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerHPForceLimitHigh : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerHPForceMargin : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerTimeout : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowerPositionOffset : 1    1
    Should Contain X Times    ${positionControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referencePosition : 0    1
    ${displacementSensorSettings_start}=    Get Index From List    ${full_list}    === Event displacementSensorSettings received =${SPACE}
    ${end}=    Evaluate    ${displacementSensorSettings_start}+${7}
    ${displacementSensorSettings_list}=    Get Slice From List    ${full_list}    start=${displacementSensorSettings_start}    end=${end}
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPositionOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotationOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotationOffset : 1    1
    Should Contain X Times    ${displacementSensorSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotationOffset : 1    1
    ${pidSettings_start}=    Get Index From List    ${full_list}    === Event pidSettings received =${SPACE}
    ${end}=    Evaluate    ${pidSettings_start}+${6}
    ${pidSettings_list}=    Get Slice From List    ${full_list}    start=${pidSettings_start}    end=${end}
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestep : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}d : 0    1
    Should Contain X Times    ${pidSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}n : 0    1
    ${accelerometerSettings_start}=    Get Index From List    ${full_list}    === Event accelerometerSettings received =${SPACE}
    ${end}=    Evaluate    ${accelerometerSettings_start}+${10}
    ${accelerometerSettings_list}=    Get Slice From List    ${full_list}    start=${accelerometerSettings_start}    end=${end}
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationDistance : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bias : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensitivity : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometerOffset : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scalar : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsFaultLow : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsWarningLow : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsWarningHigh : 0    1
    Should Contain X Times    ${accelerometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}limitsFaultHigh : 0    1
    ${gyroSettings_start}=    Get Index From List    ${full_list}    === Event gyroSettings received =${SPACE}
    ${end}=    Evaluate    ${gyroSettings_start}+${3}
    ${gyroSettings_list}=    Get Slice From List    ${full_list}    start=${gyroSettings_start}    end=${end}
    Should Contain X Times    ${gyroSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataRate : 1    1
    Should Contain X Times    ${gyroSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularVelocityOffset : 0    1
    ${inclinometerSettings_start}=    Get Index From List    ${full_list}    === Event inclinometerSettings received =${SPACE}
    ${end}=    Evaluate    ${inclinometerSettings_start}+${6}
    ${inclinometerSettings_list}=    Get Slice From List    ${full_list}    start=${inclinometerSettings_start}    end=${end}
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerOffset : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultLow : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warningLow : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warningHigh : 1    1
    Should Contain X Times    ${inclinometerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultHigh : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${3}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${10}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${6}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Evaluate    ${authList_start}+${3}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${4}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${2}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${2}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === Event configurationApplied received =${SPACE}
    ${end}=    Evaluate    ${configurationApplied_start}+${6}
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${end}
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurations : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherInfo : RO    1
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === Event configurationsAvailable received =${SPACE}
    ${end}=    Evaluate    ${configurationsAvailable_start}+${5}
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${end}
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overrides : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
