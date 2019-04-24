*** Settings ***
Documentation    MTMount Deployable_Platforms communications tests.
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
${component}    Deployable_Platforms
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Deployable_Platforms
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
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Current_Drive_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Current_Drive_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Set_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Set_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Actual_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Position_Actual_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Extended_Directional_Limit_Switch_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Extended_Directional_Limit_Switch_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Retracted_Directional_Limit_Switch_Section_1 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Retracted_Directional_Limit_Switch_Section_2 : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_1_Extension_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_1_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_1_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_2_Locked_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Platform_2_Extension_2_Retracted_Limit_Switch : 1    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}DP_Interlocks : LSST    10
    Should Contain X Times    ${Deployable_Platforms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
