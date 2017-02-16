*** Settings ***
Documentation    This suite builds the various interfaces for the M2MS.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${timeout}    1200s

*** Test Cases ***
Create SALGEN Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=SALGEN    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Verify M2MS XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms_Commands.xml
    File Should Exist    ${SALWorkDir}/m2ms_Events.xml
    File Should Exist    ${SALWorkDir}/m2ms_Telemetry.xml

Salgen M2MS Validate
    [Documentation]    Validate the M2MS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing m2ms
    Should Contain    ${output}    Completed m2ms validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_MirrorPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_AxialForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_TangentForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_ZenithAngleMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_AxialActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_TangentActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_PowerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_TemperaturesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_RawDisplacement.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_StepVectorUpdate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_TargetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_SystemStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_RawTelemetry.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_ActuatorLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_ApplyBendingMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_ApplyForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_SetCorrectionMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_PositionMirror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_command_MoveAxialActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_logevent_M2SummaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_logevent_M2DetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_logevent_M2FaultState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/m2ms_logevent_M2AssemblyInPosition.idl

Salgen M2MS HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/m2ms
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/m2ms    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/m2ms/m2ms_Commands.html
    File Should Exist    ${SALWorkDir}/html/m2ms/m2ms_Events.html
    File Should Exist    ${SALWorkDir}/html/m2ms/m2ms_Telemetry.html

Salgen M2MS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for m2ms_MirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_AxialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_TangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_ZenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_AxialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_TangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_PowerStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_TemperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_RawDisplacement.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_StepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_TargetForces.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_SystemStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_RawTelemetry.idl
    Should Contain    ${output}    Generating SAL CPP code for m2ms_ActuatorLimitSwitches.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    16
    Should Contain X Times    ${output}    cpp : Done Subscriber    16
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/m2ms/cpp
    @{files}=    List Directory    ${SALWorkDir}/m2ms/cpp    pattern=*m2ms*
    File Should Exist    ${SALWorkDir}/m2ms/cpp/libsacpp_m2ms_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*m2ms*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_m2ms.idl

Verify M2MS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*m2ms*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/m2ms_MirrorPositionMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_AxialForcesMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_TangentForcesMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_ZenithAngleMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_AxialActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/m2ms_TangentActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_PowerStatus
    Directory Should Exist    ${SALWorkDir}/m2ms_TemperaturesMeasured
    Directory Should Exist    ${SALWorkDir}/m2ms_RawDisplacement
    Directory Should Exist    ${SALWorkDir}/m2ms_StepVectorUpdate
    Directory Should Exist    ${SALWorkDir}/m2ms_TargetForces
    Directory Should Exist    ${SALWorkDir}/m2ms_SystemStatus
    Directory Should Exist    ${SALWorkDir}/m2ms_RawTelemetry
    Directory Should Exist    ${SALWorkDir}/m2ms_ActuatorLimitSwitches

Verify M2MS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms_MirrorPositionMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_MirrorPositionMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_AxialForcesMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_AxialForcesMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_TangentForcesMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_TangentForcesMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_ZenithAngleMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_ZenithAngleMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_AxialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_AxialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_TangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_TangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_PowerStatus/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_PowerStatus/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_TemperaturesMeasured/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_TemperaturesMeasured/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_RawDisplacement/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_RawDisplacement/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_StepVectorUpdate/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_StepVectorUpdate/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_TargetForces/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_TargetForces/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_SystemStatus/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_SystemStatus/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_RawTelemetry/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_RawTelemetry/cpp/standalone/sacpp_m2ms_sub
    File Should Exist    ${SALWorkDir}/m2ms_ActuatorLimitSwitches/cpp/standalone/sacpp_m2ms_pub
    File Should Exist    ${SALWorkDir}/m2ms_ActuatorLimitSwitches/cpp/standalone/sacpp_m2ms_sub

Verify M2MS C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_enable_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_enable_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_disable_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_disable_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_abort_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_abort_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_enterControl_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_enterControl_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_exitControl_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_exitControl_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_standby_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_standby_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_start_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_start_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_stop_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_stop_controller

Verify M2MS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_ApplyBendingMode_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_ApplyBendingMode_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_ApplyForce_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_ApplyForce_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_SetCorrectionMode_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_SetCorrectionMode_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_PositionMirror_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_PositionMirror_controller
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_MoveAxialActuator_commander
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_MoveAxialActuator_controller

Verify M2MS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2SummaryState_send
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2SummaryState_log
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2DetailedState_send
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2DetailedState_log
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2FaultState_send
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2FaultState_log
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2AssemblyInPosition_send
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/sacpp_m2ms_M2AssemblyInPosition_log

Salgen M2MS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for m2ms_MirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_AxialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_TangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_ZenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_AxialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_TangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_PowerStatus.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_TemperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_RawDisplacement.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_StepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_TargetForces.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_SystemStatus.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_RawTelemetry.idl
    Should Contain    ${output}    Generating SAL Java code for m2ms_ActuatorLimitSwitches.idl
    Should Contain X Times    ${output}    javac : Done Publisher    16
    Should Contain X Times    ${output}    javac : Done Subscriber    16
    Should Contain X Times    ${output}    javac : Done Commander/Controller    16
    Should Contain X Times    ${output}    javac : Done Event/Logger    16
    Directory Should Exist    ${SALWorkDir}/m2ms/java
    @{files}=    List Directory    ${SALWorkDir}/m2ms/java    pattern=*m2ms*
    File Should Exist    ${SALWorkDir}/m2ms/java/sal_m2ms.idl

Salgen M2MS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_m2ms ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/m2ms_${SALVersion}/pom.xml

Salgen M2MS Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for m2ms
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_m2ms.so
    Directory Should Exist    ${SALWorkDir}/m2ms/python
    @{files}=    List Directory    ${SALWorkDir}/m2ms/python    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_abort.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_abort.py
    File Should Exist    ${SALWorkDir}/m2ms/cpp/src/SALPY_m2ms.so

Verify M2MS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m2ms/python    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_MirrorPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_MirrorPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_ZenithAngleMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_ZenithAngleMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_AxialActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TangentActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_PowerStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_PowerStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TemperaturesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TemperaturesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_RawDisplacement_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_RawDisplacement_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_StepVectorUpdate_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_StepVectorUpdate_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TargetForces_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_TargetForces_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_SystemStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_SystemStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_RawTelemetry_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_RawTelemetry_Subscriber.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_ActuatorLimitSwitches_Publisher.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_ActuatorLimitSwitches_Subscriber.py

Verify M2MS Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_enable.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_enable.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_disable.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_disable.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_abort.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_abort.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_standby.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_standby.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_start.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_start.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_stop.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_stop.py

Verify M2MS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m2ms/python    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_ApplyForce.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_ApplyForce.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_SetCorrectionMode.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_SetCorrectionMode.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_PositionMirror.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_PositionMirror.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Commander_MoveAxialActuator.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Controller_MoveAxialActuator.py

Verify M2MS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m2ms/python    pattern=*m2ms*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Event_M2SummaryState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_EventLogger_M2SummaryState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Event_M2DetailedState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_EventLogger_M2DetailedState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Event_M2FaultState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_EventLogger_M2FaultState.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_Event_M2AssemblyInPosition.py
    File Should Exist    ${SALWorkDir}/m2ms/python/m2ms_EventLogger_M2AssemblyInPosition.py

Salgen M2MS LabVIEW
    [Documentation]    Generate m2ms low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator m2ms labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/m2ms/labview
    @{files}=    List Directory    ${SALWorkDir}/m2ms/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m2ms/labview/SAL_m2ms_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/m2ms/labview/SAL_m2ms_shmem.h
    File Should Exist    ${SALWorkDir}/m2ms/labview/SALLV_m2ms.so
