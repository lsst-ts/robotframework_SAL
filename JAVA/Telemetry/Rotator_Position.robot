*** Settings ***
Documentation    Rotator_Position communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    rotator
${component}    Position
${timeout}    30s
#${subOut}    ${subSystem}_${component}_sub.out
#${pubOut}    ${subSystem}_${component}_pub.out

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/java/standalone/saj_${subSystem}_${component}_pub.jar
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/java/standalone/saj_${subSystem}_${component}_sub.jar

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/java/standalone
    Comment    Start Subscriber.
    ${input}=    Write    java -cp $SAL_HOME/lib/saj_${subSystem}_types.jar:./classes:$OSPL_HOME/jar/dcpssaj.jar:saj_${subSystem}_${component}_sub.jar ${subSystem}_${component}DataSubscriber
    ${output}=    Read Until    [${component} Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [${component} Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/java/standalone
    Comment    Start Publisher.
    ${input}=    Write    java -cp $SAL_HOME/lib/saj_${subSystem}_types.jar:./classes:$OSPL_HOME/jar/dcpssaj.jar:saj_${subSystem}_${component}_pub.jar ${subSystem}_${component}DataPublisher
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample ${component}] writing a message containing :    5
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    5

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain X Times    ${output}    [getSample ${component} ] message received :    7
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    6
    Should Contain X Times    ${output}    revCode \ :    7
