*** Settings ***
Documentation    This suite builds the various interfaces for the Scheduler.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${timeout}    900s

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

Verify Scheduler XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler_Telemetry.xml

Salgen Scheduler Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing scheduler
    Should Contain    ${output}    Completed scheduler validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*scheduler*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_timeHandler.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_cloud.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_seeing.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_filterSwap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_schedulerConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_driverConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_field.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_obsSiteConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_telescopeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_rotatorConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_domeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_cameraConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_slewConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_opticsLoopCorrConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_parkConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_areaDistPropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_blockPusher.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_observatoryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_observation.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_interestedProposal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_parameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_Application.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_program.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_progress.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_rankingData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_econstraints.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_iconstraints.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/scheduler_command_stop.idl

Salgen Scheduler HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/scheduler
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/scheduler    pattern=*scheduler*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/scheduler/scheduler_Telemetry.html

Salgen Scheduler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for scheduler_timeHandler.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_cloud.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_seeing.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_filterSwap.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_schedulerConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_driverConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_field.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_obsSiteConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_telescopeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_rotatorConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_domeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_cameraConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_slewConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_opticsLoopCorrConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_parkConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_areaDistPropConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_blockPusher.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_observatoryState.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_target.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_observation.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_interestedProposal.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_parameters.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_program.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_progress.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_rankingData.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_econstraints.idl
    Should Contain    ${output}    Generating SAL CPP code for scheduler_iconstraints.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    28
    Should Contain X Times    ${output}    cpp : Done Subscriber    28
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/scheduler/cpp
    @{files}=    List Directory    ${SALWorkDir}/scheduler/cpp    pattern=*scheduler*
    File Should Exist    ${SALWorkDir}/scheduler/cpp/libsacpp_scheduler_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*scheduler*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_scheduler.idl

Verify Scheduler Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*scheduler*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/scheduler_timeHandler
    Directory Should Exist    ${SALWorkDir}/scheduler_cloud
    Directory Should Exist    ${SALWorkDir}/scheduler_seeing
    Directory Should Exist    ${SALWorkDir}/scheduler_filterSwap
    Directory Should Exist    ${SALWorkDir}/scheduler_schedulerConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_driverConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_field
    Directory Should Exist    ${SALWorkDir}/scheduler_obsSiteConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_telescopeConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_rotatorConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_domeConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_cameraConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_slewConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_opticsLoopCorrConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_parkConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_areaDistPropConfig
    Directory Should Exist    ${SALWorkDir}/scheduler_blockPusher
    Directory Should Exist    ${SALWorkDir}/scheduler_observatoryState
    Directory Should Exist    ${SALWorkDir}/scheduler_target
    Directory Should Exist    ${SALWorkDir}/scheduler_observation
    Directory Should Exist    ${SALWorkDir}/scheduler_interestedProposal
    Directory Should Exist    ${SALWorkDir}/scheduler_parameters
    Directory Should Exist    ${SALWorkDir}/scheduler_Application
    Directory Should Exist    ${SALWorkDir}/scheduler_program
    Directory Should Exist    ${SALWorkDir}/scheduler_progress
    Directory Should Exist    ${SALWorkDir}/scheduler_rankingData
    Directory Should Exist    ${SALWorkDir}/scheduler_econstraints
    Directory Should Exist    ${SALWorkDir}/scheduler_iconstraints

Verify Scheduler C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler_timeHandler/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_timeHandler/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_cloud/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_cloud/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_seeing/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_seeing/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_filterSwap/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_filterSwap/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_schedulerConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_schedulerConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_driverConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_driverConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_field/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_field/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_obsSiteConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_obsSiteConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_telescopeConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_telescopeConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_rotatorConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_rotatorConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_domeConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_domeConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_cameraConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_cameraConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_slewConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_slewConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_opticsLoopCorrConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_opticsLoopCorrConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_parkConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_parkConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_areaDistPropConfig/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_areaDistPropConfig/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_blockPusher/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_blockPusher/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_observatoryState/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_observatoryState/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_target/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_target/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_observation/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_observation/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_interestedProposal/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_interestedProposal/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_parameters/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_parameters/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_Application/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_Application/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_program/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_program/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_progress/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_progress/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_rankingData/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_rankingData/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_econstraints/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_econstraints/cpp/standalone/sacpp_scheduler_sub
    File Should Exist    ${SALWorkDir}/scheduler_iconstraints/cpp/standalone/sacpp_scheduler_pub
    File Should Exist    ${SALWorkDir}/scheduler_iconstraints/cpp/standalone/sacpp_scheduler_sub

Verify Scheduler C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_enable_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_enable_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_disable_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_disable_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_abort_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_abort_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_enterControl_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_enterControl_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_exitControl_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_exitControl_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_standby_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_standby_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_start_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_start_controller
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_stop_commander
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/sacpp_scheduler_stop_controller

Salgen Scheduler Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for scheduler_Application.idl
    Should Contain    ${output}    Processing scheduler Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/scheduler/java
    @{files}=    List Directory    ${SALWorkDir}/scheduler/java    pattern=*scheduler*
    File Should Exist    ${SALWorkDir}/scheduler/java/sal_scheduler.idl

Salgen Scheduler Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator scheduler maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_scheduler ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/scheduler_${SALVersion}/pom.xml

Salgen Scheduler Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for scheduler
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_scheduler.so
    Directory Should Exist    ${SALWorkDir}/scheduler/python
    @{files}=    List Directory    ${SALWorkDir}/scheduler/python    pattern=*scheduler*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_abort.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_abort.py
    File Should Exist    ${SALWorkDir}/scheduler/cpp/src/SALPY_scheduler.so

Verify Scheduler Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/scheduler/python    pattern=*scheduler*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_timeHandler_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_timeHandler_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_cloud_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_cloud_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_seeing_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_seeing_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_filterSwap_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_filterSwap_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_schedulerConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_schedulerConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_driverConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_driverConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_field_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_field_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_obsSiteConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_obsSiteConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_telescopeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_telescopeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_rotatorConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_rotatorConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_domeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_domeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_cameraConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_cameraConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_slewConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_slewConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_opticsLoopCorrConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_opticsLoopCorrConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_parkConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_parkConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_areaDistPropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_areaDistPropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_blockPusher_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_blockPusher_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_observatoryState_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_observatoryState_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_target_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_target_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_observation_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_observation_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_interestedProposal_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_interestedProposal_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_parameters_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_parameters_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_program_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_program_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_progress_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_progress_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_rankingData_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_rankingData_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_econstraints_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_econstraints_Subscriber.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_iconstraints_Publisher.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_iconstraints_Subscriber.py

Verify Scheduler Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_enable.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_enable.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_disable.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_disable.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_abort.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_abort.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_standby.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_standby.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_start.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_start.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Commander_stop.py
    File Should Exist    ${SALWorkDir}/scheduler/python/scheduler_Controller_stop.py

Salgen Scheduler LabVIEW
    [Documentation]    Generate scheduler low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator scheduler labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/scheduler/labview
    @{files}=    List Directory    ${SALWorkDir}/scheduler/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/scheduler/labview/SAL_scheduler_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/scheduler/labview/SAL_scheduler_shmem.h
