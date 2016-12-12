*** Settings ***
Documentation    This suite builds the various interfaces for the OCS.
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

Verify OCS XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/ocs_Events.xml
    File Should Exist    ${SALWorkDir}/ocs_Telemetry.xml

Salgen OCS Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing ocs
    Should Contain    ${output}    Completed ocs validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*ocs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_SequencerHeartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsEntityStartup.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsEntityShutdown.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsCommandIssued.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsCommandStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsCurrentScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsNextScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsScriptStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsScriptEnd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsScriptError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/ocs_logevent_ocsScriptEntititesInUse.idl

Salgen OCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/ocs
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/ocs    pattern=*ocs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/ocs/ocs_Events.html
    File Should Exist    ${SALWorkDir}/html/ocs/ocs_Telemetry.html

Salgen OCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ocs_SequencerHeartbeat.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    1
    Should Contain X Times    ${output}    cpp : Done Subscriber    1
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/ocs/cpp
    @{files}=    List Directory    ${SALWorkDir}/ocs/cpp    pattern=*ocs*
    File Should Exist    ${SALWorkDir}/ocs/cpp/libsacpp_ocs_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*ocs*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_ocs.idl

Verify OCS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*ocs*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/ocs_SequencerHeartbeat

Verify OCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/ocs_SequencerHeartbeat/cpp/standalone/sacpp_ocs_pub
    File Should Exist    ${SALWorkDir}/ocs_SequencerHeartbeat/cpp/standalone/sacpp_ocs_sub

Verify OCS C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_enable_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_enable_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_disable_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_disable_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_abort_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_abort_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_enterControl_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_enterControl_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_exitControl_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_exitControl_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_standby_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_standby_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_start_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_start_controller
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_stop_commander
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_stop_controller

Verify OCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsEntityStartup_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsEntityStartup_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsEntityShutdown_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsEntityShutdown_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCommandIssued_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCommandIssued_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCommandStatus_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCommandStatus_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCurrentScript_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsCurrentScript_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsNextScript_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsNextScript_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptStart_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptStart_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptEnd_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptEnd_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptError_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptError_log
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptEntititesInUse_send
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/sacpp_ocs_ocsScriptEntititesInUse_log

Salgen OCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ocs_SequencerHeartbeat.idl
    Should Contain X Times    ${output}    javac : Done Publisher    1
    Should Contain X Times    ${output}    javac : Done Subscriber    1
    Should Contain X Times    ${output}    javac : Done Commander    1
    Should Contain X Times    ${output}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/ocs/java
    @{files}=    List Directory    ${SALWorkDir}/ocs/java    pattern=*ocs*
    File Should Exist    ${SALWorkDir}/ocs/java/sal_ocs.idl

Salgen OCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ocs maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_ocs ${SALVersion}
    Should Contain X Times    ${output}    Tests run: 18, Failures: 0, Errors: 0, Skipped: 0    4
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain X Times    ${output}    [INFO] Finished at:    4
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/ocs_${SALVersion}/pom.xml

Salgen OCS Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ocs
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_ocs.so
    Directory Should Exist    ${SALWorkDir}/ocs/python
    @{files}=    List Directory    ${SALWorkDir}/ocs/python    pattern=*ocs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_abort.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_abort.py
    File Should Exist    ${SALWorkDir}/ocs/cpp/src/SALPY_ocs.so

Verify OCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/ocs/python    pattern=*ocs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_SequencerHeartbeat_Publisher.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_SequencerHeartbeat_Subscriber.py

Verify OCS Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_enable.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_enable.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_disable.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_disable.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_abort.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_abort.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_standby.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_standby.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_start.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_start.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Commander_stop.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Controller_stop.py

Verify OCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/ocs/python    pattern=*ocs*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsEntityStartup.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsEntityStartup.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsEntityShutdown.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsEntityShutdown.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsCommandIssued.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsCommandIssued.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsCommandStatus.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsCommandStatus.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsCurrentScript.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsCurrentScript.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsNextScript.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsNextScript.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsScriptStart.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsScriptStart.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsScriptEnd.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsScriptEnd.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsScriptError.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsScriptError.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_Event_ocsScriptEntititesInUse.py
    File Should Exist    ${SALWorkDir}/ocs/python/ocs_EventLogger_ocsScriptEntititesInUse.py

Salgen OCS LabVIEW
    [Documentation]    Generate ocs low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ocs labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/ocs/labview
    @{files}=    List Directory    ${SALWorkDir}/ocs/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/ocs/labview/SAL_ocs_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/ocs/labview/SAL_ocs_shmem.h
