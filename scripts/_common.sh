#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  FUNCTIONS
function createSession() {
	SessionType=$1
    echo "Create $SessionType Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=$SessionType    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Login With Public Key    \${UserName}    keyfile=\${KeyFile}    password=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}" >> $testSuite
    echo "" >> $testSuite
}

