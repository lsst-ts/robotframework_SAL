*** Settings ***
Documentation    ATAOS_Commands communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATAOS
${component}    all
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Commander_all.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Controller_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Commander_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Controller_all.java

Start Controller
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${controllerOutput}=    Start Process    mvn    -Dtest\=${subSystem}Controller_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=controller    stdout=${EXECDIR}${/}stdoutController.txt    stderr=${EXECDIR}${/}stderrController.txt
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutController.txt

Start Commander
    [Tags]    functional
    Comment    Commander program waiting for Controller program to be Ready.
    ${controllerOutput}=    Get File    ${EXECDIR}${/}stdoutController.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     'ATAOS all controllers ready' in $controllerOutput
    \    ${controllerOutput}=    Get File    ${EXECDIR}${/}stdoutController.txt
    \    Sleep    3s
    Comment    Executing Combined Java Sender Program.
    ${commanderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Commander_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=commander    stdout=${EXECDIR}${/}stdoutCommander.txt    stderr=${EXECDIR}${/}stderrCommander.txt
    :FOR    ${i}    IN RANGE    30
    \    ${controllerOutput}=    Get File    ${EXECDIR}${/}stdoutController.txt
    \    Run Keyword If    'BUILD SUCCESS' in $controllerOutput    Set Test Variable    ${controllerCompletionTextFound}    "TRUE"
    \    Exit For Loop If     'BUILD SUCCESS' in $controllerOutput
    \    Sleep    3s
    Should Be True    ${controllerCompletionTextFound} == "TRUE"
