*** Settings ***
Documentation    MTTCS WEP communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTTCS
${component}    wEP
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
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wEP
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTTCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}basisSetName : LSST    10
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberOfTerms : 1    10
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 9    1
