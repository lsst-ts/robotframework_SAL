*** Settings ***
Documentation    This resource file defines common keywords used by all the SAL test suites.
Library          SSHLibrary

*** Keywords ***
Create Session
    [Arguments]    ${type}
    [Documentation]    Create an SSH connection to the SAL host.
    Open Connection    host=${Host}    alias=${type}    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
