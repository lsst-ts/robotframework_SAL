*** Settings ***
Documentation    MTMount Locking_Pins communications tests.
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
${component}    Locking_Pins
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
    Should Contain    ${output}    ===== MTMount subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Locking_Pins
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTMount subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Status_Drive_1 : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Status_Drive_2 : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Drive_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Drive_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Current_Drive_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Current_Drive_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Setpoint_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Position_Setpoint_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Free_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Free_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Lock_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Lock_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Test_Limit_1 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Test_Limit_2 : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Retracted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Retracted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Inserted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Inserted : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_1_Test : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Elevation_Locking_Pin_2_Test : 1    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}LP_Interlocks : LSST    10
    Should Contain X Times    ${Locking_Pins_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
