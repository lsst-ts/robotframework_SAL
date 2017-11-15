*** Settings ***
Documentation    TCS State Machine tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    standby
${timeout}    60s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Commander_${component}Test.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Controller_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Commander_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Controller_${component}Test.java

Run Maven Tests
    [Tags]    smoke
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Run the test.
    ${input}=    Write    mvn -Dtest=${subSystem}Commander_${component}Test test
    ${output}=    Read Until Prompt
    Log    ${output}
