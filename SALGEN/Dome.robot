*** Settings ***
Documentation     Initial SAL tests.
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
    Comment    Define variables.
    Set Global Variable    ${Host}    140.252.33.40
    Comment    Connect.
    Open Connection    ${Host}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
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
    Should Contain    ${output}    SAL generator - V3.0
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_TC.idl

Verify Dome Telemetry directories
	[Tags]
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

Salgen Dome HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V3.0
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Application-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_Application-streamdef.html

Salgen Dome C++
	[Documentation]    Generate C++ wrapper. This takes ~2mins.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V3.0
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Application.idl
    Should Contain    ${output}    Processing ${subSystem} Application in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Salgen Dome Java
    [Documentation]    Generate Java wrapper. This takes ~2mins.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V3.0
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Application.idl
    Should Contain    ${output}    Processing ${subSystem} Application in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Dome Maven Deploy
	[Documentation]    Build the JAVA interfaces.
	[Tags]    skipped

Salgen Dome Python
    [Documentation]    Generate Python wrapper. This takes ~4mins.
    [Tags]
    ${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V3.0
	Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}Commander.py

Salgen Dome Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    /opt/sal/lsstsal/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V3.0
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview    pattern=${subSystem}*
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
