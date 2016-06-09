*** Settings ***
Documentation    Initial SAL tests.
Suite Setup    Log Many    ${subSystem}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot

*** Variables ***
${subSystem}    dm
${timeout}    200s

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

Verify DM XML Definitions exist
	[Tags]
	File Should Exist    ${SALWorkDir}/${subSystem}_Telemetry.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_Events.xml
	File Should Exist    ${SALWorkDir}/${subSystem}_alert.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_archiver.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_events.xml
    File Should Exist    ${SALWorkDir}/${subSystem}_operations.xml

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
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_summit_to_base_network_status.idl

Salgen DM HTML
	[Documentation]    Create web form interfaces.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
	${output}=    Read Until Prompt
	Log    ${output}
	Should Contain    ${output}    SAL generator - V${SALVersion}
	Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
	@{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_summit-metadata.html
    File Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}/${subSystem}_summit-streamdef.html

Salgen DM C++
	[Documentation]    Generate C++ wrapper. This takes ~2mins.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
	${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_summit_to_base_network_status.idl
    Should Contain    ${output}    Processing ${subSystem} summit_to_base_network_status in ${SALWorkDir}
    Should Contain    ${output}    cpp : Done Publisher
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify DM Telemetry directories
    [Tags]
	@{files}=    List Directory    ${SALWorkDir}    pattern=${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_dq
    Directory Should Exist    ${SALWorkDir}/${subSystem}_efd_slave_replication_state
    Directory Should Exist    ${SALWorkDir}/${subSystem}_international_network_status
    Directory Should Exist    ${SALWorkDir}/${subSystem}_successfully_archived
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_psf
    Directory Should Exist    ${SALWorkDir}/${subSystem}_summit_to_base_network_status
    Directory Should Exist    ${SALWorkDir}/${subSystem}_alert_summary
    Directory Should Exist    ${SALWorkDir}/${subSystem}_available_replicators_distributors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_raft_images_sent_current

Salgen DM Java
    [Documentation]    Generate Java wrapper. This takes ~2mins.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_summit_to_base_network_status.idl
    Should Contain    ${output}    Processing ${subSystem} summit_to_base_network_status in ${SALWorkDir}
    Should Contain    ${output}    javac : Done Event/Logger
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen DM Python
    [Documentation]    Generate Python wrapper. This takes ~4mins.
    [Tags]
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}Commander.py

Salgen DM Labview
	[Documentation]    Generate ${subSystem} low-level LabView interface.
	[Tags]
	${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
	@{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview    pattern=${subSystem}*
	Log Many    @{files}
	File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so