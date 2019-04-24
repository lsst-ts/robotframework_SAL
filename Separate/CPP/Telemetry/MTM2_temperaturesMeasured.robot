*** Settings ***
Documentation    MTM2 TemperaturesMeasured communications tests.
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
${component}    temperaturesMeasured
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperaturesMeasured
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
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 9    1
