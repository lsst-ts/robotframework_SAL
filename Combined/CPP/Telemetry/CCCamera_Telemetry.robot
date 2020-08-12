*** Settings ***
Documentation    CCCamera Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCCamera
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== CCCamera subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_filterChanger test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_filterChanger
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_filterChanger start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::filterChanger_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_filterChanger end of topic ===
    Comment    ======= Verify ${subSystem}_bonnShutter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bonnShutter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_bonnShutter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bonnShutter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_bonnShutter end of topic ===
    Comment    ======= Verify ${subSystem}_rebpower_R22 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_R22
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_rebpower_R22 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_R22_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_rebpower_R22 end of topic ===
    Comment    ======= Verify ${subSystem}_rebpower_RebPS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_RebPS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_rebpower_RebPS start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_RebPS_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_rebpower_RebPS end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_VQMonitor test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_VQMonitor
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_VQMonitor start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_VQMonitor_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_VQMonitor end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_IonPumps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_IonPumps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_IonPumps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_IonPumps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_IonPumps end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Turbo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Turbo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Turbo start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Turbo_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Turbo end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Cryo test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Cryo
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cryo start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Cryo_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cryo end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Cold2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Cold2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cold2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Cold2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cold2 end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Cold1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Cold1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cold1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Cold1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Cold1 end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_24VC test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_24VC
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_24VC start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_24VC_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_24VC end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_24VD test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_24VD
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_24VD start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_24VD_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_24VD end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_BFR test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_BFR
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_quadbox_BFR start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_BFR_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_quadbox_BFR end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_5V test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_5V
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_5V start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_5V_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_5V end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_48V test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_48V
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_48V start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_48V_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_quadbox_PDU_48V end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${filterChanger_start}=    Get Index From List    ${full_list}    === CCCamera_filterChanger start of topic ===
    ${filterChanger_end}=    Get Index From List    ${full_list}    === CCCamera_filterChanger end of topic ===
    ${filterChanger_list}=    Get Slice From List    ${full_list}    start=${filterChanger_start}    end=${filterChanger_end}
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemperature : 1    10
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorEncoder : 1    10
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}linearPosition : 1    10
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end}
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter5V : 1    10
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter36V : 1    10
    ${rebpower_R22_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_R22 start of topic ===
    ${rebpower_R22_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_R22 end of topic ===
    ${rebpower_R22_list}=    Get Slice From List    ${full_list}    start=${rebpower_R22_start}    end=${rebpower_R22_end}
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_analog_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_heater_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clockhi_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clockhi_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_heater_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_digital_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_heater_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_digital_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_digital_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_Power : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_digital_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clockhi_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_heater_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_analog_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_analog_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clockhi_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_hvbias_VbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clockhi_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_analog_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_analog_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clockhi_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_Power : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clockhi_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_analog_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_heater_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_analog_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_digital_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_analog_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_analog_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_digital_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_heater_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_heater_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_heater_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clockhi_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_digital_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_hvbias_IbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clockhi_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_digital_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clockhi_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clockhi_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_analog_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_hvbias_VbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_hvbias_IbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_analog_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_heater_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_digital_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_analog_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clocklo_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clockhi_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_analog_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_heater_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_heater_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_heater_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_digital_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_heater_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_digital_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_digital_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clockhi_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_analog_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_Power : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_hvbias_IbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_OD_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_OD_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_digital_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_heater_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_OD_IbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_hvbias_VbefSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_heater_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_digital_VbefLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_digital_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clockhi_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_IaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_analog_VaftSwch : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb1_clocklo_VaftLDO2 : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb2_clockhi_VaftLDO : 1    10
    Should Contain X Times    ${rebpower_R22_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reb0_clocklo_VaftSwch : 1    10
    ${rebpower_RebPS_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebPS start of topic ===
    ${rebpower_RebPS_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_RebPS end of topic ===
    ${rebpower_RebPS_list}=    Get Slice From List    ${full_list}    start=${rebpower_RebPS_start}    end=${rebpower_RebPS_end}
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp2 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp3 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp4 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp5 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp0 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp1 : 1    10
    Should Contain X Times    ${rebpower_RebPS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p00_BoardTemp6 : 1    10
    ${vacuum_VQMonitor_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor start of topic ===
    ${vacuum_VQMonitor_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_VQMonitor end of topic ===
    ${vacuum_VQMonitor_list}=    Get Slice From List    ${full_list}    start=${vacuum_VQMonitor_start}    end=${vacuum_VQMonitor_end}
    Should Contain X Times    ${vacuum_VQMonitor_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vqmpressure : 1    10
    ${vacuum_IonPumps_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps start of topic ===
    ${vacuum_IonPumps_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_IonPumps end of topic ===
    ${vacuum_IonPumps_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_start}    end=${vacuum_IonPumps_end}
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionpump_voltage : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionpump_current : 1    10
    ${vacuum_Turbo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo start of topic ===
    ${vacuum_Turbo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Turbo end of topic ===
    ${vacuum_Turbo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Turbo_start}    end=${vacuum_Turbo_end}
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rpm : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltage : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboSpeed : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pumpTemperature : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cntrlrSinkTemperature : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveFrequency : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}current : 1    10
    Should Contain X Times    ${vacuum_Turbo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cntrlrAirTemperature : 1    10
    ${vacuum_Cryo_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo start of topic ===
    ${vacuum_Cryo_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cryo end of topic ===
    ${vacuum_Cryo_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cryo_start}    end=${vacuum_Cryo_end}
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rejectTemperature : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffEnabled : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPower : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOnTemperature : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 1    10
    Should Contain X Times    ${vacuum_Cryo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffTemperature : 1    10
    ${vacuum_Cold2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 start of topic ===
    ${vacuum_Cold2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold2 end of topic ===
    ${vacuum_Cold2_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold2_start}    end=${vacuum_Cold2_end}
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rejectTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOnTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffEnabled : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPower : 1    10
    ${vacuum_Cold1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 start of topic ===
    ${vacuum_Cold1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Cold1 end of topic ===
    ${vacuum_Cold1_list}=    Get Slice From List    ${full_list}    start=${vacuum_Cold1_start}    end=${vacuum_Cold1_end}
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPower : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rejectTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOnTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffTemperature : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}autoOffEnabled : 1    10
    Should Contain X Times    ${vacuum_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 1    10
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end}
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bpu_Maq20_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ion_Pumps_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpga_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bpu_Maq20_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fes_Shu_HCU_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}body_Purge_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pwr_Cry_HCU_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pwr_Cry_HCU_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}body_Purge_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fes_Shu_HCU_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gauges_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ion_Pumps_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gauges_I : 1    10
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end}
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpga_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryo_Turbo_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryo_Turbo_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end}
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}protection_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_48V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_24V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clean_5_24V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_0 : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_28V_I : 1    10
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end}
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_B_I : 1    10
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === CCCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end}
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpga_T : 1    10
