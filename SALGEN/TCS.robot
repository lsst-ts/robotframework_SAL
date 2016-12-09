*** Settings ***
Documentation    This suite builds the various interfaces for the TCS.
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

Verify TCS XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs_Commands.xml
    File Should Exist    ${SALWorkDir}/tcs_Events.xml
    File Should Exist    ${SALWorkDir}/tcs_Telemetry.xml

Salgen TCS Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing tcs
    Should Contain    ${output}    Completed tcs validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_PointingModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_AOCS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_TimeKeeper.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_Site.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_Target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_PointingControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_TrackRefSys.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_ZEMAX.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_PointingLog.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_DawdleFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_OpticsVt.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_WEP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_TrackingTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_kernel_FK5Target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_wfpCalculate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_command_wfpSimulate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_logevent_wfpDataReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/tcs_logevent_zemaxError.idl

Salgen TCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/tcs
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/tcs    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/tcs/tcs_Commands.html
    File Should Exist    ${SALWorkDir}/html/tcs/tcs_Events.html
    File Should Exist    ${SALWorkDir}/html/tcs/tcs_Telemetry.html

Salgen TCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_PointingModel.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_AOCS.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_TimeKeeper.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_Site.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_Target.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_PointingControl.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_TrackRefSys.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_ZEMAX.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_PointingLog.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_DawdleFilter.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_OpticsVt.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_WEP.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_TrackingTarget.idl
    Should Contain    ${output}    Generating SAL CPP code for tcs_kernel_FK5Target.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    14
    Should Contain X Times    ${output}    cpp : Done Subscriber    14
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/tcs/cpp
    @{files}=    List Directory    ${SALWorkDir}/tcs/cpp    pattern=*tcs*
    File Should Exist    ${SALWorkDir}/tcs/cpp/libsacpp_tcs_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*tcs*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_tcs.idl

Verify TCS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*tcs*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_PointingModel
    Directory Should Exist    ${SALWorkDir}/tcs_AOCS
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_TimeKeeper
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_Site
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_Target
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_PointingControl
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_TrackRefSys
    Directory Should Exist    ${SALWorkDir}/tcs_ZEMAX
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_PointingLog
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_DawdleFilter
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_OpticsVt
    Directory Should Exist    ${SALWorkDir}/tcs_WEP
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_TrackingTarget
    Directory Should Exist    ${SALWorkDir}/tcs_kernel_FK5Target

Verify TCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingModel/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingModel/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_AOCS/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_AOCS/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TimeKeeper/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TimeKeeper/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_Site/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_Site/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_Target/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_Target/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingControl/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingControl/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TrackRefSys/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TrackRefSys/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_ZEMAX/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_ZEMAX/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingLog/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_PointingLog/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_DawdleFilter/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_DawdleFilter/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_OpticsVt/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_OpticsVt/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_WEP/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_WEP/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TrackingTarget/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_TrackingTarget/cpp/standalone/sacpp_tcs_sub
    File Should Exist    ${SALWorkDir}/tcs_kernel_FK5Target/cpp/standalone/sacpp_tcs_pub
    File Should Exist    ${SALWorkDir}/tcs_kernel_FK5Target/cpp/standalone/sacpp_tcs_sub

Verify TCS C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_enable_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_enable_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_disable_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_disable_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_abort_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_abort_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_enterControl_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_enterControl_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_exitControl_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_exitControl_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_standby_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_standby_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_start_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_start_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_stop_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_stop_controller

Verify TCS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpCalculate_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpCalculate_controller
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpSimulate_commander
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpSimulate_controller

Verify TCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpDataReady_send
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_wfpDataReady_log
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_zemaxError_send
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/sacpp_tcs_zemaxError_log

Salgen TCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for tcs_Application.idl
    Should Contain    ${output}    Processing tcs Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/tcs/java
    @{files}=    List Directory    ${SALWorkDir}/tcs/java    pattern=*tcs*
    File Should Exist    ${SALWorkDir}/tcs/java/sal_tcs.idl

Salgen TCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator tcs maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_tcs ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/tcs_${SALVersion}/pom.xml

Salgen TCS Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for tcs
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_tcs.so
    Directory Should Exist    ${SALWorkDir}/tcs/python
    @{files}=    List Directory    ${SALWorkDir}/tcs/python    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_abort.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_abort.py
    File Should Exist    ${SALWorkDir}/tcs/cpp/src/SALPY_tcs.so

Verify TCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/tcs/python    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingModel_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingModel_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_AOCS_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_AOCS_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TimeKeeper_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TimeKeeper_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_Site_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_Site_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_Target_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_Target_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingControl_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingControl_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TrackRefSys_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TrackRefSys_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_ZEMAX_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_ZEMAX_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingLog_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_PointingLog_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_DawdleFilter_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_DawdleFilter_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_OpticsVt_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_OpticsVt_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_WEP_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_WEP_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TrackingTarget_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_TrackingTarget_Subscriber.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_FK5Target_Publisher.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_kernel_FK5Target_Subscriber.py

Verify TCS Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_enable.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_enable.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_disable.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_disable.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_abort.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_abort.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_standby.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_standby.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_start.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_start.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_stop.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_stop.py

Verify TCS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/tcs/python    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Commander_wfpSimulate.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Controller_wfpSimulate.py

Verify TCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/tcs/python    pattern=*tcs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Event_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_EventLogger_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_Event_zemaxError.py
    File Should Exist    ${SALWorkDir}/tcs/python/tcs_EventLogger_zemaxError.py

Salgen TCS LabVIEW
    [Documentation]    Generate tcs low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator tcs labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/tcs/labview
    @{files}=    List Directory    ${SALWorkDir}/tcs/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/tcs/labview/SAL_tcs_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/tcs/labview/SAL_tcs_shmem.h
