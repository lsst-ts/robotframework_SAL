*** Settings ***
Documentation    This suite builds the various interfaces for the Hexapod.
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

Verify Hexapod XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod_Commands.xml
    File Should Exist    ${SALWorkDir}/hexapod_Events.xml
    File Should Exist    ${SALWorkDir}/hexapod_Telemetry.xml

Salgen Hexapod Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing hexapod
    Should Contain    ${output}    Completed hexapod validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_hexapod.idl

Salgen Hexapod HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/hexapod
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/hexapod    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/hexapod/hexapod_Commands.html
    File Should Exist    ${SALWorkDir}/html/hexapod/hexapod_Events.html
    File Should Exist    ${SALWorkDir}/html/hexapod/hexapod_Telemetry.html

Salgen Hexapod C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for hexapod_Metrology.idl
    Should Contain    ${output}    Generating SAL CPP code for hexapod_LimitSensors.idl
    Should Contain    ${output}    Generating SAL CPP code for hexapod_Electrical.idl
    Should Contain    ${output}    Generating SAL CPP code for hexapod_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for hexapod_Actuators.idl
    Should Contain    ${output}    Generating SAL CPP code for hexapod_TC.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    7
    Should Contain X Times    ${output}    cpp : Done Subscriber    7
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/hexapod/cpp
    @{files}=    List Directory    ${SALWorkDir}/hexapod/cpp    pattern=*hexapod*
    File Should Exist    ${SALWorkDir}/hexapod/cpp/libsacpp_hexapod_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*hexapod*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_hexapod.idl

Verify Hexapod Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*hexapod*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/hexapod_Metrology
    Directory Should Exist    ${SALWorkDir}/hexapod_LimitSensors
    Directory Should Exist    ${SALWorkDir}/hexapod_Electrical
    Directory Should Exist    ${SALWorkDir}/hexapod_Application
    Directory Should Exist    ${SALWorkDir}/hexapod_Actuators
    Directory Should Exist    ${SALWorkDir}/hexapod_TC

Verify Hexapod C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod_Metrology/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_Metrology/cpp/standalone/sacpp_hexapod_sub
    File Should Exist    ${SALWorkDir}/hexapod_LimitSensors/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_LimitSensors/cpp/standalone/sacpp_hexapod_sub
    File Should Exist    ${SALWorkDir}/hexapod_Electrical/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_Electrical/cpp/standalone/sacpp_hexapod_sub
    File Should Exist    ${SALWorkDir}/hexapod_Application/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_Application/cpp/standalone/sacpp_hexapod_sub
    File Should Exist    ${SALWorkDir}/hexapod_Actuators/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_Actuators/cpp/standalone/sacpp_hexapod_sub
    File Should Exist    ${SALWorkDir}/hexapod_TC/cpp/standalone/sacpp_hexapod_pub
    File Should Exist    ${SALWorkDir}/hexapod_TC/cpp/standalone/sacpp_hexapod_sub

Verify Hexapod C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_enable_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_enable_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_disable_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_disable_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_abort_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_abort_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_enterControl_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_enterControl_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_exitControl_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_exitControl_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_standby_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_standby_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_start_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_start_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_stop_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_stop_controller

Verify Hexapod C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureAcceleration_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureAcceleration_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureLimits_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureLimits_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureLut_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureLut_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_move_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_move_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureVelocity_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_configureVelocity_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_offset_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_offset_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_pivot_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_pivot_controller
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_test_commander
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_command_test_controller

Verify Hexapod C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_error_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_error_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_interlock_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_interlock_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_limit_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_limit_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_slewOK_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_slewOK_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_tempError_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_tempError_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_trackLost_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_trackLost_log
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_tracking_send
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/sacpp_hexapod_logevent_tracking_log

Salgen Hexapod Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for hexapod_Application.idl
    Should Contain    ${output}    Processing hexapod Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/hexapod/java
    @{files}=    List Directory    ${SALWorkDir}/hexapod/java    pattern=*hexapod*
    File Should Exist    ${SALWorkDir}/hexapod/java/sal_hexapod.idl

Salgen Hexapod Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator hexapod maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_hexapod ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/hexapod_${SALVersion}/pom.xml

Salgen Hexapod Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for hexapod
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_hexapod.so
    Directory Should Exist    ${SALWorkDir}/hexapod/python
    @{files}=    List Directory    ${SALWorkDir}/hexapod/python    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_abort.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_abort.py
    File Should Exist    ${SALWorkDir}/hexapod/cpp/src/SALPY_hexapod.so

Verify Hexapod Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/hexapod/python    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Metrology_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Metrology_Subscriber.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_LimitSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_LimitSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Electrical_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Electrical_Subscriber.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Actuators_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Actuators_Subscriber.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_TC_Subscriber.py

Verify Hexapod Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_enable.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_enable.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_disable.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_disable.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_abort.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_abort.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_standby.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_standby.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_start.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_start.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Commander_stop.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_Controller_stop.py

Verify Hexapod Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/hexapod/python    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureAcceleration_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureAcceleration_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureLimits_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureLimits_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureLut_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureLut_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_move_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_move_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureVelocity_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_configureVelocity_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_offset_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_offset_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_pivot_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_pivot_Controller.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_test_Commander.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_command_test_Controller.py

Verify Hexapod Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/hexapod/python    pattern=*hexapod*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_error_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_error_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_interlock_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_interlock_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_limit_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_limit_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_slewOK_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_slewOK_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_tempError_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_tempError_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_trackLost_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_trackLost_EventLogger.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_tracking_Event.py
    File Should Exist    ${SALWorkDir}/hexapod/python/hexapod_logevent_tracking_EventLogger.py

Salgen Hexapod LabVIEW
    [Documentation]    Generate hexapod low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator hexapod labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/hexapod/labview
    @{files}=    List Directory    ${SALWorkDir}/hexapod/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/hexapod/labview/SAL_hexapod_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/hexapod/labview/SAL_hexapod_shmem.h
