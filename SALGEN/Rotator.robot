*** Settings ***
Documentation    This suite builds the various interfaces for the Rotator.
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

Verify Rotator XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator_Commands.xml
    File Should Exist    ${SALWorkDir}/rotator_Events.xml
    File Should Exist    ${SALWorkDir}/rotator_Telemetry.xml

Salgen Rotator Validate
    [Documentation]    Validate the Rotator XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing rotator
    Should Contain    ${output}    Completed rotator validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_LimitSensors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_Position.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_Electrical.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_configureAcceleration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_configureVelocity.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_track.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_command_test.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_error.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_interlock.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_limit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_moveOK.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_tempError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_trackLost.idl
    File Should Exist    ${SALWorkDir}/idl-templates/rotator_logevent_tracking.idl

Salgen Rotator HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/rotator
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/rotator    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/rotator/rotator_Commands.html
    File Should Exist    ${SALWorkDir}/html/rotator/rotator_Events.html
    File Should Exist    ${SALWorkDir}/html/rotator/rotator_Telemetry.html

Salgen Rotator C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for rotator_LimitSensors.idl
    Should Contain    ${output}    Generating SAL CPP code for rotator_Position.idl
    Should Contain    ${output}    Generating SAL CPP code for rotator_Electrical.idl
    Should Contain    ${output}    Generating SAL CPP code for rotator_TC.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    4
    Should Contain X Times    ${output}    cpp : Done Subscriber    4
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/rotator/cpp
    @{files}=    List Directory    ${SALWorkDir}/rotator/cpp    pattern=*rotator*
    File Should Exist    ${SALWorkDir}/rotator/cpp/libsacpp_rotator_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*rotator*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_rotator.idl

Verify Rotator Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*rotator*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/rotator_LimitSensors
    Directory Should Exist    ${SALWorkDir}/rotator_Position
    Directory Should Exist    ${SALWorkDir}/rotator_Electrical
    Directory Should Exist    ${SALWorkDir}/rotator_TC

Verify Rotator C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator_LimitSensors/cpp/standalone/sacpp_rotator_pub
    File Should Exist    ${SALWorkDir}/rotator_LimitSensors/cpp/standalone/sacpp_rotator_sub
    File Should Exist    ${SALWorkDir}/rotator_Position/cpp/standalone/sacpp_rotator_pub
    File Should Exist    ${SALWorkDir}/rotator_Position/cpp/standalone/sacpp_rotator_sub
    File Should Exist    ${SALWorkDir}/rotator_Electrical/cpp/standalone/sacpp_rotator_pub
    File Should Exist    ${SALWorkDir}/rotator_Electrical/cpp/standalone/sacpp_rotator_sub
    File Should Exist    ${SALWorkDir}/rotator_TC/cpp/standalone/sacpp_rotator_pub
    File Should Exist    ${SALWorkDir}/rotator_TC/cpp/standalone/sacpp_rotator_sub

Verify Rotator C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_enable_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_enable_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_disable_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_disable_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_abort_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_abort_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_enterControl_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_enterControl_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_exitControl_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_exitControl_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_standby_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_standby_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_start_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_start_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_stop_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_stop_controller

Verify Rotator C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_configureAcceleration_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_configureAcceleration_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_configureVelocity_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_configureVelocity_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_move_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_move_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_track_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_track_controller
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_test_commander
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_test_controller

Verify Rotator C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_error_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_error_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_interlock_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_interlock_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_limit_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_limit_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_moveOK_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_moveOK_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_tempError_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_tempError_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_trackLost_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_trackLost_log
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_tracking_send
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/sacpp_rotator_tracking_log

Salgen Rotator Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for rotator_LimitSensors.idl
    Should Contain    ${output}    Generating SAL Java code for rotator_Position.idl
    Should Contain    ${output}    Generating SAL Java code for rotator_Electrical.idl
    Should Contain    ${output}    Generating SAL Java code for rotator_TC.idl
    Should Contain X Times    ${output}    javac : Done Publisher    4
    Should Contain X Times    ${output}    javac : Done Subscriber    4
    Should Contain X Times    ${output}    javac : Done Commander/Controller    4
    Should Contain X Times    ${output}    javac : Done Event/Logger    4
    Directory Should Exist    ${SALWorkDir}/rotator/java
    @{files}=    List Directory    ${SALWorkDir}/rotator/java    pattern=*rotator*
    File Should Exist    ${SALWorkDir}/rotator/java/sal_rotator.idl

Salgen Rotator Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_rotator ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/rotator_${SALVersion}/pom.xml

Salgen Rotator Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for rotator
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_rotator.so
    Directory Should Exist    ${SALWorkDir}/rotator/python
    @{files}=    List Directory    ${SALWorkDir}/rotator/python    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_abort.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_abort.py
    File Should Exist    ${SALWorkDir}/rotator/cpp/src/SALPY_rotator.so

Verify Rotator Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/rotator/python    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_LimitSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_LimitSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Position_Publisher.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Position_Subscriber.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Electrical_Publisher.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Electrical_Subscriber.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_TC_Subscriber.py

Verify Rotator Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_enable.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_enable.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_disable.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_disable.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_abort.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_abort.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_standby.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_standby.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_start.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_start.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_stop.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_stop.py

Verify Rotator Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/rotator/python    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_configureAcceleration.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_configureAcceleration.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_configureVelocity.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_configureVelocity.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_move.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_move.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_track.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_track.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Commander_test.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Controller_test.py

Verify Rotator Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/rotator/python    pattern=*rotator*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_error.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_error.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_interlock.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_interlock.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_limit.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_limit.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_moveOK.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_moveOK.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_tempError.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_tempError.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_trackLost.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_trackLost.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_Event_tracking.py
    File Should Exist    ${SALWorkDir}/rotator/python/rotator_EventLogger_tracking.py

Salgen Rotator LabVIEW
    [Documentation]    Generate rotator low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator rotator labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/rotator/labview
    @{files}=    List Directory    ${SALWorkDir}/rotator/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rotator/labview/SAL_rotator_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/rotator/labview/SAL_rotator_shmem.h
    File Should Exist    ${SALWorkDir}/rotator/labview/SALLV_rotator.so
