*** Settings ***
Documentation    MTMount Compressed_Air communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    Compressed_Air
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
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Compressed_Air
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_CP_CPM_0001 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_AZ_CP_CPM_0002 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_CP_CPM_0001 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_EL_CP_CPM_0002 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_CP_CPM_0101 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}TMA_PI_CP_CTM_0101 : 1    10
    Should Contain X Times    ${Compressed_Air_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
