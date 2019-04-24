*** Settings ***
Documentation    MTM1M3 ForceActuatorPressure communications tests.
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
${component}    forceActuatorPressure
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
    Comment    ======= Verify ${subSystem}_powerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_forceActuatorPressure
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
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 9    1
