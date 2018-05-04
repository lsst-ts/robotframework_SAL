*** Settings ***
Documentation    This suite builds the various interfaces for the Scheduler.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    scheduler
${timeout}    1200s

*** Test Cases ***
Verify Scheduler XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler_Telemetry.xml

Salgen Scheduler Validate
    [Documentation]    Validate the Scheduler XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timeHandler.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cloud.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_seeing.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_filterSwap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_schedulerConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_driverConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_field.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_obsSiteConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_telescopeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rotatorConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_domeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cameraConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_slewConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_opticsLoopCorrConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_parkConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_generalPropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sequencePropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observatoryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observation.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_interestedProposal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_parameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Application.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_program.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_progress.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rankingData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_econstraints.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_iconstraints.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl

Salgen Scheduler HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/scheduler_Telemetry.html

Salgen Scheduler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timeHandler.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cloud.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_seeing.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_filterSwap.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_driverConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_field.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_domeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_slewConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_parkConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_observatoryState.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_target.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_observation.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_parameters.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Application.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_program.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_progress.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_rankingData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_econstraints.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_iconstraints.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    28
    Should Contain X Times    ${output}    cpp : Done Subscriber    28
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

Verify Scheduler Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeHandler
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cloud
    Directory Should Exist    ${SALWorkDir}/${subSystem}_seeing
    Directory Should Exist    ${SALWorkDir}/${subSystem}_filterSwap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_driverConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_field
    Directory Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_domeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_slewConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_parkConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observatoryState
    Directory Should Exist    ${SALWorkDir}/${subSystem}_target
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_parameters
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Application
    Directory Should Exist    ${SALWorkDir}/${subSystem}_program
    Directory Should Exist    ${SALWorkDir}/${subSystem}_progress
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rankingData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_econstraints
    Directory Should Exist    ${SALWorkDir}/${subSystem}_iconstraints

Verify Scheduler C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloud/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloud/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_filterSwap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_filterSwap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_field/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_field/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_target/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_target/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_parameters/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_parameters/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Application/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Application/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_program/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_program/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_progress/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_progress/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rankingData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rankingData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_econstraints/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_econstraints/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_iconstraints/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_iconstraints/cpp/standalone/sacpp_${subSystem}_sub

Verify Scheduler C++ State Command Interfaces
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

Salgen Scheduler Python
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

Verify Scheduler Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloud_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloud_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_filterSwap_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_filterSwap_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_field_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_field_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_target_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_target_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parameters_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parameters_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Application_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Application_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_program_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_program_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_progress_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_progress_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rankingData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rankingData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_econstraints_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_econstraints_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_iconstraints_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_iconstraints_Subscriber.py

Verify Scheduler Python State Command Interfaces
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

Salgen Scheduler Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timeHandler.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cloud.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_seeing.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_filterSwap.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_driverConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_field.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_domeConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_slewConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_parkConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_observatoryState.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_target.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_observation.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_parameters.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Application.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_program.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_progress.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_rankingData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_econstraints.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_iconstraints.idl
    Should Contain X Times    ${output}    javac : Done Publisher    28
    Should Contain X Times    ${output}    javac : Done Subscriber    28
    Should Contain X Times    ${output}    javac : Done Commander/Controller    28
    Should Contain X Times    ${output}    javac : Done Event/Logger    28
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Scheduler Maven
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

