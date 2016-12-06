*** Settings ***
Documentation    This suite builds the various interfaces for the Camera.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${timeout}    900s

*** Test Cases ***
SSH Into Host
    [Documentation]    Connect to the SAL host.
    [Tags]
    Comment    Connect.
    Open Connection    ${Host}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
	Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALInstall}/OpenSpliceDDS

Verify Camera XML Definitions exist
	[Tags]
	File Should Exist    ${SALWorkDir}/${subSystem}_Telemetry.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_Events.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_Commands.xml

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
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cryo.idl

Salgen Camera HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V${SALVersion}
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Cryo-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Cryo-streamdef.html

Salgen Camera C++
	[Documentation]    Generate C++ wrapper.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cryo.idl
    Should Contain    ${output}    Processing ${subSystem} Cryo in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
	Should Not Contain    ${output}    *** DDS error in file
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify Camera Telemetry directories
    [Tags]
	@{files}=    List Directory    ${SALWorkDir}    pattern=${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cold
    Directory Should Exist    ${SALWorkDir}/${subSystem}_SAS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_SDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Filter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Prot
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Purge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cluster_Encoder
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Shutter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_GDS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_GAS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_PCMS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cryo
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WAS

Salgen Camera Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cryo.idl
    Should Contain    ${output}    Processing ${subSystem} Cryo in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=${subSystem}*
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
    Should Contain    ${output}    Tests run: 35, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
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
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py

Verify Camera Python Interfaces
	[Documentation]    Verify the Python interfaces were properly created.
	[Tags]    python
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=${subSystem}*
	Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cryo_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cryo_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ccsConfigured.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ccsConfigured.py

Salgen Camera Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor
