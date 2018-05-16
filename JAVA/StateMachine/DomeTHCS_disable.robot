*** Settings ***
Documentation    DomeTHCS State Machine tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    domeTHCS
${component}    disable
${timeout}    60s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Commander_${component}Test.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Controller_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Commander_${component}Test.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Controller_${component}Test.java

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Run the Commander test.
    ${input}=    Write    mvn -Dtest=${subSystem}Commander_${component}Test test
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -16
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )([0-9]+)( timed out)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Start the Controller test.
    ${input}=    Write    mvn -Dtest=${subSystem}Controller_${component}Test test

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/maven/${subSystem}_${SALVersion}
    Comment    Run the Commander test.
    ${input}=    Write    mvn -Dtest=${subSystem}Commander_${component}Test test
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand] ${component} writing a command containing :    1
    ${CmdComplete}=    Get Line    ${output}    -15
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready
    Should Contain    ${output}    ack      : 301
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
    Should Contain X Times    ${output}    seqNum \ \ :    2
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain X Times    ${output}    === [ackCommand_disable] acknowledging a command with :    2
