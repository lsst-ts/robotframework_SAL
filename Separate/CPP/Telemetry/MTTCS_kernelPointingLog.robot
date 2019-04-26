*** Settings ***
Documentation    MTTCS KernelPointingLog communications tests.
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
${component}    kernelPointingLog
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelPointingLog
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
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 0    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 1    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 2    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 3    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 4    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 5    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 6    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 7    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 8    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 9    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}casspa : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fl : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humid : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}marked : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pitch : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}press : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcorr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roll : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavel : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yr : 1    10
