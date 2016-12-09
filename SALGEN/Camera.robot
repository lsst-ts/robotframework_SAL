*** Settings ***
Documentation    This suite builds the various interfaces for the Camera.
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

Verify Camera XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/camera_Commands.xml
    File Should Exist    ${SALWorkDir}/camera_Events.xml
    File Should Exist    ${SALWorkDir}/camera_Telemetry.xml

Salgen Camera Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing camera
    Should Contain    ${output}    Completed camera validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_camera.idl

Salgen Camera HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/camera
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/camera    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/camera/camera_Commands.html
    File Should Exist    ${SALWorkDir}/html/camera/camera_Events.html
    File Should Exist    ${SALWorkDir}/html/camera/camera_Telemetry.html

Salgen Camera C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for camera_Cold.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_SAS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_SDS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Filter.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Prot.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_CCS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Purge.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_WDS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Cluster_Encoder.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Shutter.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_GDS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_GAS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_PCMS.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_Cryo.idl
    Should Contain    ${output}    Generating SAL CPP code for camera_WAS.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    16
    Should Contain X Times    ${output}    cpp : Done Subscriber    16
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/camera/cpp
    @{files}=    List Directory    ${SALWorkDir}/camera/cpp    pattern=*camera*
    File Should Exist    ${SALWorkDir}/camera/cpp/libsacpp_camera_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*camera*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_camera.idl

Verify Camera Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*camera*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/camera_Cold
    Directory Should Exist    ${SALWorkDir}/camera_SAS
    Directory Should Exist    ${SALWorkDir}/camera_SDS
    Directory Should Exist    ${SALWorkDir}/camera_Filter
    Directory Should Exist    ${SALWorkDir}/camera_Prot
    Directory Should Exist    ${SALWorkDir}/camera_CCS
    Directory Should Exist    ${SALWorkDir}/camera_Purge
    Directory Should Exist    ${SALWorkDir}/camera_WDS
    Directory Should Exist    ${SALWorkDir}/camera_Cluster_Encoder
    Directory Should Exist    ${SALWorkDir}/camera_Shutter
    Directory Should Exist    ${SALWorkDir}/camera_GDS
    Directory Should Exist    ${SALWorkDir}/camera_GAS
    Directory Should Exist    ${SALWorkDir}/camera_PCMS
    Directory Should Exist    ${SALWorkDir}/camera_Cryo
    Directory Should Exist    ${SALWorkDir}/camera_WAS

Verify Camera C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/camera_Cold/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Cold/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_SAS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_SAS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_SDS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_SDS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Filter/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Filter/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Prot/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Prot/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_CCS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_CCS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Purge/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Purge/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_WDS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_WDS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Cluster_Encoder/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Cluster_Encoder/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Shutter/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Shutter/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_GDS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_GDS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_GAS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_GAS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_PCMS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_PCMS/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_Cryo/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_Cryo/cpp/standalone/sacpp_camera_sub
    File Should Exist    ${SALWorkDir}/camera_WAS/cpp/standalone/sacpp_camera_pub
    File Should Exist    ${SALWorkDir}/camera_WAS/cpp/standalone/sacpp_camera_sub

Verify Camera C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_enable_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_enable_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_disable_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_disable_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_abort_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_abort_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_enterControl_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_enterControl_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_exitControl_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_exitControl_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_standby_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_standby_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_start_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_start_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_stop_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_stop_controller

Verify Camera C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_configure_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_configure_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_initGuiders_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_initGuiders_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_initImage_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_initImage_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_setFilter_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_setFilter_controller
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_takeImages_commander
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_command_takeImages_controller

Verify Camera C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_ccsConfigured_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_ccsConfigured_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endInitializeGuider_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endInitializeGuider_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endInitializeImage_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endInitializeImage_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endLoadFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endLoadFilter_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endReadout_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endReadout_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endRotateCarousel_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endRotateCarousel_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endSetFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endSetFilter_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endShutterClose_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endShutterClose_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endShutterOpen_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endShutterOpen_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endTakeImage_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endTakeImage_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endUnloadFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_endUnloadFilter_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_notReadyToTakeImage_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_notReadyToTakeImage_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_prepareToTakeImage_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_prepareToTakeImage_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_readyToTakeImage_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_readyToTakeImage_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startIntegration_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startIntegration_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startLoadFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startLoadFilter_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startReadout_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startReadout_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startRotateCarousel_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startRotateCarousel_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startSetFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startSetFilter_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startShutterClose_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startShutterClose_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startShutterOpen_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startShutterOpen_log
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startUnloadFilter_send
    File Should Exist    ${SALWorkDir}/camera/cpp/src/sacpp_camera_logevent_startUnloadFilter_log

Salgen Camera Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for camera_Application.idl
    Should Contain    ${output}    Processing camera Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/camera/java
    @{files}=    List Directory    ${SALWorkDir}/camera/java    pattern=*camera*
    File Should Exist    ${SALWorkDir}/camera/java/sal_camera.idl

Salgen Camera Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator camera maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_camera ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/camera_${SALVersion}/pom.xml

Salgen Camera Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for camera
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_camera.so
    Directory Should Exist    ${SALWorkDir}/camera/python
    @{files}=    List Directory    ${SALWorkDir}/camera/python    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_abort.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_abort.py
    File Should Exist    ${SALWorkDir}/camera/cpp/src/SALPY_camera.so

Verify Camera Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/camera/python    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cold_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cold_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_SAS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_SAS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_SDS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_SDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Filter_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Filter_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Prot_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Prot_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_CCS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_CCS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Purge_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Purge_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_WDS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_WDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cluster_Encoder_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cluster_Encoder_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Shutter_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Shutter_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_GDS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_GDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_GAS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_GAS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_PCMS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_PCMS_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cryo_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Cryo_Subscriber.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_WAS_Publisher.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_WAS_Subscriber.py

Verify Camera Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_enable.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_enable.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_disable.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_disable.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_abort.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_abort.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_standby.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_standby.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_start.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_start.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Commander_stop.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_Controller_stop.py

Verify Camera Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/camera/python    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_configure_Commander.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_configure_Controller.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_initGuiders_Commander.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_initGuiders_Controller.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_initImage_Commander.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_initImage_Controller.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_setFilter_Commander.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_setFilter_Controller.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_takeImages_Commander.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_command_takeImages_Controller.py

Verify Camera Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/camera/python    pattern=*camera*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_ccsConfigured_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_ccsConfigured_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endInitializeGuider_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endInitializeGuider_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endInitializeImage_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endInitializeImage_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endLoadFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endLoadFilter_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endReadout_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endReadout_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endRotateCarousel_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endRotateCarousel_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endSetFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endSetFilter_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endShutterClose_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endShutterClose_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endShutterOpen_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endShutterOpen_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endTakeImage_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endTakeImage_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endUnloadFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_endUnloadFilter_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_notReadyToTakeImage_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_notReadyToTakeImage_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_prepareToTakeImage_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_prepareToTakeImage_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_readyToTakeImage_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_readyToTakeImage_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startIntegration_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startIntegration_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startLoadFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startLoadFilter_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startReadout_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startReadout_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startRotateCarousel_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startRotateCarousel_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startSetFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startSetFilter_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startShutterClose_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startShutterClose_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startShutterOpen_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startShutterOpen_EventLogger.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startUnloadFilter_Event.py
    File Should Exist    ${SALWorkDir}/camera/python/camera_logevent_startUnloadFilter_EventLogger.py

Salgen Camera LabVIEW
    [Documentation]    Generate camera low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator camera labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/camera/labview
    @{files}=    List Directory    ${SALWorkDir}/camera/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/camera/labview/SAL_camera_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/camera/labview/SAL_camera_shmem.h
