*** Settings ***
Documentation    MTM2 AxialActuatorPositionAbsoluteEncoderPositionMeasured communications tests.
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
${component}    axialActuatorPositionAbsoluteEncoderPositionMeasured
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
    Comment    ======= Verify ${subSystem}_actuatorLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured
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
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 0    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 1    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 2    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 3    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 4    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 5    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 6    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 7    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 8    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 9    1
