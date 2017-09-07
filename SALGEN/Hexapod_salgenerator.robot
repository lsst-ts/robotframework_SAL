*** Settings ***
Documentation    This suite builds the various interfaces for the Hexapod.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    hexapod
${timeout}    1200s

*** Test Cases ***
Verify Hexapod XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod_Commands.xml
    File Should Exist    ${SALWorkDir}/hexapod_Events.xml
    File Should Exist    ${SALWorkDir}/hexapod_Telemetry.xml

Salgen Hexapod Validate
    [Documentation]    Validate the Hexapod XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Metrology.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_LimitSensors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Electrical.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Application.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Actuators.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configureAcceleration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configureLimits.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configureLut.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configureVelocity.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offset.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pivot.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_test.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_error.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlock.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_limit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_slewOK.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_tempError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_trackLost.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_tracking.idl

Salgen Hexapod HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/hexapod_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/hexapod_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/hexapod_Telemetry.html

Salgen Hexapod C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Metrology.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_LimitSensors.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Electrical.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Actuators.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TC.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    6
    Should Contain X Times    ${output}    cpp : Done Subscriber    6
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

Verify Hexapod Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Metrology
    Directory Should Exist    ${SALWorkDir}/${subSystem}_LimitSensors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Electrical
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Application
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Actuators
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TC

Verify Hexapod C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_Metrology/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Metrology/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_LimitSensors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_LimitSensors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Electrical/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Electrical/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Application/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Application/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Actuators/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Actuators/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_TC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_TC/cpp/standalone/sacpp_${subSystem}_sub

Verify Hexapod C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_controller

Verify Hexapod C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureAcceleration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureAcceleration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureLimits_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureLimits_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureLut_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureLut_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureVelocity_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureVelocity_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pivot_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pivot_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_test_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_test_controller

Verify Hexapod C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_error_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_error_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_limit_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_limit_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_slewOK_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_slewOK_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tempError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tempError_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackLost_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackLost_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tracking_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tracking_log

Salgen Hexapod Python
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify Hexapod Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Metrology_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Metrology_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_LimitSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_LimitSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Electrical_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Electrical_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Actuators_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Actuators_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TC_Subscriber.py

Verify Hexapod Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stop.py

Verify Hexapod Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configureAcceleration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configureAcceleration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configureLimits.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configureLimits.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configureLut.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configureLut.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configureVelocity.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configureVelocity.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pivot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pivot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_test.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_test.py

Verify Hexapod Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_error.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_error.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_interlock.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_interlock.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_limit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_limit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_slewOK.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_slewOK.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_tempError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_tempError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_trackLost.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_trackLost.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_tracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_tracking.py

Salgen Hexapod LabVIEW
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

Salgen Hexapod Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Metrology.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_LimitSensors.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Electrical.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Application.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Actuators.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TC.idl
    Should Contain X Times    ${output}    javac : Done Publisher    6
    Should Contain X Times    ${output}    javac : Done Subscriber    6
    Should Contain X Times    ${output}    javac : Done Commander/Controller    6
    Should Contain X Times    ${output}    javac : Done Event/Logger    6
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Hexapod Maven
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

