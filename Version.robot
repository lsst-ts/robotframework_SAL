*** Settings ***
Documentation    This suite builds the various interfaces for the Camera.
Suite Setup    Log    ${SALVersion}
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
	Should Contain    ${output}    SAL development environment is configured
	Should Contain    ${output}    LSST middleware toolset environment v${SALVersion} is configured

Verify SAL Version file exists
    [Tags]    smoke
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke
    Write    cat ${SALInstall}/lsstsal/scripts/sal_version.tcl
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    set SALVERSION ${SALVersion}
