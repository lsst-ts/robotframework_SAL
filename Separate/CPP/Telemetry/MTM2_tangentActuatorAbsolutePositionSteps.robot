*** Settings ***
Documentation    MTM2 TangentActuatorAbsolutePositionSteps communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM2
${component}    tangentActuatorAbsolutePositionSteps
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
    Should Contain    ${string}    ===== MTM2 subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_actuatorLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentActuatorAbsolutePositionSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM2 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink0DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink60DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink120DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink180DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink240DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink300DegAbsolutePositionSteps : 1    10
