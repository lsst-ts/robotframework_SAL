*** Settings ***
Documentation    M1M3_StatusChecks sender/logger tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    StatusChecks
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}Test.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Event_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}EventLogger_${component}Test.java

Run Maven Tests
    [Tags]    smoke
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Run the test.
    ${input}=    Write    mvn -Dtest=${subSystem}Event_${component}Test test
    ${output}=    Read Until Prompt
    Log    ${output}
