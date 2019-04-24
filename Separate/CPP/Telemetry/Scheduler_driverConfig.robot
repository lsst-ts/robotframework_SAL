*** Settings ***
Documentation    Scheduler DriverConfig communications tests.
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
${component}    driverConfig
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_driverConfig
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
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coaddValues : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeBalancing : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timecostTimeMax : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timecostTimeRef : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timecostCostRef : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timecostWeight : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filtercostWeight : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propboostWeight : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nightBoundary : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newMoonPhaseThreshold : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignoreSkyBrightness : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignoreAirmass : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignoreClouds : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignoreSeeing : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lookaheadWindowSize : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lookaheadBonusWeight : 1    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupType : LSST    10
    Should Contain X Times    ${driverConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}startupDatabase : LSST    10
