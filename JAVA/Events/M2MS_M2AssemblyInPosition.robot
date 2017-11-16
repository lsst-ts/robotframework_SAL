*** Settings ***
Documentation    M2MS_M2AssemblyInPosition sender/logger tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    M2AssemblyInPosition
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}Test.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Event_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}EventLogger_${component}Test.java

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Start the EventLogger test.
    ${input}=    Write    mvn -Dtest=${subSystem}EventLogger_${component}Test test

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Run the Event test.
    ${input}=    Write    mvn -Dtest=${subSystem}Event_${component}Test test
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample logevent_M2AssemblyInPosition] writing a message containing :    1
    Should Contain    ${output}    revCode \ :

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    Running ${subSystem}EventLogger_M2AssemblyInPositionTest
    Should Not Contain    ${output}    [ERROR]
