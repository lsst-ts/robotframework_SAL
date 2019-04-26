*** Settings ***
Documentation    MTMount OSS4 communications tests.
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
${component}    OSS4
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS4
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
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5002 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5022 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5032 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5052 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5002 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5003 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5022 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5023 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5032 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5033 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5034 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5052 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5053 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5054 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5001 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5021 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5031 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5051 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_middle_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M3_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_middle_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M3_right_Bearing_calculated : 1    10
