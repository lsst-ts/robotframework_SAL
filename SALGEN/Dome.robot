*** Settings ***
Documentation    This suite builds the various interfaces for the Dome.
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

Verify Dome XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/domeADB_Commands.xml
    File Should Exist    ${SALWorkDir}/domeADB_Events.xml
    File Should Exist    ${SALWorkDir}/domeADB_Telemetry.xml
    File Should Exist    ${SALWorkDir}/domeAPS_Commands.xml
    File Should Exist    ${SALWorkDir}/domeAPS_Events.xml
    File Should Exist    ${SALWorkDir}/domeAPS_Telemetry.xml
    File Should Exist    ${SALWorkDir}/domeLWS_Commands.xml
    File Should Exist    ${SALWorkDir}/domeLWS_Events.xml
    File Should Exist    ${SALWorkDir}/domeLWS_Telemetry.xml
    File Should Exist    ${SALWorkDir}/domeLouvers_Commands.xml
    File Should Exist    ${SALWorkDir}/domeLouvers_Events.xml
    File Should Exist    ${SALWorkDir}/domeLouvers_Telemetry.xml
    File Should Exist    ${SALWorkDir}/domeMONCS_Commands.xml
    File Should Exist    ${SALWorkDir}/domeMONCS_Events.xml
    File Should Exist    ${SALWorkDir}/domeMONCS_Telemetry.xml
    File Should Exist    ${SALWorkDir}/domeTHCS_Commands.xml
    File Should Exist    ${SALWorkDir}/domeTHCS_Events.xml
    File Should Exist    ${SALWorkDir}/domeTHCS_Telemetry.xml
    File Should Exist    ${SALWorkDir}/dome_Commands.xml
    File Should Exist    ${SALWorkDir}/dome_Events.xml
    File Should Exist    ${SALWorkDir}/dome_Telemetry.xml

Salgen Dome Validate
    [Documentation]    Validate the Dome XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing dome
    Should Contain    ${output}    Completed dome validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Summary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Crawl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Park.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_SetLouvers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_CloseShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_OpenShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_StopShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_StateChanged.idl

Salgen Dome HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/dome
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/dome    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dome/domeADB_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeADB_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeADB_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/domeAPS_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeAPS_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeAPS_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLWS_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLWS_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLWS_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLouvers_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLouvers_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeLouvers_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/domeMONCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeMONCS_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeMONCS_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/domeTHCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/domeTHCS_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/domeTHCS_Telemetry.html
    File Should Exist    ${SALWorkDir}/html/dome/dome_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/dome_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/dome_Telemetry.html

Salgen Dome C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for dome_Summary.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    1
    Should Contain X Times    ${output}    cpp : Done Subscriber    1
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/dome/cpp
    @{files}=    List Directory    ${SALWorkDir}/dome/cpp    pattern=*dome*
    File Should Exist    ${SALWorkDir}/dome/cpp/libsacpp_dome_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*dome*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_dome.idl

Verify Dome Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*dome*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/dome_Summary

Verify Dome C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome_Summary/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Summary/cpp/standalone/sacpp_dome_sub

Verify Dome C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_enable_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_enable_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_disable_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_disable_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_abort_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_abort_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_enterControl_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_enterControl_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_exitControl_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_exitControl_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_standby_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_standby_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_start_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_start_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_stop_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_stop_controller

Verify Dome C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Crawl_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Crawl_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Move_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Move_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Park_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Park_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_SetLouvers_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_SetLouvers_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_CloseShutter_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_CloseShutter_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_OpenShutter_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_OpenShutter_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_StopShutter_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_StopShutter_controller

Verify Dome C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_StateChanged_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_StateChanged_log

Salgen Dome Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for dome_Summary.idl
    Should Contain X Times    ${output}    javac : Done Publisher    1
    Should Contain X Times    ${output}    javac : Done Subscriber    1
    Should Contain X Times    ${output}    javac : Done Commander/Controller    1
    Should Contain X Times    ${output}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/dome/java
    @{files}=    List Directory    ${SALWorkDir}/dome/java    pattern=*dome*
    File Should Exist    ${SALWorkDir}/dome/java/sal_dome.idl

Salgen Dome Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_dome ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/dome_${SALVersion}/pom.xml

Salgen Dome Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for dome
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_dome.so
    Directory Should Exist    ${SALWorkDir}/dome/python
    @{files}=    List Directory    ${SALWorkDir}/dome/python    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_abort.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_abort.py
    File Should Exist    ${SALWorkDir}/dome/cpp/src/SALPY_dome.so

Verify Dome Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dome/python    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/python/dome_Summary_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Summary_Subscriber.py

Verify Dome Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_enable.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_enable.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_disable.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_disable.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_abort.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_abort.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_standby.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_standby.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_start.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_start.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_stop.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_stop.py

Verify Dome Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dome/python    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Crawl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Crawl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Move.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Move.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Park.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Park.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_SetLouvers.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_SetLouvers.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_CloseShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_CloseShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_OpenShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_OpenShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_StopShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_StopShutter.py

Verify Dome Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dome/python    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_StateChanged.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_StateChanged.py

Salgen Dome LabVIEW
    [Documentation]    Generate dome low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator dome labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/dome/labview
    @{files}=    List Directory    ${SALWorkDir}/dome/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/labview/SAL_dome_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/dome/labview/SAL_dome_shmem.h
    File Should Exist    ${SALWorkDir}/dome/labview/SALLV_dome.so
