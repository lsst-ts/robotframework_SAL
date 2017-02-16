*** Settings ***
Documentation    This suite builds the various interfaces for the DM.
Suite Setup    Log Many    ${Host}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${timeout}    1200s

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
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing dm
    Should Contain    ${output}    Completed dm validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*dm*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/dm_alert_dq.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_alert_psf.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_alert_summary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_available_replicators_distributors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_efd_slave_replication_state.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_international_network_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_raft_images_sent_current.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_successfully_archived.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_summit_to_base_network_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_logevent_dmPublished.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_logevent_dmToArchive.idl
    File Should Exist    ${SALWorkDir}/idl-templates/dm_logevent_dmToBase.idl

Salgen DM HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/dm
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/dm    pattern=*dm*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dm/dm_Events.html
    File Should Exist    ${SALWorkDir}/html/dm/dm_Telemetry.html

Salgen DM C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for dm_alert_dq.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_alert_psf.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_alert_summary.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_available_replicators_distributors.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_efd_slave_replication_state.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_international_network_status.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_raft_images_sent_current.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_successfully_archived.idl
    Should Contain    ${output}    Generating SAL CPP code for dm_summit_to_base_network_status.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    9
    Should Contain X Times    ${output}    cpp : Done Subscriber    9
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/dm/cpp
    @{files}=    List Directory    ${SALWorkDir}/dm/cpp    pattern=*dm*
    File Should Exist    ${SALWorkDir}/dm/cpp/libsacpp_dm_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*dm*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_dm.idl

Verify DM Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*dm*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/dm_alert_dq
    Directory Should Exist    ${SALWorkDir}/dm_alert_psf
    Directory Should Exist    ${SALWorkDir}/dm_alert_summary
    Directory Should Exist    ${SALWorkDir}/dm_available_replicators_distributors
    Directory Should Exist    ${SALWorkDir}/dm_efd_slave_replication_state
    Directory Should Exist    ${SALWorkDir}/dm_international_network_status
    Directory Should Exist    ${SALWorkDir}/dm_raft_images_sent_current
    Directory Should Exist    ${SALWorkDir}/dm_successfully_archived
    Directory Should Exist    ${SALWorkDir}/dm_summit_to_base_network_status

Verify DM C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dm_alert_dq/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_alert_dq/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_alert_psf/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_alert_psf/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_alert_summary/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_alert_summary/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_available_replicators_distributors/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_available_replicators_distributors/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_efd_slave_replication_state/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_efd_slave_replication_state/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_international_network_status/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_international_network_status/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_raft_images_sent_current/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_raft_images_sent_current/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_successfully_archived/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_successfully_archived/cpp/standalone/sacpp_dm_sub
    File Should Exist    ${SALWorkDir}/dm_summit_to_base_network_status/cpp/standalone/sacpp_dm_pub
    File Should Exist    ${SALWorkDir}/dm_summit_to_base_network_status/cpp/standalone/sacpp_dm_sub

Verify DM C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_enable_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_enable_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_disable_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_disable_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_abort_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_abort_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_enterControl_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_enterControl_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_exitControl_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_exitControl_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_standby_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_standby_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_start_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_start_controller
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_stop_commander
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_stop_controller

Verify DM C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmPublished_send
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmPublished_log
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmToArchive_send
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmToArchive_log
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmToBase_send
    File Should Exist    ${SALWorkDir}/dm/cpp/src/sacpp_dm_dmToBase_log

Salgen DM Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for dm_alert_dq.idl
    Should Contain    ${output}    Generating SAL Java code for dm_alert_psf.idl
    Should Contain    ${output}    Generating SAL Java code for dm_alert_summary.idl
    Should Contain    ${output}    Generating SAL Java code for dm_available_replicators_distributors.idl
    Should Contain    ${output}    Generating SAL Java code for dm_efd_slave_replication_state.idl
    Should Contain    ${output}    Generating SAL Java code for dm_international_network_status.idl
    Should Contain    ${output}    Generating SAL Java code for dm_raft_images_sent_current.idl
    Should Contain    ${output}    Generating SAL Java code for dm_successfully_archived.idl
    Should Contain    ${output}    Generating SAL Java code for dm_summit_to_base_network_status.idl
    Should Contain X Times    ${output}    javac : Done Publisher    9
    Should Contain X Times    ${output}    javac : Done Subscriber    9
    Should Contain X Times    ${output}    javac : Done Commander/Controller    9
    Should Contain X Times    ${output}    javac : Done Event/Logger    9
    Directory Should Exist    ${SALWorkDir}/dm/java
    @{files}=    List Directory    ${SALWorkDir}/dm/java    pattern=*dm*
    File Should Exist    ${SALWorkDir}/dm/java/sal_dm.idl

Salgen DM Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_dm ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/dm_${SALVersion}/pom.xml

Salgen DM Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for dm
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_dm.so
    Directory Should Exist    ${SALWorkDir}/dm/python
    @{files}=    List Directory    ${SALWorkDir}/dm/python    pattern=*dm*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_abort.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_abort.py
    File Should Exist    ${SALWorkDir}/dm/cpp/src/SALPY_dm.so

Verify DM Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dm/python    pattern=*dm*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_dq_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_dq_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_psf_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_psf_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_summary_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_alert_summary_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_available_replicators_distributors_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_available_replicators_distributors_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_efd_slave_replication_state_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_efd_slave_replication_state_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_international_network_status_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_international_network_status_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_raft_images_sent_current_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_raft_images_sent_current_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_successfully_archived_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_successfully_archived_Subscriber.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_summit_to_base_network_status_Publisher.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_summit_to_base_network_status_Subscriber.py

Verify DM Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_enable.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_enable.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_disable.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_disable.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_abort.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_abort.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_standby.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_standby.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_start.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_start.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Commander_stop.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Controller_stop.py

Verify DM Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/dm/python    pattern=*dm*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dm/python/dm_Event_dmPublished.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_EventLogger_dmPublished.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Event_dmToArchive.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_EventLogger_dmToArchive.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_Event_dmToBase.py
    File Should Exist    ${SALWorkDir}/dm/python/dm_EventLogger_dmToBase.py

Salgen DM LabVIEW
    [Documentation]    Generate dm low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator dm labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/dm/labview
    @{files}=    List Directory    ${SALWorkDir}/dm/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/dm/labview/SAL_dm_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/dm/labview/SAL_dm_shmem.h
    File Should Exist    ${SALWorkDir}/dm/labview/SALLV_dm.so
