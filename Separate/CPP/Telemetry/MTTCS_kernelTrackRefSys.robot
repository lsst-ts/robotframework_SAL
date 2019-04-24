*** Settings ***
Documentation    MTTCS KernelTrackRefSys communications tests.
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
${component}    kernelTrackRefSys
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
    Should Contain    ${string}    ===== MTTCS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelTrackRefSys
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
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 0    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 1    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 2    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 3    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 4    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 5    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 6    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 7    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 8    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 9    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 0    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 1    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 2    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 3    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 4    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 5    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 6    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 7    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 8    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 9    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cst : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}diurab : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hm : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humid : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}press : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refa : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refb : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sst : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tdbj : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlat : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlr : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavel : 1    10
