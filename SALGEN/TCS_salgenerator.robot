*** Settings ***
Documentation    This suite builds the various interfaces for the TCS.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    tcs
${timeout}    1500s

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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_PointingModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_AOCS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_TimeKeeper.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_Site.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_Target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_PointingControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_TrackRefSys.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ZEMAX.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_PointingLog.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_DawdleFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_OpticsVt.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_WEP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_TrackingTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernel_FK5Target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_wfpCalculate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_wfpSimulate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_wfpDataReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_zemaxError.idl

Salgen TCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/tcs_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/tcs_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/tcs_Telemetry.html

Salgen TCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_PointingModel.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_AOCS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_TimeKeeper.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_Site.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_Target.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_PointingControl.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_TrackRefSys.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ZEMAX.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_PointingLog.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_DawdleFilter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_OpticsVt.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_WEP.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_TrackingTarget.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernel_FK5Target.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    14
    Should Contain X Times    ${output}    cpp : Done Subscriber    14
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

Verify TCS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingModel
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AOCS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TimeKeeper
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_Site
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_Target
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingControl
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackRefSys
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ZEMAX
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingLog
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_DawdleFilter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_OpticsVt
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WEP
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackingTarget
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_FK5Target

Verify TCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingModel/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingModel/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_AOCS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_AOCS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TimeKeeper/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TimeKeeper/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_Site/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_Site/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_Target/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_Target/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingControl/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingControl/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackRefSys/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackRefSys/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ZEMAX/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ZEMAX/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingLog/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingLog/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_DawdleFilter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_DawdleFilter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_OpticsVt/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_OpticsVt/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_WEP/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_WEP/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackingTarget/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackingTarget/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_FK5Target/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernel_FK5Target/cpp/standalone/sacpp_${subSystem}_sub

Verify TCS C++ State Command Interfaces
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

Verify TCS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpCalculate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpCalculate_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpSimulate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpSimulate_controller

Verify TCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpDataReady_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpDataReady_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_zemaxError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_zemaxError_log

Salgen TCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_PointingModel.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_AOCS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_TimeKeeper.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_Site.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_Target.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_PointingControl.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_TrackRefSys.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ZEMAX.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_PointingLog.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_DawdleFilter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_OpticsVt.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_WEP.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_TrackingTarget.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernel_FK5Target.idl
    Should Contain X Times    ${output}    javac : Done Publisher    14
    Should Contain X Times    ${output}    javac : Done Subscriber    14
    Should Contain X Times    ${output}    javac : Done Commander/Controller    14
    Should Contain X Times    ${output}    javac : Done Event/Logger    14
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen TCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

Salgen TCS Python
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

Verify TCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingModel_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingModel_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AOCS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_AOCS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TimeKeeper_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TimeKeeper_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_Site_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_Site_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_Target_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_Target_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingControl_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingControl_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TrackRefSys_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TrackRefSys_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ZEMAX_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ZEMAX_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingLog_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_PointingLog_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_DawdleFilter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_DawdleFilter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_OpticsVt_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_OpticsVt_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WEP_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WEP_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TrackingTarget_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_TrackingTarget_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_FK5Target_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernel_FK5Target_Subscriber.py

Verify TCS Python State Command Interfaces
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

Verify TCS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_wfpSimulate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_wfpSimulate.py

Verify TCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_zemaxError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_zemaxError.py

Salgen TCS LabVIEW
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