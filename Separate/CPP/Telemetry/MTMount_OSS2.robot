*** Settings ***
Documentation    MTMount OSS2 communications tests.
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
${component}    OSS2
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
    Comment    ======= Verify ${subSystem}_Safety_System test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_OSS2
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
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CTM_5001 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5057 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5056 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5055 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5054 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5013 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5012 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5011 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5006 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5005 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5004 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5003 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5002 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}OSS_MP_CPM_5001 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XPos_M2_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M1_right_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_left_Bearing_calculated : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_1 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_2 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_3 : 1    10
    Should Contain X Times    ${OSS2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}AZ_XNeg_M2_right_Bearing_calculated : 1    10
