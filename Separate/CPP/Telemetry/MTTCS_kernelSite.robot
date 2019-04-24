*** Settings ***
Documentation    MTTCS KernelSite communications tests.
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
${component}    kernelSite
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelSite
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
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 0    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 1    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 2    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 3    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 4    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 5    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 6    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 7    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 8    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 9    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 0    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 1    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 2    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 3    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 4    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 5    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 6    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 7    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 8    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 9    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daz : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}diurab : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elong : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refa : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refb : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}st0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}t0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tt0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttj : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttmtai : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uau : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ukm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vau : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vkm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}delat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}delut : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elongm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttmtat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xpm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ypm : 1    10
