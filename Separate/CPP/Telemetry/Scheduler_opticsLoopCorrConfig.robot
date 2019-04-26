*** Settings ***
Documentation    Scheduler OpticsLoopCorrConfig communications tests.
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
${component}    opticsLoopCorrConfig
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
    Should Contain    ${output}    ===== Scheduler subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_opticsLoopCorrConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsOlSlope : 1    10
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 1    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 2    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 3    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 4    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 5    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 6    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 7    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 8    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClAltLimit : 9    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 0    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 1    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 2    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 3    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 4    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 5    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 6    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 7    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 8    1
    Should Contain X Times    ${opticsLoopCorrConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telOpticsClDelay : 9    1
