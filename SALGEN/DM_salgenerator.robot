*** Settings ***
Documentation    This suite builds the various interfaces for the DM.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    dm
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

Verify DM XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/dm_Events.xml
    File Should Exist    ${SALWorkDir}/dm_Telemetry.xml

Salgen DM Validate
    [Documentation]    Validate the DM XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_alert_dq.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_alert_psf.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_alert_summary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_available_replicators_distributors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_efd_slave_replication_state.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_international_network_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_raft_images_sent_current.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_successfully_archived.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_summit_to_base_network_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dmPublished.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dmToArchive.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dmToBase.idl

Salgen DM HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/dm_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/dm_Telemetry.html

Salgen DM C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_alert_dq.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_alert_psf.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_alert_summary.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_available_replicators_distributors.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_efd_slave_replication_state.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_international_network_status.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_raft_images_sent_current.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_successfully_archived.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_summit_to_base_network_status.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    9
    Should Contain X Times    ${output}    cpp : Done Subscriber    9
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

Verify DM Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_dq
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_psf
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_summary
    Directory Should Exist    ${SALWorkDir}/${subSystem}_available_replicators_distributors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_efd_slave_replication_state
    Directory Should Exist    ${SALWorkDir}/${subSystem}_international_network_status
    Directory Should Exist    ${SALWorkDir}/${subSystem}_raft_images_sent_current
    Directory Should Exist    ${SALWorkDir}/${subSystem}_successfully_archived
    Directory Should Exist    ${SALWorkDir}/${subSystem}_summit_to_base_network_status

Verify DM C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_dq/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_dq/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_psf/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_psf/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_summary/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_alert_summary/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_available_replicators_distributors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_available_replicators_distributors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_efd_slave_replication_state/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_efd_slave_replication_state/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_international_network_status/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_international_network_status/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_raft_images_sent_current/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_raft_images_sent_current/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_successfully_archived/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_successfully_archived/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_summit_to_base_network_status/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_summit_to_base_network_status/cpp/standalone/sacpp_${subSystem}_sub

Verify DM C++ State Command Interfaces
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

Verify DM C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmPublished_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmPublished_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmToArchive_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmToArchive_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmToBase_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dmToBase_log

Salgen DM Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_alert_dq.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_alert_psf.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_alert_summary.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_available_replicators_distributors.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_efd_slave_replication_state.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_international_network_status.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_raft_images_sent_current.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_successfully_archived.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_summit_to_base_network_status.idl
    Should Contain X Times    ${output}    javac : Done Publisher    9
    Should Contain X Times    ${output}    javac : Done Subscriber    9
    Should Contain X Times    ${output}    javac : Done Commander/Controller    9
    Should Contain X Times    ${output}    javac : Done Event/Logger    9
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen DM Maven
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

Salgen DM Python
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

Verify DM Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_dq_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_dq_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_psf_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_psf_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_summary_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_alert_summary_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_available_replicators_distributors_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_available_replicators_distributors_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_efd_slave_replication_state_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_efd_slave_replication_state_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_international_network_status_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_international_network_status_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_raft_images_sent_current_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_raft_images_sent_current_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_successfully_archived_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_successfully_archived_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_summit_to_base_network_status_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_summit_to_base_network_status_Subscriber.py

Verify DM Python State Command Interfaces
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

Verify DM Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dmPublished.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dmPublished.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dmToArchive.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dmToArchive.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dmToBase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dmToBase.py

Salgen DM LabVIEW
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
