*** Settings ***
Documentation    This suite builds the various interfaces for the M1M3.
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

Verify M1M3 XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3_Commands.xml
    File Should Exist    ${SALWorkDir}/m1m3_Events.xml
    File Should Exist    ${SALWorkDir}/m1m3_Telemetry.xml

Salgen M1M3 Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing m1m3
    Should Contain    ${output}    Completed m1m3 validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_m1m3.idl

Salgen M1M3 HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/m1m3
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/m1m3    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/m1m3/m1m3_Commands.html
    File Should Exist    ${SALWorkDir}/html/m1m3/m1m3_Events.html
    File Should Exist    ${SALWorkDir}/html/m1m3/m1m3_Telemetry.html

Salgen M1M3 C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for m1m3_LimitSensors.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Metrology.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_LUT.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Actuators.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Electrical.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Surface.idl
    Should Contain    ${output}    Generating SAL CPP code for m1m3_Support.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    10
    Should Contain X Times    ${output}    cpp : Done Subscriber    10
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/m1m3/cpp
    @{files}=    List Directory    ${SALWorkDir}/m1m3/cpp    pattern=*m1m3*
    File Should Exist    ${SALWorkDir}/m1m3/cpp/libsacpp_m1m3_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*m1m3*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_m1m3.idl

Verify M1M3 Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*m1m3*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/m1m3_LimitSensors
    Directory Should Exist    ${SALWorkDir}/m1m3_Metrology
    Directory Should Exist    ${SALWorkDir}/m1m3_Application
    Directory Should Exist    ${SALWorkDir}/m1m3_LUT
    Directory Should Exist    ${SALWorkDir}/m1m3_Actuators
    Directory Should Exist    ${SALWorkDir}/m1m3_TC
    Directory Should Exist    ${SALWorkDir}/m1m3_Electrical
    Directory Should Exist    ${SALWorkDir}/m1m3_Surface
    Directory Should Exist    ${SALWorkDir}/m1m3_Support

Verify M1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3_LimitSensors/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_LimitSensors/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Metrology/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Metrology/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Application/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Application/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_LUT/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_LUT/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Actuators/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Actuators/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_TC/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_TC/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Electrical/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Electrical/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Surface/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Surface/cpp/standalone/sacpp_m1m3_sub
    File Should Exist    ${SALWorkDir}/m1m3_Support/cpp/standalone/sacpp_m1m3_pub
    File Should Exist    ${SALWorkDir}/m1m3_Support/cpp/standalone/sacpp_m1m3_sub

Verify M1M3 C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_enable_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_enable_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_disable_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_disable_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_abort_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_abort_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_enterControl_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_enterControl_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_exitControl_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_exitControl_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_standby_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_standby_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_start_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_start_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_stop_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_stop_controller

Verify M1M3 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_configure_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_configure_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_status_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_status_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_target_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_target_controller
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_update_commander
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_command_update_controller

Verify M1M3 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_interlock_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_interlock_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_limitError_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_limitError_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_targetDone_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_targetDone_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_targetError_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_targetError_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_tempError_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_tempError_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_updateDone_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_updateDone_log
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_updateError_send
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/sacpp_m1m3_logevent_updateError_log

Salgen M1M3 Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for m1m3_Application.idl
    Should Contain    ${output}    Processing m1m3 Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/m1m3/java
    @{files}=    List Directory    ${SALWorkDir}/m1m3/java    pattern=*m1m3*
    File Should Exist    ${SALWorkDir}/m1m3/java/sal_m1m3.idl

Salgen M1M3 Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator m1m3 maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_m1m3 ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/m1m3_${SALVersion}/pom.xml

Salgen M1M3 Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for m1m3
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_m1m3.so
    Directory Should Exist    ${SALWorkDir}/m1m3/python
    @{files}=    List Directory    ${SALWorkDir}/m1m3/python    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_abort.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_abort.py
    File Should Exist    ${SALWorkDir}/m1m3/cpp/src/SALPY_m1m3.so

Verify M1M3 Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m1m3/python    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_LimitSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_LimitSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Metrology_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Metrology_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_LUT_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_LUT_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Actuators_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Actuators_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Electrical_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Electrical_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Surface_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Surface_Subscriber.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Support_Publisher.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Support_Subscriber.py

Verify M1M3 Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_enable.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_enable.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_disable.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_disable.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_abort.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_abort.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_standby.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_standby.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_start.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_start.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Commander_stop.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_Controller_stop.py

Verify M1M3 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m1m3/python    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_configure_Commander.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_configure_Controller.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_status_Commander.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_status_Controller.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_target_Commander.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_target_Controller.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_update_Commander.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_command_update_Controller.py

Verify M1M3 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/m1m3/python    pattern=*m1m3*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_interlock_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_interlock_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_limitError_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_limitError_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_targetDone_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_targetDone_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_targetError_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_targetError_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_tempError_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_tempError_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_updateDone_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_updateDone_EventLogger.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_updateError_Event.py
    File Should Exist    ${SALWorkDir}/m1m3/python/m1m3_logevent_updateError_EventLogger.py

Salgen M1M3 LabVIEW
    [Documentation]    Generate m1m3 low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator m1m3 labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/m1m3/labview
    @{files}=    List Directory    ${SALWorkDir}/m1m3/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/m1m3/labview/SAL_m1m3_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/m1m3/labview/SAL_m1m3_shmem.h
