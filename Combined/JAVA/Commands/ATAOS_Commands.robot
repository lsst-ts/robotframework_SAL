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

*** Test Cases ***
Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${controllerOutput}=    Start Process    mvn    -Dtest\=${subSystem}Controller_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=controller    stdout=${EXECDIR}${/}stdoutController.txt    stderr=${EXECDIR}${/}stderrController.txt
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutController.txt

