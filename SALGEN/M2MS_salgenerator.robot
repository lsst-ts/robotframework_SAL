*** Settings ***
Documentation    This suite builds the various interfaces for the M2MS.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    m2ms
${timeout}    1200s

*** Test Cases ***
Verify M2MS XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms_Commands.xml
    File Should Exist    ${SALWorkDir}/m2ms_Events.xml
    File Should Exist    ${SALWorkDir}/m2ms_Telemetry.xml

Salgen M2MS Validate
    [Documentation]    Validate the M2MS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_MirrorPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AxialForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TangentForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ZenithAngleMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AxialActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TangentActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_PowerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TemperaturesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_RawDisplacement.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_StepVectorUpdate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TargetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_SystemStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_RawTelemetry.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ActuatorLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyBendingMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ApplyForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_SetCorrectionMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_PositionMirror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_MoveAxialActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_M2SummaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_M2DetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_M2FaultState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_M2AssemblyInPosition.idl

Salgen M2MS HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m2ms_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m2ms_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/m2ms_Telemetry.html

Salgen M2MS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_MirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AxialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ZenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AxialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_PowerStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TemperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_RawDisplacement.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_StepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TargetForces.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_SystemStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_RawTelemetry.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ActuatorLimitSwitches.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    16
    Should Contain X Times    ${output}    cpp : Done Subscriber    16
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

Verify M2MS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_MirrorPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ZenithAngleMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_PowerStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TemperaturesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_RawDisplacement
    Directory Should Exist    ${SALWorkDir}/${subSystem}_StepVectorUpdate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TargetForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_SystemStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_RawTelemetry
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ActuatorLimitSwitches

Verify M2MS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_MirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_MirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialForcesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialForcesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentForcesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentForcesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ZenithAngleMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ZenithAngleMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_PowerStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_PowerStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TemperaturesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TemperaturesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_RawDisplacement/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_RawDisplacement/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_StepVectorUpdate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_StepVectorUpdate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TargetForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TargetForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_SystemStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_SystemStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_RawTelemetry/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_RawTelemetry/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ActuatorLimitSwitches/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ActuatorLimitSwitches/cpp/standalone/sacpp_${subSystem}_sub

Verify M2MS C++ State Command Interfaces
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

Verify M2MS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyBendingMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyBendingMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ApplyForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SetCorrectionMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_SetCorrectionMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PositionMirror_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_PositionMirror_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveAxialActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_MoveAxialActuator_controller

Verify M2MS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2SummaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2SummaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2DetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2DetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2FaultState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2FaultState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2AssemblyInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_M2AssemblyInPosition_log

Salgen M2MS Python
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

Verify M2MS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MirrorPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MirrorPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ZenithAngleMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ZenithAngleMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PowerStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PowerStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TemperaturesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TemperaturesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_RawDisplacement_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_RawDisplacement_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_StepVectorUpdate_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_StepVectorUpdate_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TargetForces_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TargetForces_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SystemStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SystemStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_RawTelemetry_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_RawTelemetry_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ActuatorLimitSwitches_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ActuatorLimitSwitches_Subscriber.py

Verify M2MS Python State Command Interfaces
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

Verify M2MS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_SetCorrectionMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_SetCorrectionMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_PositionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_PositionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_MoveAxialActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_MoveAxialActuator.py

Verify M2MS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_M2SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_M2SummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_M2DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_M2DetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_M2FaultState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_M2FaultState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_M2AssemblyInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_M2AssemblyInPosition.py

Salgen M2MS LabVIEW
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

Salgen M2MS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_MirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AxialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ZenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AxialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_PowerStatus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TemperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_RawDisplacement.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_StepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TargetForces.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_SystemStatus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_RawTelemetry.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ActuatorLimitSwitches.idl
    Should Contain X Times    ${output}    javac : Done Publisher    16
    Should Contain X Times    ${output}    javac : Done Subscriber    16
    Should Contain X Times    ${output}    javac : Done Commander/Controller    16
    Should Contain X Times    ${output}    javac : Done Event/Logger    16
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen M2MS Maven
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

