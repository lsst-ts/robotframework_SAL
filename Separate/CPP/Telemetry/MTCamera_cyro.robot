*** Settings ***
Documentation    MTCamera Cyro communications tests.
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
${component}    cyro
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
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cyro
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressor : 1    10
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 9    1
