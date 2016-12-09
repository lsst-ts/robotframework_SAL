*** Settings ***
Documentation    This suite builds the various interfaces for the M2MS.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}    ${SALVersion}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${timeout}    300s

*** Test Cases ***
SSH Into Host
    [Documentation]    Connect to the SAL host.
    [Tags]
    Comment    Connect.
    Open Connection    ${Host}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALInstall}/OpenSpliceDDS

Verify M2MS XML Definitions exist
	[Tags]
	File Should Exist    ${SALWorkDir}/${subSystem}_Telemetry.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_Events.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_Commands.xml

Salgen M2MS Validate
    [Documentation]    Validate the M2MS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TangentForcesMeasured.idl

Salgen M2MS HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V${SALVersion}
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_TangentForcesMeasured-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_TangentForcesMeasured-streamdef.html

Salgen M2MS C++
	[Documentation]    Generate C++ wrapper.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_TangentForcesMeasured.idl
    Should Contain    ${output}    Processing ${subSystem} TangentForcesMeasured in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
	Should Not Contain    ${output}    *** DDS error in file
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify M2MS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
	Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ZenithAngleMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentStrainMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TangentActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_MirrorPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AxialActuatorAbsolutePositionSteps

Salgen M2MS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_TangentForcesMeasured.idl
    Should Contain    ${output}    Processing ${subSystem} TangentForcesMeasured in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen M2MS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain    ${output}    Tests run: 17, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
    Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

Salgen M2MS Python
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

Verify M2MS Python Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ApplyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_TangentForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_M2FaultState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_M2FaultState.py

Salgen M2MS Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
