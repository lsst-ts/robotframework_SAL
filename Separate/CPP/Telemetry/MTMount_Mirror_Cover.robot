*** Settings ***
Documentation    MTMount Mirror_Cover communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
${component}    Mirror_Cover
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
    Should Contain    ${string}    ===== MTMount subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Mirror_Cover
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Status : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Current : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Actual_Position : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Deployed_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_3_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_4_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}MirrorCover_Interlocks : LSST    10
    Should Contain X Times    ${Mirror_Cover_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
