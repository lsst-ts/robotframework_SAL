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
    File Should Exist    ${SALWorkDir}/dome_Commands.xml
    File Should Exist    ${SALWorkDir}/dome_Events.xml
    File Should Exist    ${SALWorkDir}/dome_Telemetry.xml

Salgen Dome Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing dome
    Should Contain    ${output}    Completed dome validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Shutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Application.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Bogies.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Louvers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_CapacitorBank.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Metrology.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Electrical.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_Screen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_CloseShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Crawl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Louvers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_MovetoCal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_OpenShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Park.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_command_Track.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_AccLimit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_VelLimit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_crawlLost.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_crawling.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_interlock.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_jerkLimit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_lldvError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_lldvOK.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_posLimit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_powerError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_screenLimit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_slewError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_slewOK.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_slewReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_tempError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_trackLost.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dome_logevent_tracking.idl

Salgen Dome HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/dome
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/dome    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dome/dome_Commands.html
    File Should Exist    ${SALWorkDir}/html/dome/dome_Events.html
    File Should Exist    ${SALWorkDir}/html/dome/dome_Telemetry.html

Salgen Dome C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for dome_Azimuth.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Shutter.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Bogies.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Louvers.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_CapacitorBank.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Metrology.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Electrical.idl
    Should Contain    ${output}    Generating SAL CPP code for dome_Screen.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    10
    Should Contain X Times    ${output}    cpp : Done Subscriber    10
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
    Directory Should Exist    ${SALWorkDir}/dome_Azimuth
    Directory Should Exist    ${SALWorkDir}/dome_Shutter
    Directory Should Exist    ${SALWorkDir}/dome_Application
    Directory Should Exist    ${SALWorkDir}/dome_TC
    Directory Should Exist    ${SALWorkDir}/dome_Bogies
    Directory Should Exist    ${SALWorkDir}/dome_Louvers
    Directory Should Exist    ${SALWorkDir}/dome_CapacitorBank
    Directory Should Exist    ${SALWorkDir}/dome_Metrology
    Directory Should Exist    ${SALWorkDir}/dome_Electrical
    Directory Should Exist    ${SALWorkDir}/dome_Screen

Verify Dome C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome_Azimuth/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Azimuth/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Shutter/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Shutter/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Application/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Application/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_TC/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_TC/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Bogies/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Bogies/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Louvers/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Louvers/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_CapacitorBank/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_CapacitorBank/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Metrology/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Metrology/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Electrical/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Electrical/cpp/standalone/sacpp_dome_sub
    File Should Exist    ${SALWorkDir}/dome_Screen/cpp/standalone/sacpp_dome_pub
    File Should Exist    ${SALWorkDir}/dome_Screen/cpp/standalone/sacpp_dome_sub

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
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_CloseShutter_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_CloseShutter_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Crawl_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Crawl_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Louvers_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Louvers_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Move_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Move_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_MovetoCal_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_MovetoCal_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_OpenShutter_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_OpenShutter_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Park_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Park_controller
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Track_commander
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_Track_controller

Verify Dome C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_AccLimit_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_AccLimit_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_VelLimit_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_VelLimit_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_crawlLost_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_crawlLost_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_crawling_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_crawling_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_interlock_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_interlock_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_jerkLimit_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_jerkLimit_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_lldvError_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_lldvError_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_lldvOK_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_lldvOK_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_posLimit_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_posLimit_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_powerError_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_powerError_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_screenLimit_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_screenLimit_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewError_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewError_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewOK_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewOK_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewReady_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_slewReady_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_tempError_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_tempError_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_trackLost_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_trackLost_log
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_tracking_send
    File Should Exist    ${SALWorkDir}/dome/cpp/src/sacpp_dome_tracking_log

Salgen Dome Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for dome_Application.idl
    Should Contain    ${output}    Processing dome Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
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
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/dome_${SALVersion}/pom.xml

Salgen Dome Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome sal python
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
    File Should Exist    ${SALWorkDir}/dome/python/dome_Azimuth_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Azimuth_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Shutter_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Shutter_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Bogies_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Bogies_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Louvers_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Louvers_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_CapacitorBank_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_CapacitorBank_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Metrology_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Metrology_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Electrical_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Electrical_Subscriber.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Screen_Publisher.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Screen_Subscriber.py

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
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_CloseShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_CloseShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Crawl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Crawl.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Louvers.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Louvers.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Move.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Move.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_MovetoCal.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_MovetoCal.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_OpenShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_OpenShutter.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Park.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Park.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Commander_Track.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Controller_Track.py

Verify Dome Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dome/python    pattern=*dome*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_AccLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_AccLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_VelLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_VelLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_crawlLost.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_crawlLost.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_crawling.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_crawling.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_interlock.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_interlock.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_jerkLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_jerkLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_lldvError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_lldvError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_lldvOK.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_lldvOK.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_posLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_posLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_powerError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_powerError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_screenLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_screenLimit.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_slewError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_slewError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_slewOK.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_slewOK.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_slewReady.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_slewReady.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_tempError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_tempError.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_trackLost.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_trackLost.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_Event_tracking.py
    File Should Exist    ${SALWorkDir}/dome/python/dome_EventLogger_tracking.py

Salgen Dome LabVIEW
    [Documentation]    Generate dome low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator dome labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/dome/labview
    @{files}=    List Directory    ${SALWorkDir}/dome/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dome/labview/SAL_dome_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/dome/labview/SAL_dome_shmem.h
