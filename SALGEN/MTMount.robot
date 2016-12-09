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
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing mtmount
    Should Contain    ${output}    Completed mtmount validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*mtmount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_mtmount.idl

Salgen MTMount HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/mtmount
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/mtmount    pattern=*mtmount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/mtmount/MTMount_Commands.html
    File Should Exist    ${SALWorkDir}/html/mtmount/MTMount_Events.html
    File Should Exist    ${SALWorkDir}/html/mtmount/MTMount_Telemetry.html

Salgen MTMount C++
    [Documentation]    Generate C++ wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Az.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Alt.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Az_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Az_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Alt_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Az_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Alt_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Bal.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_MC.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Cam_CW.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_Cab_TC.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_DP_1.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_DP_2.idl
    Should Contain    ${output}    Generating SAL CPP code for mtmount_MTMount_MotionParameters.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    15
    Should Contain X Times    ${output}    cpp : Done Subscriber    15
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]
    Directory Should Exist    ${SALWorkDir}/mtmount/cpp
    @{files}=    List Directory    ${SALWorkDir}/mtmount/cpp    pattern=*mtmount*
    File Should Exist    ${SALWorkDir}/mtmount/cpp/libsacpp_mtmount_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*mtmount*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_mtmount.idl

Verify MTMount Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*mtmount*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Az
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_CW
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_OSS
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_OSS
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_TC
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_TC
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Bal
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_MC
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Cam_CW
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_Cab_TC
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_1
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_2
    Directory Should Exist    ${SALWorkDir}/mtmount_MTMount_MotionParameters

Verify MTMount C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_CW/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_CW/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_OSS/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_OSS/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_OSS/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_OSS/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_TC/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Az_TC/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_TC/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Alt_TC/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Bal/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Bal/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_MC/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_MC/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Cam_CW/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Cam_CW/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Cab_TC/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_Cab_TC/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_1/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_1/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_2/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_DP_2/cpp/standalone/sacpp_mtmount_sub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_MotionParameters/cpp/standalone/sacpp_mtmount_pub
    File Should Exist    ${SALWorkDir}/mtmount_MTMount_MotionParameters/cpp/standalone/sacpp_mtmount_sub

Verify MTMount C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_enable_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_enable_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_disable_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_disable_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_abort_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_abort_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_enterControl_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_enterControl_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_exitControl_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_exitControl_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_standby_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_standby_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_start_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_start_controller
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_stop_commander
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/sacpp_mtmount_stop_controller

Salgen MTMount Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for mtmount_Application.idl
    Should Contain    ${output}    Processing mtmount Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/mtmount/java
    @{files}=    List Directory    ${SALWorkDir}/mtmount/java    pattern=*mtmount*
    File Should Exist    ${SALWorkDir}/mtmount/java/sal_mtmount.idl

Salgen MTMount Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator mtmount maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_mtmount ${SALVersion}
    Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/mtmount_${SALVersion}/pom.xml

Salgen MTMount Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for mtmount
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_mtmount.so
    Directory Should Exist    ${SALWorkDir}/mtmount/python
    @{files}=    List Directory    ${SALWorkDir}/mtmount/python    pattern=*mtmount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_abort.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_abort.py
    File Should Exist    ${SALWorkDir}/mtmount/cpp/src/SALPY_mtmount.so

Verify MTMount Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/mtmount/python    pattern=*mtmount*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Az_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Alt_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Bal_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Bal_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_MC_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_MC_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Cam_CW_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Cam_CW_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Cab_TC_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_Cab_TC_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_DP_1_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_DP_1_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_DP_2_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_DP_2_Subscriber.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_MotionParameters_Publisher.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_MTMount_MotionParameters_Subscriber.py

Verify MTMount Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_enable.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_enable.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_disable.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_disable.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_abort.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_abort.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_standby.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_standby.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_start.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_start.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Commander_stop.py
    File Should Exist    ${SALWorkDir}/mtmount/python/mtmount_Controller_stop.py

Salgen MTMount LabVIEW
    [Documentation]    Generate mtmount low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator mtmount labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/mtmount/labview
    @{files}=    List Directory    ${SALWorkDir}/mtmount/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/mtmount/labview/SAL_mtmount_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/mtmount/labview/SAL_mtmount_shmem.h
