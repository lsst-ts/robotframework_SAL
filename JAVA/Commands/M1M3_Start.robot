*** Settings ***
Documentation    M1M3_Start commander/controller tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    Start
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Commander_${component}Test.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Controller_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_*/src/test/java/${subSystem}Commander${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_*/src/test/java/${subSystem}Controller_${component}Test.java

