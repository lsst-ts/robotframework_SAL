*** Settings ***
Documentation    This suite builds the various interfaces for the M1M3.
Force Tags    salgen    
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_MirrorForceData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_HardpointData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AirData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_DynamicData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_FPGAData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_IMSData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ForceActuatorStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ElevationData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_HardpointStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_EnterMaintenance.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_AbortLowerM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAberrationByForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAOSCorrectionByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ClearAOSCorrection.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_RaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestForceActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_LowerM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAOSCorrectionByForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyAberrationByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestHardpoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ManipulateM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ClearAberration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Exit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_TestAir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_AbortRaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_MoveHardpointActuators.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ExitMaintenance.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_Shutdown.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AirStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorSafetyChecks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorTest.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ActuatorBroadcastCounter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_StatusChecks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_CellChecks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorBreakaway.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_RaiseMirrorComplete.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ILCCommunication.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ElevationAngleChecks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_DetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ServoLoops.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ForceActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_LowerMirrorComplete.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_HardpointActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ErrorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_StartupChecks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SummaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_SettingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ActuatorTestStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_AppliedSettingsMatchStart.idl

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
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ForceActuatorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_MirrorForceData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_HardpointData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AirData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_DynamicData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_FPGAData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_IMSData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ForceActuatorStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ElevationData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_HardpointStatus.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    10
    Should Contain X Times    ${output}    cpp : Done Subscriber    10
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify M1M3 Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_MirrorForceData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_HardpointData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AirData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_DynamicData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_FPGAData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_IMSData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ElevationData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_HardpointStatus

Verify M1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_MirrorForceData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_MirrorForceData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AirData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AirData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_DynamicData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_DynamicData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_FPGAData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_FPGAData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_IMSData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_IMSData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ForceActuatorStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ElevationData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ElevationData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_HardpointStatus/cpp/standalone/sacpp_${subSystem}_sub

Verify M1M3 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnterMaintenance_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_EnterMaintenance_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortLowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortLowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationByForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationByForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAOSCorrectionByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAOSCorrectionByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAOSCorrection_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAOSCorrection_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAOSCorrectionByForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAOSCorrectionByForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyAberrationByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestHardpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestHardpoint_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ManipulateM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ManipulateM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAberration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ClearAberration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Exit_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Exit_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestAir_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_TestAir_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortRaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AbortRaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveHardpointActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveHardpointActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ExitMaintenance_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ExitMaintenance_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Shutdown_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_Shutdown_controller

Verify M1M3 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorChase_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorChase_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AirStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorSafetyChecks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorSafetyChecks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorTest_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorTest_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ActuatorBroadcastCounter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ActuatorBroadcastCounter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StatusChecks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StatusChecks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellChecks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_CellChecks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorBreakaway_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorBreakaway_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseMirrorComplete_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_RaiseMirrorComplete_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ILCCommunication_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ILCCommunication_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ElevationAngleChecks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ElevationAngleChecks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_DetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ServoLoops_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ServoLoops_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ForceActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerMirrorComplete_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LowerMirrorComplete_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_HardpointActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ErrorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ErrorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StartupChecks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_StartupChecks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SummaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SummaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SettingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ActuatorTestStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ActuatorTestStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_AppliedSettingsMatchStart_log

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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MirrorForceData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MirrorForceData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AirData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AirData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DynamicData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DynamicData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_FPGAData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_FPGAData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_IMSData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_IMSData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ForceActuatorStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ForceActuatorStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ElevationData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ElevationData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_HardpointStatus_Subscriber.py

Verify M1M3 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_EnterMaintenance.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_EnterMaintenance.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_AbortLowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_AbortLowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAberrationByForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAberrationByForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAOSCorrectionByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAOSCorrectionByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ClearAOSCorrection.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ClearAOSCorrection.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_RaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_RaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_LowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_LowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAOSCorrectionByForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAOSCorrectionByForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyAberrationByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyAberrationByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ManipulateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ManipulateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ClearAberration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ClearAberration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Exit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Exit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_TestAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_TestAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_AbortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_AbortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_MoveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_MoveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ExitMaintenance.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ExitMaintenance.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_Shutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_Shutdown.py

Verify M1M3 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AirStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AirStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorSafetyChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorSafetyChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorTest.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorTest.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ActuatorBroadcastCounter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ActuatorBroadcastCounter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_StatusChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_StatusChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_CellChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_CellChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorBreakaway.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorBreakaway.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_RaiseMirrorComplete.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_RaiseMirrorComplete.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ILCCommunication.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ILCCommunication.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ElevationAngleChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ElevationAngleChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ServoLoops.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ServoLoops.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ForceActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ForceActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_LowerMirrorComplete.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_LowerMirrorComplete.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_HardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_HardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SettingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SettingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_StartupChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_StartupChecks.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_SettingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_SettingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ActuatorTestStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ActuatorTestStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_AppliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_AppliedSettingsMatchStart.py

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
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_MirrorForceData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_HardpointData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AirData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_DynamicData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_FPGAData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_IMSData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ForceActuatorStatus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ElevationData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_HardpointStatus.idl
    Should Contain X Times    ${output}    javac : Done Publisher    10
    Should Contain X Times    ${output}    javac : Done Subscriber    10
    Should Contain X Times    ${output}    javac : Done Commander/Controller    10
    Should Contain X Times    ${output}    javac : Done Event/Logger    10
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen M1M3 Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
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

