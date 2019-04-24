*** Settings ***
Documentation    Rotator Motors communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Rotator
${component}    Motors
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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Motors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Motors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Rotator subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 0    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 1    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 2    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 3    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 4    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 5    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 6    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 7    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 8    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Calibrated : 9    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 0    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 1    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 2    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 3    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 4    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 5    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 6    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 7    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 8    1
    Should Contain X Times    ${Motors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Raw : 9    1
