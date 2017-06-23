*** Settings ***
Documentation    This suite builds the various interfaces for the Camera.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    camera
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

Verify Camera XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/camera_Commands.xml
    File Should Exist    ${SALWorkDir}/camera_Events.xml
    File Should Exist    ${SALWorkDir}/camera_Telemetry.xml

Salgen Camera Validate
    [Documentation]    Validate the Camera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cold.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_SAS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_SDS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Filter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Prot.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_CCS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Purge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_WDS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cluster_Encoder.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Shutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_GDS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_GAS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_PCMS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cryo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_WAS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initGuiders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_takeImages.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ccsConfigured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endInitializeGuider.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endInitializeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endLoadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endRotateCarousel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endUnloadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_notReadyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_prepareToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_readyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startIntegration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startLoadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startRotateCarousel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startUnloadFilter.idl

Salgen Camera HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Telemetry.html

Salgen Camera C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cold.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_SAS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_SDS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Filter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Prot.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_CCS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Purge.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_WDS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cluster_Encoder.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Shutter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_GDS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_GAS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_PCMS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cryo.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_WAS.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    15
    Should Contain X Times    ${output}    cpp : Done Subscriber    15
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

Verify Camera Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cold
    Directory Should Exist    ${SALWorkDir}/${subSystem}_SAS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_SDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Filter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Prot
    Directory Should Exist    ${SALWorkDir}/${subSystem}_CCS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Purge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cluster_Encoder
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Shutter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_GDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_GAS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_PCMS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cryo
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WAS

Verify Camera C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_Cold/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cold/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_SAS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_SAS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_SDS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_SDS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Filter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Filter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Prot/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Prot/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_CCS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_CCS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Purge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Purge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_WDS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_WDS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cluster_Encoder/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cluster_Encoder/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Shutter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Shutter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_GDS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_GDS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_GAS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_GAS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_PCMS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_PCMS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cryo/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cryo/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_WAS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_WAS/cpp/standalone/sacpp_${subSystem}_sub

Verify Camera C++ State Command Interfaces
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

Verify Camera C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_controller

Verify Camera C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsConfigured_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsConfigured_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeGuider_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeGuider_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLoadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLoadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endRotateCarousel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endRotateCarousel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endSetFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endSetFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endUnloadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endUnloadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prepareToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prepareToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_readyToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_readyToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLoadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLoadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startRotateCarousel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startRotateCarousel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_log

Salgen Camera Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cold.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_SAS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_SDS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Filter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Prot.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_CCS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Purge.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_WDS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cluster_Encoder.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Shutter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_GDS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_GAS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_PCMS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cryo.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_WAS.idl
    Should Contain X Times    ${output}    javac : Done Publisher    15
    Should Contain X Times    ${output}    javac : Done Subscriber    15
    Should Contain X Times    ${output}    javac : Done Commander/Controller    15
    Should Contain X Times    ${output}    javac : Done Event/Logger    15
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Camera Maven
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

Salgen Camera Python
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

Verify Camera Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cold_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cold_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SAS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SAS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SDS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_SDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Filter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Filter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Prot_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Prot_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_CCS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_CCS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Purge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Purge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WDS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cluster_Encoder_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cluster_Encoder_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Shutter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Shutter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GDS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GDS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GAS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_GAS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PCMS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_PCMS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cryo_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cryo_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WAS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_WAS_Subscriber.py

Verify Camera Python State Command Interfaces
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

Verify Camera Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_takeImages.py

Verify Camera Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ccsConfigured.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ccsConfigured.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endInitializeGuider.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endInitializeGuider.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endInitializeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endInitializeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_prepareToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_prepareToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_readyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_readyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startUnloadFilter.py

Salgen Camera LabVIEW
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