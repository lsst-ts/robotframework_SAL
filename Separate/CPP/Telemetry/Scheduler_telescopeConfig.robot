*** Settings ***
Documentation    Scheduler TelescopeConfig communications tests.
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
${component}    telescopeConfig
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_telescopeConfig
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
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMinpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMinpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxpos : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeMaxspeed : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeAccel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitudeDecel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMaxspeed : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthAccel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDecel : 1    10
    Should Contain X Times    ${telescopeConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settleTime : 1    10
