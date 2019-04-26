*** Settings ***
Documentation    MTTCS KernelPointingModel communications tests.
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
${component}    kernelPointingModel
${timeout}    15s

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
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== MTTCS subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelPointingModel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTTCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 0    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 1    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 2    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 3    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 4    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 5    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 6    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 7    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 8    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 9    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 0    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 1    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 2    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 3    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 4    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 5    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 6    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 7    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 8    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 9    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTerml : 1    10
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTerms : 1    10
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTermx : 1    10
