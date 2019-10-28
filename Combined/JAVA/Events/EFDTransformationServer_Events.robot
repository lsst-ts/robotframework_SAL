*** Settings ***
Documentation    EFDTransformationServer_Events communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    EFDTransformationServer
${component}    all
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutLogger.txt

Start Sender
    [Tags]    functional
    Comment    Sender program waiting for Logger program to be Ready.
    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     'EFDTransformationServer all loggers ready' in $loggerOutput
    \    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    \    Sleep    3s
    Comment    Executing Combined Java Sender Program.
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    :FOR    ${i}    IN RANGE    30
    \    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    \    Run Keyword If    'BUILD SUCCESS' in $loggerOutput    Set Test Variable    ${loggerCompletionTextFound}    "TRUE"
    \    Exit For Loop If     'BUILD SUCCESS' in $loggerOutput
    \    Sleep    3s
    Should Be True    ${loggerCompletionTextFound} == "TRUE"
