*** Settings ***
Documentation    Test Scalars communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Test
${component}    scalars
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
    Should Contain    ${string}    ===== Test subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_arrays test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_scalars
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Test subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x01    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}char0 : LSST    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x01    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}string0 : LSST    10
