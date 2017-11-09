*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Force Tags    version
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    Global_Vars.robot

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify SAL Version
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=VER    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    ${output}=    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
	Set Suite Variable    ${versionData}    ${output}
	Should Contain    ${versionData}    SAL development environment is configured
	Should Contain    ${versionData}    LSST middleware toolset environment v${SALVersion} is configured

Verify OpenSplice Version
	[Documentation]    Verify the OpenSplice version and date.
	[Tags]    smoke
	Log    ${versionData}
	Log Many    ${OpenspliceVersion}    ${OpenspliceDate}
	Should Contain    ${versionData}    Vortex OpenSplice HDE Release 
	Should Contain    ${versionData}    ${OpenspliceVersion} For x86_64.linux-debug
	Should Contain    ${versionData}    Date ${OpenspliceDate}

Verify SAL Version file exists
    [Tags]    smoke
	Log    ${SALInstall}/lsstsal/scripts/sal_version.tcl
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke
    Write    cat ${SALInstall}/lsstsal/scripts/sal_version.tcl
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    set SALVERSION ${SALVersion}
