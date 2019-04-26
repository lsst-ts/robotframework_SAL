*** Settings ***
Documentation    MTMount OSS5 communications tests.
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
${component}    OSS5
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
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS5
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
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5012 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5013 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5042 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CFM_5043 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5012 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5013 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5014 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5015 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5016 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5042 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5043 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5044 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5045 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CPM_5046 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5011 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}CTM_5041 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XPos_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_XPos_M2_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}EL_XNeg_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}El_XNeg_M2_right_Bearing_calculated : 1    10
