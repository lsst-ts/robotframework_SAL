*** Settings ***
Documentation     Initial SAL tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Suite Teardown         Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    tcs
${timeout}    300s

*** Test Cases ***
SSH Into Host
    [Documentation]    Connect to the SAL host.
    [Tags]
    Comment    Connect.
    Open Connection    ${Host}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Login    ${UserName}    ${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALInstall}/OpenSpliceDDS

Verify TCS XML Definitions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_Commands.xml

Salgen TCS Validate
    [Documentation]    Validate the TCS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ZEMAX.idl

Salgen TCS HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    ${SALHome}//scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V${SALVersion}
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_ZEMAX-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_ZEMAX-streamdef.html

Salgen TCS C++
	[Documentation]    Generate C++ wrapper. This takes ~2mins.
	[Tags]
	${input}=    Write    ${SALHome}//scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ZEMAX.idl
    Should Contain    ${output}    Processing ${subSystem} kernel_TrackingTarget in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify TCS Telemetry directories
    [Tags]
    @{files}=    List Directory    ${SALWorkDir}    pattern=${subSystem}*
	Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_AOCS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_DawdleFilter 
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_FK5Target
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_OpticsVt
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingControl
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingLog
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_PointingModel
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_Site
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_Target
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TimeKeeper
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackingTarget
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernel_TrackRefSys
    Directory Should Exist    ${SALWorkDir}/${subSystem}_WEP
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ZEMAX

Salgen TCS Java
    [Documentation]    Generate Java wrapper. This takes ~2mins.
    [Tags]
    ${input}=    Write    ${SALHome}//scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ZEMAX.idl
    Should Contain    ${output}    Processing ${subSystem} kernel_TrackingTarget in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen TCS Python
    [Documentation]    Generate Python wrapper. This takes ~4mins.
    [Tags]
    ${input}=    Write    ${SALHome}//scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
	Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}Commander.py

Salgen TCS Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    ${SALHome}//scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview    pattern=${subSystem}*
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
