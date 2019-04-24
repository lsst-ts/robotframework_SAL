*** Settings ***
Documentation    Scheduler SlewConfig communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    slewConfig
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
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_slewConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomalt : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomaz : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqDomazSettle : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelalt : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelaz : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsOpenLoop : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelOpticsClosedLoop : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelSettle : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqTelRot : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqFilter : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqExposures : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqReadout : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqAdc : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqInsOptics : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderPos : LSST    10
    Should Contain X Times    ${slewConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}prereqGuiderAdq : LSST    10
