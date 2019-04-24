*** Settings ***
Documentation    MTM1M3 ForceActuatorData communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    forceActuatorData
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
    Should Contain    ${string}    ===== MTM1M3 subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_powerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_forceActuatorData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM1M3 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
