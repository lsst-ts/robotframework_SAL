*** Settings ***
Documentation    This suite builds the various interfaces for the MTMount.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    MTMount
${timeout}    1200s

*** Test Cases ***
Verify MTMount XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/MTMount_Commands.xml
    File Should Exist    ${SALWorkDir}/MTMount_Events.xml
    File Should Exist    ${SALWorkDir}/MTMount_Telemetry.xml

Salgen MTMount Validate
    [Documentation]    Validate the MTMount XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Az.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Alt.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Az_CW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Az_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Alt_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Az_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Alt_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Bal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_MC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cam_CW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cab_TC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_DP_1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_DP_2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_MotionParameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveToTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_trackTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearerror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountInPosition.idl

Salgen MTMount HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Telemetry.html

Salgen MTMount C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Az.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Alt.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Az_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Az_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Alt_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Az_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Alt_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Bal.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_MC.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cam_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cab_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_DP_1.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_DP_2.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_MotionParameters.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    14
    Should Contain X Times    ${output}    cpp : Done Subscriber    14
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify MTMount Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Az
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Alt
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Az_CW
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Az_OSS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Alt_OSS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Az_TC
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Alt_TC
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Bal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_MC
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cam_CW
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cab_TC
    Directory Should Exist    ${SALWorkDir}/${subSystem}_DP_1
    Directory Should Exist    ${SALWorkDir}/${subSystem}_DP_2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_MotionParameters

Verify MTMount C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_Az/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_CW/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_CW/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_OSS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_OSS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt_OSS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt_OSS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_TC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Az_TC/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt_TC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Alt_TC/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Bal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Bal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_MC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_MC/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cam_CW/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cam_CW/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cab_TC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cab_TC/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_DP_1/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_DP_1/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_DP_2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_DP_2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_MotionParameters/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_MotionParameters/cpp/standalone/sacpp_${subSystem}_sub

Verify MTMount C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller

Verify MTMount C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCamWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCamWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCamWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCamWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearerror_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearerror_controller

Verify MTMount C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountError_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountInPosition_log

Salgen MTMount Python
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTMount Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Az_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Alt_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Bal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Bal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MC_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cam_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cam_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cab_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cab_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DP_1_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DP_1_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DP_2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_DP_2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MotionParameters_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_MotionParameters_Subscriber.py

Verify MTMount Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    python
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py

Verify MTMount Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveToTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveToTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearerror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearerror.py

Verify MTMount Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountInPosition.py

Salgen MTMount LabVIEW
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

Salgen MTMount Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Az.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Alt.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Az_CW.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Az_OSS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Alt_OSS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Az_TC.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Alt_TC.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Bal.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_MC.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cam_CW.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cab_TC.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_DP_1.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_DP_2.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_MotionParameters.idl
    Should Contain X Times    ${output}    javac : Done Publisher    14
    Should Contain X Times    ${output}    javac : Done Subscriber    14
    Should Contain X Times    ${output}    javac : Done Commander/Controller    14
    Should Contain X Times    ${output}    javac : Done Event/Logger    14
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTMount Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java    TSS-2602
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

