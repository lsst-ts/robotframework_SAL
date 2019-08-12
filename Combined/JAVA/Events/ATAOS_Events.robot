*** Settings ***
Documentation    ATAOS_Events communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
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
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    Comment    Start the EventLogger test.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=logger    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200    1s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    
    Set Test Variable    ${loggersReadyTextFound}    "FALSE"
    :FOR    ${i}    IN RANGE    30
    \    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    \    Run Keyword If     'ATAOS all loggers ready' in $output    Set Test Variable    ${loggersReadyTextFound}    "TRUE"
    \    Exit For Loop If     'ATAOS all loggers ready' in $output
    \    Sleep    3s
    Should Be True    ${loggersReadyTextFound} == "TRUE"
