*** Settings ***
Documentation     This suite builds the various interfaces for the Dome.
Force Tags    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}    ${SALVersion}
Suite Teardown         Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${timeout}    400s

*** Test Cases ***
SSH Into Host
    [Documentation]    Connect to the SAL host.
    [Tags]
    Comment    Connect.
    Open Connection    ${Host}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALInstall}/OpenSpliceDDS

Verify Dome XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_Telemetry.xml

Salgen Dome Validate
    [Documentation]    Validate the TCS XML definitions.
    [Tags]
    Write    cd ${SALWorkDir}
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} validate
    ${output}=    Read Until Prompt
	Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TC.idl

Salgen Dome HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V${SALVersion}
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Application-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Application-streamdef.html

Salgen Dome C++
	[Documentation]    Generate C++ wrapper.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Application.idl
    Should Contain    ${output}    Processing ${subSystem} Application in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
	Should Not Contain    ${output}    *** DDS error in file
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify Dome Telemetry directories
	[Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=${subSystem}*
	Log Many    @{files}
	Directory Should Exist    ${SALWorkDir}/${subSystem}_Azimuth
	Directory Should Exist    ${SALWorkDir}/${subSystem}_Application
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Bogies
    Directory Should Exist    ${SALWorkDir}/${subSystem}_CapacitorBank
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Electrical
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Louvers
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Metrology
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Screen
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Shutter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_TC

Salgen Dome Java
    [Documentation]    Generate Java wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Application.idl
    Should Contain    ${output}    Processing ${subSystem} Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Dome Maven
	[Documentation]    Generate the Maven repository.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
	Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
	Should Contain    ${output}    Tests run: 33, Failures: 0, Errors: 0, Skipped: 0
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    4
	Should Contain    ${output}    [INFO] Finished at:
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

Salgen Dome Python
    [Documentation]    Generate Python wrapper.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal python
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

Salgen Dome Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview    pattern=${subSystem}*
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
