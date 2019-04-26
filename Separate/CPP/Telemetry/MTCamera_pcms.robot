*** Settings ***
Documentation    MTCamera Pcms communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
${component}    pcms
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
    Should Contain    ${output}    ===== MTCamera subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pcms
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
