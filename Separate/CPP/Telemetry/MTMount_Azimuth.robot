*** Settings ***
Documentation    MTMount Azimuth communications tests.
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
${component}    Azimuth
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_Azimuth
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
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Status : LSST    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Angle_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Angle_Set : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Aceleration_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Velocity_Set : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Velocity_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Torque_Actual : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Power_Off_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Directional_limit_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Directional_limit_switch : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Positive_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Negative_Adjustable_Software_limit : 1    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}Azimuth_Interlocks : LSST    10
    Should Contain X Times    ${Azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
