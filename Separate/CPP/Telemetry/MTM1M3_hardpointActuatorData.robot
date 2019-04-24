*** Settings ***
Documentation    MTM1M3 HardpointActuatorData communications tests.
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
${component}    hardpointActuatorData
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hardpointActuatorData
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
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fX : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fY : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fZ : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mX : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mY : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mZ : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    10
