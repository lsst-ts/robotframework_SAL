*** Settings ***
Documentation    MTCamera Purge communications tests.
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
${component}    purge
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_purge
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
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 0    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 1    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 2    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 3    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 4    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 5    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 6    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 7    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 8    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 9    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blowerSetting : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blowerSpeed : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bodyFlowMeter : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bodyTemp : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaters : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}microphone : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trunkFlowMeter : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trunkTemp : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveSetting : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valves : 1    10
