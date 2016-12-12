*** Settings ***
Documentation    This suite builds the various interfaces for the MTMount.
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

Verify MTMount XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount_Commands.xml
    File Should Exist    ${SALWorkDir}/MTMount_Events.xml
    File Should Exist    ${SALWorkDir}/MTMount_Telemetry.xml

Salgen MTMount Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing MTMount
    Should Contain    ${output}    Completed MTMount validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Az.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Alt.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Az_CW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Az_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Alt_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Az_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Alt_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Bal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_MC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Cam_CW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_Cab_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_DP_1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_DP_2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_MotionParameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_closeMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_configure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_disableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_enableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_moveToTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_openMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_trackTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_command_clearerror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_logevent_mountState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_logevent_mountWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_logevent_mountError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/MTMount_logevent_mountInPosition.idl

Salgen MTMount HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/MTMount
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/MTMount    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/MTMount/MTMount_Commands.html
    File Should Exist    ${SALWorkDir}/html/MTMount/MTMount_Events.html
    File Should Exist    ${SALWorkDir}/html/MTMount/MTMount_Telemetry.html

Salgen MTMount C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Az.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Alt.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Az_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Az_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Alt_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Az_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Alt_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Bal.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_MC.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Cam_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_Cab_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_DP_1.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_DP_2.idl
    Should Contain    ${output}    Generating SAL CPP code for MTMount_MotionParameters.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    14
    Should Contain X Times    ${output}    cpp : Done Subscriber    14
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/MTMount/cpp
    @{files}=    List Directory    ${SALWorkDir}/MTMount/cpp    pattern=*MTMount*
    File Should Exist    ${SALWorkDir}/MTMount/cpp/libsacpp_MTMount_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*MTMount*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_MTMount.idl

Verify MTMount Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*MTMount*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/MTMount_Az
    Directory Should Exist    ${SALWorkDir}/MTMount_Alt
    Directory Should Exist    ${SALWorkDir}/MTMount_Az_CW
    Directory Should Exist    ${SALWorkDir}/MTMount_Az_OSS
    Directory Should Exist    ${SALWorkDir}/MTMount_Alt_OSS
    Directory Should Exist    ${SALWorkDir}/MTMount_Az_TC
    Directory Should Exist    ${SALWorkDir}/MTMount_Alt_TC
    Directory Should Exist    ${SALWorkDir}/MTMount_Bal
    Directory Should Exist    ${SALWorkDir}/MTMount_MC
    Directory Should Exist    ${SALWorkDir}/MTMount_Cam_CW
    Directory Should Exist    ${SALWorkDir}/MTMount_Cab_TC
    Directory Should Exist    ${SALWorkDir}/MTMount_DP_1
    Directory Should Exist    ${SALWorkDir}/MTMount_DP_2
    Directory Should Exist    ${SALWorkDir}/MTMount_MotionParameters

Verify MTMount C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount_Az/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Az/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Alt/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Alt/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Az_CW/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Az_CW/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Az_OSS/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Az_OSS/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Alt_OSS/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Alt_OSS/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Az_TC/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Az_TC/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Alt_TC/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Alt_TC/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Bal/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Bal/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_MC/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_MC/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Cam_CW/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Cam_CW/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_Cab_TC/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_Cab_TC/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_DP_1/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_DP_1/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_DP_2/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_DP_2/cpp/standalone/sacpp_MTMount_sub
    File Should Exist    ${SALWorkDir}/MTMount_MotionParameters/cpp/standalone/sacpp_MTMount_pub
    File Should Exist    ${SALWorkDir}/MTMount_MotionParameters/cpp/standalone/sacpp_MTMount_sub

Verify MTMount C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enable_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enable_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_disable_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_disable_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_abort_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_abort_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enterControl_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enterControl_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_exitControl_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_exitControl_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_standby_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_standby_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_start_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_start_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_stop_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_stop_controller

Verify MTMount C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_closeMirrorCover_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_closeMirrorCover_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_configure_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_configure_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_disableCamWrap_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_disableCamWrap_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enableCamWrap_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_enableCamWrap_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_moveToTarget_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_moveToTarget_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_openMirrorCover_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_openMirrorCover_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_trackTarget_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_trackTarget_controller
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_clearerror_commander
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_clearerror_controller

Verify MTMount C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountState_send
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountState_log
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountWarning_send
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountWarning_log
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountError_send
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountError_log
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountInPosition_send
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/sacpp_MTMount_mountInPosition_log

Salgen MTMount Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for MTMount_Az.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Alt.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Az_CW.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Az_OSS.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Alt_OSS.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Az_TC.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Alt_TC.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Bal.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_MC.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Cam_CW.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_Cab_TC.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_DP_1.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_DP_2.idl
    Should Contain    ${output}    Generating SAL Java code for MTMount_MotionParameters.idl
    Should Contain X Times    ${output}    javac : Done Publisher    14
    Should Contain X Times    ${output}    javac : Done Subscriber    14
    Should Contain X Times    ${output}    javac : Done Commander    1
    Should Contain X Times    ${output}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/MTMount/java
    @{files}=    List Directory    ${SALWorkDir}/MTMount/java    pattern=*MTMount*
    File Should Exist    ${SALWorkDir}/MTMount/java/sal_MTMount.idl

Salgen MTMount Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator MTMount maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_MTMount ${SALVersion}
    Should Contain X Times    ${output}    Tests run: 20, Failures: 0, Errors: 0, Skipped: 0    4
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/MTMount_${SALVersion}/pom.xml

Salgen MTMount Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for MTMount
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_MTMount.so
    Directory Should Exist    ${SALWorkDir}/MTMount/python
    @{files}=    List Directory    ${SALWorkDir}/MTMount/python    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_abort.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_abort.py
    File Should Exist    ${SALWorkDir}/MTMount/cpp/src/SALPY_MTMount.so

Verify MTMount Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/MTMount/python    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Az_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Alt_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Bal_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Bal_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_MC_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_MC_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Cam_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Cam_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Cab_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Cab_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_DP_1_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_DP_1_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_DP_2_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_DP_2_Subscriber.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_MotionParameters_Publisher.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_MotionParameters_Subscriber.py

Verify MTMount Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_enable.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_enable.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_disable.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_disable.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_abort.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_abort.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_standby.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_standby.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_start.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_start.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_stop.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_stop.py

Verify MTMount Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/MTMount/python    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_configure.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_configure.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_moveToTarget.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_moveToTarget.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_trackTarget.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_trackTarget.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Commander_clearerror.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Controller_clearerror.py

Verify MTMount Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/MTMount/python    pattern=*MTMount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Event_mountState.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_EventLogger_mountState.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Event_mountWarning.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_EventLogger_mountWarning.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Event_mountError.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_EventLogger_mountError.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_Event_mountInPosition.py
    File Should Exist    ${SALWorkDir}/MTMount/python/MTMount_EventLogger_mountInPosition.py

Salgen MTMount LabVIEW
    [Documentation]    Generate MTMount low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator MTMount labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/MTMount/labview
    @{files}=    List Directory    ${SALWorkDir}/MTMount/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/MTMount/labview/SAL_MTMount_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/MTMount/labview/SAL_MTMount_shmem.h
    File Should Exist    ${SALWorkDir}/MTMount/labview/SALLV_MTMount.so
