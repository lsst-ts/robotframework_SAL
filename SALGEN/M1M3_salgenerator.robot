*** Settings ***
Documentation    This suite builds the various interfaces for the M1M3.
Force Tags    salgen    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    m1m3
${timeout}    1200s

*** Test Cases ***
Verify M1M3 XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3_Commands.xml
    File Should Exist    ${SALWorkDir}/m1m3_Events.xml
    File Should Exist    ${SALWorkDir}/m1m3_Telemetry.xml

Salgen M1M3 Validate
    [Documentation]    Validate the M1M3 XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ForceActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_InclinometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OuterLoopData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AccelerometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_HardpointActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_IMSData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_GyroData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_PowerSupplyData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_PIDData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_HardpointMonitorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_RaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_AbortRaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_LowerM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_EnterEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ExitEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnAirOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnAirOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestAir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_MoveHardpointActuators.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_StopHardpointMotion.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestHardpoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_EnableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_DisableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestForceActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Shutdown.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TranslateM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ClearOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAberrationForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ClearAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyActiveOpticForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ClearActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_PositionM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnLightsOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnLightsOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnPowerOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TurnPowerOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_EnableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_DisableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_RunMirrorForceProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_AbortProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyOffsetForcesByMirrorForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_UpdatePID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ResetPID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_SetThermalSetpoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ErrorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SettingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_DetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SummaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ILCWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_InterlockWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AirSupplyStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AirSupplyWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_InterlockStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_DisplacementSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_InclinometerSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AccelerometerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceSetpointWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointMonitorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_CellLightStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_CellLightWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_PowerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_PowerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorForceWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_GyroWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_PowerSupplyStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_CommandRejectionWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_PIDInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointMonitorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointMonitorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedVelocityForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedVelocityForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RejectedCylinderForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedCylinderForces.idl

Salgen M1M3 HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m1m3_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m1m3_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m1m3_Telemetry.html

Salgen M1M3 C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ForceActuatorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_InclinometerData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_OuterLoopData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AccelerometerData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_HardpointActuatorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_IMSData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_GyroData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_PowerSupplyData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_PIDData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_HardpointMonitorData.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    10
    Should Contain X Times    ${output}    cpp : Done Subscriber    10
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify M1M3 Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_InclinometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OuterLoopData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AccelerometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_HardpointActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_IMSData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_GyroData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_PowerSupplyData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_PIDData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_HardpointMonitorData

Verify M1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_InclinometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_InclinometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_OuterLoopData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OuterLoopData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AccelerometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AccelerometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_IMSData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_IMSData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_GyroData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_GyroData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_PowerSupplyData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_PowerSupplyData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_PIDData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_PIDData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointMonitorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointMonitorData/cpp/standalone/sacpp_${subSystem}_sub

Verify M1M3 C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller

Verify M1M3 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortRaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortRaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnterEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnterEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ExitEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ExitEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnAirOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnAirOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnAirOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnAirOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestAir_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestAir_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveHardpointActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveHardpointActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StopHardpointMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StopHardpointMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestHardpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestHardpoint_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Shutdown_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Shutdown_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TranslateM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TranslateM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyActiveOpticForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyActiveOpticForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PositionM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PositionM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnLightsOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnLightsOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnLightsOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnLightsOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnPowerOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnPowerOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnPowerOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TurnPowerOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RunMirrorForceProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RunMirrorForceProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyOffsetForcesByMirrorForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyOffsetForcesByMirrorForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_UpdatePID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_UpdatePID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ResetPID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ResetPID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SetThermalSetpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SetThermalSetpoint_controller

Verify M1M3 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ErrorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ErrorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SummaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SummaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ILCWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ILCWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InterlockWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InterlockWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirSupplyWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirSupplyWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InterlockStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InterlockStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisplacementSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DisplacementSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InclinometerSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_InclinometerSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AccelerometerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AccelerometerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceSetpointWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceSetpointWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellLightStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellLightStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellLightWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellLightWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorForceWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorForceWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_GyroWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_GyroWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PowerSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CommandRejectionWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CommandRejectionWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PIDInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PIDInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointMonitorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RejectedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedCylinderForces_log

Salgen M1M3 Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify M1M3 Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ForceActuatorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ForceActuatorData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_InclinometerData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_InclinometerData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OuterLoopData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OuterLoopData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AccelerometerData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AccelerometerData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointActuatorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointActuatorData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_IMSData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_IMSData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GyroData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GyroData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PowerSupplyData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PowerSupplyData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PIDData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PIDData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointMonitorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointMonitorData_Subscriber.py

Verify M1M3 Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    python
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py

Verify M1M3 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_RaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_RaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_AbortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_AbortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_LowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_LowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_EnterEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_EnterEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ExitEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ExitEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnAirOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnAirOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnAirOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnAirOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_MoveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_MoveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_StopHardpointMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_StopHardpointMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_EnableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_EnableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_DisableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_DisableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Shutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Shutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TranslateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TranslateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ClearOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ClearOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAberrationForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAberrationForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ClearAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ClearAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyActiveOpticForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyActiveOpticForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ClearActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ClearActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_PositionM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_PositionM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnLightsOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnLightsOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnLightsOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnLightsOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnPowerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnPowerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TurnPowerOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TurnPowerOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_EnableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_EnableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_DisableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_DisableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_RunMirrorForceProfile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_RunMirrorForceProfile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_AbortProfile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_AbortProfile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyOffsetForcesByMirrorForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyOffsetForcesByMirrorForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_UpdatePID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_UpdatePID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ResetPID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ResetPID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_SetThermalSetpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_SetThermalSetpoint.py

Verify M1M3 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SettingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SettingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SettingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SettingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ILCWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ILCWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_InterlockWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_InterlockWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AirSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AirSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AirSupplyWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AirSupplyWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_InterlockStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_InterlockStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_DisplacementSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_DisplacementSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_InclinometerSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_InclinometerSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AccelerometerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AccelerometerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceSetpointWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceSetpointWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointMonitorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointMonitorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_CellLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_CellLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_CellLightWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_CellLightWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_PowerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_PowerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_PowerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_PowerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorForceWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorForceWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_GyroWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_GyroWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_PowerSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_PowerSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_CommandRejectionWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_CommandRejectionWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_PIDInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_PIDInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointMonitorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointMonitorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointMonitorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointMonitorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RejectedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RejectedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedCylinderForces.py

Salgen M1M3 LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so

Salgen M1M3 Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ForceActuatorData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_InclinometerData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_OuterLoopData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AccelerometerData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_HardpointActuatorData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_IMSData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_GyroData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_PowerSupplyData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_PIDData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_HardpointMonitorData.idl
    Should Contain X Times    ${output}    javac : Done Publisher    10
    Should Contain X Times    ${output}    javac : Done Subscriber    10
    Should Contain X Times    ${output}    javac : Done Commander/Controller    10
    Should Contain X Times    ${output}    javac : Done Event/Logger    10
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen M1M3 Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java    TSS-2602
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

