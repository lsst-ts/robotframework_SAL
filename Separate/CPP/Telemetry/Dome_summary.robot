*** Settings ***
Documentation    Dome Summary communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
${component}    summary
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== Dome subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_summary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_summary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Dome subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 0    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 1    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 2    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 3    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 4    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 5    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 6    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 7    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 8    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : 9    1
