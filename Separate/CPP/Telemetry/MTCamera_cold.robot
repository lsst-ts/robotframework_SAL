*** Settings ***
Documentation    MTCamera Cold communications tests.
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
${component}    cold
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cold
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
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utilityRoomTemperature : 1    10
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 9    1
