*** Settings ***
Documentation    Hexapod Application communications tests.
Force Tags    cpp    TSS-2679
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Hexapod
${component}    Application
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
    Should Contain    ${string}    ===== Hexapod subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Electrical test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Application
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Hexapod subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Demand : 9    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Error : 9    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 0    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 1    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 2    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 3    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 4    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 5    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 6    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 7    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 8    1
    Should Contain X Times    ${Application_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Position : 9    1
